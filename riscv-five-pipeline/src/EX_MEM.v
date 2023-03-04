module EX_MEM (
    input clk,
    input reset,

    //input_DataMemory
    input [2:0] MemOp_line_in,
    input MemWrite_line_in,
    input MemRead_line_in,
    input [31:0] ReadData2_line_in,

    //input_BranchCond
    input [2:0] Branch_line_in,
    input Less_line_in,
    input Zero_line_in,

    input [31:0] ALUResult_line_in,

    //intput_forwarding
    input     [4:0] rs1_line_in,
    input     [4:0] rs2_line_in,
    
    //input_WriteBack
    input RegWrite_line_in,
    input [4:0] rd_line_in,
    input  MemtoReg_line_in,

    //DataMemory
    output reg [2:0] MemOp_line_out,
    output reg MemRead_line_out,
    output reg   MemWrite_line_out, 
    output reg [31:0] ReadData2_line_out,

    //output_BranchCond
    output reg [2:0] Branch_line_out,
    output reg Zero_line_out,
    output reg Less_line_out,
    
    
    output reg [31:0] ALUResult_line_out,
    
    //output_forwarding
    output     [4:0] rs1_line_out,
    output     [4:0] rs2_line_out,

    //output_WriteBack
    output reg [4:0] rd_line_out,
    output reg RegWrite_line_out,
    output reg MemtoReg_line_out
);
    always @(posedge clk) begin
        if(!reset)
            begin
                ALUResult_line_out <= ALUResult_line_in;
                
                MemOp_line_out <= MemOp_line_in;
                MemWrite_line_out <= MemOp_line_in;
                MemRead_line_out <= MemRead_line_in;
                ReadData2_line_out <= ReadData2_line_in;
                
                Branch_line_out <= Branch_line_in;
                Less_line_out <= Less_line_in;
                Zero_line_out <= Zero_line_in;

                rs1_line_out <= rs1_line_in;
                rs2_line_out <= rs2_line_in;

                rd_line_out <= rd_line_in;
                RegWrite_line_out <= RegWrite_line_in;
                MemtoReg_line_out <= MemtoReg_line_in;
            end
    end
endmodule