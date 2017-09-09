`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    13:11:25 11/22/2011 
// Design Name:     2x1 Multiplexor with 5 bit throughput
// Module Name:     MUX2x1_5b 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//              2x1 Multiplexor with 5 bit throughpu
//
// Dependencies:    N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MUX2x1_5b(choice, mux_in1, mux_in2, mux_ctrl);

    output  [4:0]   choice;
    input   [4:0]   mux_in1, mux_in2;
    input           mux_ctrl;

    assign choice = mux_ctrl? mux_in2 : mux_in1;

endmodule
