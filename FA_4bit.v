`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  
// Engineer:    Robert A. Maxwell
// 
// Create Date:    14:57:42 06/07/2011 
// Design Name:    4-Bit Full Adder
// Module Name:    FA_4bit 
// Project Name:   MIPS 16 bit Processor
// Target Devices:
// Tool versions: 
// Description: 
//              4-Bit Full Adder using 4 1-bit Full Adders
//
// Dependencies: 1-Bit Full Adder (Add_Full.v)
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module FA_4bit(sum, c_out, a, b, c_in);
	
	input 	[3:0] 	a, b;						// inputs
	input 			c_in;
	output 	[3:0] 	sum;						//outputs
	output 			c_out;
	
	wire 	[3:1] 	c;							//carry wire

	Add_Full Bit0(sum[0], c[1], a[0], b[0], c_in),				//1-bit Full adder 1
				Bit1(sum[1], c[2], a[1], b[1], c[1]),			//1-bit Full adder 2
				Bit2(sum[2], c[3], a[2], b[2], c[2]),			//1-bit Full adder 3
				Bit3(sum[3], c_out, a[3], b[3], c[3]);			//1-bit Full adder 4

endmodule
