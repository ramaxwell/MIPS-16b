`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Robert A. Maxwell
// 
// Create Date:    14:01:51 11/16/2011 
// Design Name:    Instruction Decode Stage
// Module Name:    stage2 
// Project Name:   MIPS 16 bit Processor
// Target Devices: 
// Tool versions: 
// Description: 
//              Instruction Decode stage for 5 stage pipeline
//
// Dependencies:    Register File (reg_file.v), Sign Extend (SEXT.v), 
//                  MIPS Controller  (MIPS_Control.v), 2 by 1 MUX (MUX2x1.v),
//                  Register Compare (REG_compare.v), Left Shift (LSHF.v),
//                  Left Shift 26 bit (LSHF_26.v), 32bit RC Adder (Adder_32b.v),
//                  
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module stage2(rf_read_data1, rf_read_data2, sext_out, src1_out, src2_out, dest_out, rw_control, alu_src, alu_op, reg_dst, bra, jmp_wire, mem_w, mem_r, mem2reg, pc_next, pc_source, offset_addr_32b, j_addr, clock_off, rf_write_data, rf_write_addr, inst_code, next_pc, reg_rw_control);

    output     [31:0]  rf_read_data1, rf_read_data2, sext_out;
    output     [4:0]   src1_out, src2_out, dest_out;
    output             rw_control;
                            //1 = write, 0 = read
    output             alu_src;
                            //1 = immed, 0 = r_data2
    output     [3:0]   alu_op;
                            //alu_control
    output             reg_dst;
                            //1 = reg_dest, 0 = reg_src2; aka immed. dest.
    output     [4:0]   bra;
    output             jmp_wire;
    output             mem_w, mem_r;
    output             mem2reg;
                            //1 = alu_out to reg, 0 = mem2reg
    output     [31:0]  pc_next;

    output reg         pc_source;
    output     [31:0]  offset_addr_32b;
    output     [31:0]  j_addr;
    output             clock_off;

    input      [31:0]  rf_write_data;
    input      [4:0]   rf_write_addr;
    input      [31:0]  inst_code, next_pc;
    input              reg_rw_control;


    wire       [5:0]   op_code, funct;
    wire       [4:0]   reg_src1, reg_src2, reg_dest, shft_amt;

    wire       [4:0]    cmp_wire;
    wire       [31:0]   bra_mux_wire;
    wire       [31:0]   off_shft_out;
    wire                addr_error_wire;
    wire       [31:0]   offset_addr;
    wire       [27:0]   immed28;
    wire       [25:0]   immed26;
    wire                b_eq, b_ne, b_gt, b_gt_eq_z, b_lt;

    assign     pc_next = next_pc;
    assign     op_code = inst_code[31:26];
    assign     reg_src1 = inst_code[25:21];
    assign     reg_src2 = inst_code[20:16];
    assign     reg_dest = inst_code[15:11];
    assign     shft_amt = inst_code[10:6];
    assign     funct = inst_code[5:0];
    assign     bra = {b_eq, b_ne, b_gt, b_gt_eq_z, b_lt};
    assign     src1_out = reg_src1;
    assign     src2_out = reg_src2;
    assign     dest_out = reg_dest;
    assign     immed26 = inst_code[25:0];
    assign     j_addr = {pc_next[31:28],immed28};

    initial pc_source = 1'b0;

    reg_file   rf(rf_read_data1, rf_read_data2, reg_src1, reg_src2, rf_write_addr, rf_write_data, reg_rw_control);
    
    SEXT       extend(sext_out, inst_code[15:0]);

    MIPS_Control mips_c(rw_control, alu_src, alu_op, reg_dst, b_eq, b_ne, b_gt, b_gt_eq_z, b_lt, jmp_wire, mem_w, mem_r, mem2reg, clock_off, op_code, funct);
       
    //**************//
    // new hardware //
    //**************//

    MUX2x1 id_bra_mux(bra_mux_wire, sext_out, rf_read_data2, alu_src);

    REG_compare id_reg_cmp(cmp_wire, rf_read_data1, bra_mux_wire);
 
    LSHF shft_offset(off_shft_out, sext_out);
 
    LSHF_26 j_imm_pc(immed28, immed26);
 
    Adder_32b      offset_add(offset_addr, addr_error_wire, next_pc, off_shft_out, 1'b0);
    
    SEXT fill_bits(offset_addr_32b, offset_addr[15:0]);

    always @(cmp_wire or b_eq or b_ne or b_gt or b_gt_eq_z or b_lt)begin
                        //{equal, !equal, less than, greater than, zero}
        pc_source = (cmp_wire[4] & b_eq) | (cmp_wire[3] & b_ne) | 
                    (cmp_wire[2] & b_gt) | (cmp_wire[1] & b_gt_eq_z) | 
                    (cmp_wire[0] & b_lt);
    end

endmodule