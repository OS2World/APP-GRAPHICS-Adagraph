-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ    Program generate file      ******.DXF                      บ
-- บ      from file                ******.mov                      บ
-- บ      connection to         AUTOCAD  system                    บ
-- บ  Author: Leonid Dulman                                        บ
-- บ   Part 1 creation temporery text file                         บ
-- บ   Adagraph - graphic extension Ada 95 ( GNAT 3.05) DOS        บ
-- บ             1996                                              บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
with text_io;
with builtin; use builtin;
with Ada.direct_io;
procedure tempor is
------------------------------------------------
cons,acadfile:text_io.file_type;
type mov_out is array(1..20) of float;
package dirmv is new Ada.direct_io(mov_out); use dirmv;
fi,fo:string(1..12):=(others=>' ');
movfile:dirmv.file_type;
buffer  :mov_out;
position:integer        :=21;
x,y,z,xl,yl:float;
flag:boolean:=false;
motor:integer            :=0;
npen :integer            :=1;
nmf:varing;
l:natural                :=40;
xb,yb,xe,ye:string(1..10);

 ----------------------------------
function rd return float   is
x:float;
begin
text_io.new_line;
if motor mod 10 = 0 then put_edit("Block ",motor,6);  end if;
motor:=motor+1;
if position=21 then read(movfile,buffer); position:=1;   end if;
x:=buffer(position); position:=position+1;
return x;
end rd;
procedure open_mov is
begin
text_io.put("Input out file name  [adagraph] (.TMP)=>");  -- only filename
text_io.get_line(fo,l);
if l<2 then overlay(fo,1,"adagraph.tmp"); l:=12;  -- default  output name
       else overlay(fo,l+1,".tmp");l:=l+4;        -- original output name
end if;
text_io.create (file=>acadfile,name => fo); -- ,mode => out_file);
text_io.put(" Open file connection with AUTOCAD => ");
for i in 1..l loop text_io.put(fo(i)); end loop;text_io.new_line;
text_io.create (file=>cons,name => "CON"); -- ,mode => out_file);
text_io.set_output(cons);
end;

begin
text_io.put("Input file name from Adagraph(.mov) [adagraph] =>");
text_io.get_line(fi,l);
if l<2 then overlay(fi,1,"adagraph.mov"); l:=12;
       else overlay(fi,l+1,".mov");l:=l+4;
end if;
dirmv.open (file=>movfile,name =>fi,mode => in_file);
text_io.put(" Open input file => ");
for i in 1..l loop text_io.put(fi(i)); end loop;
text_io.new_line;
open_mov;
------------------------------------------------------------------
<<start>>
xl:=rd; yl:=rd;
xe:=put_f(xl,10); xe(1):=' '; text_io.put(acadfile,xe); -- text_io.new_line(acadfile);
ye:=put_f(yl,10); ye(1):=' '; text_io.put(acadfile,ye); text_io.new_line(acadfile);
for j in 1..integer'last  loop
   z:=rd;
   exit when z>9998.1  AND Z<9999.9;
   if z>9997.9 and z<9998.1  then goto start; end if;  -- new page
   if z>=10000.0 then
     ye:=put_f(z,10); ye(1):=' '; text_io.put(acadfile,ye); text_io.new_line(acadfile);
     npen:=integer(z-10000.0); flag:=true;  goto next;
   end if;
   x:=z; z:=rd; y:=abs(z);
   if x<0.0 then
      xb:=put_f(x,10); yb:=put_f(y,10);
            else
      xe:=put_f(abs(x),10); ye:=put_f(y,10);
      if index(xb,'.') = 0 then xb := " 0.0      " ; end if;
      if index(xe,'.') = 0 then xe := " 0.0      " ; end if;
      if index(yb,'.') = 0 then yb := " 0.0      " ; end if;
      if index(ye,'.') = 0 then ye := " 0.0      " ; end if;
      text_io.put(acadfile,xb); -- text_io.new_line(acadfile);
      text_io.put(acadfile,yb); -- text_io.new_line(acadfile);
      text_io.put(acadfile,xe); -- text_io.new_line(acadfile);
      text_io.put(acadfile,ye); text_io.new_line(acadfile);
      xb:=xe;  yb := ye;
   end if;
<<next>> null; end loop;
text_io.put(acadfile,"9999.0"); text_io.new_line(acadfile);
<<fin>> close(movfile);
exception
when dirmv.name_error => text_io.put(" file <"); text_io.put(fi) ;
                         text_io.put(" > not found  ");
end tempor ;
