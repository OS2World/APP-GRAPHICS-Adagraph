-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ    Package Adagraph.line                                      บ
-- บ                                                               บ
-- บ    Complex and Special Line Drawing                           บ
-- บ   Author Leonid Dulman                                        บ
-- บ                 1996                                          บ
-- บ                                                               บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
with Addtype; use Addtype;
with Elemfunc; Use Elemfunc;
with ssp  ; use ssp  ;
with grafcom; use grafcom ;
package  body Adagraph.linedraw is
-------------------------------------------------------------------
-- draw  spline curve
procedure sincl(xb,step:float;y:vector;n:integer) is
b:vector(0..3);
z,dy1,dy2,xbeg,dx,dx1,xf2,yf2,f,x1,x2,xf1,yf1,xj,k:float;
begin   xbeg:=xb; dx:=step;
tmf(xbeg,y(1),xf2,yf2); move(xf2,yf2,0);
if n<2 then return; end if;
if n=2 then x2:=xbeg+dx; tmf(x2,y(2),xf2,yf2); move(xf2,yf2,1);return;end if;
f:=1.0/(0.25*rdb(1)/rdb(17));  x2:=xbeg; dy2:=deriv5(dx,y,n,1);
for i in 2..n  loop  x1:=x2; dy1:=dy2; x2:=x1+dx; dy2:=deriv5(dx,y,n,i);
b:=cubpol(x1,x2,y(i-1),y(i),dy1,dy2);  xf1:=xf2; yf1:=yf2;
tmf(x2,y(i),xf2,yf2); xj:=x1; k:=sqrt((xf2-xf1)**2+(yf2-yf1)**2)*f+1.0;
dx1:=dx/float(integer(k)+1);
for j in 1..integer(k) loop  xj:=xj+dx1; z:=poly(b,xj);
                             tmf(xj,z,xf1,yf1); move(xf1,yf1,1); end loop;
move(xf2,yf2,1); end loop;
end sincl;
------------------------------------------------------------------------
procedure sincl(x:vector;y:vector;nb,ne:integer) is
b:vector(0..3); n:integer;
z,dy1,dy2,xbeg,dx,dx1,xf2,yf2,f,x1,x2,xf1,yf1,xj,k:float;
begin   n:=ne-nb+1;
if n<2 then return; end if;
xbeg:=x(nb); dx:=x(nb+1)-x(nb);
tmf(xbeg,y(nb),xf2,yf2); move(xf2,yf2,0);
if n=2 then x2:=xbeg+dx; tmf(x2,y(nb+1),xf2,yf2); move(xf2,yf2,1);return;end if;
f:=1.0/(0.25*rdb(1)/rdb(17));  x2:=xbeg; dy2:=deriv5(dx,y,n,nb);
for i in nb+1..ne  loop  x1:=x2; dy1:=dy2; dx:=x(i)-x(i-1);
x2:=x1+dx; dy2:=deriv5(dx,y,n,i);
b:=cubpol(x1,x2,y(i-1),y(i),dy1,dy2);  xf1:=xf2; yf1:=yf2;
tmf(x2,y(i),xf2,yf2); xj:=x1; k:=sqrt((xf2-xf1)**2+(yf2-yf1)**2)*f+1.0;
dx1:=dx/float(integer(k)+1);
for j in 1..integer(k) loop  xj:=xj+dx1; z:=poly(b,xj);
                             tmf(xj,z,xf1,yf1); move(xf1,yf1,1); end loop;
