`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Robert A. Maxwell
// 
// Create Date:    13:58:48 11/16/2011 
// Design Name:    Register File
// Module Name:    reg_file 
// Project Name:   MIPS 16 bit Processor
// Target Devices: N/A
// Tool versions: 
// Description: 
//          Register file loaded with incremented (arbitrary) values
//
//   MIPS Register Assignments
//      R0 = 0;     //always
//      R1          //reserved for assembler
//      R2,3        //returned values
//      R4-7        //arguments
//      R8-15       //temporaries
//      R16-23      //saved values
//      R24,25      //temporaries
//      R28         //global pointer
//      R29         //stack pointer
//      R30         //frame pointer
//      R31         //return address
//
// Dependencies: N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module reg_file(r_data1, r_data2, r_addr1, r_addr2, w_addr, w_data, reg_write_ctrl);

    output  [31:0]  r_data1, r_data2;
    input   [4:0]   r_addr1, r_addr2, w_addr;
    input   [31:0]  w_data;
    input           reg_write_ctrl;

    reg     [31:0]  my_reg_file [0:31];

    //Setup initial register values
    // For this Proj, just using arbitrary values
    initial begin
        my_reg_file[0] = 32'h00000000;
        my_reg_file[1] = 32'h00000001;
        my_reg_file[2] = 32'h00000002;
        my_reg_file[3] = 32'h00000003;
        my_reg_file[4] = 32'h00000004;
        my_reg_file[5] = 32'h00000005;
        my_reg_file[6] = 32'h00000006;
        my_reg_file[7] = 32'h00000007;
        my_reg_file[8] = 32'h00000008;
        my_reg_file[9] = 32'h00000009;
        my_reg_file[10] = 32'h0000000A;
        my_reg_file[11] = 32'h0000000B;
        my_reg_file[12] = 32'h0000000C;
        my_reg_file[13] = 32'h0000000D;
        my_reg_file[14] = 32'h0000000E;
        my_reg_file[15] = 32'h0000000F;
        my_reg_file[16] = 32'h00000010;
        my_reg_file[17] = 32'h00000011;
        my_reg_file[18] = 32'h00000012;
        my_reg_file[19] = 32'h00000013;
        my_reg_file[20] = 32'h00000014;
        my_reg_file[21] = 32'h00000015;
        my_reg_file[22] = 32'h00000016;
        my_reg_file[23] = 32'h00000017;
        my_reg_file[24] = 32'h00000018;
        my_reg_file[25] = 32'h00000019;
        my_reg_file[26] = 32'h0000002A;
        my_reg_file[27] = 32'h0000002B;
        my_reg_file[28] = 32'h0000002C;
        my_reg_file[29] = 32'h0000002D;
        my_reg_file[30] = 32'h0000002E;
        my_reg_file[31] = 32'h0000002F;
    end

    assign r_data1 = my_reg_file[r_addr1];
    assign r_data2 = my_reg_file[r_addr2];

    always@(reg_write_ctrl or w_addr or w_data)begin

        if(reg_write_ctrl) my_reg_file[w_addr] = w_data; 

    end

endmodule
