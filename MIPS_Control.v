`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    13:17:57 11/21/2011 
// Design Name:     Controller for MIPS Machine
// Module Name:     MIPS_Control 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//              Controller for driving wires (and muxes by extension)
//
// Dependencies: N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MIPS_Control(rw_ctrl, alu_source, alu_opcode, register_dst, br_eq, br_ne, br_gt, br_gt_eq_z, br_lt, j, mem_write, mem_read, mem_2_reg, clk_off, instr_code, alu_funct);			

    output reg          rw_ctrl, alu_source;
    output reg  [3:0]   alu_opcode;
            // ALU CTRL MAP:
            // 0001=add, 1001=sub, 0011=and, 0100=or, 0101=SLL, 1101=SRL
    output reg          register_dst;
    output reg          br_eq, br_ne, br_gt, br_gt_eq_z, br_lt, j;
    output reg          mem_write, mem_read;
    output reg          mem_2_reg;
    output reg          clk_off;

    input       [5:0]   instr_code;
    input       [5:0]   alu_funct;

    initial begin
        j = 1'b0;
        clk_off = 1'b0;
    end

    //Control and Immediate Operations
    parameter   ALU_BASE = 6'b000000, ADDI = 6'b001000, ADDIU = 6'b001001, ANDI = 6'b001100,ORI = 6'b001101, LOADW = 6'b100011, STW = 6'b101011, LUI = 6'b001111, BEQ = 6'b000100, BNE = 6'b000101, BGTZ = 6'b000111, BGEZ = 6'b000001, BLTZ = 6'b000011, SLTI = 6'b001010, SLTIU = 6'b001011, JUMP = 6'b000010, JAL = 6'b000011;

    //ALU operations
    parameter   ADD = 6'b100000, SUB = 6'b100010, ADDU = 6'b100001, SUBU = 6'b100011, AND = 6'b100100, OR = 6'b100101, SLL = 6'b000000, SRL = 6'b000010, SLT = 6'b101010, SLTU = 6'b101011, SYSCALL = 6'b001100;

    always@(instr_code or alu_funct) begin

    case(instr_code)

        ALU_BASE:begin
            case(alu_funct)
                ADD: begin 
                    rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b0001; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
                end
                SUB: begin  
                    rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b1001; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
                end
                ADDU: begin 
                    rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b0001; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
                end
                SUBU: begin  
                    rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b1001; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
                end
                AND: begin  
                    rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b0011; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
                end
                OR: begin  
                    rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b0100; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
                end
                SLL: begin 
                    rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0101; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
                end
                SRL: begin 
                    rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b1101; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
                end
                SLT: begin  
                    rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b0010; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
                end
                SLTU: begin  
                    rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b1010; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
                end
            /*	NOOP: begin  
                    rw_ctrl = 1'b0; alu_source = 1'b0; alu_opcode = 4'b0000; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
                end  */
                SYSCALL: begin
                    rw_ctrl = 1'b0; alu_source = 1'b0; alu_opcode = 4'b0000; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b1;
                end
                default: begin  
                    rw_ctrl = 1'bx; alu_source = 1'bx; alu_opcode = 4'bxxxx; register_dst = 1'bx; br_eq = 1'bx; br_ne = 1'bx; br_gt = 1'bx; br_gt_eq_z = 1'bx; br_lt = 1'bx; j = 1'b0; mem_write = 1'bx; mem_read = 1'bx; mem_2_reg = 1'bx; clk_off = 1'b0;
                end
            endcase
        end
        ADDI: begin 
            rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0001; register_dst = 1'b0; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
        end
        ADDIU: begin  
            rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0001; register_dst = 1'b0; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
            mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
        end
        ANDI: begin  
            rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0011; register_dst = 1'b0; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
        end
        ORI: begin  
            rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0100; register_dst = 1'b0; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
        end
        LOADW: begin 
            rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0001; register_dst = 1'b0; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b1; mem_2_reg = 1'b0; clk_off = 1'b0;
        end
        STW: begin  
            rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'b0001; register_dst = 1'b0; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b1; mem_read = 1'b0; mem_2_reg = 1'b0; clk_off = 1'b0;
        end
        LUI: begin  
            rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0111; register_dst = 1'b0; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b1; mem_2_reg = 1'b1;clk_off = 1'b0;
        end
        BEQ: begin  
            rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'b0000; register_dst = 1'b1; br_eq = 1'b1; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
        end
        BNE: begin  
            rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'bxxxx; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b1; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
        end
        BGTZ: begin
            rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'bxxxx; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b1; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
        end
        BGEZ: begin
            rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'bxxxx; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b1; br_lt = 1'b0; j = 1'b0;
            mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
        end
        BLTZ: begin
            rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'bxxxx; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b1; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1;	clk_off = 1'b0;
        end
        SLTI: begin  
            rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0010; register_dst = 1'b0; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
        end
        SLTIU: begin 
            rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b1010; register_dst = 1'b0; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
        end
        JUMP: begin 
            rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'b0000; register_dst = 1'b1; br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0;  j = 1'b1; mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
        end
        /*JAL: begin   end
        */
        default: begin   end
    endcase
    
    end

endmodule
