`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    12:03:33 11/27/2011 
// Design Name:    Comparator for Registers
// Module Name:    REG_compare 
// Project Name:   MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//          Comparator for Reg Values (in1 compared to in2)
//          Compare output map: 5-bits
//              {equal, !equal, less than, greater than, zero}
// Dependencies:    N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module REG_compare(compare_out, in1, in2);
        //comparator(compare_wire, alu_in1, alu_in2);

    output  [4:0]   compare_out;
    input   [31:0]  in1, in2;

    assign compare_out[4] = (in1 == in2)? 1'b1 : 1'b0;  //equality
    assign compare_out[3] = (in1 != in2)? 1'b1 : 1'b0;  //non-equality
    assign compare_out[2] = (in1 < in2)? 1'b1 : 1'b0;   //LT
    assign compare_out[1] = (in1 > in2)? 1'b1 : 1'b0;   //GT
    assign compare_out[0] = (in1 == 0)? 1'b1 : 1'b0;    //Zero

endmodule
