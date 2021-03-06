-- 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
-- �    Package  MVGRAPH Graphic extension GNAT OS/2               �
-- �      file system AUTOCAD connection                           �
-- �                                                               �
-- �  Author : Leonid Dulman                                       �
-- �                                                               �
-- �                     1996                                      �
-- �                                                               �
-- 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�

with text_io; use text_io;
with Ada.sequential_io;
with addtype; use addtype;
package body mvgraph is
----------------------------------------------------------
subtype mov_out is vector(1..20);
package dirmv is new Ada.sequential_io(mov_out); use dirmv;
buffer:mov_out;
movfile:dirmv.file_type;
position:integer:=1;

procedure open_mov(fn:string:="adagraph.mov") is

begin
for i in 1..20  loop buffer(i):=9999.0; end loop;
open (movfile,name => fn,mode =>out_file);
put("Open removing file  "); put(fn);
exception
when dirmv.name_error =>  create(movfile,name => fn);
end  open_mov;

procedure close_mov is
begin   write(movfile,buffer);
close(movfile);
 end ;

procedure wrt(x:float)   is

begin
if position=21 then
   write(movfile,buffer);
   position:=1;
   for i in 1..20 loop buffer(i):=9999.0; end loop;
end if;
buffer(position):=x; position:=position+1;
end wrt;
end mvgraph ;
