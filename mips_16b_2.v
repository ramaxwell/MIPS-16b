//////////////////////////////////////////////////////////////////////////////////
// Engineer(s): Robert A. Maxwell, Ryan Agudelo 
// With Supervision from : Dr. Eugene John
// Institution: University of Texas at San Antonio
// Department: Department of Electrical and Computer Engineering
//
// Create Date:    13:58:05 11/16/2011 
// Design Name:    MIPS 16 bit processor
// Module Name:    mips_16b 
// Project Name:   mips_16b
// Target Devices: NA
// Tool versions: NA
// 
//
// Dependencies: stage1.v, stage2.v, stage3.v, stage4.v, forwarding_unit.v, stage5.v
//
// Revision: This is the final revision for the completion of VLSI class Final Project
// Revision 1.04 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mips_16b(clk, clk_en, reset, next_pc_if, instr_if, reg_write_id, mem2reg_id, branch_id, mem_w_id, mem_r_id, 
					reg_dst_id, alu_src_id, alu_op_id, next_pc_id, r_data1_id, r_data2_id, pc_offset_id, dest1_id, dest2_id, 
					source1_id, reg_write_ex, mem2reg_ex, branch_ex, mem_w_ex, mem_r_ex, offset_pc_ex, cond_code_ex, 
					alu_out_ex, reg_data2_ex, dest_reg_ex, reg_write_mem, mem2reg_mem, read_data_mem, alu_out_mem, 
					dest_reg_mem, pc, cycle_count, instr_count, branch_stall_count);
		
		input					clk, clk_en, reset;		
		
//******************//		
//Pipeline registers//
//******************//
	// IF/ID register
	output reg	[31:0]	next_pc_if, instr_if;		
																	//still need entire pipeline of regs for jump operation
	//	ID/EX register
	output reg				reg_write_id, mem2reg_id;			// control registers				
	output reg	[4:0]		branch_id;
	output reg				mem_w_id, mem_r_id;	//
	output reg				reg_dst_id, alu_src_id;
	output reg	[3:0]		alu_op_id;
	output reg	[31:0]	next_pc_id;								//datapath registers
	output reg	[31:0]	r_data1_id, r_data2_id;				//
	output reg	[31:0]	pc_offset_id;
	output reg	[4:0]		dest1_id, dest2_id;
	output reg	[4:0]		source1_id;
	
	// EX/MEM register
	output reg				reg_write_ex, mem2reg_ex;			// control registers	
	output reg	[4:0]		branch_ex;
	output reg				mem_w_ex, mem_r_ex;
	output reg	[31:0]	offset_pc_ex;							//datapath registers
	output reg	[5:0]		cond_code_ex;
	output reg	[31:0]	alu_out_ex;
	output reg	[31:0]	reg_data2_ex;
	output reg	[4:0]		dest_reg_ex;
	
	// MEM/WB register
	output reg				reg_write_mem, mem2reg_mem;		// control registers	
	output reg	[31:0]	read_data_mem, alu_out_mem;		//datapath registers
	output reg	[4:0]		dest_reg_mem;
	//end of pipline registers
	
	output reg		[31:0]	pc;			//want pc <= pc_val (posedge clk)
	
	output reg		[31:0]	cycle_count;						//performance counters
	output reg		[31:0]	instr_count;						//
	//output reg		[31:0]   load_stall_count;					//
	output reg		[31:0]	branch_stall_count;				//
	
	//uppper level wires
	wire		[31:0]	pc_val;		//wire that feeds PC
	wire		[31:0]	next_pc;		//post incremented PC
	wire		[31:0]	full_instr;
	wire		[31:0]	jump_addr;
	wire					jmp;
	wire		[31:0]	pc_addr_mux_out;
	wire		[1:0]		forwarding_mux1_ctrl, forwarding_mux2_ctrl;
	wire					clockOFF;		//clock cutoff signal
//	wire					clock;
//	reg					clock_enable;
	//
	//stage 2 wires
	//
	wire		[4:0]		source1_wire, source_wire, dest_wire;	
	wire		[31:0]	immed16_wire;
	wire		[31:0]	RFread_data1_wire, RFread_data2_wire;
	wire		[31:0]	next_pc_id_wire;
	wire					reg_rw_wire, alu_src_wire, reg_dest_wire;
	wire		[3:0]		alu_op_wire;
	wire		[4:0]		branch_wire;
	wire					mem_w_wire, mem_r_wire, mem2reg_wire;
	wire					pc_src_wire;
	wire		[31:0]	addr_offset_wire;
	//
	//stage 3 wires
	//
	wire		[31:0]	offset_ex_wire;
	wire		[5:0]		cond_code_wire;
	wire		[31:0]	alu_out_ex_wire;
	wire		[31:0]	reg_data2_wire;
	wire		[4:0]		dest_reg_wire;
	//
	//stage 4 wires
	//
	wire					reg_write_ex_wire, mem2reg_ex_wire;
	wire		[4:0]		branch_ex_wire;
	wire					mem_w_ex_wire, mem_r_ex_wire;
	wire		[4:0]		reg_dest_mem_wire;
	wire		[31:0]	rw_addr_mem_wire;
	wire		[31:0]	mem_data_wire;
	wire					reg_write_mem_wire, mem2reg_mem_wire;
	//
	//stage 5 wires
	//
	wire		[31:0]	rf_w_data;
	wire		[4:0]		rf_w_addr;
															//no more wires
		
//PC address mux			
			assign pc_addr_mux_out = (pc_src_wire)? addr_offset_wire: next_pc;			
