module forwarding (
    input [4:0] rs1_ID_EX_out,
    input [4:0] rs2_ID_EX_out,
    input [4:0] rd_EX_MEM_out,
    input [4:0] rd_MEM_WB_out,
    input RegWrite_EX_MEM_out,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);
    always @(*) begin
        
    end
endmodule