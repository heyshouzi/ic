
module ImmGen (
    input clk,
    input [31:0] Instruction,
    input [6:0] opcode,
    output reg [31:0] ImmGenOut     //32位经过符号扩展的偏移地址
);
    parameter R_Type  =   7'b0110011;
    parameter I_Type  =   7'b0010011;
    parameter Il_Type =   7'b0000011;
    parameter S_Type  =   7'b0100011;
    parameter B_Type  =   7'b1100011;
    parameter lui     =   7'b0110111;
    parameter auipc   =   7'b0010111;
    parameter Jal     =   7'b1101111;
    parameter Jalr    =   7'b1100111;
    always @ (posedge clk)
    begin
        case (opcode)
            //处理I型jalr指令的imm
            Jalr:  ImmGenOut  <= {{21{Instruction[31]}},Instruction[30:20]};
            //处理I型(lb、lh、lw、lbu、lhu)指令的imm                
            Il_Type:  ImmGenOut  <= {{21{Instruction[31]}},Instruction[30:20]};
            //处理I型(addi、slti、xori、ori、andi)指令的imm               
            I_Type:  ImmGenOut  <= {{21{Instruction[31]}},Instruction[30:20]};
            //处理S型指令的imm                 
            S_Type:  ImmGenOut  <= {{21{Instruction[31]}},Instruction[30:25],Instruction[11:7]};
            //处理B型指令的imm                                  
            B_Type:  ImmGenOut  <= {{20{Instruction[31]}},Instruction[7],Instruction[30:25],Instruction[11:8],{1'b0}};   
            //处理U型 lui指令的imm                           
            lui:  ImmGenOut  <= {Instruction[31:12],{12{1'b0}}}; 
              
            auipc:  ImmGenOut  <= {Instruction[31:12],{12{1'b0}}}; 
            //处理J型指令的imm                          
            Jal:  ImmGenOut  <= {{12{Instruction[31]}},Instruction[19:12],Instruction[20],Instruction[30:21],{1'b0}};                      
            default:  ImmGenOut <= 32'd0;
        endcase
    end
endmodule
