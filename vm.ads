-- my first Ada program
-- Simple VM
-- CMD format: opcode | op0 (reg\mem\integer)  
package vm is
-- TYPES
type CMD_OPCODE_T is (
	-- NO OPERATION
        NOP, 
	-- ABSOLUTE JUMP
        JMP, 
	-- MOVE TO REG\MEM\AC FROM AC(BUS)
        MOV, 
	-- MOVE TO AC FROM \REG\MEM\AC\IMMEDIATE
	MOVA,
	-- AC = AC + \REG\MEM\AC\IMMEDIATE
        ADD, 
	-- PRINT INTEGER IN AC
        PRINT, 
	-- AC = AC - \REG\MEM\AC\IMMEDIATE
        SUB, 
	-- AC *= REG\MEM\AC\IMMEDIATE
        MUL);
type CMD_ACCESS_T is (
        REGISTER,
        MEMORY,
        BUS,
	IMMEDIATE,
	NO_ACCESS);
type CMD_T is
        record
                opcode: CMD_OPCODE_T;
                opaccess:  CMD_ACCESS_T;
                operand: INTEGER;
        end record;
type PRG_T is array (Natural range <>) of CMD_T;
type DATA_T is array (Natural range <>) of INTEGER;
type FLAGS_T is
	record
		carry: BOOLEAN;
		zero: BOOLEAN;
		overflow: BOOLEAN;
	end record;
--------- VARIABLES --------------
PRG_LENGTH:constant integer:=255;
PRG_MEM: PRG_T (0..PRG_LENGTH);
DATA_MEM: DATA_T (0..PRG_LENGTH);
-- instructions --
-- NOP 
NOP_I : constant CMD_T := (NOP, NO_ACCESS, 0);
-- Registers --
-- PROGRAM COUNTER
PC:INTEGER := 0;
-- STACK POINTER
SP:INTEGER := 0;
-- FLAGS
FLAGS: FLAGS_T;
-- GENERAL PURPOSE
type REG_T is array (Natural range <>) of INTEGER;
REG: REG_T(0..20);
-- ACCUMULATOR
AC: INTEGER;
-- procedures
procedure start;
procedure print_cmd(CMD: CMD_T) ;
function run_cmd_nop(CMD: CMD_T) return INTEGER;
function run_cmd_jmp(CMD: CMD_T) return INTEGER;
function run_cmd_mov(CMD: CMD_T) return INTEGER;
function run_cmd_add(CMD: CMD_T) return INTEGER;
function run_cmd_print(CMD: CMD_T) return INTEGER;
function run_cmd_sub(CMD: CMD_T) return INTEGER;
function run_cmd_mul(CMD: CMD_T) return INTEGER;
function run_cmd_mova(CMD: CMD_T) return INTEGER;
end vm;
