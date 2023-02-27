module ID_EX (
    input clk,
    input reset,
    //immgen
    input [31:0] imm_line_in,
    //cu
    input  RegWrite_line_in,
    input [2:0] Branch_line_in,
    input MemWrite_line_in,
    input MemOp_line_in,
    input MemRead_line_in,
    input ALUASrc_line_in,
    input [1:0] ALUBSrc_line_in,
    input [3:0] ALUCtl_line_in,
    //pc
    input [31:0] pc_line_in,
    //registerfile
    input     [31:0] rs1_line_in,
    input     [31:0] rs2_line_in,
    
    output reg RegWrite_line_out,
    output reg [2:0] Branch_line_out,
    output reg MemWrite_line_out,
    output reg MemOp_line_out,
    output reg MemRead_line_out,
    output reg ALUASrc_line_out,
    output reg [1:0] ALUBSrc_line_out,
    output reg [3:0] ALUCtl_line_out,

    output reg [31:0] imm_line_out,
    output reg [31:0] rs1_line_out,
    output reg [31:0] rs2_line_out,
    output reg [31:0] pc_line_out,
);
    always @(posedge clk) begin
        if(!reset) begin
            rs1_line_out <= rs1_line_in;
            rs2_line_out <= rs2_line_in;

            pc_line_out  <= pc_line_in;

            RegWrite_line_out <= RegWrite_line_in;
            Branch_line_out <= Branch_line_in;
            MemWrite_line_out <= MemWrite_line_in;
            MemOp_line_out <= MemOp_line_in;
            MemRead_line_out <= MemRead_line_in;
            ALUASrc_line_out <= ALUASrc_line_in;
            ALUBSrc_line_out <= ALUBSrc_line_in;
            ALUCtl_line_out = ALUCtl_line_in;

            imm_line_out = imm_line_in;
        end
        
    end
endmodule