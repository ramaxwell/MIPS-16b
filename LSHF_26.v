`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:16 11/27/2011 
// Design Name: 
// Module Name:    LSHF_26 
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
module LSHF_26(shift28_out, shift26_in);
		
		output	[27:0]		shift28_out;
		input	[25:0]		shift26_in;
		
		assign shift28_out = shift26_in << 2;

endmodule
