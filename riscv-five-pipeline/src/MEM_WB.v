module MEM_WB (
    input clk,
    input reset,

    input [31:0] MemReadData_line_in,
    input [31:0] ALUResult_line_in,
    input  MemtoReg_line_in,
    input RegWrite_line_in,
    input [4:0] rs1_line_in,
    input [4:0] rs2_line_in,
    input [4:0] rd_line_in,

    output reg MemtoReg_line_out,
    output reg RegWrite_line_out,
    output reg [4:0] rs1_line_out,
    output reg [4:0] rs2_line_out,
    output reg [4:0] rd_line_out,
    output reg [31:0] MemReadData_line_out,
    output reg [31:0] ALUResult_line_out
);
    always @(posedge clk ) begin
        if(!reset)
            begin
                ALUResult_line_out <= ALUResult_line_in;
                MemReadData_line_out <= MemReadData_line_in;
                MemtoReg_line_out <= MemtoReg_line_in;
                rs1_line_out <= rs1_line_in;
                rs2_line_out <= rs2_line_in;
                rd_line_out <= rd_line_in;
                RegWrite_line_out <= RegWrite_line_in;
            end
    end
endmodule