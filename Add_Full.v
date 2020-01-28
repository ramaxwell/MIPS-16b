`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UTSA
// Engineer: Robert A. Maxwell
// 
// Create Date:    13:42:22 06/07/2011 
// Design Name: Full Adder using 2 Half Adders
// Module Name:    Add_Full 
// Project Name: 4-bit Full Adder
// Target Devices: Spartan 3E Starter Board
// Tool versions: 
// Description: 1-Bit Full Adder for use in a 4-bit full adder
//
// Dependencies: Half Adder (Add_Half.v)
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Add_Full(sum, c_out, a, b, c_in);
	
	input a, b, c_in;
	output sum, c_out;
	wire hSum, hCarry, tCarry;
	
	Add_Half HA1(hSum, hCarry, a, b),						//1st half adder
			 HA2(sum, tCarry, hSum, c_in);					//2nd half adder
	
	assign c_out = tCarry | hCarry;							//or gate for carry
	
endmodule
