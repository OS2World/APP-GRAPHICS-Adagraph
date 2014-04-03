-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ    Package Adagraph.Curved                                    บ
-- บ       Circle Drawing                                          บ
-- บ                                                               บ
-- บ  Author : Leonid Dulman                                       บ
-- บ                                                               บ
-- บ                  1996                                         บ
-- บ          package body                                         บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
with text_io; use text_io;
with builtin; use builtin;
with Addtype; use Addtype;
with Elemfunc; Use Elemfunc;
with grafcom; use grafcom;
package body Adagraph.curved is
--------------------------------------------------------------
procedure arcc1(xm,ym,xf,yf:in out float;j:integer;
                r:in out float;jb:in out integer) is
a,b,c,p,s2,s1,z,alpha,s:float;
begin
a:=sqrt((xtr-xf)**2+(ytr-yf)**2); b:=sqrt((xf-xm)**2+(yf-ym)**2);
if ivest(a,0.0,0.000001) <0 then return; end if;
if ivest(a,0.0,0.000001) =0 then  r:=b/2.0; jb:=1; return; end if;
c:=sqrt((xm-xtr)**2+(ym-ytr)**2); p:=(a+b+c)/2.0;
s2:=p*(p-a)*(p-b)*(p-c);
if ivest(s2,0.0,0.000001) <0 then return ; end if;
if ivest(s2,0.0,0.000001) =0 then  r:=0.0; jb:=0;  return; end if;
s1:=sqrt(s2); r:=(a*b*c)/(4.0*s1); z:=sqrt((p-b)*(p-c)/(p*(p-a)));
alpha:=2.0*arctan(z)/0.01745329;    jb:=1;
if ivest(alpha,90.0,0.000001) >0 then jb:=0 ; end if;
s:=(xtr-xf)*(ym-yf)-(xm-xf)*(ytr-yf);
if ivest(s,0.0,0.000001) =0 then return ; end if;
if ivest(s,0.0,0.000001) <0 then r:=-r;  end if;
if j <= 0 then return ; end if;
jb:=1-jb;   r:=-r;
end arcc1;
--------------------------------------------------------------
procedure arcang(r:in out float;delx,dely:float;j:integer;
                 th0a,thfa:in out  float) is
rd,r1,cl,a,th0,thf,z,d,q1,q2:float;
begin
if ivest(abs(dely),0.0,0.000001 ) <0 or j<0 or
   ivest(abs(delx),0.0,0.000001 ) <0 or r=0.0 then return; end if;

rd:=180.0/3.141593;   r1:=abs(r);   cl:=sqrt(delx**2+dely**2);
if ivest(2.0*r1,cl,0.000001 ) <0 then r:=0.0;return; end if;
if ivest(2.0*r1,cl,0.000001 ) =0 then a:=0.0;  goto l11 ; end if;
z:=sqrt((r1-cl/2.0)/(r1+cl/2.0));   a:=2.0*rd*arctan(z);
if ivest(abs(dely),0.0,0.000001 ) >0 then goto l11;  end if;
if ivest(abs(delx),0.0,0.000001 ) =0 then
   th0a:=0.0;  thfa:=360.0;  return; end if;
if delx <0.0 then   th0:=a; thf:=180.0-a;  goto l100; end if;
th0:=180.0-a;  thf:=a;  goto l200;
if dely <0.0 then  th0:=90.0-a ;  thf:=270.0+a;  goto l200; end if;
th0:=270.0+a; thf:=90.0-a;   goto l100;
<<l11>> z:=abs(dely)/abs(delx);  d:=arctan(z)*rd; q1:=a-d; q2:=a+d;
if dely >0.0 then goto l17 ; end if;
if delx <0.0 then  th0:=q2; thf:=180.0-q1;  goto l100;
                  else  th0:=180.0-q2;  thf:=q1; goto l200; end if;
<<l17>>  if delx <0.0 then  th0:=q1;  thf:=180.0-q2; goto l100;
                  else  th0:=180.0-q1; thf:=q2; goto l200; end if;
<<l100>> if j >0 then
     if r <0.0 then goto l101;else  goto l102;end if; -- 14
end if;
     if r <0.0 then goto l102; else  goto l101; end if; -- 13
<<l200>> if j =0 then
     if r <0.0 then goto l101;else  goto l102;end if; -- 14
end if;
if r <0.0 then goto l102; else  goto l101; end if; -- 13
<<l101>> th0a:=th0;   thfa:=thf;  goto l300;
<<l102>> th0a:=thf+180.0;   thfa:=th0+180.0;
<<l300>>  if ivest(th0a,0.0,360.0) >0 then
   th0a:=abs(abs(th0a)-360.0)*float(sign(th0a));  end if;
if ivest(thfa,0.0,360.0) =0 then return; end if;
thfa:=abs(abs(thfa)-360.0)*float(sign(thfa));
end arcang;
-------------------------------------------------------------------
procedure arcia(r,th0,thf:float) is
r1,tn,x,y,th,th02,thf2,th01,thf1,fctr,dth,b,c:float;
n:integer;
begin
x:=xtr; y:=ytr; r1:=abs(r); th:=abs(th0-thf);
if ivest(th,360.0,0.00000001) >0 or r=0.0 then gffals(5); return; end if;
if ivest(th,360.0,0.00000001) =0 then goto l6; end if;
if th0 > thf then  goto l2 ; end if;
if r >0.0 then goto l6; end if;
th02:=th0+360.0;  thf2:=thf;  goto l3;
<<l2>> if r <0.0 then goto l6; end if;
thf2:=thf+360.0;  th02:=th0;  goto l3;
<<l6>> th02:=th0;  thf2:=thf;
<<l3>> th01:=th02*0.01745329;thf1:=thf2*0.01745329;
       fctr:=(rdb(17)/rdb(1))*2.54;
dth:=fctr*0.01/r1;c:=x-r1*cos(th01);tn:=(thf1-th01)/dth;
if thf1 <  th01 then tn:=abs(tn); dth:=-dth; end if;
b:=y-r1*sin(th01);   n:=integer(tn);
for i in 1..n loop  th01:=th01+dth; x:=r1*cos(th01)+c; y:=r1*sin(th01)+b;
move(x,y,1);
end loop;
x:=r1*cos(thf1)+c;   y:=r1*sin(thf1)+b; move(x,y,1);  return;
end arcia;
--------------------------------------------------------------
procedure arcib(r:float;xf,yf:in out float;j:integer) is
delx,dely,th0,thf,rr:float;
begin  delx:=xf-xtr; dely:=yf-ytr; rr:=r;
arcang(rr,delx,dely,j,th0,thf);
arcia(rr,th0,thf);
end arcib;
---------------------------------------------------------------------
procedure arcic(xm,ym:in out float;xf,yf:in out float;j:integer)  is
delx,dely,r,th0,thf:float; jb:integer;
begin  delx:=xf-xtr;    dely:=yf-ytr;
arcc1(xm,ym,xf,yf,j,r,jb);
arcang(r,delx,dely,jb,th0,thf);
arcia(r,th0,thf);
end arcic;
--------------------------------------------------------------------
procedure arcid(xc,yc,phi:float) is
delx,dely,r,th0,thf:float;
begin    delx:=xtr-xc;   dely:=ytr-yc;   r:=sqrt(delx**2+dely**2);
th0:=angler(delx,dely);    thf:=th0+phi;
if phi =0.0 then return; end if;
if phi<0.0 then r:=-r; end  if;
arcia(r,th0,thf);
end  arcid;
--------------------------------------------------------------------
end Adagraph.curved;
