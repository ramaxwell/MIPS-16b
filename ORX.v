`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:21:58 11/19/2011 
// Design Name: 
// Module Name:    ORX 
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
module ORX(out_or, ORin1, ORin2);
		
		output	[31:0]	out_or;
		input	[31:0]	ORin1, ORin2;
		
		assign	out_or = ORin1 | ORin2;

endmodule
