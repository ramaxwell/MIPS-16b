`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    14:08:30 07/27/2011 
// Design Name:     1-bit Full Add/Subtract
// Module Name:     Full_Add_Sub 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//                  Adder/Subtractor controlled by XOR gate
//                  (0: Adder, 1: Subtractor)
//
// Dependencies:    Half Adder (Half_Add.v)
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Full_Add_Sub(a, b, select, full_cin, full_sum, full_cout);

	input	a, b, full_cin, select;
	output	full_sum, full_cout;
	
	wire	h_sum_wire, h_cout_wire, b_in_wire, h2_cout_wire;
	
	xor(b_in_wire, select, b);
	
	Half_Add HA_1(a, b_in_wire, h_sum_wire, h_cout_wire);				//(a, b, h_sum, h_carry)
	Half_Add HA_2(h_sum_wire, full_cin, full_sum, h2_cout_wire);

	or(full_cout, h_cout_wire, h2_cout_wire);
	
endmodule
