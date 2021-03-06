-- 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
-- �    Package  TVGRAF  Graphic extension GNAT OS/2               �
-- �                                                               �
-- �                                                               �
-- �  Author: Leonid Dulman                                        �
-- �                                                               �
-- �                       1996                                    �
-- �        Load symbol table                                      �
-- 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�

with text_io; use text_io;
with Ada.direct_io;
package body tvgraph is
----------------------------------------------------------
type txt_rec is array(1..87) of character;
package dirio is new ada.direct_io(txt_rec); use dirio;
ctpoka:txt_rec;
rec:dirio.count;
txtfile:dirio.file_type;

procedure open_tabl is
begin

open (txtfile,name => "symtab.txt",mode => in_file);
put(" Load symbol table Start ");

end  open_tabl;

procedure blank(s:in out string;n_tab:integer) is

begin
for i in 1..s'length loop s(i):='0'; end loop;
rec:=dirio.count(n_tab);
read (txtfile,ctpoka,from => rec) ;
for i in 1..s'length loop s(i):=ctpoka(i); end loop;
end blank;


procedure close_tabl is
begin close(txtfile);
put(" Ended ");
new_line;
end ;

end tvgraph;
