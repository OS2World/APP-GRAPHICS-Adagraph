-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ    Package ADAGRAPH                                           บ
-- บ                                                               บ
-- บ  Author Leonid Dulman               า       า                 บ
-- บ                                     บ D บ S บ                 บ
-- บ            1991                     ศอออสอออผ                 บ
-- บ  This  is a system independed variant of adagraph             บ
-- บ                                                               บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
with addtype; use addtype;
package  adagraph is
--------------------------------------------------------------------
procedure gffals(n:integer) ;
procedure grinit(fn:string:="adagraph.mov";i_top:integer:=0;i_bot:integer:=199;
           j_left:integer:=0;j_right:integer:=319;al:integer:=16#0d#);
procedure grfin(al:integer:=16#02#);
procedure page(xl,yl:float;name:string;n,j:integer);
procedure symbol(x,y,size:float;jtext:string;n:integer;theta:float:=0.0);
procedure number(x,y,z:float; fnum:float;   np:integer:=6;th:float:=0.0);
procedure number(x,y,z:float; fnum:integer; np:integer:=6;th:float:=0.0);
procedure marker(nm:integer:=0);
----------------------------------------------------------
procedure move(x,y:float;j:integer:=0);
procedure mova(dl,th:float;j:integer:=0);
procedure movb(dx,dy:float;j:integer:=0);
procedure movc(xm,ym,dl:float;j:integer:=0);
----------------------------------------------------------
procedure italic(j:integer:=0);
procedure set(j:integer:=0) ;
procedure where(x,y,f:in out float) ;
procedure pen(j:integer);
----------------------------------------------------------
procedure beglev;
procedure endlev;
procedure reset;
----------------------------------------------------------
procedure rotate(x,y,psi:float);
procedure pscale(x,y,rd:float);
procedure lscale(x1,y1,x2,y2,rd:float);
procedure transl(dx,dy:float) ;
----------------------------------------------------------
procedure limits (xmin,xmax,ymin,ymax:float) ;
procedure region(x,y,xl,yl:float;name:string:=" ";
                 n:integer:=0;j:integer:=0);
----------------------------------------------------------
function angler(x,y:float) return float;
procedure box(x,y,xl,yl:float);
procedure  circle(xa,ya,th0,thf,r0,rf:float;l:integer:=1);
----------------------------------------------------------
procedure tmf(xm,ym:float;xf,yf:in out float);
----------------------------------------------------------
procedure line(points:matrix;n:integer);
procedure line(x,y:vector;n:integer);
procedure lineo(x,y:vector;n:integer);
procedure lineo(points:matrix;n:integer);
----------------------------------------------------------
procedure mms;
procedure inches;
----------------------------------------------------------
end adagraph;
