`timescale 1ns / 1ps

/*
ALU Module

Performs arithmetic operations for add,
sub, and, or operations. Also performs 
comparison operation for beq, blt.
*/

// 4-7 -> add, sub, and, or respectively

module ALU(
    input wire [31:0] ip_0,
    input wire [31:0] ip_1,
    input wire [2:0] opcode,
    output wire [31:0] op_0,
    output wire change_pc
    );

    // Use assign statement to perform add, sub,
    // and, or operations on ip_0 and ip_1 based 
    // on the instruction/opcode
    
//    assign op_0 = 
    //we have to use ternary operators, we can't use if or case statements unless we have a register and an always
    assign op_0 = (opcode == 3'b100) ? ip_0 + ip_1: //and op code
                  (opcode == 3'b101) ? ip_0 - ip_1: //sub op code
                  (opcode == 3'b110) ? ip_0 & ip_1: //and op code
                  (opcode == 3'b111) ? ip_0 | ip_1: //or op code
                                              op_0; //error state,   
  // always #1 $display ("value stored in ip_0 in ALU: %B", op_0);  
    // Change_pc is required for the branch operations for 
    // the two control instructions. If ip_0 and ip_1 are equal 
    //  when the instruction is "beq" or ip_0 < ip_1 when 
    // instruction is "blt", the change_pc goes high 
    
    assign change_pc = opcode == 2 ? (ip_0 == ip_1):(
                        opcode == 3 ? (ip_0 < ip_1) : 0);
    
    
endmodule
