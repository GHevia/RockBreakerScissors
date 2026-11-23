// Offline mirror of GameScene. Types: rock=0, paper=1, scissors=2.
#include <algorithm>
#include <cmath>
#include <iostream>
#include <vector>
#include <random>
using namespace std;
struct Obj { int type; double x,y,vx,vy,r; };
struct Wall { double x,y,w,h; };
struct Level { int n,ammo; double speed,r; vector<Obj> objects; vector<Wall> walls; };
struct Shot { int frame; double x,y; };
struct Result { bool won=false; int frame=0; vector<Shot> shots; };
struct Sim {
    Level l; double w,h; vector<Obj> objects; vector<Wall> walls; int ammo; bool fired=false;
    Sim(Level level,double width,double height):l(level),w(width),h(height),ammo(l.ammo) {
        objects=l.objects; walls=l.walls;
        for(auto &o:objects) { o.x=24+o.x*(w-48); o.y=48+o.y*(h-72); o.r*=.8; }
        for(auto &a:walls) { a.x=24+a.x*(w-48);a.y=48+a.y*(h-72);a.w=max(8.,a.w*(w-48));a.h=max(8.,a.h*(h-72)); }
    }
    void shoot(double x,double y) {
        if(ammo<=0)return;
        double dx=x-w*.5,dy=y-24,len=hypot(dx,dy);
        if(len==0)return;
        objects.push_back({0,w*.5,24,dx/len*l.speed,dy/len*l.speed,l.r*.8}); --ammo; fired=true;
    }
    int step() {
        for(auto &o:objects) {
            double ox=o.x,oy=o.y; o.x+=o.vx/60; o.y+=o.vy/60;
            if(o.x-o.r<24) {o.x=24+o.r;o.vx*=-1;} else if(o.x+o.r>w-24){o.x=w-24-o.r;o.vx*=-1;}
            if(o.y-o.r<48) {o.y=48+o.r;o.vy*=-1;} else if(o.y+o.r>h-24){o.y=h-24-o.r;o.vy*=-1;}
            for(auto a:walls) {
                double x0=a.x-a.w/2,x1=a.x+a.w/2,y0=a.y-a.h/2,y1=a.y+a.h/2;
                if(o.x<x0-o.r||o.x>=x1+o.r||o.y<y0-o.r||o.y>=y1+o.r)continue;
                if(ox+o.r<=x0){o.x=x0-o.r;o.vx=-abs(o.vx);}
                else if(ox-o.r>=x1){o.x=x1+o.r;o.vx=abs(o.vx);}
                else if(oy+o.r<=y0){o.y=y0-o.r;o.vy=-abs(o.vy);}
                else if(oy-o.r>=y1){o.y=y1+o.r;o.vy=abs(o.vy);}
                else if(min(abs(o.x-x0),abs(o.x-x1))<min(abs(o.y-y0),abs(o.y-y1))){o.x=ox;o.vx*=-1;}
                else {o.y=oy;o.vy*=-1;}
            }
        }
        for(size_t i=0;i<objects.size();++i)for(size_t j=i+1;j<objects.size();++j){
            auto &a=objects[i];auto &b=objects[j];
            double dx=a.x-b.x,dy=a.y-b.y,r=a.r+b.r;
            if(a.type==b.type||dx*dx+dy*dy>r*r)continue;
            if((a.type==0&&b.type==2)||(a.type==2&&b.type==1)||(a.type==1&&b.type==0))b.type=a.type;
            else a.type=b.type;
        }
        int counts[3]={};for(auto o:objects)++counts[o.type];
        if(counts[0]==int(objects.size()))return 1;
        if(counts[1]==int(objects.size()))return -1;
        if(counts[2]==int(objects.size())&&(!(l.n>=1&&l.n<=5)||fired||ammo==0))return -1;
        return 0;
    }
};
Result search(Level l,double w,double h) {
    // Seeded policies try early rocks, safe delayed shots, and paper deliveries with backup rocks.
    mt19937 rng(l.n); uniform_real_distribution<double> unit(0,1);
    for(int attempt=0;attempt<540;++attempt) {
        Sim s(l,w,h); Result r; int next=attempt<36?30+(attempt%12)*30:(attempt-36)%24;
        for(int frame=0;frame<7200;++frame) {
            bool paper=false;for(auto o:s.objects)paper|=o.type==1;
            bool delivery = attempt >= 180;
            if(s.ammo>0&&frame>=next&&(!paper||(!delivery&&attempt>=36)||(delivery&&s.ammo>=l.ammo-2))) {
                double x=w*(.12+.76*unit(rng)),y=h*(.3+.6*unit(rng));
                if(delivery && paper && !s.fired) {
                    vector<Obj> papers;for(auto o:s.objects)if(o.type==1)papers.push_back(o);
                    auto target=papers[attempt%papers.size()];
                    x=target.x+(unit(rng)-.5)*target.r;
                    y=target.y+(unit(rng)-.5)*target.r;
                }
                s.shoot(x,y);r.shots.push_back({frame,x/w,y/h});
                next=frame+(delivery?60+(attempt%8)*24:12+(attempt%8)*24);
            }
            int state=s.step();if(state!=0){if(state==1){r.won=true;r.frame=frame;return r;}break;}
            // Solver pruning only: mixed rock/paper is not an in-game loss.
            bool anyPaper=false,anyScissors=false;
            for(auto o:s.objects){anyPaper|=o.type==1;anyScissors|=o.type==2;}
            if(anyPaper&&!anyScissors)break;
        }
    }
    return {};
}
int main(){
    cout.precision(17);
    int n;cin>>n;int wins=0,issues=0;
    cout<<"level,width,height,objects,paper,scissors,rocks,ammo,launch_speed,radius,walls,overlaps,wall_overlaps,idle_loss_seconds,win_seconds,shots\n";
    for(int k=0;k<n;++k){
        Level l;int no,nw;cin>>l.n>>l.ammo>>l.speed>>l.r>>no>>nw;
        for(int i=0;i<no;++i){Obj o;double angle,speed;cin>>o.type>>o.x>>o.y>>angle>>speed>>o.r;o.vx=cos(angle*M_PI/180)*speed;o.vy=sin(angle*M_PI/180)*speed;l.objects.push_back(o);}
        for(int i=0;i<nw;++i){Wall a;cin>>a.x>>a.y>>a.w>>a.h;l.walls.push_back(a);}
        for(auto size:vector<pair<double,double>>{{320,568},{390,600},{768,900}}){
            Sim initial(l,size.first,size.second);int overlaps=0,wallOverlaps=0,counts[3]={};
            for(auto o:initial.objects) {
                ++counts[o.type];
                for(auto a:initial.walls) if(abs(o.x-a.x)<a.w/2+o.r&&abs(o.y-a.y)<a.h/2+o.r)++wallOverlaps;
            }
            for(size_t i=0;i<initial.objects.size();++i)for(size_t j=i+1;j<initial.objects.size();++j){auto a=initial.objects[i],b=initial.objects[j];if(hypot(a.x-b.x,a.y-b.y)<=a.r+b.r)++overlaps;}
            int idleLoss=-1;for(int f=0;f<180;++f)if(initial.step()==-1){idleLoss=f;break;}
            auto result=search(l,size.first,size.second); wins+=result.won;issues+=(overlaps+wallOverlaps>0);
            cout<<l.n<<','<<size.first<<','<<size.second<<','<<no<<','<<counts[1]<<','<<counts[2]<<','<<counts[0]<<','<<l.ammo<<','<<l.speed<<','<<l.r<<','<<nw<<','<<overlaps<<','<<wallOverlaps<<','<<(idleLoss<0?-1:idleLoss/60.)<<','<<(result.won?result.frame/60.:-1)<<",\"";
            for(auto shot:result.shots)cout<<shot.frame<<':'<<shot.x<<':'<<shot.y<<';';cout<<'"'<<'\n';
        }
    }
    cerr<<wins<<"/"<<n*3<<" layout/size combinations have a simulated winning sequence; "<<issues<<" have startup overlaps.\n";
}
