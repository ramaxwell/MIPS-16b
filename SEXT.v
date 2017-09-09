`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    13:59:47 11/16/2011 
// Design Name:     32 bit Sign Extend
// Module Name:     SEXT 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//          Sign Extend 16 bit to 32 bits
//
// Dependencies:    N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SEXT(out_long, in_short);

    output  [31:0]  out_long;
    input   [15:0]  in_short;

    parameter   ONES = 16'hFFFF, ZEROS = 16'h0000;

    assign      out_long = in_short[15] ? {ONES,in_short} : {ZEROS,in_short};

endmodule
