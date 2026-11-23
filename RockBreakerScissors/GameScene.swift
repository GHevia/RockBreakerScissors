import SpriteKit
import CoreGraphics

final class GameScene: SKScene {
    // MARK: - Public callbacks

    var onWin: ((ObjectType) -> Void)?
    var onLose: ((ObjectType) -> Void)?
    var didUseAmmo: (() -> Void)?
    var canLaunchRock: (() -> Bool)?
    var isGameplayPaused = false
    var didTryLaunchWithoutAmmo: (() -> Void)?

    // MARK: - Private state

    private var currentLevel: LevelDefinition?
    private var objectNodes: [SKSpriteNode] = []
    private var isShowingResult = false
    private var hasLaunchedRock = false
    private(set) var lossMessage: String?

    private var launcherPosition: CGPoint = .zero
    private var aimDots: [SKShapeNode] = []
    private var touchStartPoint: CGPoint?
    private var launcherNode: SKSpriteNode?
    private var launchPortNode: SKShapeNode?
    private var boundaryLineNodes: [SKShapeNode] = []
    private var wallNodes: [SKShapeNode] = []
    private var wallRects: [CGRect] = []

    private let arenaInset: CGFloat = 24
    private let launchPortRadius: CGFloat = 18
    private let aimDotCount: Int = 9
    private let aimDotSpacing: CGFloat = 22
    private let objectScale: CGFloat = 0.80

    // MARK: - Theme state

    private var isDarkMode: Bool = true

    private var accentColor: SKColor {
        isDarkMode
            ? SKColor.white.withAlphaComponent(0.85)
            : SKColor.black.withAlphaComponent(0.75)
    }

    private var secondaryAccentColor: SKColor {
        isDarkMode
            ? SKColor.white.withAlphaComponent(0.20)
            : SKColor.black.withAlphaComponent(0.12)
    }

    // MARK: - Scene setup

    override func didMove(to view: SKView) {
        // Intentionally do nothing here.
        // GameView controls backgroundColor based on light/dark mode.
    }

    func applyTheme(isDarkMode: Bool) {
        self.isDarkMode = isDarkMode

        launchPortNode?.fillColor = secondaryAccentColor
        launchPortNode?.strokeColor = accentColor

        for dot in aimDots {
            dot.fillColor = accentColor
        }

        for line in boundaryLineNodes {
            line.strokeColor = accentColor
        }

        for wall in wallNodes {
            wall.fillColor = secondaryAccentColor
            wall.strokeColor = accentColor
        }
    }

    func load(level: LevelDefinition) {
        removeAllChildren()
        removeAllActions()

        currentLevel = level
        objectNodes.removeAll()
        aimDots.removeAll()
        boundaryLineNodes.removeAll()
        wallNodes.removeAll()
        wallRects.removeAll()
        isShowingResult = false
        hasLaunchedRock = false
        lossMessage = nil
        touchStartPoint = nil

        setupLauncher()
        setupWalls(level.walls)
        setupInitialObjects(level.initialObjects)
        applyTheme(isDarkMode: isDarkMode)
        setupBoundaries()
    }

    // MARK: - Setup

    private func setupBoundaries() {
        let minX = arenaInset
        let maxX = size.width - arenaInset
        let minY = arenaInset + 24
        let maxY = size.height - arenaInset

        let topLine = SKShapeNode()
        let topPath = CGMutablePath()
        topPath.move(to: CGPoint(x: minX, y: maxY))
        topPath.addLine(to: CGPoint(x: maxX, y: maxY))
        topLine.path = topPath
        topLine.lineWidth = 2
        topLine.strokeColor = accentColor
        topLine.zPosition = 5
        addChild(topLine)

        let bottomLine = SKShapeNode()
        let bottomPath = CGMutablePath()
        bottomPath.move(to: CGPoint(x: minX, y: minY))
        bottomPath.addLine(to: CGPoint(x: maxX, y: minY))
        bottomLine.path = bottomPath
        bottomLine.lineWidth = 2
        bottomLine.strokeColor = accentColor
        bottomLine.zPosition = 5
        addChild(bottomLine)

        let leftLine = SKShapeNode()
        let leftPath = CGMutablePath()
        leftPath.move(to: CGPoint(x: minX, y: minY))
        leftPath.addLine(to: CGPoint(x: minX, y: maxY))
        leftLine.path = leftPath
        leftLine.lineWidth = 2
        leftLine.strokeColor = accentColor
        leftLine.zPosition = 5
        addChild(leftLine)

        let rightLine = SKShapeNode()
        let rightPath = CGMutablePath()
        rightPath.move(to: CGPoint(x: maxX, y: minY))
        rightPath.addLine(to: CGPoint(x: maxX, y: maxY))
        rightLine.path = rightPath
        rightLine.lineWidth = 2
        rightLine.strokeColor = accentColor
        rightLine.zPosition = 5
        addChild(rightLine)

        boundaryLineNodes = [topLine, bottomLine, leftLine, rightLine]
    }

