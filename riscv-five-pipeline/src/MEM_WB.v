module MEM_WB (
    input clk,
    input reset,
    input [31:0] MemReadData_MEM_WB_in,
    input [31:0] ALUResult_MEM_WB_in,
    input  MemtoReg_MEM_WB_in,
    input RegWrite_MEM_WB_in,
    input [4:0] rs1_MEM_WB_in,
    input [4:0] rs2_MEM_WB_in,
    input [4:0] rd_MEM_WB_in,

    output reg MemtoReg_MEM_WB_out,
    output reg RegWrite_MEM_WB_out,
    output reg [4:0] rs1_MEM_WB_out,
    output reg [4:0] rs2_MEM_WB_out,
    output reg [4:0] rd_MEM_WB_out,
    output reg [31:0] MemReadData_MEM_WB_out,
    output reg [31:0] ALUResult_MEM_WB_out
);
    always @(posedge clk ) begin
        if(!reset)
            begin
                ALUResult_MEM_WB_out <= ALUResult_MEM_WB_in;
                MemReadData_MEM_WB_out <= MemReadData_MEM_WB_in;
                MemtoReg_MEM_WB_out <= MemtoReg_MEM_WB_in;
                rs1_MEM_WB_out <= rs1_MEM_WB_in;
                rs2_MEM_WB_out <= rs2_MEM_WB_in;
                rd_MEM_WB_out <= rd_MEM_WB_in;
                RegWrite_MEM_WB_out <= RegWrite_MEM_WB_in;
            end
    end
endmodule