//jump mux
			assign pc_val = jmp? jump_addr: pc_addr_mux_out;
			
stage1 IF(full_instr, next_pc, pc);

stage2 ID(RFread_data1_wire, RFread_data2_wire, immed16_wire, source1_wire, source_wire, dest_wire, reg_rw_wire,
			alu_src_wire, alu_op_wire, reg_dest_wire, branch_wire, jmp, mem_w_wire, mem_r_wire,
			mem2reg_wire, next_pc_id_wire, pc_src_wire, addr_offset_wire, jump_addr, clockOFF, rf_w_data, rf_w_addr ,
			instr_if, next_pc_if, reg_write_mem);

stage3 EX(offset_ex_wire, cond_code_wire, alu_out_ex_wire, reg_data2_wire, dest_reg_wire, next_pc_id, 
				pc_offset_id, r_data1_id, r_data2_id, alu_op_id, dest1_id, dest2_id, alu_src_id, reg_dst_id,	
				rf_w_data, alu_out_ex, forwarding_mux1_ctrl ,forwarding_mux2_ctrl );
				
stage4 MEM(mem_data_wire, rw_addr_mem_wire, reg_dest_mem_wire, cond_code_ex, alu_out_ex, reg_data2_ex, 
			dest_reg_ex, branch_ex, mem_w_ex, mem_r_ex);

Forwarding_Unit forward(forwarding_mux1_ctrl, forwarding_mux2_ctrl, dest1_id, source1_id, dest_reg_mem, 
								dest_reg_ex, mem2reg_mem, branch_ex);

stage5 WB(rf_w_data, rf_w_addr, read_data_mem, alu_out_mem, mem2reg_mem, dest_reg_mem);

assign		reg_write_ex_wire = reg_write_id;
assign		mem2reg_ex_wire = mem2reg_id;
assign		branch_ex_wire = branch_id;
assign		mem_w_ex_wire = mem_w_id;
assign		mem_r_ex_wire = mem_r_id;
assign		reg_write_mem_wire = reg_write_ex;
assign		mem2reg_mem_wire = mem2reg_ex;

//and(clock, clk, clock_enable);

/*
	always@(posedge clk)begin
		if(reset)begin
		//IF stage
			pc <= 0;	next_pc_if<=0; instr_if<=0;
		//ID Stage
						//reset control registers
			reg_write_id <= 0; alu_src_id <= 0; alu_op_id <= 0; reg_dst_id <= 0;			
			branch_id <= 0; mem_w_id <= 0; mem_r_id <= 0; mem2reg_id <= 0; next_pc_id <= 0;	
						//reset datapath registers
			r_data1_id <= 0; r_data2_id <= 0; pc_offset_id <= 0; dest1_id <= 0;		
			dest2_id <= 0; source1_id <= 0;
		//EX Stage
						//reset control registers
			reg_write_ex <= 0; mem2reg_ex <= 0;	branch_ex <= 0; mem_w_ex <= 0; mem_r_ex <= 0;				
						//reset datapath registers
			offset_pc_ex <= 0; cond_code_ex <= 0; alu_out_ex <= 0; reg_data2_ex <= 0; dest_reg_ex <= 0;
		//MEM Stage
						// update control registers
			reg_write_mem <= 0; mem2reg_mem <= 0;	
						//update datapath registers
			read_data_mem <= 0; alu_out_mem <= 0; dest_reg_mem <= 0;
		end
	end
	*/
	/*always@(clk_en or clockOFF)begin
		if(clk_en)begin
				clock_enable = ~clock_enable;
		end
				
		if(clockOFF)begin
				clock_enable = ~clock_enable;
		end
	end
	*/
	always@(posedge clk)begin	
		
		cycle_count <= cycle_count + 1;
			
		if(pc_src_wire | jmp)begin
			branch_stall_count <= branch_stall_count+1;
			
		end else instr_count <= instr_count + 1;
		
	end
	
	//*************//
	// IF/ID stage //	
	//*************//
	always@(posedge clk)begin
			
				pc <= pc_val;				//pre stage											
				next_pc_if <= next_pc;			//update datapath registers
				instr_if	  <= full_instr;
	end
	
	//*************//
	// ID/EX stage //
	//*************//
	always@(posedge clk) begin
			
			reg_write_id <= reg_rw_wire;			//update control registers
			alu_src_id <= alu_src_wire;
			alu_op_id <= alu_op_wire;
			reg_dst_id <= reg_dest_wire;
			branch_id <= branch_wire;
			mem_w_id <= mem_w_wire;
			mem_r_id <= mem_r_wire;
			mem2reg_id <= mem2reg_wire;
			next_pc_id <= next_pc_id_wire;			//just a wire conntecting between registers
			r_data1_id <= RFread_data1_wire;			//update datapath registers
			r_data2_id <= RFread_data2_wire;
			pc_offset_id <= immed16_wire;
			dest1_id <= source_wire;
			dest2_id <= dest_wire;
			source1_id <= source1_wire;
	end

	//**************//
	// EX/MEM stage //
	//**************//
	always@(posedge clk) begin
	
		reg_write_ex <= reg_write_ex_wire;					// update control registers
		mem2reg_ex <= mem2reg_ex_wire;						//just wires conntecting between registers
		branch_ex <= branch_ex_wire;
		mem_w_ex <= mem_w_ex_wire;
		mem_r_ex <= mem_r_ex_wire;
		offset_pc_ex <= offset_ex_wire;							//update datapath registers
		cond_code_ex <= cond_code_wire;
		alu_out_ex <= alu_out_ex_wire;
		reg_data2_ex <= reg_data2_wire;
		dest_reg_ex <= dest_reg_wire;

	end

	//**************//
	// MEM/WB stage //
	//**************//
	always@(posedge clk) begin
	
		reg_write_mem <= reg_write_mem_wire;
		mem2reg_mem <= mem2reg_mem_wire;				// update control registers	
		read_data_mem <= mem_data_wire;
		alu_out_mem <= rw_addr_mem_wire;				//update datapath registers
		dest_reg_mem <= reg_dest_mem_wire;
	
	end

