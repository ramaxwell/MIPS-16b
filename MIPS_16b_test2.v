`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:06:41 11/30/2011
// Design Name:   mips_16b
// Module Name:   D:/Xilinx_Working/MIPS_16b/MIPS_16b_test2.v
// Project Name:  MIPS_16b
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MIPS_16b_test2;

	// Inputs
	reg clk;
	reg clk_en;
	reg reset;

	// Outputs
	wire [31:0] next_pc_if;
	wire [31:0] instr_if;
	wire reg_write_id;
	wire mem2reg_id;
	wire [4:0] branch_id;
	wire mem_w_id;
	wire mem_r_id;
	wire reg_dst_id;
	wire alu_src_id;
	wire [3:0] alu_op_id;
	wire [31:0] next_pc_id;
	wire [31:0] r_data1_id;
	wire [31:0] r_data2_id;
	wire [31:0] pc_offset_id;
	wire [4:0] dest1_id;
	wire [4:0] dest2_id;
	wire [4:0] source1_id;
	wire reg_write_ex;
	wire mem2reg_ex;
	wire [4:0] branch_ex;
	wire mem_w_ex;
	wire mem_r_ex;
	wire [31:0] offset_pc_ex;
	wire [5:0] cond_code_ex;
	wire [31:0] alu_out_ex;
	wire [31:0] reg_data2_ex;
	wire [4:0] dest_reg_ex;
	wire reg_write_mem;
	wire mem2reg_mem;
	wire [31:0] read_data_mem;
	wire [31:0] alu_out_mem;
	wire [4:0] dest_reg_mem;
	wire [31:0] pc;
	wire [31:0] cycle_count;
	wire [31:0] instr_count;
	wire [31:0] load_stall_count;
	wire [31:0] branch_stall_count;

	// Instantiate the Unit Under Test (UUT)
	mips_16b uut (
		.clk(clk), 
		.clk_en(clk_en), 
		.reset(reset), 
		.next_pc_if(next_pc_if), 
		.instr_if(instr_if), 
		.reg_write_id(reg_write_id), 
		.mem2reg_id(mem2reg_id), 
		.branch_id(branch_id), 
		.mem_w_id(mem_w_id), 
		.mem_r_id(mem_r_id), 
		.reg_dst_id(reg_dst_id), 
		.alu_src_id(alu_src_id), 
		.alu_op_id(alu_op_id), 
		.next_pc_id(next_pc_id), 
		.r_data1_id(r_data1_id), 
		.r_data2_id(r_data2_id), 
		.pc_offset_id(pc_offset_id), 
		.dest1_id(dest1_id), 
		.dest2_id(dest2_id), 
		.source1_id(source1_id), 
		.reg_write_ex(reg_write_ex), 
		.mem2reg_ex(mem2reg_ex), 
		.branch_ex(branch_ex), 
		.mem_w_ex(mem_w_ex), 
		.mem_r_ex(mem_r_ex), 
		.offset_pc_ex(offset_pc_ex), 
		.cond_code_ex(cond_code_ex), 
		.alu_out_ex(alu_out_ex), 
		.reg_data2_ex(reg_data2_ex), 
		.dest_reg_ex(dest_reg_ex), 
		.reg_write_mem(reg_write_mem), 
		.mem2reg_mem(mem2reg_mem), 
		.read_data_mem(read_data_mem), 
		.alu_out_mem(alu_out_mem), 
		.dest_reg_mem(dest_reg_mem), 
		.pc(pc), 
		.cycle_count(cycle_count), 
		.instr_count(instr_count), 
		.load_stall_count(load_stall_count), 
		.branch_stall_count(branch_stall_count)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clk_en = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
	always begin
		#1 clk = ~clk;
	end
	
endmodule

