-- my first Ada program
-- Simple VM
-- CMD format: opcode | op0 (reg\mem) | op0 select bus | op1(reg\mem) | op1 select bus | integer value | 
package vm is
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
PRG_LENGTH:constant integer:=255;
type PRG_T is array (Natural range <>) of CMD_T;
PRG_MEM: PRG_T (0..PRG_LENGTH);
-- instructions --
-- NOP 
NOP_I : constant CMD_T := (NOP, 0, NO_ACCESS, 0, NO_ACCESS, 0);
procedure start;
end vm;
