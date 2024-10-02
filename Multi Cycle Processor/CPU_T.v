`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2024 03:20:44 AM
// Design Name: 
// Module Name: CPU_T
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


module CPU_T(

    );
    
        reg CLK =0; 
    
     CPU myCPU(
            CLK
        );
       
     
      
       
       always #5 CLK = ~CLK;       
        
endmodule
