`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:53:08 11/24/2011 
// Design Name: 
// Module Name:    MUX2x1_src 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MUX2x1_src(choice, mux_in1, mux_in2, mux_ctrl);	////output, input, input, ctrl
	
	output	[31:0]	choice;
	input	[31:0]	mux_in1, mux_in2;
	input			mux_ctrl;

	assign choice = mux_ctrl? mux_in2 : mux_in1;
	
endmodule