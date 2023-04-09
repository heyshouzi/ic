module HazardDetection (
    input [6:0] opcode;
    input  PCASrc,
    input PCBSrc;
    output predictor;
    output flush;
);
    reg predictor_temp;
    reg flush_temp;
    parameter B_Type  =   7'b1100011;
    parameter Jal     =   7'b1101111;
    parameter Jalr    =   7'b1100111;
    initial begin
        predictor_temp = 0;
        flush_temp     = 0;
    end
    always@(*)begin
        case (opcode)
            B_Type: begin
                if(!PCASrc && PCBSrc)begin
                    predictor_temp = 0;
                    flush_temp     = 0;
                end
                else begin
                    predictor_temp = 1;
                    flush_temp     = 1;
                end
            end
             Jal: begin
                if(!PCASrc && PCBSrc)begin
                    predictor_temp = 0;
                    flush_temp     = 0;
                end
                else begin
                    predictor_temp = 1;
                    flush_temp     = 1;
                end
            end
            Jalr:begin
                if(!PCASrc && PCBSrc)begin
                    predictor_temp = 0;
                    flush_temp     = 0;
                end
                else begin
                    predictor_temp = 1;
                    flush_temp     = 1;
                end
            end
            default: begin
                    predictor_temp = 0;
                    flush_temp     = 0;
                end
        endcase
        predictor = predictor_temp;
        flush     = flush_temp;
    end
endmodule