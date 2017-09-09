`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    15:36:05 07/27/2011 
// Design Name:     Variable Amount Cross Shifter
// Module Name:     Xshifter 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//              Shifter that takes in an amount and a direction and
//          shifts data appropriately
//
// Dependencies:    N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Xshifter(result, data, amt, direc);

    output  [31:0]  result;
    input   [31:0]  data;
    input   [4:0]   amt;
    input           direc;  //0 = lshf, 1 = rshf

    assign	result = (direc)? (data >> amt) : (data << amt);

endmodule
