`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:18 06/20/2011 
// Design Name: 
// Module Name:    alu_16b 
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
module alu_16b(alu_out, cond_code, inA, inB, alu_ctrl);
	
	output reg	[31:0]	alu_out;		//
	output 		[5:0]	cond_code;		//{equal, !equal, less than, greater than, zero, overflow}
	
	input		[31:0]		inA, inB;
	input		[3:0]		alu_ctrl;				//which alu operation
	
	wire		[15:0]		alu_in1, alu_in2;		//
	wire		[4:0]		compare_wire;			//{equal, !equal, less than, greater than, zero}
	wire		[31:0]		and_wire, or_wire;
	wire		[31:0]		shiftWire;
	wire		[15:0]		sumWire; 
	wire					carry_wire;
	wire					AorS, LorR;				//add or sub  //left or right shift
	wire		[4:0]		shift_amt;
	
	assign	alu_in1 = inA[15:0];
	assign	alu_in2 = inB[15:0];
	assign 	cond_code = {compare_wire, carry_wire};
	assign	AorS = alu_ctrl[3];
	assign  LorR = alu_ctrl[3];
	assign	shift_amt = inB[10:6];
	
	parameter	ONE = 4'b0001, TWO = 4'b1001, THREE = 4'b0011, FOUR = 4'b0100, FIVE = 4'b0101, 
				SIX = 4'b1101, SEVEN = 4'b0111, EIGHT = 4'b0010, NINE = 4'b1010;
	
	parameter   ONE_32b = 32'h00000001, ZERO_32b = 32'h00000000;
	
   //multiplier_16b umult(multWire, overFlow, inA, inB, 16'h0000);		//multiplier
	
	Add_Sub_xbits uadd(sumWire, carry_wire, alu_in1, alu_in2, AorS);	//Adder (16b)
				//Add_Sub_xbits(sum, carry, Aa, Bb, add_sub_sel)		//Add = 0; Sub = 1;
				
	Xshifter lshf(shiftWire, inA, shift_amt, LorR);//inB[10:6] should be shift amount	//Xshifter(result, data, amt, direc)			//Direc: 0 = lshf, 1 = rshf

	//*************************************************
	Xcompare comparator(compare_wire, inA, inB, alu_out);
	//*************************************************
	ANDX ander(and_wire, inA, inB);
	
	ORX	orer(or_wire, inA, inB);

	always@(inA or inB or alu_ctrl or sumWire or and_wire or or_wire or shiftWire or shift_amt or compare_wire)
	begin
		case(alu_ctrl)
			ONE: begin alu_out = sumWire[15]? {16'hFFFF, sumWire} : {16'h0000,sumWire};  end	//add			0001
			TWO: begin alu_out = sumWire[15]? {16'hFFFF, sumWire} : {16'h0000,sumWire};  end	//sub			1001
			THREE: begin alu_out = and_wire; end					//and	0011
			FOUR: begin alu_out = or_wire; end						//or	0100
			FIVE: begin alu_out = shiftWire; end					//SL	0101
			SIX: begin alu_out = shiftWire; end						//SR	1101
			SEVEN: begin alu_out = inB << 16; end					//LUI
			EIGHT: begin  alu_out = (inA[31] ^ inB[31]) ? {31'h00000000, ~compare_wire[2]} : {31'h00000000, compare_wire[2]}; end				///slt/i
			NINE: begin alu_out = {31'h00000000, compare_wire[2]}; end		///sltu/ui
			default:begin alu_out = 32'h00000000; end
		endcase
	end
					
endmodule
