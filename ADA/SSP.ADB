with text_io; use text_io;
with builtin; use builtin;
with Elemfunc; Use Elemfunc;
with addtype; use addtype;
package body ssp is
--         ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
--         ³                                            ³
--         ³    Scientific program package              ³
--         ³    Author :  Leonid Dulman                 ³
--         ³                                            ³
--         ³             1990,1996                      ³
--         ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
--
--------------------------------------------------------------------
errssp:exception;
function dipoly(a:matrix;x,y:float) return float  is -- polynomial calculation
m,n:integer;
s,s1:float;
begin
m:=a'last(1); n:=a'last(2);
s:=0.0;
for i in reverse 0..m loop  s1:=0.0;
  for j  in reverse 0..n  loop  s1:=s1*y+a(i,j); end loop;
s:=s*x+s1;            end loop;
return s;    end dipoly;
--------------------------------------------------------------------
function poly(a:vector;x:float) return float  is -- vector calculation
n:integer;
s:float;
begin n:=a'last(1); s:=0.0;
for i in reverse 0..n loop
s:=s*x+a(i); end loop;
return s;    end poly;
--------------------------------------------------------------------
function sum(a:vector;ib,ie:integer) return float is
s:float;
begin s:=0.0;
for i in ib..ie loop s:=s+a(i); end loop;
return s; end sum;
--------------------------------------------------------------------
function sum(a:ivector;ib,ie:integer) return integer is
s:integer;
begin s:=0;
for i in ib..ie loop s:=s+a(i); end loop;
return s; end sum;
--------------------------------------------------------------------
function any(a:bvector;ib,ie:integer) return boolean is

begin
for i in ib..ie loop if a(i) then return true; end if; end loop;
return  false; end any;
--------------------------------------------------------------------
function any(a:ivector;n:integer;ib,ie:integer) return boolean is

begin
for i in ib..ie loop if a(i)=n then return true; end if; end loop;
return  false; end any;
--------------------------------------------------------------------
function bce(a:bvector;ib,ie:integer) return boolean is

begin
for i in ib..ie loop if not a(i) then return false; end if; end loop;
return  true; end bce;
--------------------------------------------------------------------
function bce(a:ivector;n:integer;ib,ie:integer) return boolean is

begin
for i in ib..ie loop if a(i) /= n then return false; end if; end loop;
return  true; end bce;
--------------------------------------------------------------------
--    find of index for interpolation
procedure find(x:vector;xa:in out float;ex:in out boolean; num:out integer) is
ex1,exn:boolean;
n:integer;
begin
n:=x'last(1); ex1:=xa<x(1); exn:=xa>x(n); ex:=ex1  or  exn ;
if ex1 then  xa:=max(xa,x(1)*2.0-x(2)); num:=1;   return; end if;
if exn then xa:=min(xa,x(n)*2.0-x(n-1));num:=n-1; return; end if;
for i  in 2..n loop if x(i)>=xa then num:=i-1;    return; end if; end loop;
end find;
------------------------------------------------------------------
--    formula of linear interpolation
function zzz(x1,x2,z1,z2,xa:float) return float is
begin return z1+(xa-x1)/(x2-x1)*(z2-z1) ;
end zzz;
------------------------------------------------------------------
-- yx :     linear  interpolation
procedure yx(x,y:vector;xa:in out float;ex:in out boolean;yy:out float) is
------------------------------------------------------------------
xb:float;
i:integer;
begin  ex:=false; xb:=xa; find(x,xb,ex,i);
if y(i)=0.0 then yy:=0.0; else --  ­®à¬ «ì­ë© å®¤
yy:=zzz(x(i),x(i+1),y(i),y(i+1),xb); end if;
end  yx ;
--------------------------------------------------------------------
--    interplation of two variable function
procedure zxy(x,y:vector;z:matrix;xa,ya:float;ex,ey:in out boolean;
              rez:out float) is
