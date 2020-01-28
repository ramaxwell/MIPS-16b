`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:05 07/27/2011 
// Design Name: 
// Module Name:    Xshifter 
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
module Xshifter(result, data, amt, direc);

	output 	[31:0]	result;
	input	[31:0]	data;
	input	[4:0]	amt;
	input			direc;  //0 = lshf, 1 = rshf
	
	assign	result = (direc)? (data >> amt) : (data << amt);
	
endmodule
