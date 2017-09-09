`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    17:49:16 11/27/2011 
// Design Name:     26 bit Left Shift
// Module Name:     LSHF_26 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//              Left shift 26 bit input by 2 
// Dependencies: N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LSHF_26(shift28_out, shift26_in);

    output  [27:0]  shift28_out;
    input   [25:0]  shift26_in;

    assign shift28_out = shift26_in << 2;

endmodule
