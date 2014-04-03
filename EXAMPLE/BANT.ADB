with text_io;use text_io;
with adagraph; use adagraph;
procedure bant   is
d,xc,yc,yl,xl:float;
begin
put("Check adagraph package");  new_line;
grinit(al=>16#13#);
d:=3.6; xc:= 6.0; yc:= 6.0; yl:=-d/2.0; xl:=yl/1.7330514;
page(12.0,12.0,"bantik",0,1);
transl(xc,yc);
for ii in 1..3 loop  beglev;  pen(ii);
 for jj in 1..2 loop   beglev;
  for k in 1..20 loop move(0.0,0.0,0); move(0.0,-d,1);
    move(-0.8660257*d,-d/2.0,1); move(0.0,0.0,1);
    pscale(xl,yl,0.8); rotate(xl,yl,-8.0);
  end loop;
  endlev;
  lscale(0.0,0.0,0.0,1.0,-1.0);
 end loop;
 endlev;
 rotate(0.0,0.0,120.0);
end loop;
pen(2);
<<fin>>  transl(-xc,-yc);
symbol(2.5,2.5,0.7,"D E S  Incorporation",20,0.0);
symbol(0.5,1.5,0.7,"Example work in ada"  ,19,0.0);
symbol(0.5,0.5,0.7,"with package Adagraph",21,0.0);
grfin;
put(" Creation of Adagraph.mov file is ended"); new_line;
put(" You may view it by bantview.exe  program"); new_line;
put(" or create import file for AutoCad by adacad.exe program");

  exception
  when others           =>  put("mistake");

end   bant  ;
