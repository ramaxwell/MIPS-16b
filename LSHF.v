`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    13:59:23 11/16/2011 
// Design Name:    Left Shift
// Module Name:    LSHF 
// Project Name:   MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//              Left shift input by two and output lower 32 bits
//
// Dependencies:    N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LSHF(shift_out, shift_in);

    output  [31:0]  shift_out;
    input   [31:0]  shift_in;

    wire    [33:0]  shifted;

    assign shifted = shift_in << 2;
    assign shift_out = shifted[31:0];

endmodule
