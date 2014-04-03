-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ    Program generate file      ******.DXF                      บ
-- บ      from file                ******.mov                      บ
-- บ      connection to         AUTOCAD  system                    บ
-- บ  Author: Leonid Dulman                                        บ
-- บ                                                               บ
-- บ   Adagraph - graphic extension Ada 95 ( GNAT 3.05) OS/2       บ
-- บ             1996                                              บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
with text_io;
with builtin; use builtin;
with Ada.direct_io;
procedure adacad    is
----------------------------------------------------------
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
s0:constant string(1..3) :="  0";
s8:constant string(1..3) :="  8";
s9:constant string(1..3) :="  9";
s62:constant string(1..3):=" 62";
s10:constant string(1..3):=" 10";
s11:constant string(1..3):=" 11";
s20:constant string(1..3):=" 20";
s21:constant string(1..3):=" 21";
sln:constant string(1..4):="LINE";
xb,yb,xe,ye:string(1..10);
it:string(1..6);
 ----------------------------------
procedure prnt is
begin
if xb(1)='+' then xb(1):=' '; end if;if xe(1)='+' then xe(1):=' '; end if;
if yb(1)='+' then yb(1):=' '; end if;if ye(1)='+' then ye(1):=' '; end if;
text_io.put(acadfile,s0);         text_io.new_line(acadfile);
text_io.put(acadfile,sln);         text_io.new_line(acadfile);
text_io.put(acadfile,s8);         text_io.new_line(acadfile);
text_io.put(acadfile,'0');         text_io.new_line(acadfile);
text_io.put(acadfile,s62);         text_io.new_line(acadfile);
it:=put_i(npen); it(1):=' ';text_io.put(acadfile,it); text_io.new_line(acadfile);
text_io.put(acadfile,s10);         text_io.new_line(acadfile);
text_io.put(acadfile,xb);         text_io.new_line(acadfile);
text_io.put(acadfile,s20);         text_io.new_line(acadfile);
text_io.put(acadfile,yb);         text_io.new_line(acadfile);
text_io.put(acadfile,s11);         text_io.new_line(acadfile);
text_io.put(acadfile,xe);         text_io.new_line(acadfile);
text_io.put(acadfile,s21);         text_io.new_line(acadfile);
text_io.put(acadfile,ye);         text_io.new_line(acadfile);
xb:=put_f(x,10); yb:=put_f(y,10);
end;
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
text_io.put("Input out file name  [adagraph] (.DXF)=>");  -- only filename
text_io.get_line(fo,l);
if l<2 then overlay(fo,1,"adagraph.dxf"); l:=12;  -- default  output name
       else overlay(fo,l+1,".dxf");l:=l+4;        -- original output name
end if;
text_io.create (file=>acadfile,name => fo); -- ,mode => out_file);
text_io.put(" Open file connection with AUTOCAD => ");
for i in 1..l loop text_io.put(fo(i)); end loop;text_io.new_line;
text_io.create (file=>cons,name => "CON"); -- ,mode => out_file);
text_io.set_output(cons);
end;

begin
text_io.put("Input file name from Adagraph(.mov) [adagraphp] =>");
text_io.get_line(fi,l);
if l<2 then overlay(fi,1,"adagraph.mov"); l:=12;
       else overlay(fi,l+1,".mov");l:=l+4;