    private func setupLauncher() {
        launcherPosition = CGPoint(x: size.width * 0.5, y: arenaInset)

        let rock = SKSpriteNode(imageNamed: "rock")
        rock.size = CGSize(width: 42, height: 42)
        rock.position = CGPoint(x: launcherPosition.x, y: launcherPosition.y)
        rock.zPosition = 10
        addChild(rock)
        launcherNode = rock

        let port = SKShapeNode(circleOfRadius: launchPortRadius)
        port.position = launcherPosition
        port.fillColor = secondaryAccentColor
        port.strokeColor = accentColor
        port.lineWidth = 2
        port.zPosition = 11
        addChild(port)
        launchPortNode = port
    }

    private func setupWalls(_ definitions: [ArenaWallDefinition]) {
        let minX = arenaInset
        let maxX = size.width - arenaInset
        let minY = arenaInset + 24
        let maxY = size.height - arenaInset
        let arenaWidth = maxX - minX
        let arenaHeight = maxY - minY

        for definition in definitions {
            let width = max(8, definition.widthPercent * arenaWidth)
            let height = max(8, definition.heightPercent * arenaHeight)
            let centerX = minX + definition.xPercent * arenaWidth
            let centerY = minY + definition.yPercent * arenaHeight
            let rect = CGRect(
                x: centerX - width / 2,
                y: centerY - height / 2,
                width: width,
                height: height
            )

            let wall = SKShapeNode(rect: rect, cornerRadius: 4)
            wall.fillColor = secondaryAccentColor
            wall.strokeColor = accentColor
            wall.lineWidth = 2
            wall.zPosition = 4
            addChild(wall)

            wallNodes.append(wall)
            wallRects.append(rect)
        }
    }

    private func setupInitialObjects(_ definitions: [InitialObjectDefinition]) {
        let minX = arenaInset
        let maxX = size.width - arenaInset
        let minY = arenaInset + 24
        let maxY = size.height - arenaInset

        for def in definitions {
            let clampedX = max(0.0, min(1.0, def.xPercent))
            let clampedY = max(0.0, min(1.0, def.yPercent))

            let x = minX + clampedX * (maxX - minX)
            let y = minY + clampedY * (maxY - minY)

            let node = makeNode(
                type: def.type,
                position: CGPoint(x: x, y: y),
                velocity: def.velocity,
                radius: def.radius
            )
            addChild(node)
            objectNodes.append(node)
        }
    }

    // MARK: - Node creation

    private func makeNode(
        type: ObjectType,
        position: CGPoint,
        velocity: CGVector,
        radius: CGFloat
    ) -> SKSpriteNode {
        let scaledRadius = radius * objectScale
        let node = SKSpriteNode(imageNamed: assetName(for: type))
        node.name = objectName(for: type)
        node.size = CGSize(width: scaledRadius * 2, height: scaledRadius * 2)
        node.position = position
        node.userData = NSMutableDictionary()
        node.userData?["vx"] = velocity.dx
        node.userData?["vy"] = velocity.dy
        node.userData?["radius"] = scaledRadius
        return node
    }

    private func assetName(for type: ObjectType) -> String {
        switch type {
        case .rock:
            return "rock"
        case .paper:
            return "paper"
        case .scissors:
            return "scissors"
        }
    }

    private func objectName(for type: ObjectType) -> String {
        switch type {
        case .rock:
            return "rock"
        case .paper:
            return "paper"
        case .scissors:
            return "scissors"
        }
    }

    private func objectType(for node: SKSpriteNode) -> ObjectType? {
        guard let name = node.name else { return nil }

        switch name {
        case "rock":
            return .rock
        case "paper":
            return .paper
        case "scissors":
            return .scissors
        default:
            return nil
        }
    }

