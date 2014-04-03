package body grafcom is
--------------------------------------------------------------
function ivest (a,b,eps:float) return integer is
begin
if abs(a-b) <= eps then  return 0; end if;
if a < b then return -1 ; end if;
return 1;
end ivest;
--------------------------------------------------------------
end grafcom;