move(xf2,yf2,1); end loop;
end sincl;
------------------------------------------------------------------------
procedure sincl(xy:matrix;nb,ne:integer) is
b:vector(0..3); n:integer; y:vector(nb..ne);
z,dy1,dy2,xbeg,dx,dx1,xf2,yf2,f,x1,x2,xf1,yf1,xj,k:float;
begin    n:=ne-nb+1;
if n<2 then return; end if;
for i in nb..ne loop y(i):=xy(i,2); end loop;
xbeg:=xy(nb,1); dx:=xy(nb+1,1)-xy(nb,1);
tmf(xbeg,y(nb),xf2,yf2); move(xf2,yf2,0);
if n=2 then x2:=xbeg+dx; tmf(x2,xy(nb+1,2),xf2,yf2); move(xf2,yf2,1);return;end if;
f:=1.0/(0.25*rdb(1)/rdb(17));  x2:=xbeg; dy2:=deriv5(dx,y,n,nb);
for i in nb+1..ne  loop  x1:=x2; dy1:=dy2; dx:=xy(i,1)-xy(i-1,1);
x2:=x1+dx; dy2:=deriv5(dx,y,n,i);
b:=cubpol(x1,x2,y(i-1),y(i),dy1,dy2);  xf1:=xf2; yf1:=yf2;
tmf(x2,y(i),xf2,yf2); xj:=x1; k:=sqrt((xf2-xf1)**2+(yf2-yf1)**2)*f+1.0;
dx1:=dx/float(integer(k)+1);
for j in 1..integer(k) loop  xj:=xj+dx1; z:=poly(b,xj);
                             tmf(xj,z,xf1,yf1); move(xf1,yf1,1); end loop;
move(xf2,yf2,1); end loop;
end sincl;
------------------------------------------------------------------------
procedure DASHP(X,Y,DL: float) is
f,d,dx,dy,s : float ;

begin
move(xtr,ytr,0) ;
if dl< 0.01 then move(x,y,0); return; end if; -- length very small
f:=rdb(17)/rdb(1) ;
dx:=x-xtr ;
dy:=y-ytr ;
s:=sqrt(dx*dx+dy*dy) ;
if s <  0.5*f then move(x,y,1); return; end if;
d := abs dl ;
dx:=d*(dx/s) ;
dy:=d*(dy/s) ;

if dl > 0.0 then  -- shade line
   loop
      s:=s-1.3*d ;
      exit when s < 0.0 ;
      move(xtr+dx,ytr+dy,1) ;
      move(xtr+0.3*dx,ytr+0.3*dy,0) ;
   end loop ;
   move(x,y,1) ;
   return ;
end if;
--               shade-dotted line
loop
  s:=s-1.23*d ;
  exit when s < 0.0 ;
  move(xtr+dx,ytr+dy,1) ;
  move(xtr+0.1*dx,ytr+0.1*dy,0) ;
  move(xtr+0.03*dx,ytr+0.03*dy,1) ;
  move(xtr+0.1*dx,ytr+0.1*dy,0) ;
end loop ;
move(x,y,1) ;
end DASHP ;
------------------------------------------------------------------------
procedure FATLIN(XF,YF,D:float)  is
x0,y0,sl,f,dx,dy:float;
begin
x0  :=  xtr;  y0  :=  ytr ;
sl  :=  sqrt((xf-x0)**2+(yf-y0)**2) ;
if sl <  1.0e-3 then return ; end if;
f  :=  rdb(17)/rdb(1) ;  f  :=  (d*0.1-0.03)*f/sl ;
dx  :=  f*(yf-y0) ;  dy  :=  f*(x0-xf) ;
move(xf,yf,1) ; move(xtr+dx/2.0,ytr+dy/2.0,1) ;
move(x0+dx/2.0,y0+dy/2.0,1) ; move(xtr-dx,ytr-dy,1) ;
move(xf-dx/2.0,yf -dy/2.0,1); move(xf,yf,1) ;
end  FATLIN;
------------------------------------------------------------------------
procedure BROLIN(K:integer;XS1,YS1,XF1,YF1,S1,S2:float )  is

