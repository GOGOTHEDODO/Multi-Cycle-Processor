`timescale 1ns / 1ps
/*
Decoder Module

Takes a 32-bit instruction as input and drives each
of the output based on the Instruction Set Architecture
given in the project instructions
*/


module  Decoder(
    input [31:0] inst, 
    output [2:0] opcode,
    output [4:0] reg_addr_0,
    output [4:0] reg_addr_1,
    output [4:0] reg_addr_2,
    output [14:0] addr // specs say 15 but it still works as we only support 2^7 addresses
    );
    
    // Use assign statements to redirect parts of the instruction to output
    //not all parts are used for all instructions, but that does not matter as
    //there is no overlap in instruction bits, so the use parts go fully unused. 
    assign opcode = inst[31:29];
    assign addr = inst[14:0]; 
    assign reg_addr_0 = inst[29:24]; 
    assign reg_addr_1 = inst[23:19]; 
    assign reg_addr_2 = inst[18:14]; 
    
endmodule
