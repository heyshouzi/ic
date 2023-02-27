module BranchControl (
    input [2:0] Branch,
    input Less,
    input Zero,
    output reg PCASrc,
    output reg PCBSrc
);
    always @(*) begin
        case (Branch)
            //npc = pc + 4;
            3'b000:
                begin
                    PCASrc <= 1'b0;
                    PCBSrc <= 1'b0;
                end
            //npc = pc + imm;
            3'b001:
                begin
                    PCASrc <= 1'b1;
                    PCBSrc <= 1'b0;
                end
            //npc = ReadData1 + imm;
            3'b010:
                begin
                    PCASrc <= 1'b1;
                    PCBSrc <= 1'b1;
                end
            3'b100:
                case(Zero)
                    //npc = pc + 4;
                    1'b0:
                        begin
                            PCASrc <= 1'b0;
                            PCBSrc <= 1'b0;
                        end
                    //npc = pc + imm;
                    1'b1:
                        begin
                            PCASrc <= 1'b1;
                            PCBSrc <= 1'b0;
                        end
                endcase
            3'b110:
                case(Less)
                    //npc = pc + 4;
                    1'b0:
                        begin
                            PCASrc <= 1'b0;
                            PCBSrc <= 1'b0;
                        end
                    //npc = pc + imm;
                    1'b1:
                        begin
                            PCASrc <= 1'b1;
                            PCBSrc <= 1'b0;
                        end
                endcase
            3'b111:
                case(Less)
                    //npc = pc + imm;
                    1'b0:
                        begin
                            PCASrc <= 1'b1;
                            PCBSrc <= 1'b0;
                        end
                    //npc = pc + 4;
                    1'b1:
                        begin
                            PCASrc <= 1'b0;
                            PCBSrc <= 1'b0;
                        end
                endcase    
            default: 
                begin
                    PCASrc <= 1'b0;
                    PCBSrc <= 1'b0;
                end
        endcase
    end
    
endmodule