endmodule
//*************************************//
//Instruction Fetch Stage	(IF)			//
//*************************************//
module stage1(instr_out, post_inc_pc, prog_count);

	output 		[31:0]	instr_out, post_inc_pc;
	input			[31:0]	prog_count;
	
	parameter INC_VAL = 32'h00000004, CARRY_IN = 1'b0;
	
	wire						adder_cout;
	
instr_mem i_mem(instr_out, prog_count);
							
Adder_32b pc_inc(post_inc_pc, adder_cout, prog_count, INC_VAL, CARRY_IN);
							
endmodule
//**************************//
//Instruction Memory	Module //
//**************************//
module instr_mem(inst, read_addr);
	
	output 		[31:0]		inst;
	input			[31:0] 		read_addr;
	
	reg [7:0] my_memory [0:255];
		
	assign inst = {my_memory[read_addr],my_memory[read_addr+1],my_memory[read_addr+2],my_memory[read_addr+3]};
	
endmodule
//**************************//
//32 bit Adder	Module 		 //
//**************************//
module Adder_32b(Sum, Cout, x, y, Cin);

	output [31:0] Sum;
	output Cout;
	input [31:0] x, y;
	input Cin;

	wire [7:0] cout_add;

FA_4bit FA1(Sum[3:0], cout_add[0], x[3:0], y[3:0], Cin),
		  FA2(Sum[7:4], cout_add[1], x[7:4], y[7:4], cout_add[0]),
		  FA3(Sum[11:8], cout_add[2], x[11:8], y[11:8], cout_add[1]),
		  FA4(Sum[15:12], cout_add[3], x[15:12], y[15:12], cout_add[2]),
		  FA5(Sum[19:16], cout_add[4], x[19:16], y[19:16], cout_add[3]),
		  FA6(Sum[23:20], cout_add[5], x[23:20], y[23:20], cout_add[4]),
		  FA7(Sum[27:24], cout_add[6], x[27:24], y[27:24], cout_add[5]),
		  FA8(Sum[31:28], cout_add[7], x[31:28], y[31:28], cout_add[6]);
	
	assign Cout = cout_add[7];

endmodule
//**************************//
//4 bit Full Adder Module   //
//**************************//
module FA_4bit(sum, c_out, a, b, c_in);
	
	input [3:0] a, b;						// inputs
	input c_in;
	output [3:0] sum;						//outputs
	output c_out;
	
	wire [3:1] c;							//carry wire

	Add_Full Bit0(sum[0], c[1], a[0], b[0], c_in),			//1-bit Full adder 1
				Bit1(sum[1], c[2], a[1], b[1], c[1]),			//1-bit Full adder 2
				Bit2(sum[2], c[3], a[2], b[2], c[2]),			//1-bit Full adder 3
				Bit3(sum[3], c_out, a[3], b[3], c[3]);			//1-bit Full adder 4

endmodule
//**************************//
//1 bit Full Adder Module   //
//**************************//
module Add_Full(sum, c_out, a, b, c_in);
	
	input a, b, c_in;
	output sum, c_out;
	wire hSum, hCarry, tCarry;
	
	Add_Half HA1(hSum, hCarry, a, b),						//1st half adder
				HA2(sum, tCarry, hSum, c_in);					//2nd half adder
	
	assign c_out = tCarry | hCarry;							//or gate for carry
	
endmodule
//**************************//
//Half Adder Module 			 //
//**************************//
module Add_Half(sum, c_out, a, b);
	
	input a, b;
	output sum, c_out;
	
	xor(sum,a,b);						//only need gate level operations
	and(c_out,a,b);
	
