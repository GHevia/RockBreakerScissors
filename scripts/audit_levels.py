#!/usr/bin/env python3
"""Audit the authored Swift layouts without Xcode. Requires Python 3 and a C++17 compiler.

python3 scripts/audit_levels.py --report level-audit.csv
The simulator mirrors GameScene's fixed-step movement, walls, conversions and loss rules.
A found sequence proves one simulated win; a failed search does not prove impossibility.
"""
import argparse
import csv
import io
import math
import re
import subprocess
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def parse_levels(source):
    levels = {}
    for number, body in re.findall(r'static let level(\d+) = LevelDefinition\((.*?)\n    \)', source, re.S):
        objects = []
        for fields in re.findall(r'InitialObjectDefinition\((.*?)\)', body, re.S):
            values = dict(re.findall(r'(\w+):\s*([.\w-]+)', fields))
            angle = float(values['angleDegrees']) if 'angleDegrees' in values else math.degrees(math.atan2(float(values['directionDY']), float(values['directionDX'])))
            objects.append(dict(type=values['type'].lstrip('.'), x=float(values['xPercent']), y=float(values['yPercent']), angle=angle, speed=float(values['speed']), radius=float(values['radius'])))
        walls = []
        for fields in re.findall(r'ArenaWallDefinition\((.*?)\)', body, re.S):
            values = dict(re.findall(r'(\w+):\s*([\d.]+)', fields))
            walls.append([float(values[key]) for key in ['xPercent', 'yPercent', 'widthPercent', 'heightPercent']])
        hint = re.search(r'introMessage: "([^"]+)"', body)
        levels[int(number)] = dict(number=int(number), ammo=int(re.search(r'startingAmmo: (\d+)', body)[1]), speed=float(re.search(r'launchSpeed: ([\d.]+)', body)[1]), radius=float(re.search(r'launchedRockRadius: ([\d.]+)', body)[1]), objects=objects, walls=walls, hint=hint[1] if hint else None)
    return levels


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=ROOT / 'RockBreakerScissors/LevelDefinition.swift')
    parser.add_argument('--report', type=Path, default=ROOT / 'level-audit.csv')
    parser.add_argument('--check', action='store_true', help='Fail if a win is missing, a startup overlap exists, or a layout loses within three idle seconds')
    parser.add_argument('--update-test-sequences', action='store_true', help='Refresh embedded SpriteKit replay sequences after a successful audit')
    args = parser.parse_args()
    levels = parse_levels(args.source.read_text())
    assert sorted(levels) == list(range(1, 101)), 'Expected contiguous levels 1 through 100'
    lines = [str(len(levels))]
    for n, level in sorted(levels.items()):
        lines.append(f"{n} {level['ammo']} {level['speed']} {level['radius']} {len(level['objects'])} {len(level['walls'])}")
        for o in level['objects']:
            lines.append(f"{['rock', 'paper', 'scissors'].index(o['type'])} {o['x']} {o['y']} {o['angle']} {o['speed']} {o['radius']}")
        lines.extend(' '.join(map(str, wall)) for wall in level['walls'])
    with tempfile.TemporaryDirectory(prefix='rbs-audit-') as temp:
        binary = Path(temp) / 'audit'
        subprocess.run(['c++', '-std=c++17', '-O2', str(ROOT / 'scripts/audit_levels.cpp'), '-o', str(binary)], check=True)
        result = subprocess.run([str(binary)], input='\n'.join(lines), text=True, capture_output=True, check=True)
    args.report.write_text(result.stdout)
    print(result.stderr.strip())
    print(f'Report: {args.report}')
    rows = list(csv.DictReader(io.StringIO(result.stdout)))
    passed = all(float(r['win_seconds']) >= 0 and int(r['overlaps']) == 0
                 and int(r['wall_overlaps']) == 0 and float(r['idle_loss_seconds']) < 0 for r in rows)
    if args.update_test_sequences:
        if not passed:
            raise SystemExit('Replay fixtures were not updated because the audit has unresolved cases')
        test = ROOT / 'RockBreakerScissorsTests/RockBreakerScissorsTests.swift'
        marker = '\n// BEGIN GENERATED WINNING SEQUENCES'
        content = test.read_text().split(marker)[0]
        content += marker + '\nprivate let campaignWinningSequences = """\n'
        content += '\n'.join(','.join(r[key] for key in ['level', 'width', 'height', 'shots']) for r in rows)
        test.write_text(content + '\n"""\n')
        print('Updated 300 SpriteKit replay sequences')
    if args.check and not passed:
        raise SystemExit('Audit has unresolved cases; see the CSV (a failed search is not proof of impossibility)')


if __name__ == '__main__':
    main()
