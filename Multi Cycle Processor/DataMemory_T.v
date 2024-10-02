`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 06:33:00 PM
// Design Name: 
// Module Name: DataMemory_T
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


module DataMemory_T(

    );
    reg [14:0] data_address_T; 
    reg write_en_T;
    reg [31:0] write_data_T;
    wire [31:0] read_data_T; 
    
    DataMemory UUT(
                .data_address(data_address_T),
                .write_en(write_en_T),
                .write_data(write_data_T),
                .read_data(read_data_T) 
    );
    
    initial begin
        //put data 100 into memory 8
        data_address_T = 8; 
        write_data_T = 100; 
        #10
        write_en_T = 1; 
        #10
        write_en_T =0;  
        write_data_T = 10; 
    end
endmodule