    private func setType(_ type: ObjectType, for node: SKSpriteNode) {
        guard objectType(for: node) != type else { return }

        node.texture = SKTexture(imageNamed: assetName(for: type))
        node.name = objectName(for: type)
    }

    // MARK: - Touch handling

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        guard !isShowingResult, !isGameplayPaused else { return }
        guard canLaunchRock?() ?? true else {
            didTryLaunchWithoutAmmo?()
            return
        }

        let location = touch.location(in: self)
        touchStartPoint = location
        updateAimDots(from: launcherPosition, toward: location)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        guard touchStartPoint != nil else { return }
        guard !isShowingResult, !isGameplayPaused else { return }

        let location = touch.location(in: self)
        updateAimDots(from: launcherPosition, toward: location)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            clearAimDots()
            touchStartPoint = nil
            return
        }
        guard !isShowingResult, !isGameplayPaused else {
            clearAimDots()
            touchStartPoint = nil
            return
        }
        guard canLaunchRock?() ?? true else {
            clearAimDots()
            touchStartPoint = nil
            return
        }
        guard touchStartPoint != nil else { return }
        launchRock(toward: touch.location(in: self))
        clearAimDots()
        touchStartPoint = nil
    }

    // Shared by touch input and deterministic gameplay checks.
    func launchRock(toward location: CGPoint) {
        guard !isShowingResult, !isGameplayPaused,
              canLaunchRock?() ?? true,
              let level = currentLevel else { return }
        let direction = CGVector(
            dx: location.x - launcherPosition.x,
            dy: location.y - launcherPosition.y
        )

        let length = sqrt(direction.dx * direction.dx + direction.dy * direction.dy)
        guard length > 0 else { return }

        let vx = (direction.dx / length) * level.launchSpeed
        let vy = (direction.dy / length) * level.launchSpeed

        let rockNode = makeNode(
            type: .rock,
            position: launcherPosition,
            velocity: CGVector(dx: vx, dy: vy),
            radius: level.launchedRockRadius
        )
        addChild(rockNode)
        objectNodes.append(rockNode)

        hasLaunchedRock = true
        didUseAmmo?()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        clearAimDots()
        touchStartPoint = nil
    }

    // MARK: - Aim dots

    private func updateAimDots(from start: CGPoint, toward end: CGPoint) {
        clearAimDots()

        let dx = end.x - start.x
        let dy = end.y - start.y
        let length = sqrt(dx * dx + dy * dy)
        guard length > 0 else { return }

        let ux = dx / length
        let uy = dy / length

        for i in 1...aimDotCount {
            let dot = SKShapeNode(circleOfRadius: 3)
            dot.fillColor = accentColor
            dot.strokeColor = .clear
            dot.zPosition = 20
            dot.position = CGPoint(
                x: start.x + ux * CGFloat(i) * aimDotSpacing,
                y: start.y + uy * CGFloat(i) * aimDotSpacing
            )
            addChild(dot)
            aimDots.append(dot)
        }
    }

    private func clearAimDots() {
        for dot in aimDots {
            dot.removeFromParent()
        }
        aimDots.removeAll()
    }

    // MARK: - Update loop

    override func update(_ currentTime: TimeInterval) {
        guard currentLevel != nil, !isGameplayPaused, !isShowingResult else { return }
        guard size.width > 0 && size.height > 0 else { return }

        let dt: CGFloat = 1.0 / 60.0

        moveObjects(dt: dt)
        handleConversions()
        evaluateGameState()
    }

    private func moveObjects(dt: CGFloat) {
        let minX = arenaInset
        let maxX = size.width - arenaInset
        let minY = arenaInset + 24
        let maxY = size.height - arenaInset

        for node in objectNodes {
            guard let vx = node.userData?["vx"] as? CGFloat,
                  let vy = node.userData?["vy"] as? CGFloat,
                  let radius = node.userData?["radius"] as? CGFloat else {
                continue
            }

            var newX = node.position.x + vx * dt
            var newY = node.position.y + vy * dt
            var newVX = vx
            var newVY = vy
            let oldPosition = node.position

            if newX - radius < minX {
                newX = minX + radius
                newVX *= -1
            } else if newX + radius > maxX {
                newX = maxX - radius
                newVX *= -1
            }

            if newY - radius < minY {
                newY = minY + radius
                newVY *= -1
            } else if newY + radius > maxY {
                newY = maxY - radius
                newVY *= -1
            }

            bounceOffWalls(
                x: &newX,
                y: &newY,
                vx: &newVX,
                vy: &newVY,
                radius: radius,
                oldPosition: oldPosition
            )

            node.position = CGPoint(x: newX, y: newY)
            node.userData?["vx"] = newVX
            node.userData?["vy"] = newVY
        }
    }

    private func bounceOffWalls(
        x: inout CGFloat,
        y: inout CGFloat,
        vx: inout CGFloat,
        vy: inout CGFloat,
        radius: CGFloat,
        oldPosition: CGPoint
    ) {
        for wall in wallRects {
            let expandedWall = wall.insetBy(dx: -radius, dy: -radius)
            guard expandedWall.contains(CGPoint(x: x, y: y)) else { continue }

            if oldPosition.x + radius <= wall.minX {
                x = wall.minX - radius
                vx = -abs(vx)
            } else if oldPosition.x - radius >= wall.maxX {
                x = wall.maxX + radius
                vx = abs(vx)
            } else if oldPosition.y + radius <= wall.minY {
                y = wall.minY - radius
                vy = -abs(vy)
            } else if oldPosition.y - radius >= wall.maxY {
                y = wall.maxY + radius
                vy = abs(vy)
            } else {
                let xDistance = min(abs(x - wall.minX), abs(x - wall.maxX))
                let yDistance = min(abs(y - wall.minY), abs(y - wall.maxY))

                if xDistance < yDistance {
                    x = oldPosition.x
                    vx *= -1
                } else {
                    y = oldPosition.y
                    vy *= -1
                }
            }
        }
    }

    // MARK: - RPS conversion

    private func handleConversions() {
        guard objectNodes.count >= 2 else { return }

        for i in 0..<(objectNodes.count - 1) {
            for j in (i + 1)..<objectNodes.count {
                let a = objectNodes[i]
                let b = objectNodes[j]

                guard let typeA = objectType(for: a),
                      let typeB = objectType(for: b),
                      let radiusA = a.userData?["radius"] as? CGFloat,
                      let radiusB = b.userData?["radius"] as? CGFloat else {
                    continue
                }

                let dx = a.position.x - b.position.x
                let dy = a.position.y - b.position.y
                let distanceSq = dx * dx + dy * dy
                let allowed = radiusA + radiusB

                if distanceSq <= allowed * allowed {
                    applyRPSBetween(a: a, typeA: typeA, b: b, typeB: typeB)
                }
            }
        }
    }

    private func applyRPSBetween(
        a: SKSpriteNode,
        typeA: ObjectType,
        b: SKSpriteNode,
        typeB: ObjectType
    ) {
        if typeA == typeB {
            return
        }

        switch (typeA, typeB) {
        case (.rock, .scissors):
            setType(.rock, for: b)

        case (.scissors, .rock):
            setType(.rock, for: a)

        case (.scissors, .paper):
            setType(.scissors, for: b)

        case (.paper, .scissors):
            setType(.scissors, for: a)

        case (.paper, .rock):
            setType(.paper, for: b)

        case (.rock, .paper):
            setType(.paper, for: a)

        default:
            break
        }
    }

    // MARK: - Win/loss detection

    private func evaluateGameState() {
        guard !isShowingResult, !isGameplayPaused else { return }
        guard objectNodes.isEmpty == false else { return }

        var rockCount = 0
        var paperCount = 0
        var scissorsCount = 0

        for node in objectNodes {
            guard let type = objectType(for: node) else { continue }

            switch type {
            case .rock:
                rockCount += 1
            case .paper:
                paperCount += 1
            case .scissors:
                scissorsCount += 1
            }
        }

        if rockCount == objectNodes.count {
            isShowingResult = true
            onWin?(.rock)
            return
        }

        if paperCount == objectNodes.count {
            isShowingResult = true
            onLose?(.paper)
            return
        }

        // Scissors-only lessons and cleared paper setups remain safe until the first shot.
        if scissorsCount == objectNodes.count && (hasLaunchedRock || !(canLaunchRock?() ?? true)) {
            isShowingResult = true
            onLose?(.scissors)
            return
        }

        if paperCount > 0 && scissorsCount == 0 {
            isShowingResult = true
            lossMessage = "Only rocks and paper remain. Keep scissors alive until all the paper is gone!"
            onLose?(.paper)
        }
    }
}
