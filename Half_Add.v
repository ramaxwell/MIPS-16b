`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    14:03:54 07/27/2011 
// Design Name:     Half Adder
// Module Name:     Half_Add 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//                  Half Adder
//
// Dependencies:    N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Half_Add(a, b, h_sum, h_carry);

    input a, b;
    output h_sum, h_carry;

    xor(h_sum, a, b);
    and(h_carry, a, b);

endmodule
