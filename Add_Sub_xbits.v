`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    15:02:11 07/27/2011 
// Design Name:     16 bit Adder/Subtractor
// Module Name:    Add_Sub_xbits 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//                  16 bit full adder/subtractor made of 1-bit full
//              adder/subtractors
//
// Dependencies:    Full Adder/Subtractor (Full_Add_Sub.v)
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Add_Sub_xbits(sum, carry, Aa, Bb, add_sub_sel);

    input   [15:0]  Aa;
    input   [15:0]  Bb;
    input           add_sub_sel;  //0 = add, 1 = sub
    output  [15:0]  sum;
    output          carry;

    wire    [15:0]  carry_wire;
    wire    [15:0]  temp_sum;
    
    //Full_Add_Sub(a,b,select,full_cin,full_sum,full_cout)
    Full_Add_Sub FAS1(Aa[0], Bb[0], add_sub_sel, add_sub_sel, temp_sum[0], carry_wire[0]), 
                FAS2(Aa[1], Bb[1], add_sub_sel, carry_wire[0], temp_sum[1], carry_wire[1]),
                FAS3(Aa[2], Bb[2], add_sub_sel, carry_wire[1], temp_sum[2], carry_wire[2]),
                FAS4(Aa[3], Bb[3], add_sub_sel, carry_wire[2], temp_sum[3], carry_wire[3]),
                FAS5(Aa[4], Bb[4], add_sub_sel, carry_wire[3], temp_sum[4], carry_wire[4]),
                FAS6(Aa[5], Bb[5], add_sub_sel, carry_wire[4], temp_sum[5], carry_wire[5]), 
                FAS7(Aa[6], Bb[6], add_sub_sel, carry_wire[5], temp_sum[6], carry_wire[6]),
                FAS8(Aa[7], Bb[7], add_sub_sel, carry_wire[6], temp_sum[7], carry_wire[7]),
                FAS9(Aa[8], Bb[8], add_sub_sel, carry_wire[7], temp_sum[8], carry_wire[8]),
                FASA(Aa[9], Bb[9], add_sub_sel, carry_wire[8], temp_sum[9], carry_wire[9]), 
                FASB(Aa[10], Bb[10], add_sub_sel, carry_wire[9], temp_sum[10], carry_wire[10]), 
                FASC(Aa[11], Bb[11], add_sub_sel, carry_wire[10], temp_sum[11], carry_wire[11]),
                FASD(Aa[12], Bb[12], add_sub_sel, carry_wire[11], temp_sum[12], carry_wire[12]),
                FASE(Aa[13], Bb[13], add_sub_sel, carry_wire[12], temp_sum[13], carry_wire[13]),
                FASF(Aa[14], Bb[14], add_sub_sel, carry_wire[13], temp_sum[14], carry_wire[14]),
                FASG(Aa[15], Bb[15], add_sub_sel, carry_wire[14], temp_sum[15], carry_wire[15]); 

    assign sum = temp_sum[15:0];
    assign carry = add_sub_sel? 1'b0: carry_wire[15];

endmodule