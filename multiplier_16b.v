`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:34:10 06/21/2011 
// Design Name: 
// Module Name:    multiplier_16b 
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
module multiplier_16b(product, cout_mult, g, h, cin_mult);

	  input [15:0] g, h, cin_mult;
	  output cout_mult;
	  output [31:0] product;
	  
	  wire [14:1] s12, s23, s34, s45, s56, s67, s78, s89, s9A, sAB, sBC, sCD, sDE, sEF, sF1;
	  wire [14:0] c12, c23, c34, c45, c56, c67, c78, c89, c9A, cAB, cBC, cCD, cDE, cEF, cF1, cfinal;
	  
	  wire [14:0] fa_input1, fa_input2;
	  wire [15:0] fa_input3, fa_input4, fa_input5, fa_input6, fa_input7,
					  fa_input8, fa_input9, fa_inputA, fa_inputB, fa_inputC, fa_inputD, fa_inputE, 
					  fa_inputF, fa_inputF1;
	  wire fa_input_last;
	  
																//	
	  and(product[0], g[0], h[0]);					// <-------------------------------bit0			
																//
	  and(fa_input1[0], g[1], h[0]);					//top row of and gates
	  and(fa_input1[1], g[2], h[0]);					//
	  and(fa_input1[2], g[3], h[0]);
	  and(fa_input1[3], g[4], h[0]);
	  and(fa_input1[4], g[5], h[0]);			
	  and(fa_input1[5], g[6], h[0]);
	  and(fa_input1[6], g[7], h[0]);
	  and(fa_input1[7], g[8], h[0]);
	  and(fa_input1[8], g[9], h[0]);
	  and(fa_input1[9], g[10], h[0]);
	  and(fa_input1[10], g[11], h[0]);
	  and(fa_input1[11], g[12], h[0]);
	  and(fa_input1[12], g[13], h[0]);
	  and(fa_input1[13], g[14], h[0]);
	  and(fa_input1[14], g[15], h[0]);				//
	  
	  and(fa_input2[0], g[0], h[1]);					//2nd row of AND gates
	  and(fa_input2[1], g[1], h[1]);					//
	  and(fa_input2[2], g[2], h[1]);
	  and(fa_input2[3], g[3], h[1]);
	  and(fa_input2[4], g[4], h[1]);
	  and(fa_input2[5], g[5], h[1]);
	  and(fa_input2[6], g[6], h[1]);
	  and(fa_input2[7], g[7], h[1]);
	  and(fa_input2[8], g[8], h[1]);
	  and(fa_input2[9], g[9], h[1]);
	  and(fa_input2[10], g[10], h[1]);
	  and(fa_input2[11], g[11], h[1]);
	  and(fa_input2[12], g[12], h[1]);
	  and(fa_input2[13], g[13], h[1]);
	  and(fa_input2[14], g[14], h[1]);				//  (end of first row of FA's
	  
	  Add_Full FA11(product[1], c12[0], fa_input1[0], fa_input2[0], cin_mult[0]),		//<------------------bit1 
				  FA12(s12[1], c12[1], fa_input1[1], fa_input2[1], cin_mult[1]),
				  FA13(s12[2], c12[2], fa_input1[2], fa_input2[2], cin_mult[2]),
				  FA14(s12[3], c12[3], fa_input1[3], fa_input2[3], cin_mult[3]),
				  FA15(s12[4], c12[4], fa_input1[4], fa_input2[4], cin_mult[4]),
				  FA16(s12[5], c12[5], fa_input1[5], fa_input2[5], cin_mult[5]),
				  FA17(s12[6], c12[6], fa_input1[6], fa_input2[6], cin_mult[6]),
				  FA18(s12[7], c12[7], fa_input1[7], fa_input2[7], cin_mult[7]),
				  FA19(s12[8], c12[8], fa_input1[8], fa_input2[8], cin_mult[8]),
				  FA1A(s12[9], c12[9], fa_input1[9], fa_input2[9], cin_mult[9]),
				  FA1B(s12[10], c12[10], fa_input1[10], fa_input2[10], cin_mult[10]),
				  FA1C(s12[11], c12[11], fa_input1[11], fa_input2[11], cin_mult[11]),
				  FA1D(s12[12], c12[12], fa_input1[12], fa_input2[12], cin_mult[12]),
				  FA1E(s12[13], c12[13], fa_input1[13], fa_input2[13], cin_mult[13]),
				  FA1F(s12[14], c12[14], fa_input1[14], fa_input2[14], cin_mult[14]);
				  
	  
	  and(fa_input3[0], g[0], h[2]);					//3rd row of AND gates
	  and(fa_input3[1], g[1], h[2]);					//
	  and(fa_input3[2], g[2], h[2]);
	  and(fa_input3[3], g[3], h[2]);
	  and(fa_input3[4], g[4], h[2]);
	  and(fa_input3[5], g[5], h[2]);
	  and(fa_input3[6], g[6], h[2]);
	  and(fa_input3[7], g[7], h[2]);
	  and(fa_input3[8], g[8], h[2]);
	  and(fa_input3[9], g[9], h[2]);
	  and(fa_input3[10], g[10], h[2]);
	  and(fa_input3[11], g[11], h[2]);
	  and(fa_input3[12], g[12], h[2]);
	  and(fa_input3[13], g[13], h[2]);
	  and(fa_input3[14], g[14], h[2]);
	  
	  and(fa_input3[15], g[15], h[1]);				//<---------- last fa_input 
																// (end of row 2)
																
	  Add_Full FA21(product[2], c23[0], s12[1], fa_input3[0], c12[0]),		//<------------------bit2 
				  FA22(s23[1], c23[1], s12[2], fa_input3[1], c12[1]),
				  FA23(s23[2], c23[2], s12[3], fa_input3[2], c12[2]),
				  FA24(s23[3], c23[3], s12[4], fa_input3[3], c12[3]),
				  FA25(s23[4], c23[4], s12[5], fa_input3[4], c12[4]),
				  FA26(s23[5], c23[5], s12[6], fa_input3[5], c12[5]),
				  FA27(s23[6], c23[6], s12[7], fa_input3[6], c12[6]),
				  FA28(s23[7], c23[7], s12[8], fa_input3[7], c12[7]),
				  FA29(s23[8], c23[8], s12[9], fa_input3[8], c12[8]),
				  FA2A(s23[9], c23[9], s12[10], fa_input3[9], c12[9]),
				  FA2B(s23[10], c23[10], s12[11], fa_input3[10], c12[10]),
				  FA2C(s23[11], c23[11], s12[12], fa_input3[11], c12[11]),
				  FA2D(s23[12], c23[12], s12[13], fa_input3[12], c12[12]),
				  FA2E(s23[13], c23[13], s12[14], fa_input3[13], c12[13]),
				  FA2F(s23[14], c23[14], fa_input3[15], fa_input3[14], c12[14]);
				  
				  
	  and(fa_input4[0], g[0], h[3]);
	  and(fa_input4[1], g[1], h[3]);
	  and(fa_input4[2], g[2], h[3]);
	  and(fa_input4[3], g[3], h[3]);
	  and(fa_input4[4], g[4], h[3]);
	  and(fa_input4[5], g[5], h[3]);
	  and(fa_input4[6], g[6], h[3]);
	  and(fa_input4[7], g[7], h[3]);
	  and(fa_input4[8], g[8], h[3]);
	  and(fa_input4[9], g[9], h[3]);
	  and(fa_input4[10], g[10], h[3]);
	  and(fa_input4[11], g[11], h[3]);
	  and(fa_input4[12], g[12], h[3]);
	  and(fa_input4[13], g[13], h[3]);
	  and(fa_input4[14], g[14], h[3]);
	  
	  and(fa_input4[15], g[15], h[2]);				//<---------- last fa_input 
																// (end of row 3)
	  Add_Full FA31(product[3], c34[0], s23[1], fa_input4[0], c23[0]),		//<------------------bit3 
				  FA32(s34[1], c34[1], s23[2], fa_input4[1], c23[1]),
				  FA33(s34[2], c34[2], s23[3], fa_input4[2], c23[2]),
				  FA34(s34[3], c34[3], s23[4], fa_input4[3], c23[3]),
				  FA35(s34[4], c34[4], s23[5], fa_input4[4], c23[4]),
				  FA36(s34[5], c34[5], s23[6], fa_input4[5], c23[5]),
				  FA37(s34[6], c34[6], s23[7], fa_input4[6], c23[6]),
				  FA38(s34[7], c34[7], s23[8], fa_input4[7], c23[7]),
				  FA39(s34[8], c34[8], s23[9], fa_input4[8], c23[8]),
				  FA3A(s34[9], c34[9], s23[10], fa_input4[9], c23[9]),
				  FA3B(s34[10], c34[10], s23[11], fa_input4[10], c23[10]),
				  FA3C(s34[11], c34[11], s23[12], fa_input4[11], c23[11]),
				  FA3D(s34[12], c34[12], s23[13], fa_input4[12], c23[12]),
				  FA3E(s34[13], c34[13], s23[14], fa_input4[13], c23[13]),
				  FA3F(s34[14], c34[14], fa_input4[15], fa_input4[14], c23[14]);
	  
	  and(fa_input5[0], g[0], h[4]);
	  and(fa_input5[1], g[1], h[4]);
	  and(fa_input5[2], g[2], h[4]);
	  and(fa_input5[3], g[3], h[4]);
	  and(fa_input5[4], g[4], h[4]);
	  and(fa_input5[5], g[5], h[4]);
	  and(fa_input5[6], g[6], h[4]);
	  and(fa_input5[7], g[7], h[4]);
	  and(fa_input5[8], g[8], h[4]);
	  and(fa_input5[9], g[9], h[4]);
	  and(fa_input5[10], g[10], h[4]);
	  and(fa_input5[11], g[11], h[4]);
	  and(fa_input5[12], g[12], h[4]);
	  and(fa_input5[13], g[13], h[4]);
	  and(fa_input5[14], g[14], h[4]);
	  
	  and(fa_input5[15], g[15], h[3]);				//<---------- last fa_input 
																// (end of row 4)
	  Add_Full FA41(product[4], c45[0], s34[1], fa_input5[0], c34[0]),		//<------------------bit4 
				  FA42(s45[1], c45[1], s34[2], fa_input5[1], c34[1]),
				  FA43(s45[2], c45[2], s34[3], fa_input5[2], c34[2]),
				  FA44(s45[3], c45[3], s34[4], fa_input5[3], c34[3]),
				  FA45(s45[4], c45[4], s34[5], fa_input5[4], c34[4]),
				  FA46(s45[5], c45[5], s34[6], fa_input5[5], c34[5]),
				  FA47(s45[6], c45[6], s34[7], fa_input5[6], c34[6]),
				  FA48(s45[7], c45[7], s34[8], fa_input5[7], c34[7]),
				  FA49(s45[8], c45[8], s34[9], fa_input5[8], c34[8]),
				  FA4A(s45[9], c45[9], s34[10], fa_input5[9], c34[9]),
				  FA4B(s45[10], c45[10], s34[11], fa_input5[10], c34[10]),
				  FA4C(s45[11], c45[11], s34[12], fa_input5[11], c34[11]),
				  FA4D(s45[12], c45[12], s34[13], fa_input5[12], c34[12]),
				  FA4E(s45[13], c45[13], s34[14], fa_input5[13], c34[13]),
				  FA4F(s45[14], c45[14], fa_input5[15], fa_input5[14], c34[14]);
	  
	  and(fa_input6[0], g[0], h[5]);
	  and(fa_input6[1], g[1], h[5]);
	  and(fa_input6[2], g[2], h[5]);
	  and(fa_input6[3], g[3], h[5]);
	  and(fa_input6[4], g[4], h[5]);
	  and(fa_input6[5], g[5], h[5]);
	  and(fa_input6[6], g[6], h[5]);
	  and(fa_input6[7], g[7], h[5]);
	  and(fa_input6[8], g[8], h[5]);
	  and(fa_input6[9], g[9], h[5]);
	  and(fa_input6[10], g[10], h[5]);
	  and(fa_input6[11], g[11], h[5]);
	  and(fa_input6[12], g[12], h[5]);
	  and(fa_input6[13], g[13], h[5]);
	  and(fa_input6[14], g[14], h[5]);
	  
	  and(fa_input6[15], g[15], h[4]);				//<---------- last fa_input 
																// (end of row 5)
	  Add_Full FA51(product[5], c56[0], s45[1], fa_input6[0], c45[0]),		//<------------------bit5
				  FA52(s56[1], c56[1], s45[2], fa_input6[1], c45[1]),
				  FA53(s56[2], c56[2], s45[3], fa_input6[2], c45[2]),
				  FA54(s56[3], c56[3], s45[4], fa_input6[3], c45[3]),
				  FA55(s56[4], c56[4], s45[5], fa_input6[4], c45[4]),
				  FA56(s56[5], c56[5], s45[6], fa_input6[5], c45[5]),
				  FA57(s56[6], c56[6], s45[7], fa_input6[6], c45[6]),
				  FA58(s56[7], c56[7], s45[8], fa_input6[7], c45[7]),
				  FA59(s56[8], c56[8], s45[9], fa_input6[8], c45[8]),
				  FA5A(s56[9], c56[9], s45[10], fa_input6[9], c45[9]),
				  FA5B(s56[10], c56[10], s45[11], fa_input6[10], c45[10]),
				  FA5C(s56[11], c56[11], s45[12], fa_input6[11], c45[11]),
				  FA5D(s56[12], c56[12], s45[13], fa_input6[12], c45[12]),
				  FA5E(s56[13], c56[13], s45[14], fa_input6[13], c45[13]),
				  FA5F(s56[14], c56[14], fa_input6[15], fa_input6[14], c45[14]);
	  
	  and(fa_input7[0], g[0], h[6]);
	  and(fa_input7[1], g[1], h[6]);
	  and(fa_input7[2], g[2], h[6]);
	  and(fa_input7[3], g[3], h[6]);
	  and(fa_input7[4], g[4], h[6]);
	  and(fa_input7[5], g[5], h[6]);
	  and(fa_input7[6], g[6], h[6]);
	  and(fa_input7[7], g[7], h[6]);
	  and(fa_input7[8], g[8], h[6]);
	  and(fa_input7[9], g[9], h[6]);
	  and(fa_input7[10], g[10], h[6]);
	  and(fa_input7[11], g[11], h[6]);
	  and(fa_input7[12], g[12], h[6]);
	  and(fa_input7[13], g[13], h[6]);
	  and(fa_input7[14], g[14], h[6]);
	  
	  and(fa_input7[15], g[15], h[5]);				//<---------- last fa_input 
																// (end of row 6)
																
	   Add_Full FA61(product[6], c67[0], s56[1], fa_input7[0], c56[0]),		//<------------------bit6
				  FA62(s67[1], c67[1], s56[2], fa_input7[1], c56[1]),
				  FA63(s67[2], c67[2], s56[3], fa_input7[2], c56[2]),
				  FA64(s67[3], c67[3], s56[4], fa_input7[3], c56[3]),
				  FA65(s67[4], c67[4], s56[5], fa_input7[4], c56[4]),
				  FA66(s67[5], c67[5], s56[6], fa_input7[5], c56[5]),
				  FA67(s67[6], c67[6], s56[7], fa_input7[6], c56[6]),
				  FA68(s67[7], c67[7], s56[8], fa_input7[7], c56[7]),
				  FA69(s67[8], c67[8], s56[9], fa_input7[8], c56[8]),
				  FA6A(s67[9], c67[9], s56[10], fa_input7[9], c56[9]),
				  FA6B(s67[10], c67[10], s56[11], fa_input7[10], c56[10]),
				  FA6C(s67[11], c67[11], s56[12], fa_input7[11], c56[11]),
				  FA6D(s67[12], c67[12], s56[13], fa_input7[12], c56[12]),
				  FA6E(s67[13], c67[13], s56[14], fa_input7[13], c56[13]),
				  FA6F(s67[14], c67[14], fa_input7[15], fa_input7[14], c56[14]);
	  
	  and(fa_input8[0], g[0], h[7]);
	  and(fa_input8[1], g[1], h[7]);
	  and(fa_input8[2], g[2], h[7]);
	  and(fa_input8[3], g[3], h[7]);
	  and(fa_input8[4], g[4], h[7]);
	  and(fa_input8[5], g[5], h[7]);
	  and(fa_input8[6], g[6], h[7]);
	  and(fa_input8[7], g[7], h[7]);
	  and(fa_input8[8], g[8], h[7]);
	  and(fa_input8[9], g[9], h[7]);
	  and(fa_input8[10], g[10], h[7]);
	  and(fa_input8[11], g[11], h[7]);
	  and(fa_input8[12], g[12], h[7]);
	  and(fa_input8[13], g[13], h[7]);
	  and(fa_input8[14], g[14], h[7]);
	  
	  and(fa_input8[15], g[15], h[6]);				//<---------- last fa_input 
																// (end of row 7)
	
	  Add_Full FA71(product[7], c78[0], s67[1], fa_input8[0], c67[0]),		//<------------------bit7
				  FA72(s78[1], c78[1], s67[2], fa_input8[1], c67[1]),
				  FA73(s78[2], c78[2], s67[3], fa_input8[2], c67[2]),
				  FA74(s78[3], c78[3], s67[4], fa_input8[3], c67[3]),
				  FA75(s78[4], c78[4], s67[5], fa_input8[4], c67[4]),
				  FA76(s78[5], c78[5], s67[6], fa_input8[5], c67[5]),
				  FA77(s78[6], c78[6], s67[7], fa_input8[6], c67[6]),
				  FA78(s78[7], c78[7], s67[8], fa_input8[7], c67[7]),
				  FA79(s78[8], c78[8], s67[9], fa_input8[8], c67[8]),
				  FA7A(s78[9], c78[9], s67[10], fa_input8[9], c67[9]),
				  FA7B(s78[10], c78[10], s67[11], fa_input8[10], c67[10]),
				  FA7C(s78[11], c78[11], s67[12], fa_input8[11], c67[11]),
				  FA7D(s78[12], c78[12], s67[13], fa_input8[12], c67[12]),
				  FA7E(s78[13], c78[13], s67[14], fa_input8[13], c67[13]),
				  FA7F(s78[14], c78[14], fa_input8[15], fa_input8[14], c67[14]);
		
	  and(fa_input9[0], g[0], h[8]);
	  and(fa_input9[1], g[1], h[8]);
	  and(fa_input9[2], g[2], h[8]);
	  and(fa_input9[3], g[3], h[8]);
	  and(fa_input9[4], g[4], h[8]);
	  and(fa_input9[5], g[5], h[8]);
	  and(fa_input9[6], g[6], h[8]);
	  and(fa_input9[7], g[7], h[8]);
	  and(fa_input9[8], g[8], h[8]);
	  and(fa_input9[9], g[9], h[8]);
	  and(fa_input9[10], g[10], h[8]);
	  and(fa_input9[11], g[11], h[8]);
	  and(fa_input9[12], g[12], h[8]);
	  and(fa_input9[13], g[13], h[8]);
	  and(fa_input9[14], g[14], h[8]);
	  
	  and(fa_input9[15], g[15], h[7]);				//<---------- last fa_input 
																// (end of row 8)
	  
	  Add_Full FA81(product[8], c89[0], s78[1], fa_input9[0], c78[0]),		//<------------------bit8
				  FA82(s89[1], c89[1], s78[2], fa_input9[1], c78[1]),
				  FA83(s89[2], c89[2], s78[3], fa_input9[2], c78[2]),
				  FA84(s89[3], c89[3], s78[4], fa_input9[3], c78[3]),
				  FA85(s89[4], c89[4], s78[5], fa_input9[4], c78[4]),
				  FA86(s89[5], c89[5], s78[6], fa_input9[5], c78[5]),
				  FA87(s89[6], c89[6], s78[7], fa_input9[6], c78[6]),
				  FA88(s89[7], c89[7], s78[8], fa_input9[7], c78[7]),
				  FA89(s89[8], c89[8], s78[9], fa_input9[8], c78[8]),
				  FA8A(s89[9], c89[9], s78[10], fa_input9[9], c78[9]),
				  FA8B(s89[10], c89[10], s78[11], fa_input9[10], c78[10]),
				  FA8C(s89[11], c89[11], s78[12], fa_input9[11], c78[11]),
				  FA8D(s89[12], c89[12], s78[13], fa_input9[12], c78[12]),
				  FA8E(s89[13], c89[13], s78[14], fa_input9[13], c78[13]),
				  FA8F(s89[14], c89[14], fa_input9[15], fa_input9[14], c78[14]);
		
	  and(fa_inputA[0], g[0], h[9]);
	  and(fa_inputA[1], g[1], h[9]);
	  and(fa_inputA[2], g[2], h[9]);
	  and(fa_inputA[3], g[3], h[9]);
	  and(fa_inputA[4], g[4], h[9]);
	  and(fa_inputA[5], g[5], h[9]);
	  and(fa_inputA[6], g[6], h[9]);
	  and(fa_inputA[7], g[7], h[9]);
	  and(fa_inputA[8], g[8], h[9]);
	  and(fa_inputA[9], g[9], h[9]);
	  and(fa_inputA[10], g[10], h[9]);
	  and(fa_inputA[11], g[11], h[9]);
	  and(fa_inputA[12], g[12], h[9]);
	  and(fa_inputA[13], g[13], h[9]);
	  and(fa_inputA[14], g[14], h[9]);
	  
	  and(fa_inputA[15], g[15], h[8]);				//<---------- last fa_input 
																// (end of row 9)
	
	  Add_Full FA91(product[9], c9A[0], s89[1], fa_inputA[0], c89[0]),		//<------------------bit9
				  FA92(s9A[1], c9A[1], s89[2], fa_inputA[1], c89[1]),
				  FA93(s9A[2], c9A[2], s89[3], fa_inputA[2], c89[2]),
				  FA94(s9A[3], c9A[3], s89[4], fa_inputA[3], c89[3]),
				  FA95(s9A[4], c9A[4], s89[5], fa_inputA[4], c89[4]),
				  FA96(s9A[5], c9A[5], s89[6], fa_inputA[5], c89[5]),
				  FA97(s9A[6], c9A[6], s89[7], fa_inputA[6], c89[6]),
				  FA98(s9A[7], c9A[7], s89[8], fa_inputA[7], c89[7]),
				  FA99(s9A[8], c9A[8], s89[9], fa_inputA[8], c89[8]),
				  FA9A(s9A[9], c9A[9], s89[10], fa_inputA[9], c89[9]),
				  FA9B(s9A[10], c9A[10], s89[11], fa_inputA[10], c89[10]),
				  FA9C(s9A[11], c9A[11], s89[12], fa_inputA[11], c89[11]),
				  FA9D(s9A[12], c9A[12], s89[13], fa_inputA[12], c89[12]),
				  FA9E(s9A[13], c9A[13], s89[14], fa_inputA[13], c89[13]),
				  FA9F(s9A[14], c9A[14], fa_inputA[15], fa_inputA[14], c89[14]);
		
	  and(fa_inputB[0], g[0], h[10]);
	  and(fa_inputB[1], g[1], h[10]);
	  and(fa_inputB[2], g[2], h[10]);
	  and(fa_inputB[3], g[3], h[10]);
	  and(fa_inputB[4], g[4], h[10]);
	  and(fa_inputB[5], g[5], h[10]);
	  and(fa_inputB[6], g[6], h[10]);
	  and(fa_inputB[7], g[7], h[10]);
	  and(fa_inputB[8], g[8], h[10]);
	  and(fa_inputB[9], g[9], h[10]);
	  and(fa_inputB[10], g[10], h[10]);
	  and(fa_inputB[11], g[11], h[10]);
	  and(fa_inputB[12], g[12], h[10]);
	  and(fa_inputB[13], g[13], h[10]);
	  and(fa_inputB[14], g[14], h[10]);
	  
	  and(fa_inputB[15], g[15], h[9]);				//<---------- last fa_input 
																// (end of row 10)
	
	  Add_Full FAA1(product[10], cAB[0], s9A[1], fa_inputB[0], c9A[0]),		//<------------------bit10
				  FAA2(sAB[1], cAB[1], s9A[2], fa_inputB[1], c9A[1]),
				  FAA3(sAB[2], cAB[2], s9A[3], fa_inputB[2], c9A[2]),
				  FAA4(sAB[3], cAB[3], s9A[4], fa_inputB[3], c9A[3]),
				  FAA5(sAB[4], cAB[4], s9A[5], fa_inputB[4], c9A[4]),
				  FAA6(sAB[5], cAB[5], s9A[6], fa_inputB[5], c9A[5]),
				  FAA7(sAB[6], cAB[6], s9A[7], fa_inputB[6], c9A[6]),
				  FAA8(sAB[7], cAB[7], s9A[8], fa_inputB[7], c9A[7]),
				  FAA9(sAB[8], cAB[8], s9A[9], fa_inputB[8], c9A[8]),
				  FAAA(sAB[9], cAB[9], s9A[10], fa_inputB[9], c9A[9]),
				  FAAB(sAB[10], cAB[10], s9A[11], fa_inputB[10], c9A[10]),
				  FAAC(sAB[11], cAB[11], s9A[12], fa_inputB[11], c9A[11]),
				  FAAD(sAB[12], cAB[12], s9A[13], fa_inputB[12], c9A[12]),
				  FAAE(sAB[13], cAB[13], s9A[14], fa_inputB[13], c9A[13]),
				  FAAF(sAB[14], cAB[14], fa_inputB[15], fa_inputB[14], c9A[14]);
		
	  and(fa_inputC[0], g[0], h[11]);
	  and(fa_inputC[1], g[1], h[11]);
	  and(fa_inputC[2], g[2], h[11]);
	  and(fa_inputC[3], g[3], h[11]);
	  and(fa_inputC[4], g[4], h[11]);
	  and(fa_inputC[5], g[5], h[11]);
	  and(fa_inputC[6], g[6], h[11]);
	  and(fa_inputC[7], g[7], h[11]);
	  and(fa_inputC[8], g[8], h[11]);
	  and(fa_inputC[9], g[9], h[11]);
	  and(fa_inputC[10], g[10], h[11]);
	  and(fa_inputC[11], g[11], h[11]);
	  and(fa_inputC[12], g[12], h[11]);
	  and(fa_inputC[13], g[13], h[11]);
	  and(fa_inputC[14], g[14], h[11]);
	  
	  and(fa_inputC[15], g[15], h[10]);				//<---------- last fa_input 
																// (end of row 11)
	
	  Add_Full FAB1(product[11], cBC[0], sAB[1], fa_inputC[0], cAB[0]),		//<------------------bit11
				  FAB2(sBC[1], cBC[1], sAB[2], fa_inputC[1], cAB[1]),
				  FAB3(sBC[2], cBC[2], sAB[3], fa_inputC[2], cAB[2]),
				  FAB4(sBC[3], cBC[3], sAB[4], fa_inputC[3], cAB[3]),
				  FAB5(sBC[4], cBC[4], sAB[5], fa_inputC[4], cAB[4]),
				  FAB6(sBC[5], cBC[5], sAB[6], fa_inputC[5], cAB[5]),
				  FAB7(sBC[6], cBC[6], sAB[7], fa_inputC[6], cAB[6]),
				  FAB8(sBC[7], cBC[7], sAB[8], fa_inputC[7], cAB[7]),
				  FAB9(sBC[8], cBC[8], sAB[9], fa_inputC[8], cAB[8]),
				  FABA(sBC[9], cBC[9], sAB[10], fa_inputC[9], cAB[9]),
				  FABB(sBC[10], cBC[10], sAB[11], fa_inputC[10], cAB[10]),
				  FABC(sBC[11], cBC[11], sAB[12], fa_inputC[11], cAB[11]),
				  FABD(sBC[12], cBC[12], sAB[13], fa_inputC[12], cAB[12]),
				  FABE(sBC[13], cBC[13], sAB[14], fa_inputC[13], cAB[13]),
				  FABF(sBC[14], cBC[14], fa_inputC[15], fa_inputC[14], cAB[14]);
				  
	  and(fa_inputD[0], g[0], h[12]);
	  and(fa_inputD[1], g[1], h[12]);
	  and(fa_inputD[2], g[2], h[12]);
	  and(fa_inputD[3], g[3], h[12]);
	  and(fa_inputD[4], g[4], h[12]);
	  and(fa_inputD[5], g[5], h[12]);
	  and(fa_inputD[6], g[6], h[12]);
	  and(fa_inputD[7], g[7], h[12]);
	  and(fa_inputD[8], g[8], h[12]);
	  and(fa_inputD[9], g[9], h[12]);
	  and(fa_inputD[10], g[10], h[12]);
	  and(fa_inputD[11], g[11], h[12]);
	  and(fa_inputD[12], g[12], h[12]);
	  and(fa_inputD[13], g[13], h[12]);
	  and(fa_inputD[14], g[14], h[12]);
	  
	  and(fa_inputD[15], g[15], h[11]);				//<---------- last fa_input 
																// (end of row 12)
	
	  
	  Add_Full FAC1(product[12], cCD[0], sBC[1], fa_inputD[0], cBC[0]),		//<------------------bit12
				  FAC2(sCD[1], cCD[1], sBC[2], fa_inputD[1], cBC[1]),
				  FAC3(sCD[2], cCD[2], sBC[3], fa_inputD[2], cBC[2]),
				  FAC4(sCD[3], cCD[3], sBC[4], fa_inputD[3], cBC[3]),
				  FAC5(sCD[4], cCD[4], sBC[5], fa_inputD[4], cBC[4]),
				  FAC6(sCD[5], cCD[5], sBC[6], fa_inputD[5], cBC[5]),
				  FAC7(sCD[6], cCD[6], sBC[7], fa_inputD[6], cBC[6]),
				  FAC8(sCD[7], cCD[7], sBC[8], fa_inputD[7], cBC[7]),
				  FAC9(sCD[8], cCD[8], sBC[9], fa_inputD[8], cBC[8]),
				  FACA(sCD[9], cCD[9], sBC[10], fa_inputD[9], cBC[9]),
				  FACB(sCD[10], cCD[10], sBC[11], fa_inputD[10], cBC[10]),
				  FACC(sCD[11], cCD[11], sBC[12], fa_inputD[11], cBC[11]),
				  FACD(sCD[12], cCD[12], sBC[13], fa_inputD[12], cBC[12]),
				  FACE(sCD[13], cCD[13], sBC[14], fa_inputD[13], cBC[13]),
				  FACF(sCD[14], cCD[14], fa_inputD[15], fa_inputD[14], cBC[14]);
				  
	  and(fa_inputE[0], g[0], h[13]);
	  and(fa_inputE[1], g[1], h[13]);
	  and(fa_inputE[2], g[2], h[13]);
	  and(fa_inputE[3], g[3], h[13]);
	  and(fa_inputE[4], g[4], h[13]);
	  and(fa_inputE[5], g[5], h[13]);
	  and(fa_inputE[6], g[6], h[13]);
	  and(fa_inputE[7], g[7], h[13]);
	  and(fa_inputE[8], g[8], h[13]);
	  and(fa_inputE[9], g[9], h[13]);
	  and(fa_inputE[10], g[10], h[13]);
	  and(fa_inputE[11], g[11], h[13]);
	  and(fa_inputE[12], g[12], h[13]);
	  and(fa_inputE[13], g[13], h[13]);
	  and(fa_inputE[14], g[14], h[13]);
	  
	  and(fa_inputE[15], g[15], h[12]);				//<---------- last fa_input 
																// (end of row 13)
	
	   
	  Add_Full FAD1(product[13], cDE[0], sCD[1], fa_inputE[0], cCD[0]),		//<------------------bit13
				  FAD2(sDE[1], cDE[1], sCD[2], fa_inputE[1], cCD[1]),
				  FAD3(sDE[2], cDE[2], sCD[3], fa_inputE[2], cCD[2]),
				  FAD4(sDE[3], cDE[3], sCD[4], fa_inputE[3], cCD[3]),
				  FAD5(sDE[4], cDE[4], sCD[5], fa_inputE[4], cCD[4]),
				  FAD6(sDE[5], cDE[5], sCD[6], fa_inputE[5], cCD[5]),
				  FAD7(sDE[6], cDE[6], sCD[7], fa_inputE[6], cCD[6]),
				  FAD8(sDE[7], cDE[7], sCD[8], fa_inputE[7], cCD[7]),
				  FAD9(sDE[8], cDE[8], sCD[9], fa_inputE[8], cCD[8]),
				  FADA(sDE[9], cDE[9], sCD[10], fa_inputE[9], cCD[9]),
				  FADB(sDE[10], cDE[10], sCD[11], fa_inputE[10], cCD[10]),
				  FADC(sDE[11], cDE[11], sCD[12], fa_inputE[11], cCD[11]),
				  FADD(sDE[12], cDE[12], sCD[13], fa_inputE[12], cCD[12]),
				  FADE(sDE[13], cDE[13], sCD[14], fa_inputE[13], cCD[13]),
				  FADF(sDE[14], cDE[14], fa_inputE[15], fa_inputE[14], cCD[14]);
				  
	  and(fa_inputF[0], g[0], h[14]);
	  and(fa_inputF[1], g[1], h[14]);
	  and(fa_inputF[2], g[2], h[14]);
	  and(fa_inputF[3], g[3], h[14]);
	  and(fa_inputF[4], g[4], h[14]);
	  and(fa_inputF[5], g[5], h[14]);
	  and(fa_inputF[6], g[6], h[14]);
	  and(fa_inputF[7], g[7], h[14]);
	  and(fa_inputF[8], g[8], h[14]);
	  and(fa_inputF[9], g[9], h[14]);
	  and(fa_inputF[10], g[10], h[14]);
	  and(fa_inputF[11], g[11], h[14]);
	  and(fa_inputF[12], g[12], h[14]);
	  and(fa_inputF[13], g[13], h[14]);
	  and(fa_inputF[14], g[14], h[14]);
	  
	  and(fa_inputF[15], g[15], h[13]);				//<---------- last fa_input 
																// (end of row 14)
	
	
	  Add_Full FAE1(product[14], cEF[0], sDE[1], fa_inputF[0], cDE[0]),		//<------------------bit14
				  FAE2(sEF[1], cEF[1], sDE[2], fa_inputF[1], cDE[1]),
				  FAE3(sEF[2], cEF[2], sDE[3], fa_inputF[2], cDE[2]),
				  FAE4(sEF[3], cEF[3], sDE[4], fa_inputF[3], cDE[3]),
				  FAE5(sEF[4], cEF[4], sDE[5], fa_inputF[4], cDE[4]),
				  FAE6(sEF[5], cEF[5], sDE[6], fa_inputF[5], cDE[5]),
				  FAE7(sEF[6], cEF[6], sDE[7], fa_inputF[6], cDE[6]),
				  FAE8(sEF[7], cEF[7], sDE[8], fa_inputF[7], cDE[7]),
				  FAE9(sEF[8], cEF[8], sDE[9], fa_inputF[8], cDE[8]),
				  FAEA(sEF[9], cEF[9], sDE[10], fa_inputF[9], cDE[9]),
				  FAEB(sEF[10], cEF[10], sDE[11], fa_inputF[10], cDE[10]),
				  FAEC(sEF[11], cEF[11], sDE[12], fa_inputF[11], cDE[11]),
				  FAED(sEF[12], cEF[12], sDE[13], fa_inputF[12], cDE[12]),
				  FAEE(sEF[13], cEF[13], sDE[14], fa_inputF[13], cDE[13]),
				  FAEF(sEF[14], cEF[14], fa_inputF[15], fa_inputF[14], cDE[14]);
				  
	  
	  and(fa_inputF1[0], g[0], h[15]);
	  and(fa_inputF1[1], g[1], h[15]);
	  and(fa_inputF1[2], g[2], h[15]);
	  and(fa_inputF1[3], g[3], h[15]);
	  and(fa_inputF1[4], g[4], h[15]);
	  and(fa_inputF1[5], g[5], h[15]);
	  and(fa_inputF1[6], g[6], h[15]);
	  and(fa_inputF1[7], g[7], h[15]);
	  and(fa_inputF1[8], g[8], h[15]);
	  and(fa_inputF1[9], g[9], h[15]);
	  and(fa_inputF1[10], g[10], h[15]);
	  and(fa_inputF1[11], g[11], h[15]);
	  and(fa_inputF1[12], g[12], h[15]);
	  and(fa_inputF1[13], g[13], h[15]);
	  and(fa_inputF1[14], g[14], h[15]);
	  
	  and(fa_inputF1[15], g[15], h[14]);				//<---------- last fa_input 
																// (end of row 15)
	
	  Add_Full FAF1(product[15], cF1[0], sEF[1], fa_inputF1[0], cEF[0]),		//<------------------bit15
				  FAF2(sF1[1], cF1[1], sEF[2], fa_inputF1[1], cEF[1]),
				  FAF3(sF1[2], cF1[2], sEF[3], fa_inputF1[2], cEF[2]),
				  FAF4(sF1[3], cF1[3], sEF[4], fa_inputF1[3], cEF[3]),
				  FAF5(sF1[4], cF1[4], sEF[5], fa_inputF1[4], cEF[4]),
				  FAF6(sF1[5], cF1[5], sEF[6], fa_inputF1[5], cEF[5]),
				  FAF7(sF1[6], cF1[6], sEF[7], fa_inputF1[6], cEF[6]),
				  FAF8(sF1[7], cF1[7], sEF[8], fa_inputF1[7], cEF[7]),
				  FAF9(sF1[8], cF1[8], sEF[9], fa_inputF1[8], cEF[8]),
				  FAFA(sF1[9], cF1[9], sEF[10], fa_inputF1[9], cEF[9]),
				  FAFB(sF1[10], cF1[10], sEF[11], fa_inputF1[10], cEF[10]),
				  FAFC(sF1[11], cF1[11], sEF[12], fa_inputF1[11], cEF[11]),
				  FAFD(sF1[12], cF1[12], sEF[13], fa_inputF1[12], cEF[12]),
				  FAFE(sF1[13], cF1[13], sEF[14], fa_inputF1[13], cEF[13]),
				  FAFF(sF1[14], cF1[14], fa_inputF1[15], fa_inputF1[14], cEF[14]);
				  
				  
																
	  and (fa_input_last, g[15], h[15]);

	  Add_Full FAFF1(product[16], cfinal[0], sF1[1], cin_mult[15], cF1[0]),		//!!!!!!!!!!!!!!!<------------------bit16
				  FAFF2(product[17], cfinal[1], sF1[2], cfinal[0], cF1[1]),				//bit17
				  FAFF3(product[18], cfinal[2], sF1[3], cfinal[1], cF1[2]),				//bit18
				  FAFF4(product[19], cfinal[3], sF1[4], cfinal[2], cF1[3]),				//bit19
				  FAFF5(product[20], cfinal[4], sF1[5], cfinal[3], cF1[4]),				//bit20
				  FAFF6(product[21], cfinal[5], sF1[6], cfinal[4], cF1[5]),				//bit21
				  FAFF7(product[22], cfinal[6], sF1[7], cfinal[5], cF1[6]),				//bit22
				  FAFF8(product[23], cfinal[7], sF1[8], cfinal[6], cF1[7]),				//bit23
				  FAFF9(product[24], cfinal[8], sF1[9], cfinal[7], cF1[8]),				//bit24
				  FAFFA(product[25], cfinal[9], sF1[10], cfinal[8], cF1[9]),			//bit25
				  FAFFB(product[26], cfinal[10], sF1[11], cfinal[9], cF1[10]),		//bit26
				  FAFFC(product[27], cfinal[11], sF1[12], cfinal[10], cF1[11]),		//bit27
				  FAFFD(product[28], cfinal[12], sF1[13], cfinal[11], cF1[12]),		//bit28
				  FAFFE(product[29], cfinal[13], sF1[14], cfinal[12], cF1[13]),		//bit29
				  FAFFF(product[30], cfinal[14], fa_input_last, cfinal[13], cF1[14]);		//bit30
	  
	  assign cout_mult = cfinal[14];
	  assign product[31] = cfinal[14];
	  
endmodule
