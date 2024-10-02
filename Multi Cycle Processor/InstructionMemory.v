`timescale 1ns / 1ps
/*
Instruction Module

A 2-d register array with one read port
*/


module  InstructionMemory(
    input [14:0] inst_address,
    output [31:0] read_data
    );
    
        // Initialize Instructions in the memory for testing
    initial begin
        ram[0]   <= 32'h2000_0004; // Store instruction that reads registerFile[0] and write to dataMemory[4].
        ram[4]   <= 32'b10000000000010001000000000000000; 
        ram[8]   <= 32'b10100100001010011000000000000000;
        ram[12]  <= 32'b11000000000010001000000000000000;
        ram[16]  <= 32'b11100000000010001000000000000000;
        ram[20]  <= 32'b00010000000000000000000000001000;
        ram[24]  <= 32'b00110000000000000000000000001000;
        ram[28]  <= 32'b01100010010000000010000000000000;
        ram[32]  <= 32'b01010001100010000000000000001111; 
    end
    
    reg [31:0] ram [255:0];
    
    // Assign statement to read ram based on inst_address
    //i think this is what they want, but this limits the ram to only using 2^16 vs the entire memory space
    assign read_data = ram[inst_address];
    
endmodule