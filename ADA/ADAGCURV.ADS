-- 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
-- �    Package Adagraph.Curved                                    �
-- �       Circle Drawing                                          �
-- �                                                               �
-- �  Author : Leonid Dulman                                       �
-- �                                                               �
-- �                  1996                                         �
-- �                                                               �
-- 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�

package Adagraph.curved is
procedure arcia(r,th0,thf:float);
procedure arcib(r:float;xf,yf:in out float;j:integer);
procedure arcang(r:in out float;delx,dely:float;j:integer;
                 th0a,thfa:in out  float);
procedure arcic(xm,ym:in out float;xf,yf:in out float;j:integer);
procedure arcid(xc,yc,phi:float);
end Adagraph.curved;
