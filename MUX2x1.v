`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    14:35:11 11/16/2011 
// Design Name:    2 by 1 Multiplexor
// Module Name:    MUX2x1 
// Project Name:   MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//              2x1 multiplexor block
//
// Dependencies: N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MUX2x1(choice, mux_in1, mux_in2, mux_ctrl);

    output  [31:0]  choice;
    input   [31:0]  mux_in1, mux_in2;
    input           mux_ctrl;

    assign choice = mux_ctrl? mux_in2 : mux_in1;

endmodule
