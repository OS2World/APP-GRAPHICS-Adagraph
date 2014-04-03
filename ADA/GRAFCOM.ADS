with addtype; use addtype;
package grafcom is
--  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
--  ³ ......................................   ³
--  ³ ....*(irdb(2),irdb(4))*...............   ³
--  ³ ....*.................*(irdb(3),irdb(5)) ³
--  ³ ......................................   ³
--  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
----------------------------------------------------------
 --  common  block ----
 --          gftab
irdb:ivector(1..5):=(0,0,119,0,319);
rdb :vector(1..17):=(1000.0,0.0,60.0,26.0,0.0,0.0,0.0,
                             0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1000.0);
--              gfatrm
a   :vector(1..6):=(1.0,0.0,0.0,0.0,1.0,0.0);
level   :integer:=0;
--           gfatrn
iss:integer:=0;
r   :vector(1..6):=(1.0,0.0,0.0,0.0,1.0,0.0);
as:matrix(1..16,1..6):=(1..16=>(1.0,0.0,0.0,0.0,1.0,0.0));
isr:ivector(1..16) ;
--           gfblan
jj  :integer:=0; xx1:float:=0.0; xx2:float:=0.0; yy1:float:=0.0; yy2:float:=0.0;
xxx:float:=0.0; yyy:float:=0.0;
--          gfntch
--          gfgel
gf  :vector(1..28):=(1..8=>0.0,9=>1.0,10..28=>0.001745329);
--
xtr:float:=0.0; ytr:float:=0.0; ax:float:=0.0; ay:float:=0.0;
--      adagraf
color:integer:=1;
x_old:float:=0.0; y_old:float:=0.0; x_new:float:=0.0; y_new:float:=0.0;
xa_old:float:=0.0; ya_old:float:=0.0; xa_new:float:=0.0; ya_new:float:=0.0;
i_beg:integer:=0; i_kon:integer:=0;
j_beg:integer:=0; j_kon:integer:=0;
pi:constant float:=3.14159265;
radian:constant float:=1.74532925e-2; -- pi/180
----------------------------------------------------------------
--      gfgobs
njch,nkch,jg,nris:integer;
nach:ivector(1..16);

type ploter is  record
 kplot:              integer; --  number elements in nplot;
nplot:ivector(1..16) ; --  vector of coordinate for liter
                end record;
type loader is array( integer range <> ) of ploter;
shrift:loader(15..254);
----------------------------------------------------------
function ivest (a,b,eps:float) return integer;
end grafcom;
