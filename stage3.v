`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:02:12 11/16/2011 
// Design Name: 
// Module Name:    stage3 
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
module stage3(offset_out, cond_codes, alu_out, regData2_out, dest_reg_out, p_count, 
				pc_offset, alu_ip1, regData2, alu_ctrl, src, dest, alu_ip2_source, 
				reg_dest_ctrl, wb_w_data, mem_alu_out, forwd_mux1_ctrl, forwd_mux2_ctrl);

	output	[31:0]	offset_out;
	output	[5:0]	cond_codes;				//{equal, !equal, less than, greater than, zero, overflow}
	output	[31:0]	alu_out, regData2_out;
	output	[4:0]	dest_reg_out;
	
	input	[31:0]		p_count, pc_offset, alu_ip1, regData2;
	input	[3:0]		alu_ctrl;									//determines alu operation
	input	[4:0]		src, dest;
	input				alu_ip2_source;
	input				reg_dest_ctrl;
	
	input	[31:0]		wb_w_data;
	input	[31:0]		mem_alu_out;
	input	[1:0]		forwd_mux1_ctrl, forwd_mux2_ctrl; //mux1 = alu_ip1, mux2 = alu_ip2
	
	wire	[31:0]		offset_shift_wire;
	wire	[31:0]		alu_ip2;
	wire	[31:0]		forwd_mux1_out, forwd_mux2_out; 
	
	wire				error2_wire; 				//carry out from offset addition
													//possibly output this for error control
	assign regData2_out = regData2;
	
	LSHF lft_shft(offset_shift_wire, pc_offset);
				//LSHF(shifted, 	shift_in);
									
	MUX3x1		alu_ip1_forward_mux(forwd_mux1_out, alu_ip1, wb_w_data, mem_alu_out, forwd_mux1_ctrl),
				alu_ip2_forward_mux(forwd_mux2_out, regData2, wb_w_data, mem_alu_out, forwd_mux2_ctrl);
	//MUX3x1							(choice, mux_in1, mux_in2, mux_in3, mux_ctrl);
	
	MUX2x1		alu_src_mux(alu_ip2, forwd_mux2_out, pc_offset, alu_ip2_source);
	MUX2x1_5b	reg_dest_mux(dest_reg_out, src, dest, reg_dest_ctrl);
					//MUX2x1(choice, 		mux_in1, mux_in2, mux_ctrl);
				
	Adder_32b	stage3ADD(offset_out, error2_wire, p_count, offset_shift_wire, 1'b0);
				//Adder_32b(Sum, 			Cout, 			x, 			y, 				Cin);
	//**************************************************//
	//needs to be designed based on alu_control encoding//
	//**************************************************//
	alu_16b alu(alu_out, cond_codes, forwd_mux1_out, alu_ip2, alu_ctrl);				
				//alu_16b(alu_out, cond_code, inA, inB, alu_ctrl);
endmodule
