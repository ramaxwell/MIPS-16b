`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    14:02:25 11/16/2011 
// Design Name:     MEM Stage
// Module Name:     stage4 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//                  Data memory with I/O and control signals
//
// Dependencies:    Data Memory (data_mem.v)
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module stage4(data_wire, rw_addr_wire, register_dest, alu_cond_code, rw_addr, write_data, reg_dest, branch_ctrl, write_sig, read_sig);

    output  [31:0]  data_wire, rw_addr_wire;	
    output  [4:0]   register_dest;

    input   [5:0]   alu_cond_code;  //zero alu result
                        
    input   [31:0]  rw_addr, write_data;
    input   [4:0]   reg_dest;
    input   [4:0]   branch_ctrl;    //branch ctrl wire
                        
    input           read_sig, write_sig;

    assign  rw_addr_wire = rw_addr;
    assign  register_dest = reg_dest;

    //data_mem(r_data, rw_addr, w_data, mem_read, mem_write);
    data_mem dmem(data_wire, rw_addr, write_data, read_sig, write_sig);
                    

endmodule

