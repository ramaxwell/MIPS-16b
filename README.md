# MIPS-16b
16 bit MIPS Machine with 5 stage pipeline, data forwarding, and Decode stage branch prediction

# Introduction

This is a 16-bit MIPS processor with limited instruction set and branch prediction. This repo is the result of
of a final project in VLSI at the Graduate level and my only large scale solo VLSI design effort. Thus, there are some strange choices I made with regards to file structure. For instance in the alu_16b.v file, there are explicit verilog file instances for AND and OR gates where in the rest of the design for the most part logic gates are implemented inline within the code. 

That being said, I plan to update this design incrementally by fixing some of the inconsistencies, and then by adding some instruction support for integer multiplication/division, floating point operations, and branch prediction. Other than that the design has been tested (initially with Xilinx ISE, recently with Icarus Verilog) and is functional. 

*Note: Many of the modules have an excess of inputs and outputs which I left in for testing/debug and potential timing analysis purposes
     
# File structure                    Description
mips_16b_test1.v                    //Testbench

usage.txt                           //How to test with Icarus Verilog

file_list.txt                       //Used with Icarus Verilog command line


mips_16b.v					//parent

-->stage1.v                         //IF stage

-->instr_mem.v                   //Instruction Memory (hard coded)
   
	-->Adder_32b.v                   //32 bit Ripple-carry adder
   
		-->FA_4bit.v
      
		-->Add_Full.v
         
		-->Add_Half.v
            
            
-->stage2.v                         //ID stage

	-->reg_file.v                    //Register file
   
	-->SEXT.v                        //Sign Extend
   
	-->MIPS_Control.v                //MIPS controller
   
	-->MUX2x1.v                      //2x1 MUX
   
	-->REG_compare.v                 //Register comparator
   
	-->LSHF.v                        //32 bit Left shift
   
	-->LSHF_26.v                     //26 bit left shift 
   
	-->Adder_32b.v                   //32 bit Ripple-carry adder
   

-->stage3.v                         //EX Stage

	-->LSHF.v                        //Left shift
	
	-->MUX3x1.v                      //3x1 MUX (really just 2 cascaded 2x1 MUXes)
	
	-->MUX2x1.v                      //2x1 MUX
	
	-->MUX2x1_5b.v                   //2x1 MUX with 5 bit throughput
	
	-->Adder_32b.v                   //32 bit Ripple-carry adder
   
	-->alu_16b.v                     //16 bit ALU
   
		-->Add_Sub_xbits.v            //16 bit Ripple-carry Adder/Subtractor
	 
		-->Full_Add_Sub.v
	 
			-->Half_Add.v
	    
	-->Xshifter.v                    //left or right cross shifter
   
	-->Xcompare.v                    //Comparator
   
	-->ANDX.v                        //Simple AND gate
   
	-->ORX.v                         //Simple OR gate
   
   
-->stage4.v                        //MEM stage

	-->data_mem.v                   //Explicit Data Memory for "storing" results
   
   
-->Forwarding_Unit.v               //Unit for data forwarding control


-->stage5.v                        //WB stage

	-->MUX2x1.v                     //2x1 MUX
   

*Note: More info on the design can be found in the power point document entitled '16 bit MIPS machine.pptx'
