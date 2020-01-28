`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:10:06 11/18/2011
// Design Name:   stage1
// Module Name:   D:/Xilinx_Working/MIPS_16b/stage1_test.v
// Project Name:  MIPS_16b
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stage1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stage1_test;

	// Inputs
	reg [31:0] addr_offset;
	reg stage1_mux_ctrl;
	reg clock;

	// Outputs
	wire [31:0] instr_out;
	wire [31:0] post_inc_pc;

	// Instantiate the Unit Under Test (UUT)
	stage1 uut (
		.instr_out(instr_out), 
		.post_inc_pc(post_inc_pc), 
		.addr_offset(addr_offset), 
		.stage1_mux_ctrl(stage1_mux_ctrl), 
		.clock(clock)
	);

	initial begin
		// Initialize Inputs
		addr_offset = 0;
		stage1_mux_ctrl = 1;
		clock = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		
		
		// Add stimulus here

	end
     
	always begin
		#1 clock = ~clock;
	end
	
endmodule

