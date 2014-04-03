-- ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
-- บ    Package  MVGRAPH Graphic extension GNAT OS/2               บ
-- บ      file system AUTOCAD connection                           บ
-- บ                                                               บ
-- บ  Author : Leonid Dulman                                       บ
-- บ                                                               บ
-- บ                     1996                                      บ
-- บ                                                               บ
-- ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

package  mvgraph  is

procedure open_mov(fn:string:="adagraph.mov");
procedure close_mov;
procedure wrt(x:float);
----------------------------------------------------------------
end mvgraph;
