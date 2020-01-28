`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:21:45 11/19/2011 
// Design Name: 
// Module Name:    ANDX 
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
module ANDX(out, in1, in2);

		output	[31:0]	out;
		input	[31:0]	in1, in2;
		
		assign	out = in1 & in2;
		
endmodule
