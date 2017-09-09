`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    14:02:44 11/16/2011 
// Design Name:     Write-Back Stage
// Module Name:     stage5 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//                  Simply sends data back to register unit from
//              MEM or ALU operations.
//              --> MUX controls whether MEM read or result of ALU OP
//                  is sent to register file
//
// Dependencies:    2 by 1 Multiplexor (MUX2x1.v)
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module stage5(data_out, r_dest, mem_data, alu_result, mem2Reg_ctrl, reg_dest5);

    output  [31:0]  data_out;
    output  [4:0]   r_dest;

    input   [31:0]  mem_data, alu_result;
    input           mem2Reg_ctrl;
    input   [4:0]   reg_dest5;

    assign  r_dest = reg_dest5;

    MUX2x1  stage5MUX(data_out, mem_data, alu_result, mem2Reg_ctrl);

    endmodule
