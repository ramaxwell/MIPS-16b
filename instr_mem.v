`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:58:26 11/16/2011 
// Design Name: 
// Module Name:    instr_mem 
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
module instr_mem(inst, read_addr);
	
	output 		[31:0]		inst;
	input		[31:0] 		read_addr;
	integer i;
	//parameter WIDTH = 32;
	reg [7:0] my_memory [0:255];
	
	initial begin
		my_memory[0] = 8'h20;		//ADDI $3,$0,#8
		my_memory[1] = 8'h03;		
		my_memory[2] = 8'h00;		
		my_memory[3] = 8'h08;		
		
		my_memory[4] = 8'h20;		//ADDI $4,$0,#1
		my_memory[5] = 8'h04;		
		my_memory[6] = 8'h00;		
		my_memory[7] = 8'h01;		

		my_memory[8] = 8'h20;		//ADDI $5,$0,#-1
		my_memory[9] = 8'h05;
		my_memory[10] = 8'hFF;
		my_memory[11] = 8'hFF;
		
		my_memory[12] = 8'h10;		//LOOP: BEQ $3,$0, end
		my_memory[13] = 8'h60;
		my_memory[14] = 8'h00;
		my_memory[15] = 8'h05;
		
		my_memory[16] = 8'h00;		//ADD $4,$4,$5
		my_memory[17] = 8'h85;
		my_memory[18] = 8'h20;
		my_memory[19] = 8'h20;
		
		my_memory[20] = 8'h00;		//SUB $5,$4,$5
		my_memory[21] = 8'h85;
		my_memory[22] = 8'h28;
		my_memory[23] = 8'h22;
		
		my_memory[24] = 8'h20;		//ADDI $3,$3,#-1
		my_memory[25] = 8'h63;
		my_memory[26] = 8'hFF;
		my_memory[27] = 8'hFF;
		
		my_memory[28] = 8'h08;		//JUMP LOOP
		my_memory[29] = 8'h00;
		my_memory[30] = 8'h00;
		my_memory[31] = 8'h03;
		
		my_memory[32] = 8'h00;		//NOOP
		my_memory[33] = 8'h00;
		my_memory[34] = 8'h00;
		my_memory[35] = 8'h00;
		
		my_memory[36] = 8'hAC;		//END: STW $4,32($0)
		my_memory[37] = 8'h04;
		my_memory[38] = 8'h00;
		my_memory[39] = 8'h20;
		
		my_memory[40] = 8'h00;		//SYSCALL		-effectively shut off clock
		my_memory[41] = 8'h00;
		my_memory[42] = 8'h00;
		my_memory[43] = 8'h0C;
/*		
		my_memory[44] = 8'h03;		//srl $15,$31,5 = x0000 0001 = R15
		my_memory[45] = 8'hE0;
		my_memory[46] = 8'h79;
		my_memory[47] = 8'h42;
		
		my_memory[48] = 8'h8C;		//LOADW 
		my_memory[49] = 8'hF0;
		my_memory[50] = 8'h00;
		my_memory[51] = 8'h09;
		
		my_memory[52] = 8'hAD;		//STW 
		my_memory[53] = 8'h06;
		my_memory[54] = 8'h00;
		my_memory[55] = 8'h0A;
		
		my_memory[56] = 8'h3C;		//LUI 
		my_memory[57] = 8'h11;
		my_memory[58] = 8'h00;
		my_memory[59] = 8'h64;
		
		my_memory[60] = 8'h03;		//BEQ 
		my_memory[61] = 8'hE0;
		my_memory[62] = 8'h79;
		my_memory[63] = 8'h42;
		
		my_memory[64] = 8'h03;		//BNE 
		my_memory[65] = 8'hE0;
		my_memory[66] = 8'h79;
		my_memory[67] = 8'h42;
		
		my_memory[68] = 8'h03;		//BGEZ 
		my_memory[69] = 8'hE0;
		my_memory[70] = 8'h79;
		my_memory[71] = 8'h42;
		
		my_memory[72] = 8'h03;		//BGTZ 
		my_memory[73] = 8'hE0;
		my_memory[74] = 8'h79;
		my_memory[75] = 8'h42;
		
		my_memory[76] = 8'h03;		//BLTZ 
		my_memory[77] = 8'hE0;
		my_memory[78] = 8'h79;
		my_memory[79] = 8'h42;
		
		my_memory[80] = 8'h03;		//SLT
		my_memory[81] = 8'hE0;
		my_memory[82] = 8'h79;
		my_memory[83] = 8'h42;
		
		my_memory[84] = 8'h03;		//SLTI
		my_memory[85] = 8'hE0;
		my_memory[86] = 8'h79;
		my_memory[87] = 8'h42;
		
		my_memory[88] = 8'h03;		//SLTU
		my_memory[89] = 8'hE0;
		my_memory[90] = 8'h79;
		my_memory[91] = 8'h42;
		
		my_memory[92] = 8'h03;		//SLTIU
		my_memory[93] = 8'hE0;
		my_memory[94] = 8'h79;
		my_memory[95] = 8'h42;
		
	*/	
		for(i = 44; i < 256; i = i+1) begin
			my_memory[i] = 0;
		end
	end
	
	assign inst = {my_memory[read_addr],my_memory[read_addr+1],my_memory[read_addr+2],my_memory[read_addr+3]};
	
endmodule
