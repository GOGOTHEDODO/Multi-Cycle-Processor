`timescale 1ns / 1ps
//`default_nettype none

/*
CPU Module

Top Module for CPU.

*/

/*
let 
lw = 000
sw = 001
beq = 010
blt = 011
add = 100
sub = 101
and = 110
or = 111



*/
module CPU(
    input clk,
    //output reg [31:0] null //here to ensure non empty design
    );
    
     
    reg [15:0]  pc_q = 0;      // Program Counter
    reg [31:0]  instruction_q; // Holds instruction binary 
    reg [1:0]   state_q = 0;   // State of CPU
    //Decoder outputs
    wire [2:0]   CPU_OpOUT; 
    wire [4:0]   CPU_RegA1OUT; 
    wire [4:0]   CPU_RegA2OUT;
    wire [4:0]   CPU_RegA3OUT; 
    wire [14:0]  CPU_JumpA1OUT;  
    //Decoder outputs reg for holding the values from wires to use inside the always
    reg [2:0]   CPU_Op=0; 
    reg [4:0]   CPU_RegA1=0; 
    reg [4:0]   CPU_RegA2=0;
    reg [4:0]   CPU_RegA3=0; 
    reg [14:0]  CPU_MemA1=0;
    //ALU regs
    reg [31:0] CPU_ip_0; 
    reg [31:0] CPU_ip_1;
    reg [31:0] CPU_op_0;  
    //ALU wires
    wire [31:0] CPU_op_0ALUOUT;
    wire CPU_Change_pc; 
    //Register File Regs
    reg CPU_write_en;
    reg [31:0] CPU_read_data_0; 
    reg [31:0] CPU_read_data_1; 
    //Register file wires for output
    wire [31:0] CPU_read_data_0OUT; 
    wire [31:0] CPU_read_data_1OUT; 
    //InstructionMemory wires
    wire [31:0] CPU_read_dataOUT;
    //InstructionMemory regs
    reg [31:0] CPU_read_data;
    //Data Memory Registers 
    //Data Memory Wires
    wire [31:0] dataMemOUT; 
    // Instantiate decoder, Instruction Memory,
    // Data Memory, Register File and ALU
    reg [31:0] CPU_op_0DATA; 
    reg CPU_write_enDATA; 
    //branch instruction addresses
    reg [14:0] branchAddr;
     
    DataMemory myDataMem (
        .data_address(CPU_MemA1),
        .write_en(CPU_write_enDATA),
        .write_data(CPU_op_0DATA),
        .read_data(dataMemOUT) //doubles up one the wire used for the output from ALU  
    );
    
    InstructionMemory myInstMem (
            .inst_address(pc_q),
            .read_data(CPU_read_dataOUT)
    );
    
     RegisterFile myRegFile(
           .read_address_0(CPU_RegA1),
           .read_address_1(CPU_RegA2),
           .write_address_0(CPU_RegA3),
           .write_en(CPU_write_en),
           .write_data(CPU_op_0),//this is doubling up on the output of the ALU to be stored, can be seperated into different var if needed or caues bugs 
           .read_data_0(CPU_read_data_0OUT),
           .read_data_1(CPU_read_data_1OUT)
       );
    
    //Decoder instanitaion
    Decoder myDecoder( 
        instruction_q, CPU_OpOUT, CPU_RegA1OUT, CPU_RegA2OUT, CPU_RegA3OUT, CPU_JumpA1OUT
    );
    //ALU instaniation
    ALU myALU(
         .ip_0(CPU_ip_0),
         .ip_1(CPU_ip_1),
         .opcode(CPU_Op),
         .op_0(CPU_op_0ALUOUT),
         .change_pc(CPU_Change_pc)
    );
    //Register File instanitation
    
    always@(posedge clk)
    begin
        if(state_q == 0) begin // Fetch Stage
              instruction_q = CPU_read_dataOUT; 
              #1 $display ("Instruction found in I-set: %B", instruction_q);
            // increment PC
            pc_q <= pc_q+4; 
            // increment state
            state_q <= 1; 
        end else if(state_q == 1) begin  // Decode Stage       
            // Instruction Decode and read data from register/memory
            // store all data necessary for next stages in a register
           CPU_Op <= CPU_OpOUT;
            #1 $display ("OPCODE: %B", CPU_Op);
            case(CPU_Op)
                3'b000, //SW and LW use the same instruction style
                3'b001:begin
                    CPU_RegA1 = CPU_RegA1OUT;
                    CPU_MemA1 = CPU_JumpA1OUT;  
                    #1 $display ("value stored in REGA 1: %B", CPU_RegA1);  
                    #1 $display ("value stored in MEMA1: %B", CPU_MemA1);  
                 end
                3'b010,
                3'b011: begin 
                    CPU_RegA1 <= CPU_RegA1OUT; 
                    CPU_RegA2 <= CPU_RegA2OUT; 
                  //  #1 $display ("value stored in REGA 1: %B", CPU_RegA1);  
                  //  #1 $display ("value stored in MEMA1: %B", CPU_MemA1); 
                    #1 branchAddr = CPU_JumpA1OUT;
                    #1 CPU_ip_0 = CPU_read_data_0OUT; 
                    # 1CPU_ip_1 = CPU_read_data_1OUT; 
                  //  #1 $display ("value being sent to ALU 1: %B", CPU_ip_0);  
                  //  #1 $display ("value being sent to ALU 2 %B", CPU_ip_1);
                   // $display("the value read from instruction is: %b", branchAddr);  
                end
                3'b100, //add
                3'b101, //sub 
                3'b110, //and
                3'b111: begin //or
                        #1 $display ("Instruction while in ALU %B", instruction_q);
                         CPU_RegA1 <= CPU_RegA1OUT; 
                         CPU_RegA2 <= CPU_RegA2OUT; 
                         CPU_RegA3 <= CPU_RegA3OUT;
                         #1 $display ("value stored in RegA 1: %B", CPU_RegA1);  
                         #1 $display ("value stored in RegA 2: %B", CPU_RegA2);  
                         #1 $display ("value stored in RegA 3: %B", CPU_RegA3);
                         CPU_ip_0 = CPU_read_data_0OUT; 
                         CPU_ip_1 = CPU_read_data_1OUT;   
                         #1 $display ("value being sent to ALU 1: %B", CPU_ip_0);  
                         #1 $display ("value being sent to ALU 2 %B", CPU_ip_1);
                        end 
                default: ; 
            endcase  
            state_q <= 2;  //update state
        end else if(state_q == 2) begin  // Execute Stage        
            // Perform ALU operations
            case(CPU_Op)
            3'b000: /*DO NOTHING*/;
            3'b001: /*Do Nothing*/;
            3'b010,
            3'b011: begin 
                if(CPU_Change_pc) pc_q = branchAddr;
                #1 $display ("The value in the program counter is: %b", pc_q); 
                #1 $display ("The value in PC change is: %b", CPU_Change_pc);  
            end
            3'b100, //add
            3'b101, //sub
            3'b110, //and
            3'b111: begin //or
                CPU_op_0 <= CPU_op_0ALUOUT; 
                #1 $display ("The output of the ALU is: %b", CPU_op_0); 
            end 
            default: ; 
            endcase
            state_q <= 3; //update state
        end else if(state_q == 3) begin  // Memory Stage
            // Access Memory and register file(for load)
            case(CPU_Op)
            3'b000:begin //Lw
                
                
                #1 CPU_op_0 =  dataMemOUT; 
                #1 CPU_write_en = 1;
                #1 CPU_write_en = 0;
                #1 $display ("value that was saved to reg read: %B", CPU_op_0);    
            end 
            3'b001: begin 
                #2 CPU_op_0DATA =  CPU_read_data_0OUT;
                CPU_write_enDATA = 1; 
                #1 CPU_write_enDATA = 0;
                #1 $display ("value that is being stored: %B", CPU_op_0DATA);
                #1 $display ("value in location: %b is %b", CPU_MemA1, myDataMem.ram[CPU_MemA1]);  
            end
            3'b100, //add
            3'b101, //sub
            3'b110, //and
            3'b111: begin //or
                CPU_write_en <=1; //this saves the value currently in reg Address 3 
                #1
               #1 null = CPU_op_0; 
                $display ("value stored in RegA 3: %B", CPU_RegA3);
                $display ("The value currently in RegA3 is: %b", myRegFile.ram[CPU_RegA3] ); 
                   CPU_write_en <=0; 
            end //for all of these instructions we let the ALU handle the processing, on CPU end the behavior is identical
            default ; 
            endcase
            state_q <= 0;
        end    
    end
    
endmodule
