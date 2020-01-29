`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    12:53:01 06/07/2011 
// Design Name:     Half Adder (R/C)
// Module Name:     Add_Half 
// Project Name:    4-bit Full Adder
// Target Devices:
// Tool versions: 
// Description: 
//              Half Adder for use in a full adder
//
// Dependencies: None
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Add_Half(sum, c_out, a, b);

    input a, b;
    output sum, c_out;

    xor(sum,a,b);       //only need gate primitives
    and(c_out,a,b);

endmodule
