-- my first Ada program
-- Simple VM
-- CMD format: opcode | op0 (reg\mem) | op0 select bus | op1(reg\mem) | op1 select bus | integer value | 
with ada.text_io;
with ada.assertions;
use ada.text_io;
package body vm is
a:integer:=0;
procedure start is
package INT_IO is new INTEGER_IO(INTEGER);
use INT_IO;
CMD: CMD_T;
begin
	main_vm_loop: loop
	-- process cmd loop engine
	-- get cmd
	CMD := PRG_MEM(PC);
	-- select appropriate subprogram
	case CMD.opcode is 
		when NOP =>
			if run_cmd_nop(CMD) /= 0
			then
				put_line("CMD ERR IGNORED");
			end if;
		when JMP =>
			if run_cmd_jmp(CMD) /= 0
			then
				put_line("CMD ERR IGNORED");
			end if;
		when MOV =>
			if run_cmd_mov(CMD) /= 0
			then
				put_line("CMD ERR IGNORED");
			end if;
		when MOVA =>
			if run_cmd_mova(CMD) /= 0
			then
				put_line("CMD ERR IGNORED");
			end if;

		when ADD =>
			if run_cmd_add(CMD) /= 0
			then
				put_line("CMD ERR IGNORED");
			end if;
		when PRINT =>
			if run_cmd_print(CMD) /= 0
			then
				put_line("CMD ERR IGNORED");
			end if;
		when SUB =>
			if run_cmd_sub(CMD) /= 0
			then
				put_line("CMD ERR IGNORED");
			end if;
		when MUL =>
			if run_cmd_mul(CMD) /= 0
			then
				put_line("CMD ERR IGNORED");
			end if;
		when others =>
			put_line("unknown cmd");
			PC := PC + 1;
	end case;
	print_cmd(CMD);
	delay 0.1;
end loop main_vm_loop;
end start;

procedure print_cmd(CMD: CMD_T) is
package INT_IO is new INTEGER_IO(INTEGER);
use INT_IO;
begin	
	put("CMD:");
	put(" " & CMD.opcode'Image);
	put(" " & CMD.opaccess'Image);
	put(" " & CMD.operand'Image);
	put(" AC=" & AC'Image);
	put(" R0=" & REG(0)'Image);
	put(" R1=" & REG(1)'Image);
	put(" R2=" & REG(2)'Image);
	put(" R3=" & REG(3)'Image);
	put(" R4=" & REG(4)'Image);
	NEW_LINE;
end print_cmd;

function run_cmd_nop(CMD: CMD_T) return INTEGER is
	use ada.assertions;
begin
	assert(CMD.opcode = NOP);
	PC := PC+1;
	return 0;
end run_cmd_nop;

function run_cmd_jmp(CMD: CMD_T) return INTEGER is
	use ada.assertions;
begin
	assert(CMD.opcode = JMP);
	PC := CMD.operand;
	return 0;
end run_cmd_jmp;

function run_cmd_mov(CMD: CMD_T) return INTEGER is
	use ada.assertions;
	STAT: INTEGER := 0;
begin
	assert(CMD.opcode = MOV);
	case CMD.opaccess is
		when REGISTER =>
			REG(CMD.operand) := AC;
		when MEMORY =>
			DATA_MEM(CMD.operand) := AC;
		when BUS =>
			AC := AC;
		when others =>
			stat := -1;
	end case;
	PC := PC+1;
	return STAT;
end run_cmd_mov;

function run_cmd_mova(CMD: CMD_T) return INTEGER is
	use ada.assertions;
	STAT: INTEGER := 0;
begin
	assert(CMD.opcode = MOVA);
	case CMD.opaccess is
		when REGISTER =>
			AC := REG(CMD.operand);
		when MEMORY =>
			AC := DATA_MEM(CMD.operand);
		when BUS =>
			AC := AC;
		when IMMEDIATE =>
			AC := CMD.operand;
		when others =>
			stat := -1;
	end case;
	PC := PC+1;
	return STAT;
end run_cmd_mova;


function run_cmd_add(CMD: CMD_T) return INTEGER is
	use ada.assertions;
	STAT: INTEGER := 0;
begin
	assert(CMD.opcode = ADD);
	case CMD.opaccess is
		when REGISTER =>
			AC := AC + REG(CMD.operand);
		when MEMORY =>
			AC := AC + DATA_MEM(CMD.operand);
		when BUS =>
			AC := AC + AC;
		when IMMEDIATE =>
			AC := CMD.operand;
		when others =>
			stat := -1;
	end case;
	PC := PC + 1;
	return stat;
end run_cmd_add;

function run_cmd_print(CMD: CMD_T) return INTEGER is
	use ada.assertions;
begin
	assert(CMD.opcode = JMP);
	PC := CMD.operand;
	return 0;
end run_cmd_print;

function run_cmd_sub(CMD: CMD_T) return INTEGER is
	use ada.assertions;
begin
	assert(CMD.opcode = JMP);
	PC := CMD.operand;
	return 0;
end run_cmd_sub;

function run_cmd_mul(CMD: CMD_T) return INTEGER is
	use ada.assertions;
begin
	assert(CMD.opcode = JMP);
	PC := CMD.operand;
	return 0;
end run_cmd_mul;

end vm;
