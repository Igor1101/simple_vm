with text_io; use text_io;
with vm;
use vm;
procedure vm_starter is 
	PROGRAM:constant PRG_T := ( 
		NOP_I, 			-- 0
		(MOVA, IMMEDIATE, 13 ),	-- 1
		(MOV, REGISTER, 0),	-- 2
		(ADD, REGISTER, 0),	-- 3
		(JMP, IMMEDIATE, 3)	-- 4
		);
	i:integer := 0;
begin
	-- flash program:)
	-- to PRG_MEM
	put_line("prglength " & Integer'Image(PROGRAM'LENGTH) );
	for i in INTEGER range 0..PROGRAM'LENGTH-1 loop
		put_line("num" & Integer'Image(i));
		PRG_MEM(i) := PROGRAM(i);
		if i >= PRG_MEM'LENGTH
		then
			put_line("flash out of range");
			exit;
		end if;
	end loop;
	start;
end vm_starter;
