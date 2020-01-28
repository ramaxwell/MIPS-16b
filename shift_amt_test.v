`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:07:26 11/24/2011
// Design Name:   Xshifter
// Module Name:   D:/Xilinx_Working/MIPS_16b/shift_amt_test.v
// Project Name:  MIPS_16b
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Xshifter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module shift_amt_test;

	// Inputs
	reg [31:0] data;
	reg [4:0] amt;
	reg direc;

	// Outputs
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	Xshifter uut (
		.result(result), 
		.data(data), 
		.amt(amt), 
		.direc(direc)
	);

	initial begin
		// Initialize Inputs
		data = 0;
		amt = 0;
		direc = 0;

		// Wait 100 ns for global reset to finish
		#100;
      	data = 32'h00000002;
		amt = 5'b01010;
		#20;
		data = 32'h0000002F;
		amt = 5'b00101;
		direc = 1'b1;
		
		// Add stimulus here

	end
      
endmodule

