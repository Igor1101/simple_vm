-- my first Ada program
-- Simple VM
-- CMD format: opcode | op0 (reg\mem) | op0 select bus | op1(reg\mem) | op1 select bus | integer value | 
package vm is
-- TYPES
type CMD_OPCODE_T is (
        NOP, 
        JMP, 
        MOV, 
        ADD, 
        PRINT, 
        SUB, 
        MUL);
type CMD_ACCESS_T is (
        REGISTER,
        MEMORY,
        BUS,
	NO_ACCESS);
type CMD_T is
        record
                opcode: CMD_OPCODE_T;
                operand0: INTEGER;
                opaccess0:  CMD_ACCESS_T;
                operand1: INTEGER;
                opaccess1:  CMD_ACCESS_T;
                value:   INTEGER;
        end record;
type PRG_T is array (Natural range <>) of CMD_T;
type FLAGS_T is
	record
		carry: BOOLEAN;
		zero: BOOLEAN;
		overflow: BOOLEAN;
	end record;
--------- VARIABLES --------------
PRG_LENGTH:constant integer:=255;
PRG_MEM: PRG_T (0..PRG_LENGTH);
-- instructions --
-- NOP 
NOP_I : constant CMD_T := (NOP, 0, NO_ACCESS, 0, NO_ACCESS, 0);
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
AC: REG_T;
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
end vm;
