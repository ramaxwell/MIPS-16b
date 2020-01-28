`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:59:53 11/28/2011 
// Design Name: 
// Module Name:    Forwarding_Unit 
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
module Forwarding_Unit(f_mux1_ctrl, f_mux2_ctrl, id_ex_src2, id_ex_src1, wb_dest_reg, mem_dest_reg, wb_mem2reg, ex_mem_branch);
	
	output reg		[1:0]		f_mux1_ctrl, f_mux2_ctrl;		//00=R_data(ID), 01=ALU_OUT(MEM), 10=W_DATA(WB)
	input			[4:0]		id_ex_src2, id_ex_src1;
	input			[4:0]		wb_dest_reg, mem_dest_reg;
	input						wb_mem2reg;
	input			[4:0]		ex_mem_branch;
	
	parameter		R_DATA = 2'b00, ALU_OUT = 2'b01, W_DATA = 2'b10;
	
	initial begin 
		f_mux1_ctrl = 2'b00;
		f_mux2_ctrl = 2'b00;
	end
	
	always@(id_ex_src1 or id_ex_src2 or mem_dest_reg or wb_dest_reg)begin
	
		if(id_ex_src1 == mem_dest_reg) begin			//does previous instruction have src1==dest(MEM)?
				f_mux1_ctrl = W_DATA;
		end else if(id_ex_src1 == wb_dest_reg) begin 	// does previous 2 instructions have src1==dest(WB)?
				f_mux1_ctrl = ALU_OUT;
		end else begin									//else normal operation
				f_mux1_ctrl = R_DATA;
		end
		
		if(id_ex_src2 == mem_dest_reg)begin				//does previous instruction have src2==dest(MEM)?
				f_mux2_ctrl = W_DATA;
		end else if(id_ex_src2 == wb_dest_reg)begin
				f_mux2_ctrl = ALU_OUT;
		end else begin									//else normal operation
				f_mux2_ctrl = R_DATA;
		end
	end

endmodule