--------------------------------------------------------------
i,j:integer;xb,yb,zi,zi1,zj,zj1,zz1,zz2:float;
begin
xb:=xa; yb:=ya; find(x,xb,ex,i); find(y,yb,ey,j);
zj:=zzz(x(i),x(i+1),z(i,j),z(i+1,j),xb);
zj1:=zzz(x(i),x(i+1),z(i,j+1),z(i+1,j+1),xb);
zi:=zzz(y(j),y(j+1),z(i,j),z(i,j+1),yb);
zi1:=zzz(y(j),y(j+1),z(i+1,j),z(i+1,j+1),yb);
zz1:=zzz(x(i),x(i+1),zi,zi1,xb);
zz2:=zzz(y(j),y(j+1),zj,zj1,yb);
rez:=(zz1+zz2)/2.0;
end zxy; --   interpol-2   ;
--------------------------------------------------------------------
--    parabolic approcsimation
procedure ap2(ib,ie:integer;x0,y:vector;a:in out vector) is
x,z:vector(ib..ie);
n:integer;
xm,x2m,x3m,x4m,ym,xym,x2ym,fn:float;
begin  n:=ie-ib+1; fn:=float(n);
xm:=sum(x0,ib,ie)/fn;
for i in ib..ie loop x(i):=x0(i)-xm;  end loop;
for i in ib..ie loop z(i):=x(i)**2;  end loop; x2m:=sum(z,ib,ie)/fn;
for i in ib..ie loop z(i):=z(i)*x(i);end loop; x3m:=sum(z,ib,ie)/fn;
for i in ib..ie loop z(i):=z(i)*x(i);end loop; x4m:=sum(z,ib,ie)/fn;
ym:=sum(y,ib,ie)/fn;
for i in ib..ie loop z(i):=y(i)*x(i);end loop; xym:=sum(z,ib,ie)/fn;
for i in ib..ie loop z(i):=z(i)*x(i);end loop; x2ym:=sum(z,ib,ie)/fn;
a(2):=(x2ym-x2m*ym-x3m/x2m*xym)/(x4m-x2m**2-x3m**2/x2m);
a(1):=(xym-a(2)*x3m)/x2m;
a(0):=ym-a(2)*(x2m-xm**2)-a(1)*xm;
a(1):=a(1)-2.0*a(2)*xm;
end ap2 ;
--------------------------------------------------------------------
function aitken(x,f:vector;n:integer;xx:float) return float is -- Eitkin interpolation
y:float;  ff:vector(0..n);
begin  for i in 0..n loop ff(i):=f(i); end loop;
for j in 0..n-1 loop  for i in j+1..n loop
ff(i):=((xx-x(j))*ff(i)-(xx-x(i))*ff(j))/(x(i)-x(j));
end loop; end loop;
y:=ff(n); return y;
end aitken;
--------------------------------------------------------------------
function aitken(xf:matrix;n:integer;xx:float)  return float is -- Eitkin interpolation
y:float;  ff:vector(0..n);
begin  for i in 0..n loop ff(i):=xf(i,2); end loop;
for j in 0..n-1 loop  for i in j+1..n loop
ff(i):=((xx-xf(j,1))*ff(i)-(xx-xf(i,1))*ff(j))/(xf(i,1)-xf(j,1));
end loop; end loop;
y:=ff(n); return y;
end aitken;
--------------------------------------------------------------------
function cubpol(x1,x2,y1,y2,dy1,dy2:float) return vector is
h0,h1,dy,s1,s2:float; b:vector(0..3);
begin
h0:=1.0/(x2-x1); h1:=h0*h0; dy:=y2-y1; s1:=x2+2.0*x1; s2:=x1+2.0*x2;
b(0):=h1*(2.0*h0*x1*x2*(x1*y2-x2*y1)+y1*x2**2+y2*x1**2-x1*x2*(dy1*x2+dy2*x1));
b(1):=h1*(-6.0*h0*x1*x2*dy+dy1*x2*s1+dy2*x1*s2);
b(2):=3.0*h0*h1*(dy*(x2+x1))-h1*(dy1*s2+dy2*s1);
b(3):=h1*(dy2+dy1-2.0*h0*dy);
return b;
end cubpol;
--------------------------------------------------------------------
function deriv5(dx:float;y:vector;n,i:integer) return float is
a:float;
begin
if n<2 then raise numeric_error;    elsif n=2
       then return (y(2)-y(1))/dx;  end if;
if n<4 then  case i is
when 1 => a:=-18.0*y(i)+24.0*y(i+1)-6.0*y(i+2);
when 2 => a:=-6.0*y(i-1)+6.0*y(i);
when others => a:=6.0*y(i-2)-24.0*y(i-1)+18.0*y(i);
end case; goto fin; end if;
if n=4 then  case i is
when 1 => a:=4.0*y(4)-18.0*y(3)+36.0*y(2)-22.0*y(1);
when 2 => a:=-2.0*y(4)+12.0*y(3)-6.0*y(2)-4.0*y(1);
when 3 => a:=6.0*y(i-2)-24.0*y(i-1)+18.0*y(i);
when others=> a:=22.0*y(i)-36.0*y(i-1)+18.0*y(i-2)-4.0*y(i-3);
end case; goto fin; end if;
case i is
when 1 => a:=4.0*y(4)-18.0*y(3)+36.0*y(2)-22.0*y(1);
when 2 => a:=-2.0*y(4)+12.0*y(3)-6.0*y(2)-4.0*y(1);
when others =>
   if n-i-1<0  then a:=22.0*y(i)-36.0*y(i-1)+18.0*y(i-2)-4.0*y(i-3);
elsif n-i-1=0  then a:=3.0*y(i+1)+11.0*y(i)-21.0*y(i-1)+9.0*y(i-2)-2.0*y(i-3);
else                a:=-y(i+2)+8.0*y(i+1)-8.0*y(i-1)+y(i-2); end if;
end case;
<<fin>> return 0.083333*a/dx;
 end deriv5;
--------------------------------------------------------------------
end ssp;
