`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:29:48 11/19/2011
// Design Name:   Add_Sub_xbits
// Module Name:   D:/Xilinx_Working/MIPS_16b/adder_test.v
// Project Name:  MIPS_16b
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Add_Sub_xbits
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module adder_test;

	// Inputs
	reg [15:0] Aa;
	reg [15:0] Bb;
	reg add_sub_sel;

	// Outputs
	wire [15:0] sum;
	wire carry;

	// Instantiate the Unit Under Test (UUT)
	Add_Sub_xbits uut (
		.sum(sum), 
		.carry(carry), 
		.Aa(Aa), 
		.Bb(Bb), 
		.add_sub_sel(add_sub_sel)
	);

	initial begin
		// Initialize Inputs
		Aa = 0;
		Bb = 0;
		add_sub_sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
      	Aa = 16'h0010;
		Bb = 16'h0002;
		#20;
		add_sub_sel = 1;
		// Add stimulus here

	end
      
endmodule

