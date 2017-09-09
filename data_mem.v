`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    18:27:50 11/18/2011 
// Design Name:     Data Memory (4KB)
// Module Name:     data_mem 
// Project Name:    MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description:
//              1 Bank (way) of 4KB data memory with 2 byte blocks
//
// Dependencies:    N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module data_mem(r_data, rw_addr, w_data, mem_read, mem_write);

    output reg  [31:0]  r_data;

    input       [31:0]  rw_addr, w_data;
    input               mem_read, mem_write;    //control signals
    
    wire        [1:0]   mem_control;
    integer             k;              //For initializing mem

    assign  mem_control = {mem_read, mem_write};

    reg [15:0] data_memory [0:255];



    initial begin		
        for(k = 0; k <= 255; k = k+1)begin
            
            data_memory[k] = k;

        end
    end

    always@(mem_control or rw_addr or w_data)begin
        case(mem_control)
            2'b01: begin 
                data_memory[rw_addr] = w_data;
                r_data = w_data;
            end
            2'b10: r_data = data_memory[rw_addr]; 
            default: r_data = 32'hXXXXXXXX;
        endcase
    end

endmodule 