`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    16:14:42 11/28/2011 
// Design Name:     Cascaded 3x1 Multiplexor
// Module Name:     MUX3x1 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//              Actually a 3x2 MUX (2 MUX ctrl signals) cascaded using
//          an XOR gate and two 2x1 MUXes
//          --> Diagram included in documentation
//
// Dependencies:    N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MUX3x1(choice, mux_in1, mux_in2, mux_in3, mux_ctrl);
            ////output, input, input, ctrl

        output  [31:0]  choice;
        input   [31:0]  mux_in1, mux_in2, mux_in3;
        input   [1:0]   mux_ctrl;

        assign choice = (mux_ctrl[1] ^ mux_ctrl[0])? (mux_ctrl[1]? mux_in3 : mux_in2) : mux_in1;

        endmodule
