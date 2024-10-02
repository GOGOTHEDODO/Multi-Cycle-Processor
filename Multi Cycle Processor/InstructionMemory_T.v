`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 07:38:08 PM
// Design Name: 
// Module Name: InstructionMemory_T
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


module InstructionMemory_T(

    );
    reg [15:0] inst_address_T;
    wire [31:0] read_data_T;   
    
    InstructionMemory UUT(
        .inst_address(inst_address_T), 
        .read_data(read_data_T)
    ); 
    
    initial begin
        UUT.ram[0] = 32'h2000_0004;
        UUT.ram[1] = 32'h1111_1111;
        
        #10
        inst_address_T = 0; 
        #10
        inst_address_T = 1; 
        
    end
    
    
endmodule
