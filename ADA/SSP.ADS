with text_io;
with builtin;
with Elemfunc; Use Elemfunc;
with addtype; use addtype;
package ssp is
--         ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
--         ³                                            ³
--         ³    Scientific program package              ³
--         ³    Author :  Leonid Dulman                 ³
--         ³                                            ³
--         ³             1990,1996                      ³
--         ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
--
--

function   poly(a:vector;x:float) return float;
function dipoly(a:matrix;x,y:float) return float;
function sum(a:vector;ib,ie:integer) return float;
function sum(a:ivector;ib,ie:integer) return integer;
function any(a:bvector;ib,ie:integer) return boolean;
function any(a:ivector;n:integer;ib,ie:integer) return boolean;
function bce(a:bvector;ib,ie:integer) return boolean;
function bce(a:ivector;n:integer;ib,ie:integer) return boolean;
procedure yx(x,y:vector;xa:in out float;ex:in out boolean;yy:out float);
procedure zxy(x,y:vector;z:matrix;xa,ya:float;ex,ey:in out boolean;rez:out float);
procedure ap2(ib,ie:integer;x0,y:vector;a:in out vector);
function aitken(x,f:vector;n:integer;xx:float) return float; -- Eitkin interpolation
function aitken(xf:matrix;n:integer;xx:float)  return float; -- Eitkin interpolation
function cubpol(x1,x2,y1,y2,dy1,dy2:float) return vector;
function deriv5(dx:float;y:vector;n,i:integer) return float;
end ssp;