endmodule
//*************************************//
//Instruction Decode Stage	(ID Stage)	//
//*************************************//
module stage2(rf_read_data1, rf_read_data2, sext_out, src1_out, src2_out, dest_out, rw_control, 
					alu_src, alu_op, reg_dst, bra, jmp_wire, mem_w, mem_r, mem2reg, pc_next, 
					pc_source, offset_addr_32b, j_addr, clock_off, rf_write_data, rf_write_addr,
					inst_code, next_pc, reg_rw_control);

	output	[31:0]		rf_read_data1, rf_read_data2, sext_out;
	output	[4:0]			src1_out, src2_out, dest_out;
	output					rw_control;										//1 = write, 0 = read
	output					alu_src;											//1 = immed, 0 = r_data2
	output	[3:0]			alu_op;											//alu_control
	output					reg_dst;									//1 = reg_dest, 0 = reg_src2; aka immed. dest.
	output	[4:0]			bra;
	output					jmp_wire;
	output					mem_w, mem_r;
	output					mem2reg;											//1 = alu_out to reg, 0 = mem2reg
	output	[31:0]		pc_next;
	
	output	reg			pc_source;
	output	[31:0]		offset_addr_32b;
	output	[31:0]		j_addr;
	output					clock_off;
	
	input		[31:0]		rf_write_data;
	input		[4:0]			rf_write_addr;
	input		[31:0]		inst_code, next_pc;
	input						reg_rw_control;


	wire		[5:0] 	op_code, funct;
	wire		[4:0] 	reg_src1, reg_src2, reg_dest, shft_amt;
	
	wire		[4:0] 	cmp_wire;
	wire		[31:0] 	bra_mux_wire;
	wire		[31:0] 	off_shft_out;
	wire					addr_error_wire;
	wire		[31:0]	offset_addr;
	wire		[27:0]	immed28;
	wire		[25:0]	immed26;
	wire					b_eq, b_ne, b_gt, b_gt_eq_z, b_lt;
	
	assign	pc_next = next_pc;
	assign	op_code = inst_code[31:26];
	assign	reg_src1 = inst_code[25:21];
	assign	reg_src2 = inst_code[20:16];		//
	assign	reg_dest = inst_code[15:11];		//
	assign	shft_amt = inst_code[10:6];
	assign	funct = inst_code[5:0];
	assign	bra = 	{b_eq, b_ne, b_gt, b_gt_eq_z, b_lt};
	assign	src1_out = reg_src1;
	assign	src2_out = reg_src2;
	assign	dest_out = reg_dest;
	assign	immed26 = inst_code[25:0];
	
	assign	j_addr = {pc_next[31:28],immed28};
	
	reg_file	 rf(rf_read_data1, rf_read_data2, reg_src1, reg_src2, rf_write_addr, rf_write_data, reg_rw_control);
			
	SEXT	extend(sext_out, inst_code[15:0]);
				
	MIPS_Control mips_c(rw_control, alu_src, alu_op, reg_dst, b_eq, b_ne, b_gt, b_gt_eq_z, b_lt, jmp_wire,
								mem_w, mem_r, mem2reg, clock_off, op_code, funct);
	
	MUX2x1 id_bra_mux(bra_mux_wire, sext_out, rf_read_data2, alu_src);
			
	REG_compare id_reg_cmp(cmp_wire, rf_read_data1, bra_mux_wire);
	LSHF shft_offset(off_shft_out, sext_out);
	
	LSHF_26 j_imm_pc(immed28, immed26);
	
	Adder_32b	offset_add(offset_addr, addr_error_wire, next_pc, off_shft_out, 1'b0);
				
	SEXT fill_bits(offset_addr_32b, offset_addr[15:0]);
																	
	always @(cmp_wire or b_eq or b_ne or b_gt or b_gt_eq_z or b_lt)begin		//{equal, !equal, less than, greater than, zero}
		pc_source = (cmp_wire[4] & b_eq) | 
						(cmp_wire[3] & b_ne) | 
						(cmp_wire[2] & b_gt) | 
						(cmp_wire[1] & b_gt_eq_z) | 
						(cmp_wire[0] & b_lt);
	end
	
endmodule
//**************************//
//Register File Module 		 //
//**************************//
module reg_file(r_data1, r_data2, r_addr1, r_addr2, w_addr, w_data, reg_write_ctrl);
		
		output 			[31:0] 	r_data1, r_data2;
		input				[4:0]		r_addr1, r_addr2, w_addr;
		input				[31:0]	w_data;
		input							reg_write_ctrl;
		
		reg	[31:0] my_reg_file [0:31];
		
		assign r_data1 = my_reg_file[r_addr1];
		assign r_data2 = my_reg_file[r_addr2];
				
		always@(reg_write_ctrl or w_addr or w_data)begin
		
			if(reg_write_ctrl) my_reg_file[w_addr] = w_data; 
		
		end
/*
		R0 = 0;		//always
		R1 			//reserved for assembler
		R2,3			//returned values
		R4-7			//arguments
		R8-15			//temporaries
		R16-23		//saved values
		R24,25		//temporaries
		R28			//global pointer
		R29			//stack pointer
		R30			//frame pointer
		R31			//return address
*/
endmodule
//**************************//
//Sign Extend	Module 		 //
//**************************//
module SEXT(out_long, in_short);
	
	output 		[31:0] 		out_long;
	input			[15:0]		in_short;
	
	parameter	ONES = 16'hFFFF, ZEROS = 16'h0000;
	
	assign	out_long = in_short[15] ? {ONES,in_short} : {ZEROS,in_short};

endmodule
//**************************//
//Control Unit Module		 //
//**************************//
module MIPS_Control(rw_ctrl, alu_source, alu_opcode, register_dst, br_eq, br_ne, br_gt, br_gt_eq_z, br_lt, j,
				mem_write, mem_read, mem_2_reg, clk_off, instr_code, alu_funct);			
				
	output reg				rw_ctrl, alu_source;
	output reg	[3:0]		alu_opcode;				// 0001=add, 1001=sub, 0011=and, 0100=or, 0101=SLL, 1101=SRL
	output reg				register_dst;
	output reg				br_eq, br_ne, br_gt, br_gt_eq_z, br_lt, j;
	output reg				mem_write, mem_read;
	output reg				mem_2_reg;
	output reg				clk_off;
	
	input		[5:0]		instr_code;
	input		[5:0]		alu_funct;
	
	parameter			ALU_BASE = 6'b000000, ADDI = 6'b001000, ADDIU = 6'b001001, ANDI = 6'b001100,
							ORI = 6'b001101, LOADW = 6'b100011, STW = 6'b101011, LUI = 6'b001111, BEQ = 6'b000100,
							BNE = 6'b000101, BGTZ = 6'b000111, BGEZ = 6'b000001, BLTZ = 6'b000011, SLTI = 6'b001010, 
							SLTIU = 6'b001011, JUMP = 6'b000010, JAL = 6'b000011;
	
	parameter			ADD = 6'b100000, SUB = 6'b100010, ADDU = 6'b100001, SUBU = 6'b100011, AND = 6'b100100,
							OR = 6'b100101, SLL = 6'b000000, SRL = 6'b000010, SLT = 6'b101010, SLTU = 6'b101011,
							SYSCALL = 6'b001100;
							
	always@(instr_code or alu_funct) begin
		
		case(instr_code)
			
			ALU_BASE:begin
					case(alu_funct)
						ADD: begin 
										rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b0001; register_dst = 1'b1; 
										br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
										mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
							  end
						SUB: begin  
										rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b1001; register_dst = 1'b1; 
										br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
										mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
							  end
						ADDU: begin 
										rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b0001; register_dst = 1'b1; 
										br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
										mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
								end
						SUBU: begin  
										rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b1001; register_dst = 1'b1; 
										br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
										mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
								end
						AND: begin  
										rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b0011; register_dst = 1'b1; 
										br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
										mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
							  end
						OR: begin  
										rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b0100; register_dst = 1'b1; 
										br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
										mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
							 end
						SLL: begin 
										rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0101; register_dst = 1'b1; 
										br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
										mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
							  end
						SRL: begin 
										rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b1101; register_dst = 1'b1; 
										br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
										mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
							  end
						SLT: begin  
										rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b0010; register_dst = 1'b1; 
										br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
										mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
							  end
						SLTU: begin  
										rw_ctrl = 1'b1; alu_source = 1'b0; alu_opcode = 4'b1010; register_dst = 1'b1; 
										br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
										mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
								end
						SYSCALL: begin
										rw_ctrl = 1'b0; alu_source = 1'b0; alu_opcode = 4'b0000; register_dst = 1'b1; 
										br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
										mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b1;
								end
						default: begin  
										rw_ctrl = 1'bx; alu_source = 1'bx; alu_opcode = 4'bxxxx; register_dst = 1'bx; 
										br_eq = 1'bx; br_ne = 1'bx; br_gt = 1'bx; br_gt_eq_z = 1'bx; br_lt = 1'bx; j = 1'b0;
										mem_write = 1'bx; mem_read = 1'bx; mem_2_reg = 1'bx; clk_off = 1'b0;
								   end
					endcase
			end
			ADDI: begin 
								rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0001; register_dst = 1'b0; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
				   end
			ADDIU: begin  
								rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0001; register_dst = 1'b0; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
					 end
			ANDI: begin  
								rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0011; register_dst = 1'b0; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
					end
			ORI: begin  
								rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0100; register_dst = 1'b0; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
				  end
			LOADW: begin 
								rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0001; register_dst = 1'b0; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b1; mem_2_reg = 1'b0; clk_off = 1'b0;
					 end
			STW: begin  
								rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'b0001; register_dst = 1'b0; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b1; mem_read = 1'b0; mem_2_reg = 1'b0; clk_off = 1'b0;
				  end
			LUI: begin  
								rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0111; register_dst = 1'b0; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b1; mem_2_reg = 1'b1;clk_off = 1'b0;
				  end
			BEQ: begin  
								rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'b0000; register_dst = 1'b1; 
								br_eq = 1'b1; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
				  end
			BNE: begin  
								rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'bxxxx; register_dst = 1'b1; 
								br_eq = 1'b0; br_ne = 1'b1; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
				  end
			BGTZ: begin
								rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'bxxxx; register_dst = 1'b1; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b1; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1;	clk_off = 1'b0;		
				  end
			BGEZ: begin
								rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'bxxxx; register_dst = 1'b1; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b1; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1;	clk_off = 1'b0;		
				  end
			BLTZ: begin
								rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'bxxxx; register_dst = 1'b1; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b1; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1;	clk_off = 1'b0;		
				  end
			SLTI: begin  
								rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b0010; register_dst = 1'b0; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
				   end
			SLTIU: begin 
								rw_ctrl = 1'b1; alu_source = 1'b1; alu_opcode = 4'b1010; register_dst = 1'b0; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0; j = 1'b0;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
					 end
			JUMP: begin 
								rw_ctrl = 1'b0; alu_source = 1'b1; alu_opcode = 4'b0000; register_dst = 1'b1; 
								br_eq = 1'b0; br_ne = 1'b0; br_gt = 1'b0; br_gt_eq_z = 1'b0; br_lt = 1'b0;  j = 1'b1;
								mem_write = 1'b0; mem_read = 1'b0; mem_2_reg = 1'b1; clk_off = 1'b0;
					end
			default: begin 
								rw_ctrl = 1'bx; alu_source = 1'bx; alu_opcode = 4'bxxxx; register_dst = 1'bx; 
								br_eq = 1'bx; br_ne = 1'bx; br_gt = 1'bx; br_gt_eq_z = 1'bx; br_lt = 1'bx; j = 1'b0;
								mem_write = 1'bx; mem_read = 1'bx; mem_2_reg = 1'bx; clk_off = 1'b0;
						end
		endcase
	
	end

endmodule
//**************************//
//Generic MUX Module			 //
//**************************//
module MUX2x1(choice, mux_in1, mux_in2, mux_ctrl);					
	
	output		[31:0]	choice;
	input			[31:0]	mux_in1, mux_in2;
	input						mux_ctrl;

	assign choice = mux_ctrl? mux_in2 : mux_in1;
	
endmodule
//**************************//
//Comparator Module			 //
//**************************//
module REG_compare(compare_out, in1, in2);			
		
		output	[4:0]		compare_out;
		input		[31:0]	in1, in2;
								//{equal, !equal, less than, greater than, zero}
			
		assign compare_out[4] = (in1 == in2)? 1'b1 : 1'b0;
		assign compare_out[3] = (in1 != in2)? 1'b1 : 1'b0;
		assign compare_out[2] = (in1 < in2)? 1'b1 : 1'b0;
		assign compare_out[1] = (in1 > in2)? 1'b1 : 1'b0;
		assign compare_out[0] = (in1 == 0)? 1'b1 : 1'b0;
					
endmodule
//******************************//
//32 bit Left Shift by 2 Module //
//******************************//
module LSHF(shift_out, shift_in);
		
		output		[31:0]		shift_out;
		input			[31:0]		shift_in;
		
		wire			[33:0]		shifted;
		
		assign shifted = shift_in << 2;
		assign shift_out = shifted[31:0];

endmodule
//******************************//
//26 bit Left Shift by 2 Module //
//******************************//
module LSHF_26(shift28_out, shift26_in);
		
		output		[27:0]		shift28_out;
		input			[25:0]		shift26_in;
		
		assign shift28_out = shift26_in << 2;

endmodule
//*************************************//
//Execution Stage	(EX)						//
//*************************************//
				module stage3(offset_out, cond_codes, alu_out, regData2_out, dest_reg_out, p_count, 
									pc_offset, alu_ip1, regData2, alu_ctrl, src, dest, alu_ip2_source, reg_dest_ctrl, 
									wb_w_data, mem_alu_out, forwd_mux1_ctrl, forwd_mux2_ctrl);

	output	[31:0]		offset_out;
	output	[5:0]			cond_codes;	//{equal, !equal, less than, greater than, zero, overflow}
	output	[31:0]		alu_out, regData2_out;
	output	[4:0]			dest_reg_out;
	
	input		[31:0]		p_count, pc_offset, alu_ip1, regData2;
	input		[3:0]			alu_ctrl;				//determines alu operation
	input		[4:0]			src, dest;
	input						alu_ip2_source;
	input						reg_dest_ctrl;
	input		[31:0]		wb_w_data;
	input		[31:0]		mem_alu_out;
	input		[1:0]			forwd_mux1_ctrl, forwd_mux2_ctrl; //mux1 = alu_ip1, mux2 = alu_ip2
	
	wire		[31:0]		offset_shift_wire;
	wire		[31:0]		alu_ip2;
	wire		[31:0]		forwd_mux1_out, forwd_mux2_out; 
	wire						error2_wire; 				//carry out from offset addition
																
	assign regData2_out = regData2;
	
	LSHF lft_shft(offset_shift_wire, pc_offset);
									
	MUX3x1		alu_ip1_forward_mux(forwd_mux1_out, alu_ip1, wb_w_data, mem_alu_out, forwd_mux1_ctrl),
					alu_ip2_forward_mux(forwd_mux2_out, regData2, wb_w_data, mem_alu_out, forwd_mux2_ctrl);
	
	MUX2x1		alu_src_mux(alu_ip2, forwd_mux2_out, pc_offset, alu_ip2_source);
	MUX2x1_5b	reg_dest_mux(dest_reg_out, src, dest, reg_dest_ctrl);
				
	Adder_32b	stage3ADD(offset_out, error2_wire, p_count, offset_shift_wire, 1'b0);
	
	alu_16b alu(alu_out, cond_codes, forwd_mux1_out, alu_ip2, alu_ctrl);				
					
endmodule
//******************************//
//Generic 3x1 MUX Module		  //
//******************************//
module MUX3x1(choice, mux_in1, mux_in2, mux_in3, mux_ctrl);					
	
	output		[31:0]	choice;
	input			[31:0]	mux_in1, mux_in2, mux_in3;
	input			[1:0]		mux_ctrl;

	assign choice = (mux_ctrl[1] ^ mux_ctrl[0])? (mux_ctrl[1]? mux_in3 : mux_in2) : mux_in1;
		
	endmodule	
//******************************//
//5 bit 2x1 MUX Module 			  //
//******************************//
module MUX2x1_5b(choice, mux_in1, mux_in2, mux_ctrl);					
	
	output		[4:0]	choice;
	input			[4:0]	mux_in1, mux_in2;
	input					mux_ctrl;

	assign choice = mux_ctrl? mux_in2 : mux_in1;
	
endmodule
//******************************//
//ALU Module 						  //
//******************************//
module alu_16b(alu_out, cond_code, inA, inB, alu_ctrl);
	
	output reg		[31:0]		alu_out;
	output 			[5:0]			cond_code;//{equal, !equal, less than, greater than, zero, overflow}
	
	input				[31:0]		inA, inB;
	input				[3:0]			alu_ctrl;			//which alu operation
	
	wire				[15:0]		alu_in1, alu_in2;
	wire				[4:0]			compare_wire;//{equal, !equal, less than, greater than, zero}
	wire				[31:0]		and_wire, or_wire;
	wire				[31:0]		shiftWire;
	wire				[15:0]		sumWire; 
	wire								carry_wire;
	wire								AorS, LorR;			//add or sub  //left or right shift
	wire				[4:0]			shift_amt;
	
	assign	alu_in1 = inA[15:0];
	assign	alu_in2 = inB[15:0];
	assign 	cond_code = {compare_wire, carry_wire};
	assign	AorS = alu_ctrl[3];
	assign   LorR = alu_ctrl[3];
	assign	shift_amt = inB[10:6];
	
	parameter	ONE = 4'b0001, TWO = 4'b1001, THREE = 4'b0011, FOUR = 4'b0100, FIVE = 4'b0101, 
					SIX = 4'b1101, SEVEN = 4'b0111, EIGHT = 4'b0010, NINE = 4'b1010;
	
	parameter   ONE_32b = 32'h00000001, ZERO_32b = 32'h00000000;
	
   //multiplier_16b umult(multWire, overFlow, inA, inB, 16'h0000);		//multiplier
	
	Add_Sub_xbits uadd(sumWire, carry_wire, alu_in1, alu_in2, AorS);				//Adder (16b)
																							//Add = 0; Sub = 1;
				
	Xshifter lshf(shiftWire, inA, shift_amt, LorR);//inB[10:6] should be shift amount
																		//Direc: 0 = lshf, 1 = rshf
	Xcompare comparator(compare_wire, inA, inB, alu_out);
	
	ANDX 	ander(and_wire, inA, inB);
	
	ORX	orer(or_wire, inA, inB);

	always@(inA or inB or alu_ctrl or sumWire or and_wire or or_wire or shiftWire or shift_amt or compare_wire) begin
		case(alu_ctrl)
			ONE: begin alu_out = sumWire[15]? {16'hFFFF, sumWire} : {16'h0000,sumWire};  end				//add			0001
			TWO: begin alu_out = sumWire[15]? {16'hFFFF, sumWire} : {16'h0000,sumWire};  end				//sub			1001
			THREE: begin alu_out = and_wire; end			//and			0011
			FOUR: begin alu_out = or_wire; end				//or			0100
			FIVE: begin alu_out = shiftWire; end			//SL			0101
			SIX: begin alu_out = shiftWire; end				//SR			1101
			SEVEN: begin alu_out = inB << 16; end			//LUI
			EIGHT: begin  alu_out = (inA[31] ^ inB[31]) ? {31'h00000000, ~compare_wire[2]} : {31'h00000000, compare_wire[2]}; end				///slt/i
			NINE: begin alu_out = {31'h00000000, compare_wire[2]}; end													///sltu/ui
			default:begin alu_out = 32'h00000000; end
		endcase
	end
					
endmodule
//******************************//
//Adder/Subtracter Module 		  //
//******************************//
module Add_Sub_xbits(sum, carry, Aa, Bb, add_sub_sel);
													//4-bits this time
		output 	[15:0]	sum;
		output				carry;
		input 	[15:0] 	Aa;
		input		[15:0]	Bb;
		input 				add_sub_sel;				//0 = add, 1 = sub
		
		wire		[15:0]	carry_wire;
		wire		[15:0] 	temp_sum;		
		
Full_Add_Sub FAS1(Aa[0], Bb[0], add_sub_sel, add_sub_sel, temp_sum[0], carry_wire[0]), 
				 FAS2(Aa[1], Bb[1], add_sub_sel, carry_wire[0], temp_sum[1], carry_wire[1]),
				 FAS3(Aa[2], Bb[2], add_sub_sel, carry_wire[1], temp_sum[2], carry_wire[2]),
				 FAS4(Aa[3], Bb[3], add_sub_sel, carry_wire[2], temp_sum[3], carry_wire[3]),
				 FAS5(Aa[4], Bb[4], add_sub_sel, carry_wire[3], temp_sum[4], carry_wire[4]),
				 FAS6(Aa[5], Bb[5], add_sub_sel, carry_wire[4], temp_sum[5], carry_wire[5]), 
				 FAS7(Aa[6], Bb[6], add_sub_sel, carry_wire[5], temp_sum[6], carry_wire[6]),
				 FAS8(Aa[7], Bb[7], add_sub_sel, carry_wire[6], temp_sum[7], carry_wire[7]),
				 FAS9(Aa[8], Bb[8], add_sub_sel, carry_wire[7], temp_sum[8], carry_wire[8]),
				 FASA(Aa[9], Bb[9], add_sub_sel, carry_wire[8], temp_sum[9], carry_wire[9]), 
				 FASB(Aa[10], Bb[10], add_sub_sel, carry_wire[9], temp_sum[10], carry_wire[10]), 
				 FASC(Aa[11], Bb[11], add_sub_sel, carry_wire[10], temp_sum[11], carry_wire[11]),
				 FASD(Aa[12], Bb[12], add_sub_sel, carry_wire[11], temp_sum[12], carry_wire[12]),
				 FASE(Aa[13], Bb[13], add_sub_sel, carry_wire[12], temp_sum[13], carry_wire[13]),
				 FASF(Aa[14], Bb[14], add_sub_sel, carry_wire[13], temp_sum[14], carry_wire[14]),
				 FASG(Aa[15], Bb[15], add_sub_sel, carry_wire[14], temp_sum[15], carry_wire[15]); 
				 
		assign sum = temp_sum[15:0];
		assign carry = add_sub_sel? 1'b0: carry_wire[15];

endmodule
//******************************//
//Adder/Subtracter 1-bit Module //
//******************************//
module Full_Add_Sub(a, b, select, full_cin, full_sum, full_cout);

	input	a, b, full_cin, select;
	output	full_sum, full_cout;
	
	wire	h_sum_wire, h_cout_wire, b_in_wire, h2_cout_wire;
	
	xor(b_in_wire, select, b);
	
	Half_Add HA_1(a, b_in_wire, h_sum_wire, h_cout_wire);		
	Half_Add HA_2(h_sum_wire, full_cin, full_sum, h2_cout_wire);

	or(full_cout, h_cout_wire, h2_cout_wire);
	
endmodule
//******************************//
//Special Half Adder Module 	  //
//******************************//
module Half_Add(a, b, h_sum, h_carry);
	input a, b;
	output h_sum, h_carry;
	
	xor(h_sum, a, b);
	and(h_carry, a, b);

endmodule
//******************************//
//Shifter Module 					  //
//******************************//
module Xshifter(result, data, amt, direc);

	output 		[31:0]		result;
	input			[31:0]		data;
	input			[4:0]			amt;
	input							direc;  //0 = lshf, 1 = rshf
	
	assign	result = (direc)? (data >> amt) : (data << amt);
	
endmodule
//******************************//
//Comparator Module 				  //
//******************************//
module Xcompare(compare_out, in1, in2, alu_result);
		
		output	[4:0]		compare_out;
		input		[31:0]	in1, in2;
		input		[31:0]	alu_result;
									//{equal, !equal, less than, greater than, zero}
			
		assign compare_out[4] = (in1 == in2)? 1'b1 : 1'b0;
		assign compare_out[3] = (in1 != in2)? 1'b1 : 1'b0;
		assign compare_out[2] = (in1 < in2)? 1'b1 : 1'b0;
		assign compare_out[1] = (in1 > in2)? 1'b1 : 1'b0;
		assign compare_out[0] = (alu_result == 0)? 1'b1 : 1'b0;
					
endmodule
//******************************//
//AND Module 						  //
//******************************//
module ANDX(out, in1, in2);

		output	[31:0]	out;
		input		[31:0]	in1, in2;
		
		assign	out = in1 & in2;
		
endmodule
//******************************//
//OR Module 						  //
//******************************//
module ORX(out_or, ORin1, ORin2);
		
		output		[31:0]	out_or;
		input			[31:0]	ORin1, ORin2;
		
		assign	out_or = ORin1 | ORin2;

endmodule
//*************************************//
//Memory Load/Store Stage	(MEM)			//
//*************************************//
module stage4(data_wire, rw_addr_wire, register_dest, alu_cond_code, rw_addr, write_data, reg_dest, branch_ctrl, write_sig, read_sig);

	output	[31:0] 	data_wire, rw_addr_wire;	
	output	[4:0]		register_dest;
	
	input		[5:0]		alu_cond_code;							
	input		[31:0]	rw_addr, write_data;
	input		[4:0]		reg_dest;
	input		[4:0]		branch_ctrl;					
	input					read_sig, write_sig;
	
	assign	rw_addr_wire = rw_addr;
	assign	register_dest = reg_dest;
	
	data_mem dmem(data_wire, rw_addr, write_data, read_sig, write_sig);
			
endmodule
//******************************//
//Data Memory Module 			  //
//******************************//
module data_mem(r_data, rw_addr, w_data, mem_read, mem_write);
	
	output reg	[31:0]		r_data;
	
	input			[31:0] 		rw_addr, w_data;
	input							mem_read, mem_write;
	
	wire			[1:0]			mem_control;
	reg [15:0] data_memory [0:256];
	
	parameter WIDTH = 32;
	
	assign	mem_control = {mem_read, mem_write};
	
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
//*************************************//
//Forwarding Control Unit	(EX Stage)	//
//*************************************//
module Forwarding_Unit(f_mux1_ctrl, f_mux2_ctrl, id_ex_src2, id_ex_src1, wb_dest_reg, mem_dest_reg, wb_mem2reg, ex_mem_branch);
	
	output reg	[1:0]		f_mux1_ctrl, f_mux2_ctrl;		//00=R_data(ID), 01=ALU_OUT(MEM), 10=W_DATA(WB)
	input			[4:0]		id_ex_src2, id_ex_src1;
	input			[4:0]		wb_dest_reg, mem_dest_reg;
	input						wb_mem2reg;
	input			[4:0]		ex_mem_branch;
	
	parameter			R_DATA = 2'b00, ALU_OUT = 2'b01, W_DATA = 2'b10;
	
	always@(id_ex_src1 or id_ex_src2 or mem_dest_reg or wb_dest_reg)begin
	
		if(id_ex_src1 == mem_dest_reg) begin			//does previous instruction have src1==dest(MEM)?
				f_mux1_ctrl = W_DATA;
		end else if(id_ex_src1 == wb_dest_reg) begin // does previous 2 instructions have src1==dest(WB)?
				f_mux1_ctrl = ALU_OUT;
		end else begin											//else normal operation
				f_mux1_ctrl = R_DATA;
		end
		
		if(id_ex_src2 == mem_dest_reg)begin			//does previous instruction have src2==dest(MEM)?
				f_mux2_ctrl = W_DATA;
		end else if(id_ex_src2 == wb_dest_reg)begin
				f_mux2_ctrl = ALU_OUT;
		end else begin										//else normal operation
				f_mux2_ctrl = R_DATA;
		end
	end

endmodule
//*************************************//
//Register Write Back Stage (WB)			//
//*************************************//
module stage5(data_out, r_dest, mem_data, alu_result, mem2Reg_ctrl, reg_dest5);
		output	[31:0]	data_out;
		output	[4:0]		r_dest;
		
		input		[31:0]	mem_data, alu_result;
		input					mem2Reg_ctrl;
		input		[4:0]		reg_dest5;
		
		assign	r_dest = reg_dest5;
		
		MUX2x1	stage5MUX(data_out, mem_data, alu_result, mem2Reg_ctrl);
					
endmodule

