-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ    Package Adagraph.Curved                                    บ
-- บ       Circle Drawing                                          บ
-- บ                                                               บ
-- บ  Author : Leonid Dulman                                       บ
-- บ                                                               บ
-- บ                  1996                                         บ
-- บ                                                               บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

package Adagraph.curved is
procedure arcia(r,th0,thf:float);
procedure arcib(r:float;xf,yf:in out float;j:integer);
procedure arcang(r:in out float;delx,dely:float;j:integer;
                 th0a,thfa:in out  float);
procedure arcic(xm,ym:in out float;xf,yf:in out float;j:integer);
procedure arcid(xc,yc,phi:float);
end Adagraph.curved;