--   TO DRAW A CHARACTER LINE  (A WROKEN LINE, ONE DOT-CHAIN LINE AND TO

--   K        SELECTIVE PARAMETER OF CHARACTER LINE.
--   K=1      BROKEN LINE
--   K=2      ONE DOT CHAIN LINE
--   K=3      TWO DOT CHAIN LINES
--   XS1,YS1  X AND Y COORDINATES OF A STARTING POINT OF THE CHAR.LINE
--   XF1,YF1 X AND Y COORDINATES OF AN END POINT OF THE CAR. LINE
--   S1       LENGTH OF THE LONG SEGMENT.
--   S2       LENGTH OF THE SHORT SEGMENT AND THE SPACE.
xss,yss,xff,yff,sleng,thett,theta,xf,yf,cleng,
xsign,ysign,xpitch,ypitch,xspace,yspace,xs,ys  : float;
kk:integer ;

function sign(x,y:float) return float is
begin
if x*y > 0.0 then return 1.0; elsif x*y < 0.0 then return -1.0;
             else return 0.0 ;
end if;
end sign ;

begin
xss := xs1;
yss := ys1 ;
xff := xf1 ;
yff := yf1 ;
sleng := sqrt((xss-xff)**2+(yss-yff)**2) ;
if xff = xss then theta := 0.5 * PI ;
             else thett := abs((yff-yss)/(xff-xss)); theta := arctan(thett);
end if;
 xsign := xff-xss ;
 ysign := yff-yss ;
 xpitch := sign(s1,xsign)*cos(theta) ;
 ypitch := sign(s1,ysign)*sin(theta) ;
 xspace := sign(s2,xsign)*cos(theta) ;
 yspace := sign(s2,ysign)*sin(theta) ;
 xs := xss ; ys := yss ;

 case k is
    when 1 =>    --  character line ***hasen
      loop
        xf := xs+xpitch ;
        yf := ys+ypitch ;
        cleng := sqrt((xss-xf)**2+(yss-yf)**2) ;
        exit when cleng >= sleng ;
        move(xs,ys,0) ; move(xf,yf,1) ;
        xs := xf+xspace ; ys := yf+yspace ;
        cleng := sqrt((xss-xs)**2+(yss-ys)**2) ;
       if cleng >= sleng then return  ;  end if;
     end loop;
     move(xs,ys,0) ;  move(xff,yff,1) ;
     return ;

  when 2 =>  --  character line ***1 ten basen
    kk := 1 ;
    loop
      if kk > 1 then  kk := 1 ; xf := xs+xspace ; yf := ys+yspace ; end if;
      kk := 2 ; xf := xs+xpitch ; yf := ys+ypitch ;
      cleng := sqrt((xss-xf)**2+(yss-yf)**2) ;
      exit when cleng >= sleng ;
      move(xs,ys,0) ; move(xf,yf,1) ;
      xs := xf+xspace ; ys := yf+yspace ;
      cleng := sqrt((xss-xs)**2+(yss-ys)**2) ;
      if cleng >= sleng then return ; end if;
    end loop;
    move(xs,ys,0) ;  move(xff,yff,1) ;
    return ;
  when 3 =>   --  character line ***2 ten sasen
    kk := 3 ;
    loop --  305 goto (310,320,330),kk
      case kk is
        when 1 => kk := 2 ; xf := xs+xspace ;  yf := ys+yspace ;
        when 2 => kk := 3 ; xf := xs+xspace ;  yf := ys+yspace ;
        when 3 => kk := 1 ; xf := xs+xpitch ; yf := ys+ypitch ;
        when others => null ;
      end case ;
      cleng := sqrt((xss-xf)**2+(yss-yf)**2) ;
      exit when cleng >= sleng;
      move(xs,ys,0) ; move(xf,yf,1) ;
      xs := xf+xspace ; ys := yf+yspace ;
      cleng := sqrt((xss-xs)**2+(yss-ys)**2) ;
      if cleng >= sleng then return; end if;
    end loop ;
    move(xs,ys,0) ;  move(xff,yff,1) ;
    return ;
    when others => Null ;
 end case;
end  BROLIN ;

end  Adagraph.linedraw;
