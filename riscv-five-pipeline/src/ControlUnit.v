// `include"riscv"
module ControlUnit (
    input  [6:0] opcode,
    input  [2:0] func3,
    input  [6:0] func7,
    output reg       RegWrite,
    output reg [2:0] Branch,
    output reg       MemtoReg,
    output reg       MemWrite,
    output reg [2:0] MemOp,
    output reg       MemRead,
    output reg       ALUASrc,
    output reg [1:0] ALUBSrc,
    output reg [3:0] ALUCtl

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
    always @(*)
        begin
            case (opcode)
                R_Type: 
                    begin
                       case (func3)
                        3'b000:
                            begin
                                case (func7[5])
                                    //add
                                    1'b0:                                   
                                        begin
                                            RegWrite  =     1'b1;
                                            Branch    =   3'b000;
                                            MemtoReg  =     1'b0;
                                            MemWrite  =     1'b0;
                                            ALUASrc   =     1'b0;
                                            ALUBSrc   =    2'b00;
                                            ALUCtl    =  4'b0000;
                                        end
                                    //sub   
                                    1'b1:
                                        begin
                                            RegWrite  =     1'b1;
                                            Branch    =   3'b000;
                                            MemtoReg  =     1'b0;
                                            MemWrite  =     1'b0;
                                            ALUASrc   =     1'b0;
                                            ALUBSrc   =    2'b00;
                                            ALUCtl    =  4'b1000;
                                        end  
                                endcase
                            end
                        //sll
                        3'b001:
                            begin
                                RegWrite  =     1'b1;
                                Branch    =   3'b000;
                                MemtoReg  =     1'b0;
                                MemWrite  =     1'b0;
                                ALUASrc   =     1'b0;
                                ALUBSrc   =    2'b00;
                                ALUCtl    =  4'b0001;
                            end  
                        //slt
                        3'b010:
                            begin
                                RegWrite  =     1'b1;
                                Branch    =   3'b000;
                                MemtoReg  =     1'b0;
                                MemWrite  =     1'b0;
                                ALUASrc   =     1'b0;
                                ALUBSrc   =    2'b00;
                                ALUCtl    =  4'b0010;
                            end
                        //sltu      
                        3'b011:
                            begin
                                RegWrite  =     1'b1;
                                Branch    =   3'b000;
                                MemtoReg  =     1'b0;
                                MemWrite  =     1'b0;
                                ALUASrc   =     1'b0;
                                ALUBSrc   =    2'b00;
                                ALUCtl    =  4'b1010;
                            end
                        //xor 
                        3'b100:
                            begin
                                RegWrite  =     1'b1;
                                Branch    =   3'b000;
                                MemtoReg  =     1'b0;
                                MemWrite  =     1'b0;
                                ALUASrc   =     1'b0;
                                ALUBSrc   =    2'b00;
                                ALUCtl    =  4'b0100;
                            end 
                        3'b101:
                            begin
                                case (func7[5])
                                    //srl
                                    1'b0:                                   
                                        begin
                                            RegWrite  =     1'b1;
                                            Branch    =   3'b000;
                                            MemtoReg  =     1'b0;
                                            MemWrite  =     1'b0;
                                            ALUASrc   =     1'b0;
                                            ALUBSrc   =    2'b00;
                                            ALUCtl    =  4'b0101;
                                        end
                                    //sra   
                                    1'b1:
                                        begin
                                            RegWrite  =     1'b1;
                                            Branch    =   3'b000;
                                            MemtoReg  =     1'b0;
                                            MemWrite  =     1'b0;
                                            ALUASrc   =     1'b0;
                                            ALUBSrc   =    2'b00;
                                            ALUCtl    =  4'b1101;
                                        end  
                                endcase
                            end
                        //or   
                        3'b110:
                            begin
                                RegWrite  =     1'b1;
                                Branch    =   3'b000;
                                MemtoReg  =     1'b0;
                                MemWrite  =     1'b0;
                                ALUASrc   =     1'b0;
                                ALUBSrc   =    2'b00;
                                ALUCtl    =  4'b0110;
                            end
                        //and    
                        3'b111:
                             begin
                               RegWrite  =     1'b1;
                                Branch    =   3'b000;
                                MemtoReg  =     1'b0;
                                MemWrite  =     1'b0;
                                ALUASrc   =     1'b0;
                                ALUBSrc   =    2'b00;
                                ALUCtl    =  4'b0111;
                            end
                       endcase
                    end
                I_Type:
                    begin
                        case (func3)
                            //addi
                            3'b000:
                                begin
                                    RegWrite  =     1'b1;
                                    Branch    =   3'b000;
                                    MemtoReg  =     1'b0;
                                    MemWrite  =     1'b0;
                                    ALUASrc   =     1'b0;
                                    ALUBSrc   =    2'b01;
                                    ALUCtl    =  4'b0000;
                                end
                            //slti
                            3'b010:
                                begin
                                    RegWrite  =     1'b1;
                                    Branch    =   3'b000;
                                    MemtoReg  =     1'b0;
                                    MemWrite  =     1'b0;
                                    ALUASrc   =     1'b0;
                                    ALUBSrc   =    2'b01;
                                    ALUCtl    =  4'b0010;
                                end
                            //sltiu    
                            3'b011:
                                begin
                                    RegWrite  =     1'b1;
                                    Branch    =   3'b000;
                                    MemtoReg  =     1'b0;
                                    MemWrite  =     1'b0;
                                    ALUASrc   =     1'b0;
                                    ALUBSrc   =    2'b01;
                                    ALUCtl    =  4'b1010;
                                end
                            //xori
                            3'b100:
                                begin
                                    RegWrite  =     1'b1;
                                    Branch    =   3'b000;
                                    MemtoReg  =     1'b0;
                                    MemWrite  =     1'b0;
                                    ALUASrc   =     1'b0;
                                    ALUBSrc   =    2'b01;
                                    ALUCtl    =  4'b0100;
                                end
                            //ori
                            3'b110:
                                begin
                                    RegWrite  =     1'b1;
                                    Branch    =   3'b000;
                                    MemtoReg  =     1'b0;
                                    MemWrite  =     1'b0;
                                    ALUASrc   =     1'b0;
                                    ALUBSrc   =    2'b01;
                                    ALUCtl    =  4'b0110;    
                                end
                            //andi
                            3'b111:
                                begin
                                    RegWrite  =     1'b1;
                                    Branch    =   3'b000;
                                    MemtoReg  =     1'b0;
                                    MemWrite  =     1'b0;
                                    ALUASrc   =     1'b0;
                                    ALUBSrc   =    2'b01;
                                    ALUCtl    =  4'b0111;  
                                end
                            //slli
                            3'b001:
                                begin
                                    RegWrite  =     1'b1;
                                    Branch    =   3'b000;
                                    MemtoReg  =     1'b0;
                                    MemWrite  =     1'b0;
                                    ALUASrc   =     1'b0;
                                    ALUBSrc   =    2'b01;
                                    ALUCtl    =  4'b0001;  
                                end
                            3'b101:
                                begin
                                    case (func7[5])
                                        //srli
                                        1'b0:
                                            begin
                                                RegWrite  =     1'b1;
                                                Branch    =   3'b000;
                                                MemtoReg  =     1'b0;
                                                MemWrite  =     1'b0;
                                                ALUASrc   =     1'b0;
                                                ALUBSrc   =    2'b01;
                                                ALUCtl    =  4'b0101;               
                                            end 
                                        // srai    
                                        1'b1:
                                            begin
                                                RegWrite  =     1'b1;
                                                Branch    =   3'b000;
                                                MemtoReg  =     1'b0;
                                                MemWrite  =     1'b0;
                                                ALUASrc   =     1'b0;
                                                ALUBSrc   =    2'b01;
                                                ALUCtl    =  4'b1101;   
                                            end 
                                    endcase
                                end
                        endcase
                    end
                S_Type:
                    begin
                       case (func3)
                       //sb
                        3'b000:
                            begin
                                RegWrite  =    1'b0;
                                Branch    =  3'b000;
                                MemWrite  =    1'b1;
                                MemOp     =  3'b000;
                                ALUASrc   =    1'b0;
                                ALUBSrc   =   2'b01;
                                ALUCtl    = 4'b0000;  
                            end
                        //sh
                        3'b001:
                            begin
                                RegWrite  =    1'b0;
                                Branch    =  3'b000;
                                MemWrite  =    1'b1;
                                MemOp     =  3'b001;
                                ALUASrc   =    1'b0;
                                ALUBSrc   =   2'b01;
                                ALUCtl    = 4'b0000;  
                            end
                        //sw
                        3'b010:
                            begin
                                RegWrite  =    1'b0;
                                Branch    =  3'b000;
                                MemWrite  =    1'b1;
                                MemOp     =  3'b010;
                                ALUASrc   =    1'b0;
                                ALUBSrc   =   2'b01;
                                ALUCtl    = 4'b0000;  
                            end
                        default:
                            begin
                                RegWrite  =    1'b0;
                                Branch    =  3'b000;
                                MemWrite  =    1'b0;
                                MemRead   =    1'b0;
                                MemOp     =  3'b000;
                                ALUASrc   =    1'b0;
                                ALUBSrc   =   2'b00;
                                ALUCtl    = 4'b0000;  
                            end 
                       endcase
                    end
                B_Type:
                    begin
                       case (func3)
                        //beq
                        3'b000:
                            begin
                                RegWrite  =    1'b0;
                                Branch    =  3'b010;
                                MemWrite  =    1'b0;
                                ALUASrc   =    1'b0;
                                ALUBSrc   =   2'b00;
                                ALUCtl    = 4'b0010;  
                            end
                        //bne 
                        3'b001:
                            begin
                                RegWrite  =    1'b0;
                                Branch    =  3'b101;
                                MemWrite  =    1'b0;
                                ALUASrc   =    1'b0;
                                ALUBSrc   =   2'b00;
                                ALUCtl    = 4'b0010;  
                            end
                        //blt
                        3'b100:
                            begin
                                RegWrite  =    1'b0;
                                Branch    =  3'b110;
                                MemWrite  =    1'b0;
                                ALUASrc   =    1'b0;
                                ALUBSrc   =   2'b00;
                                ALUCtl    = 4'b0010;  
                        end
                        //bge
                        3'b101:
                            begin
                                RegWrite  =    1'b0;
                                Branch    =  3'b111;
                                MemWrite  =    1'b0;
                                ALUASrc   =    1'b0;
                                ALUBSrc   =   2'b00;
                                ALUCtl    = 4'b0010;  
                            end
                        //bltu
                        3'b110:
                            begin
                                RegWrite  =    1'b0;
                                Branch    =  3'b110;
                                MemWrite  =    1'b0;
                                ALUASrc   =    1'b0;
                                ALUBSrc   =   2'b00;
                                ALUCtl    = 4'b1010;  
                            end
                        //bgeu
                        3'b111:
                            begin
                                RegWrite  =    1'b0;
                                Branch    =  3'b111;
                                MemWrite  =    1'b0;
                                ALUASrc   =    1'b0;
                                ALUBSrc   =   2'b00;
                                ALUCtl    = 4'b1010;  
                            end
                       endcase
                    end
                Jal:
                    begin
                        RegWrite  =    1'b1;
                        Branch    =  3'b001;
                        MemtoReg  =    1'b0;
                        MemWrite  =    1'b0;
                        ALUASrc   =    1'b1;
                        ALUBSrc   =   2'b10;
                        ALUCtl    = 4'b0000; 
                    end
                Jalr:
                    begin
                        RegWrite  =    1'b1;
                        Branch    =  3'b010;
                        MemtoReg  =    1'b0;
                        MemWrite  =    1'b0;
                        ALUASrc   =    1'b1;
                        ALUBSrc   =   2'b10;
                        ALUCtl    = 4'b0000; 
                    end
                lui:
                    begin
                        RegWrite  =    1'b1;
                        Branch    =  3'b000;
                        MemtoReg  =    1'b0;
                        MemWrite  =    1'b0;
                        MemRead   =    1'b0;
                        ALUASrc   =    1'b0;
                        ALUBSrc   =   2'b01;
                        ALUCtl    = 4'b0011;  
                    end
                auipc:
                    begin
                        RegWrite  =    1'b1;
                        Branch    =  3'b000;
                        MemtoReg  =    1'b0;
                        MemWrite  =    1'b0;
                        MemRead   =    1'b0;
                        ALUBSrc   =   2'b01;
                        ALUCtl    = 4'b0000;  
                    end
                Il_Type:
                    begin
                        case (func3)
                            //lb
                            3'b000:
                                begin
                                    RegWrite  =    1'b1;
                                    Branch    =  3'b000;
                                    MemtoReg  =    1'b1;
                                    MemWrite  =    1'b0;
                                    MemOp     =  3'b000;
                                    ALUBSrc   =   2'b01;
                                    ALUCtl    = 4'b0000;  
                                end
                            //lh
                            3'b001:
                                begin
                                    RegWrite  =    1'b1;
                                    Branch    =  3'b000;
                                    MemtoReg  =    1'b1;
                                    MemWrite  =    1'b0;
                                    MemOp     =  3'b001;
                                    ALUBSrc   =   2'b01;
                                    ALUCtl    = 4'b0000;  
                                end
                            //lw
                            3'b010:
                                begin
                                    RegWrite  =    1'b1;
                                    Branch    =  3'b000;
                                    MemtoReg  =    1'b1;
                                    MemWrite  =    1'b0;
                                    MemOp     =  3'b010;
                                    ALUBSrc   =   2'b01;
                                    ALUCtl    = 4'b0000;  
                                end
                            //lbu
                            3'b100:
                                begin
                                    RegWrite  =    1'b1;
                                    Branch    =  3'b000;
                                    MemtoReg  =    1'b1;
                                    MemWrite  =    1'b0;
                                    MemOp     =  3'b100;
                                    ALUBSrc   =   2'b01;
                                    ALUCtl    = 4'b0000;  
                                end
                            //lhu
                            3'b101:
                                begin
                                    RegWrite  =    1'b1;
                                    Branch    =  3'b000;
                                    MemtoReg  =    1'b1;
                                    MemWrite  =    1'b0;
                                    MemOp     =  3'b101;
                                    ALUBSrc   =   2'b01;
                                    ALUCtl    = 4'b0000;  
                                end 
                            default: 
                                begin
                                    RegWrite  =    1'b0;
                                    Branch    =  3'b000;
                                    MemtoReg  =    1'b0;
                                    MemWrite  =    1'b0;
                                    MemOp     =  3'b000;
                                    MemRead   =    1'b0;
                                    ALUBSrc   =   2'b00;
                                    ALUCtl    = 4'b0000;  
                                end 
                        endcase
                    end
                default: 
                    begin
                        RegWrite  =    1'b0;
                        Branch    =  3'b000;
                        MemWrite  =    1'b0;
                        MemRead   =    1'b0;
                        MemOp     =  3'b000;
                        ALUASrc   =    1'b0;
                        ALUBSrc   =   2'b00;
                        ALUCtl    = 4'b0000; 
                    end
            endcase
        end
endmodule