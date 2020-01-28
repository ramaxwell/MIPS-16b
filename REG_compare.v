`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:03:33 11/27/2011 
// Design Name: 
// Module Name:    REG_compare 
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
module REG_compare(compare_out, in1, in2);			//comparator(compare_wire, alu_in1, alu_in2);
		
		output	[4:0]	compare_out;
		input	[31:0]	in1, in2;
													//{equal, !equal, less than, greater than, zero}
			
		assign compare_out[4] = (in1 == in2)? 1'b1 : 1'b0;
		assign compare_out[3] = (in1 != in2)? 1'b1 : 1'b0;
		assign compare_out[2] = (in1 < in2)? 1'b1 : 1'b0;
		assign compare_out[1] = (in1 > in2)? 1'b1 : 1'b0;
		assign compare_out[0] = (in1 == 0)? 1'b1 : 1'b0;
					
endmodule

