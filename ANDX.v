`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    18:21:45 11/19/2011 
// Design Name:     Simple Bitwise AND Gate
// Module Name:     ANDX 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//                  Simple Bitwise AND Gate
//
// Dependencies:    N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ANDX(out, in1, in2);

    output  [31:0]  out;
    input   [31:0]  in1, in2;

    assign  out = in1 & in2;

endmodule
