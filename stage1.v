`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:01:23 11/16/2011 
// Design Name: 
// Module Name:    stage1 
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
module stage1(instr_out, post_inc_pc, prog_count);

	output 	[31:0]	instr_out, post_inc_pc;
	input	[31:0]	prog_count;
	
	parameter INC_VAL = 32'h00000004, CARRY_IN = 1'b0;
	
	wire			adder_cout;
	
instr_mem i_mem(instr_out, prog_count);
							
Adder_32b pc_inc(post_inc_pc, adder_cout, prog_count, INC_VAL, CARRY_IN);
							//Sum, Cout, x, y, Cin
	
endmodule
