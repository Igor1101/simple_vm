-- my first Ada program
-- Simple VM
-- CMD format: opcode | op0 (reg\mem) | op0 select bus | op1(reg\mem) | op1 select bus | integer value | 
with ada.text_io;
use ada.text_io;
package body vm is
a:integer:=0;
procedure start is
package INT_IO is new INTEGER_IO(INTEGER);
use INT_IO;
begin
	cycle: loop
	delay 0.2;
		if  a = 100
		then
			exit cycle;
		end if;
		a:=a+1;
        put("VM");
	put(a);
end loop cycle;
end start;
end vm;