end if;
dirmv.open (file=>movfile,name =>fi,mode => in_file);
text_io.put(" Open input file => ");
for i in 1..l loop text_io.put(fi(i)); end loop;
text_io.new_line;
open_mov;
<<start>>
xl:=rd; yl:=rd;
xb:="0.0       "; yb:="0.0       ";
xe:="0.0       "; ye:="0.0       ";
text_io.put(acadfile,s0);         text_io.new_line(acadfile);
text_io.put(acadfile,"SECTION");         text_io.new_line(acadfile);
text_io.put(acadfile,"  2");         text_io.new_line(acadfile);
text_io.put(acadfile,"HEADER");         text_io.new_line(acadfile);
text_io.put(acadfile,s9);         text_io.new_line(acadfile);
text_io.put(acadfile,"$SNAPUNIT");         text_io.new_line(acadfile);
text_io.put(acadfile,s10);         text_io.new_line(acadfile);
text_io.put(acadfile,"0.4");         text_io.new_line(acadfile);
text_io.put(acadfile,s20);         text_io.new_line(acadfile);
text_io.put(acadfile,"0.4");         text_io.new_line(acadfile);
text_io.put(acadfile,s9);         text_io.new_line(acadfile);
text_io.put(acadfile,"$LIMMIN");         text_io.new_line(acadfile);
text_io.put(acadfile,s10);         text_io.new_line(acadfile);
text_io.put(acadfile,"0.0");         text_io.new_line(acadfile);
text_io.put(acadfile,s20);         text_io.new_line(acadfile);
text_io.put(acadfile,"0.0");         text_io.new_line(acadfile);
text_io.put(acadfile,s9);         text_io.new_line(acadfile);
text_io.put(acadfile,"$LIMMAX");         text_io.new_line(acadfile);
text_io.put(acadfile,s10);         text_io.new_line(acadfile);
xe:=put_f(xl,10); xe(1):=' '; text_io.put(acadfile,xe); text_io.new_line(acadfile);
text_io.put(acadfile,s20);         text_io.new_line(acadfile);
ye:=put_f(yl,10); ye(1):=' '; text_io.put(acadfile,ye);
text_io.new_line(acadfile);
text_io.put(acadfile,s9);         text_io.new_line(acadfile);
text_io.put(acadfile,"$ORTHOMODE");         text_io.new_line(acadfile);
text_io.put(acadfile," 70");         text_io.new_line(acadfile);
text_io.put(acadfile,"0");         text_io.new_line(acadfile);
text_io.put(acadfile,s9);         text_io.new_line(acadfile);
text_io.put(acadfile,"$REGENMODE");         text_io.new_line(acadfile);
text_io.put(acadfile," 70");         text_io.new_line(acadfile);
text_io.put(acadfile,"1");         text_io.new_line(acadfile);
text_io.put(acadfile,s9);         text_io.new_line(acadfile);
text_io.put(acadfile,"$FILLMODE");         text_io.new_line(acadfile);
text_io.put(acadfile," 70");         text_io.new_line(acadfile);
text_io.put(acadfile,"1");         text_io.new_line(acadfile);
text_io.put(acadfile,s9);         text_io.new_line(acadfile);
text_io.put(acadfile,"$CLAYER");         text_io.new_line(acadfile);
text_io.put(acadfile,S8);         text_io.new_line(acadfile);
text_io.put(acadfile,"0");         text_io.new_line(acadfile);
text_io.put(acadfile,s9);         text_io.new_line(acadfile);
text_io.put(acadfile,"$CECOLOR");         text_io.new_line(acadfile);
text_io.put(acadfile," 62");         text_io.new_line(acadfile);
text_io.put(acadfile,"4");         text_io.new_line(acadfile);
text_io.put(acadfile,s9);         text_io.new_line(acadfile);
text_io.put(acadfile,"$DIMSCALE");         text_io.new_line(acadfile);
text_io.put(acadfile," 40");         text_io.new_line(acadfile);
text_io.put(acadfile,"1.0");         text_io.new_line(acadfile);
text_io.put(acadfile,s9);         text_io.new_line(acadfile);
text_io.put(acadfile,"$VIEWDIR");         text_io.new_line(acadfile);
text_io.put(acadfile,S10);         text_io.new_line(acadfile);
text_io.put(acadfile,"0.0");         text_io.new_line(acadfile);
text_io.put(acadfile,S20);         text_io.new_line(acadfile);
text_io.put(acadfile,"0.0");         text_io.new_line(acadfile);
text_io.put(acadfile," 30");         text_io.new_line(acadfile);
text_io.put(acadfile,"1.0");         text_io.new_line(acadfile);
text_io.put(acadfile,s0);         text_io.new_line(acadfile);
text_io.put(acadfile,"ENDSEC");         text_io.new_line(acadfile);
-------------------------------
text_io.put(acadfile,"  0");         text_io.new_line(acadfile);
text_io.put(acadfile,"SECTION");         text_io.new_line(acadfile);
text_io.put(acadfile,"  2");         text_io.new_line(acadfile);
text_io.put(acadfile,"ENTITIES");         text_io.new_line(acadfile);
for j in 1..integer'last

loop
   z:=rd;
   exit when z>9998.1  AND Z<9999.9;
   if z>9997.9 and z<9998.1  then goto start; end if;
   if z>=10000.0 then  npen:=integer(z-10000.0); flag:=true;  goto next; end if;
   x:=z; z:=rd; y:=abs(z);
   if x<0.0 then xb:=put_f(abs(x),10); yb:=put_f(y,10);
            else xe:=put_f(abs(x),10); ye:=put_f(y,10);  prnt;
   end if;
<<next>> null; end loop;
<<fin>> close(movfile);
text_io.put(acadfile,s0);         text_io.new_line(acadfile);
text_io.put(acadfile,"ENDSEC");   text_io.new_line(acadfile);
text_io.put(acadfile,s0);         text_io.new_line(acadfile);
text_io.put(acadfile,"EOF");
exception
when dirmv.name_error => text_io.put(" file <"); text_io.put(fi) ;
                         text_io.put(" > not found  ");
end ;
