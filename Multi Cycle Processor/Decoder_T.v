`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2024 11:50:53 PM
// Design Name: 
// Module Name: Decoder_T
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Decoder_T(

    );
    
    reg [31:0] inst_T; 
    wire[2:0] opcode_T;
    wire [4:0] reg_addr_0_T; 
    wire[4:0] reg_addr_1_T; 
    wire [4:0] reg_addr_2_T;
    wire [14:0] addr_T; 
     
    
    
    Decoder UUT(
                .inst(inst_T),
                .opcode(opcode_T), 
                .reg_addr_0(reg_addr_0_T),
                .reg_addr_1(reg_addr_1_T),
                .reg_addr_2(reg_addr_2_T),
                .addr(addr_T)
    ); 
    
    initial begin
        // wait 30 ns before sending the instruction reg3 = reg2 + reg1 to the decoder
      #30 inst_T = 32'b10000000000010001000000000000000; //
    end
    
    
endmodule
