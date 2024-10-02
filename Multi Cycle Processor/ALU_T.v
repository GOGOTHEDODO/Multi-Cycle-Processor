`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2024 09:54:39 PM
// Design Name: 
// Module Name: ALU_T
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


module ALU_T(

    );
    //create testing vars
     reg [31:0] ip_0_T; 
     reg [31:0] ip_1_T; 
     wire [31:0] op_0_T;
     reg [2:0] opcode_T; 
     wire change_pc_T;  
     
     //initalize ALU for testing
    ALU UUT(  .ip_0(ip_0_T), 
            .ip_1(ip_1_T), 
            .op_0(op_0_T), 
            .opcode(opcode_T), 
            .change_pc(change_pc_T)
            ); 
    initial begin 
        ip_1_T = 2; 
        ip_0_T = 1;
        
        #20 opcode_T = 2;
        #20 opcode_T = 3; 
        #20 opcode_T = 4;
        #20 opcode_T = 5; 
        #20 opcode_T  =6; 
        #20 opcode_T = 7; 
         
        
    end 
    
    
endmodule
