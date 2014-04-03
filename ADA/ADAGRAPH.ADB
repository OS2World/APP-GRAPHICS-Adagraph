with Text_io; use Text_io;
with builtin; use builtin;
with Elemfunc; Use Elemfunc;
with addtype; use addtype;
with grafcom; use grafcom;
with tvgraph; use tvgraph;
with mvgraph; use mvgraph;
package body adagraph is

--  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
--  ³ System inpendent Grafic package          ³
--  ³     for GNAT ADA 95                      ³
--  ³                                          ³
--  ³ ....*(irdb(2),irdb(4))*...............   ³
--  ³ ....*.................*(irdb(3),irdb(5)) ³
--  ³ ......................................   ³
--  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
-------------------------------------------------------------------
procedure gffals(n:integer) is
begin  grfin;
case n is
when 0 => put("Adagraph: very many brackets");
when 1 => put("Adagraph:number of brackets is not right");
when 2 => put("Adagraph: bank number ");put(integer'image(njch));
          put(" overflow");
when 3 => put("Adagraph: very many screens ");
when 4 => put("Adagraph: very many banks");
when 5 => put("Adagraph: mistake in parameters");
when 6 => put("Adagraph: mistake in geometric element");
when 7 => put("Adagraph: All point drawing");
when others => null;
end case;
end gffals;
-------------------------------------------------------------------
function i_point(x:float) return integer is
i:integer; dx:float;
begin
dx:=x/rdb(5)*float(irdb(5)-irdb(4));
i:=irdb(4)+integer(dx);
return i;
end i_point;
----------------------------------------------------------------
function j_point(y:float) return integer is
j:integer; dy:float;
begin
dy:=y/rdb(6)*float(irdb(3)-irdb(2));
j:=irdb(2)+integer(dy);
return j;
end j_point;
----------------------------------------------------------
procedure plot(k:integer) is
begin
i_beg:=i_point(xa_old);
i_kon:=i_point(xa_new);
j_beg:=j_point(ya_old);
j_kon:=j_point(ya_new);
if k=0 then wrt(-xa_new);  wrt(-ya_new);
       else wrt(xa_new) ;  wrt(ya_new);
end if;
end plot;
----------------------------------------------------------
procedure symtab   is
str:string(1..5); st:string(1..87);
n:integer;
begin
--   formula removing
--   100*(•+10) + (“+10)
--   pen up  - , pen down  +
for i in 15..254  loop  shrift(i).kplot:=0; end loop;
for i in 15..254  loop
   blank(st,i);
   str:=substr(st,1,5); n:=get_i(str); shrift(i).kplot:=n;
   for j in 1..n  loop
      str:=substr(st,5*j+1,5);
      shrift(i).nplot(j):=get_i(str);
   end loop; -- j
end loop;  -- i
end symtab;
----------------------------------------------------------
procedure grinit(fn:string:="adagraph.mov";i_top:integer:=0;i_bot:integer:=199;
                 j_left:integer:=0;j_right:integer:=319;al:integer:=16#0d#) is
begin
irdb(2):=i_top; irdb(3):=i_bot; irdb(4):=j_left; irdb(5):=j_right;
x_old:=0.0; y_old:=0.0;x_new:=0.0; y_new:=0.0;
xa_old:=0.0; ya_old:=0.0;xa_new:=0.0; ya_new:=0.0;
open_mov(fn);
if irdb(1)=0 then open_tabl;  symtab; close_tabl; end if;
irdb(1):=irdb(1)+1; -- counter
end   grinit;
 -------------------------------------------------------------------
procedure grfin(al:integer:=16#02#) is
begin
wrt(9999.0); close_mov;
end grfin;
 -------------------------------------------------------------------
procedure page(xl,yl:float;name:string;n,j:integer) is
x,y:float;
begin
x:=xl; y:=yl; irdb(1):=2;
rdb(5):=x; rdb(9):=x; rdb(13):=x;
rdb(6):=y; rdb(10):=y; rdb(14):=y;
i_beg:=irdb(4); i_kon:=irdb(5); j_beg:=irdb(3); j_kon:=irdb(2);
wrt(xl); wrt(yl); move(0.0,0.0);
put_edit(" Page size",yl,6); put_edit(" x ",xl,6);
if j=0 then goto fin; end if;
move(0.0,0.0,1); move(0.0,yl,1); move(xl,yl,1); move(xl,0.0,1); move(0.0,0.0,1);
symbol(0.0,yl-0.21,0.21,name,n,0.0);
<<fin>> move(0.0,0.0,0);    xtr:=0.0; ytr:=0.0;
end page;
----------------------------------------------------------
procedure atran2(a1,b1,c1:in float;a2,b2,c2:in float) is

procedure mtmpl(al1,bl1,cl1,al2,bl2,cl2,ar1,br1,cr1,ar2,br2,cr2:float;
                ae1,be1,ce1,ae2,be2,ce2: out float)  is
begin
ae1:=al1*ar1+bl1*ar2; be1:=al1*br1+bl1*br2; ce1:=al1*cr1+bl1*cr2+cl1;
ae2:=al2*ar1+bl2*ar2; be2:=al2*br1+bl2*br2; ce2:=al2*cr1+bl2*cr2+cl2;
end mtmpl;

begin
mtmpl (
a(1),a(2),a(3),a(4),a(5),a(6),
a1,b1,c1,a2,b2,c2,
r(1),r(2),r(3),r(4),r(5),r(6));
for i in 1..6 loop a(i):=r(i); end loop;
mtmpl (a(1),a(2),a(3),a(4),a(5),a(6),1.0,0.0,0.0,0.0,1.0,0.0,
       r(1),r(2),r(3),r(4),r(5),r(6));
iss:=1;
end atran2;
----------------------------------------------------------
procedure symbol(x,y,size:float;jtext:string;n:integer;theta:float:=0.0) is
ik,ipen:integer; ait,xnn,ynn,st,ct:float;
ps,fx,fy,xlp,ylp,xt,yt,xn,yn,xp,yp:float;
l,m,ix,iy,nn,nlit:integer;
begin  if n=0 then goto fin; end if;
ait:=rdb(2); ik:=1;
nn:=min(abs(n),jtext'last);
xlp:=rdb(5); ylp:=rdb(6); xp:=x; yp:=y;
if n<0 then  xp:=xp+x_old; yp:=yp+y_old; end if;
beglev; transl(xp,yp); move(0.0,0.0,0); -- start  place
ps:=radian*theta; st:=sin(ps); ct:=cos(ps);
if theta /= 0.0 then
-- for i in 1..6 loop ar(i):=r(i); aa(i):=a(i); end loop;
-- atran2(ct,-st,xp*(1.0-st)+yp*st,st,ct,-xp*st+yp*(1.0-ct));
rotate(0.0,0.0,theta);
                end if;
 xnn:=0.0; ynn:=0.0;

for i in 1..nn   loop   --  main sycle for draw litter
   nlit:=character'pos(jtext(i));
   if nlit not in 15..254 then nlit:=32; end if;
   l:=shrift(nlit).kplot;
   if l=0 then goto next; end if;
   ipen:=0;
   xn:=xnn;  yn:=ynn;
   for k in 1..l  loop   -- main sycle for point draw
     if shrift(nlit).nplot(k)<0  then ipen:=0; m:=abs(shrift(nlit).nplot(k));
                                  else ipen:=1; m:=shrift(nlit).nplot(k);
     end if;
     ix:=m/100; iy:=m-100*ix;
     yt:=float(iy-10)*size/10.0;  xt:=float(ix-10)*size/10.0+yt*ait;
     xn:=xn+xt;  yn:=yn+yt ;
     move(xn,yn,ipen);
   <<endk>> null;  end loop;  -- point draw cycle
   <<next>> fx:=xnn+0.6*size; fy:=ynn; move(fx,fy);
   xnn:=fx;  ynn:=fy;
end loop;  -- i         -- main cycle
endlev;
<<fin>>  null;
end   symbol;
----------------------------------------------------------
procedure marker(nm:integer:=0) is
nlit,l,ix,iy,m,ipen:integer;
xn,yn,xt,yt:float;
begin
nlit:=15+abs(nm);
l:=shrift(nlit).kplot;
if l=0 then goto next; end if;
ipen:=0;
xn:=x_new;  yn:=y_new;
for k in 1..l  loop   -- main sycle for point draw
   if shrift(nlit).nplot(k)<0  then ipen:=0; m:=abs(shrift(nlit).nplot(k));
                               else ipen:=1; m:=shrift(nlit).nplot(k);
   end if;
   ix:=m/100; iy:=m-100*ix; if nm<0 then ix:=ix/2; iy:=iy/2; end if;
   yt:=float(iy-10);  xt:=float(ix-10);
   xn:=xn+xt;  yn:=yn+yt ;
   move(xn,yn,ipen);
<<endk>> null; end loop;  -- point draw cycle
<<next>> null; end marker;
----------------------------------------------------------
procedure move(x,y:float;j:integer:=0) is
k:integer; x1,y1:float;
begin
x_old:=x_new; y_old:=y_new;xa_old:=xa_new; ya_old:=ya_new;
x_new:=x; y_new:=y;
xtr:=x; x1:=x; ytr:=y;  y1:=y;   -- xtr ytr old means coordinate
if iss>0 then x1:=r(1)*x+r(2)*y+r(3); y1:=r(4)*x+r(5)*y+r(6); end if;
x1:=min(rdb(5),max(0.0,x1)); y1:=min(rdb(6),max(0.0,y1)) ;
xa_new:=x1; ya_new:=y1;
k:=j mod 2;
plot(k);
xx1:=x1; ax:=x1; yy1:=y1; ay:=y1;
end move;
----------------------------------------------------------
procedure italic(j:integer:=0) is
begin
if j<0 then rdb(2):=-0.4; elsif j>0 then rdb(2):=0.4; end if;
end  italic;
----------------------------------------------------------
procedure set(j:integer:=0) is
begin
null;
end set;
----------------------------------------------------------
procedure where(x,y,f:in out float) is
begin
x:=x_old; y:=y_old; f:=rdb(1);
end  where;
----------------------------------------------------------
procedure number(x,y,z:float; fnum:integer; np:integer:=6;th:float:=0.0) is
s:string(1..np);
begin
s:=put_i(fnum,np);
symbol(x,y,z,s,np,th);
end number;
----------------------------------------------------------
procedure number(x,y,z:float; fnum:float;   np:integer:=6;th:float:=0.0) is
s:string(1..np);
begin
s:=put_f(fnum,np);
symbol(x,y,z,s,np,th);
end number;
----------------------------------------------------------
procedure pen(j:integer) is
begin
grafcom.color:=j ;
wrt(float(10000+j));
end pen;
----------------------------------------------------------
procedure beglev is
begin
level:=level+1;
if  level > 16   then  goto fin; end if;
for i in 1..6  loop as(i,level):=r(i); end loop;
isr(level):=iss;
<<fin>> null; end beglev;
----------------------------------------------------------
procedure endlev is
begin
if  level = 0   then goto fin; end if;
for i in 1..6   loop  r(i):=as(i,level); a(i):=r(i);    end loop;
iss:=isr(level);
level:=level-1;
<<fin>> null; end endlev;
----------------------------------------------------------
procedure reset is
begin
for i in 1..6 loop r(i):=as(i,level); a(i):=r(i); end loop;
end reset;
----------------------------------------------------------
procedure mova(dl,th:float;j:integer:=0)  is
al,dx,dy,x,y:float;
begin
al:=th*radian;
dx := cos(al)*dl ; dy := sin(al)*dl;
x := xtr + dx ; y := ytr + dy ;
move(x,y,j);
end mova;
----------------------------------------------------------
procedure movb(dx,dy:float;j:integer:=0)  is
begin
move(xtr+dx,ytr+dy,j);
end;
----------------------------------------------------------
procedure movc(xm,ym,dl:float;j:integer:=0)  is
dx,dy,dl1,d2:float;
begin
dx := xm-xtr; dy := ym-ytr; d2:=dx*dx+dy*dy; dl1 := sqrt(d2);
if dl1 < 1.0e-9 then goto fin; end if;
dx := xtr + dx*(dl/dl1); dy := ytr + dy*(dl/dl1);
move(dx,dy,j);
<<fin>> null; end movc;
----------------------------------------------------------
procedure transl(dx,dy:float) is
begin
atran2(1.0,0.0,dx,0.0,1.0,dy);
end transl;
----------------------------------------------------------
procedure rotate(x,y,psi:float) is
ps,st,ct,p3,p6:float;
begin
ps:=psi*radian; st:=sin(ps); ct:=cos(ps);
p3:=x*(1.0-ct)+y*st; p6:=-x*st+y*(1.0-ct);
atran2(ct,-st,p3,st,ct,p6);
end rotate;
----------------------------------------------------------
procedure pscale(x,y,rd:float) is
begin
atran2(rd,0.0,(1.0-rd)*x,0.0,rd,(1.0-rd)*y);
end pscale;
----------------------------------------------------------
procedure lscale(x1,y1,x2,y2,rd:float) is
artg,znak,dx,dy:float;
begin
dx:=x2-x1; dy:=y2-y1;
if    dx>=0.0  and dy >=0.0 then znak:=0.0;
elsif dx<=0.0  and dy >=0.0 then znak:=90.0;
elsif dx<=0.0  and dy <=0.0 then znak:=180.0;
elsif dx>=0.0  and dy <=0.0 then znak:=270.0;
end if;
if abs(dy) <1.0e-9  then
   atran2(1.0,0.0,0.0,0.0,rd,(1.0-rd)*y1);
   goto fin;
end if;
if abs(dx) <1.0e-9  then artg:=90.0;
                    else artg:=arctan(abs(dy/dx))/radian;
end if;
artg:=artg+znak;
rotate((x1*y2-x2*y1)/dy,0.0,-artg);
atran2(1.0,0.0,0.0,0.0,rd,0.0);
rotate((x1*y2-x2*y1)/dy,0.0,artg);
<<fin>> null; end  lscale;
----------------------------------------------------------
function angler(x,y:float) return float is
angl,d:float;
begin
d:=sqrt(x*x+y*y);
if d<1.0e-5 then angl:=0.0; goto fin; end if;
angl:=arcsin(abs(y)/d)/radian;
if y>=0.0 and x<=0.0 then angl:=180.0-angl; goto fin; end if;
if y<=0.0 and x<=0.0 then angl:=180.0+angl; goto fin; end if;
if y<=0.0 and x>=0.0 then angl:=360.0-angl;           end if;
<<fin>> return angl; end angler;
----------------------------------------------------------
procedure limits (xmin,xmax,ymin,ymax:float) is
xn,xx,yn,yx:float;
begin
xn:=xmin; xx:=xmax;
if xx = xn then  xx:=xx+1.0 ; xn:=xn-1.0 ; end if;
yn:=ymin ; yx:=ymax;
if yx = yn then  yx:=yx+1.0 ; yn:=yn-1.0 ; end if;
 rdb(11):=xn; rdb(12):=yn ;  rdb(13):=xx; rdb(14):=yx; irdb(3):=1 ;
end limits ;
----------------------------------------------------------
procedure region(x,y,xl,yl:float;name:string:=" ";
                 n:integer:=0;j:integer:=0) is
f,zm,z,xlr,ylr:float;
zh:float:= 0.0 ;
begin
if irdb(1) <=0 then goto fin; end if;
f:=rdb(17)/rdb(1); zm:=0.3*f; z:=xl/min(float(n),1.0);
if x<0.0 then irdb(1):=1; goto fin; end if;
if y<0.0 then irdb(1):=1; goto fin; end if;
xlr:=min(x+xl,rdb(5))-x; ylr:=min(y+yl,rdb(6))-y;
if xlr<f or ylr<f  then irdb(1):=1; goto fin; end if;
rdb(7):=x; rdb(8):=y; rdb(9):=xlr; rdb(10):=ylr;
if j>0 then box(x,y,xlr,ylr); end if;
if n>0 then symbol(x,y+ylr+zm,zh,name,n); end if;
irdb(1):=1;
<<fin>> null; end region;
----------------------------------------------------------
procedure box(x,y,xl,yl:float) is
x1,y1:float;
begin
x1:=x+xl; y1:=y+yl;
move(x,y);  move(x,y1,1); move(x1,y1,1); move(x1,y,1); move(x,y,1);
end box;
----------------------------------------------------------
procedure tmf(xm,ym:float;xf,yf:in out float)  is
cx,cy:float;
begin
cx:=rdb(9)/(rdb(13)-rdb(11)); cy:=rdb(10)/(rdb(14)-rdb(12));
xf:=rdb(7)+cx*(xm-rdb(11));   yf:=rdb(8)+cy*(ym-rdb(12));
end tmf;
----------------------------------------------------------
procedure  circle(xa,ya,th0,thf,r0,rf:float;l:integer:=1)  is
i2,i5,knt,n:integer;
x,y,rorrf,fctr,dth,t0,tf,c,tn,b,rn:float;
begin
i2:= 1 ; i5 := l + 1 ; x:=xa ; y:=ya; move (x,y);
knt:=5;rorrf := sqrt(abs(r0)+abs(rf)+0.00001);
fctr:=rdb(17)/rdb(1);dth:= (0.3/rorrf) * fctr;
t0:= th0/57.2958; tf:= thf/57.2958; c:= x-r0*cos(t0);tn:=(tf-t0) / dth;
if tf<t0 then  tn:=abs(tn);  dth:=-dth; end if;
b:=y-r0*sin(t0);  n:=integer(tn);
if n<=0 then goto fin; end if;
tn:=(rf-r0)/tn; rn:=r0-tn;
for i in 1..n  loop
  t0:=t0+dth; rn:=rn+tn; x:=rn*cos(t0)+c; y:=rn*sin(t0)+b;
  if knt<=0 then  i2:=i5-i2 ;  knt:=5 ; end if;
  knt:=knt-1;
  move(x,y,i2);
end loop;
<<fin>> x:=rf*cos(tf)+c; y:=rf*sin(tf)+b; move(x,y,i2) ;
end circle;
----------------------------------------------------------
procedure line(points:matrix;n:integer) is
ie,ib:integer;
begin
ib:=1; ie:=n;move(points(ib,1),points(ib,2),0);
for i in ib+1..ie loop move(points(i,1),points(i,2),1); end loop;
end  line;
----------------------------------------------------------
procedure line(x,y:vector;n:integer) is
ie,ib:integer;
begin
ib:=1; ie:=n;move(x(ib),y(ib),0);
for i in ib+1..ie loop move(x(i),y(i),1); end loop;
end  line;
----------------------------------------------------------
procedure lineo(x,y:vector;n:integer) is
j,m,l,inc:integer;
x0r,yor,xr,yr,df,dl,fx,fy,f,fx1,fy1:float;
begin
if irdb(2)<2 or irdb(3)<0 then return;  end if;
j:=0; x0r:=rdb(7); yor:=rdb(8); xr:=x0r+rdb(9); yr:=yor+rdb(10); m:=abs(n);
where(fx,fy,f);                      tmf(x(1),y(1),fx1,fy1);
df:=max(abs(fx1-fx),abs(fy1-fy));    tmf(x(m),y(m),fx1,fy1);
dl:=max(abs(fx1-fx),abs(fy1-fy));  l:=1;  inc:=1;
if df>dl then l:=m; inc:=-1; end if;
for  i in 1..m loop
   tmf(x(l),y(l),fx,fy); l:=l+inc;
   if n>0 then fx:=min(xr,max(x0r,fx)); fy:=min(yr,max(yor,fy)); end if;
   move(fx,fy,j);  j:=1;
end loop;
end  lineo;
----------------------------------------------------------
procedure lineo(points:matrix;n:integer) is
j,m,l,inc:integer;
x0r,yor,xr,yr,df,dl,fx,fy,f,fx1,fy1:float;
begin
if irdb(2)<2 or irdb(3)<0 then return; end if;
j:=0; x0r:=rdb(7); yor:=rdb(8); xr:=x0r+rdb(9); yr:=yor+rdb(10); m:=abs(n);
where(fx,fy,f);                      tmf(points(1,1),points(1,2),fx1,fy1);
df:=max(abs(fx1-fx),abs(fy1-fy));    tmf(points(m,1),points(m,2),fx1,fy1);
dl:=max(abs(fx1-fx),abs(fy1-fy));  l:=1;  inc:=1;
if df>dl then l:=m; inc:=-1; end if;
for  i in 1..m loop
   tmf(points(l,1),points(l,2),fx,fy); l:=l+inc;
   if n>0 then fx:=min(xr,max(x0r,fx)); fy:=min(yr,max(yor,fy)); end if;
   move(fx,fy,j);  j:=1;
end loop;
end  lineo;
----------------------------------------------------------
procedure mms  is
begin
if irdb(1)=0 then rdb(1):=0.1*rdb(17); irdb(1):=1; end if;
end mms;
----------------------------------------------------------
procedure inches  is
begin
if irdb(1)=0 then rdb(1):=2.54*rdb(17); irdb(1):=2; end if;
end inches;
----------------------------------------------------------
end adagraph;
