`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:13:57 11/19/2011
// Design Name:   alu_16b
// Module Name:   D:/Xilinx_Working/MIPS_16b/alu_test.v
// Project Name:  MIPS_16b
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_test;

	// Inputs
	reg [31:0] inA;
	reg [31:0] inB;
	reg [3:0] alu_ctrl;

	// Outputs
	wire [31:0] alu_out;
	wire [5:0] cond_code;

	// Instantiate the Unit Under Test (UUT)
	alu_16b uut (
		.alu_out(alu_out), 
		.cond_code(cond_code), 
		.inA(inA), 
		.inB(inB), 
		.alu_ctrl(alu_ctrl)
	);

	initial begin
		// Initialize Inputs
		inA = 0;
		inB = 0;
		alu_ctrl = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		inA = 32'h00000010;
		inB = 32'h00000002;
		alu_ctrl = 4'b0001;		//add
      #10;
		alu_ctrl = 4'b1001;		//sub
		#10;
		alu_ctrl = 4'b0011;		//and
		#10;
		alu_ctrl = 4'b0100;		//or
		#10;
		alu_ctrl = 4'b0101;		//sll
		#10;
		alu_ctrl = 4'b1101;		//srl
		
		// Add stimulus here

	end
      
endmodule

