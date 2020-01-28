`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:17:26 06/27/2011 
// Design Name: 
// Module Name:    Adder_32b 
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
module Adder_32b(Sum, Cout, x, y, Cin);

	output [31:0] Sum;
	output Cout;
	input [31:0] x, y;
	input Cin;

	wire [7:0] cout_add;

FA_4bit FA1(Sum[3:0], cout_add[0], x[3:0], y[3:0], Cin),
		  FA2(Sum[7:4], cout_add[1], x[7:4], y[7:4], cout_add[0]),
		  FA3(Sum[11:8], cout_add[2], x[11:8], y[11:8], cout_add[1]),
		  FA4(Sum[15:12], cout_add[3], x[15:12], y[15:12], cout_add[2]),
		  FA5(Sum[19:16], cout_add[4], x[19:16], y[19:16], cout_add[3]),
		  FA6(Sum[23:20], cout_add[5], x[23:20], y[23:20], cout_add[4]),
		  FA7(Sum[27:24], cout_add[6], x[27:24], y[27:24], cout_add[5]),
		  FA8(Sum[31:28], cout_add[7], x[31:28], y[31:28], cout_add[6]);
	
	assign Cout = cout_add[7];

endmodule