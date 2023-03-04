module WriteBack (
    input clk,
    input [31:0]ALUResult,
    input [31:0]MemReadDataOut,
    input MemtoReg,
    output reg [31:0]RegWriteData
);

    always @(*) begin
        case (MemtoReg)
            1'b0: RegWriteData = ALUResult; 
            1'b1: RegWriteData = MemReadDataOut;
            default: RegWriteData = 32'd0;
        endcase
    end
endmodule