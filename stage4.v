`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:02:25 11/16/2011 
// Design Name: 
// Module Name:    stage4 
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
module stage4(data_wire, rw_addr_wire, register_dest, alu_cond_code, rw_addr, 
				write_data, reg_dest, branch_ctrl, write_sig, read_sig);

	output	[31:0] 	data_wire, rw_addr_wire;	
	output	[4:0]	register_dest;
	
	input	[5:0]	alu_cond_code;							//zero alu result
	input	[31:0]	rw_addr, write_data;
	input	[4:0]	reg_dest;
	input	[4:0]	branch_ctrl;					//branch control wire
	input			read_sig, write_sig;
	
	assign	rw_addr_wire = rw_addr;
	assign	register_dest = reg_dest;
	
	data_mem dmem(data_wire, rw_addr, write_data, read_sig, write_sig);
			//data_mem(r_data, rw_addr, w_data, mem_read, mem_write);

endmodule
