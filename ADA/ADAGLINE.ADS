-- 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
-- �    Package Adagraph.line                                      �
-- �     Complex and Special Line Drawing                          �
-- �                                                               �
-- �   Author Leonid Dulman                                        �
-- �                 1996                                          �
-- �                                                               �
-- 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
with Addtype; use Addtype;
package  Adagraph.linedraw is
-------------------------------------------------------------------
procedure sincl(xb,step:float;y:vector;n:integer);
procedure sincl(x:vector;y:vector;nb,ne:integer);
procedure sincl(xy:matrix;nb,ne:integer);
procedure DASHP(X,Y,DL: float) ;
procedure FATLIN(XF,YF,D:float);
procedure BROLIN(K:integer;XS1,YS1,XF1,YF1,S1,S2:float ) ;

end Adagraph.linedraw;
