module EX_MEM (
    input clk,
    input reset,

    input flush,

    //input_DataMemory
    input [2:0] MemOp_EX_MEM_in,
    input MemWrite_EX_MEM_in,
    input MemRead_EX_MEM_in,
    input [31:0] ReadData2_EX_MEM_in,

    //input_BranchCond
    input [2:0] Branch_EX_MEM_in,
    input Less_EX_MEM_in,
    input Zero_EX_MEM_in,

    input [31:0] ALUResult_EX_MEM_in,

    //intput_forwarding
    input     [4:0] rs1_EX_MEM_in,
    input     [4:0] rs2_EX_MEM_in,
    
    //input_WriteBack
    input RegWrite_EX_MEM_in,
    input [4:0] rd_EX_MEM_in,
    input  MemtoReg_EX_MEM_in,

    //DataMemory
    output reg [2:0] MemOp_EX_MEM_out,
    output reg MemRead_EX_MEM_out,
    output reg   MemWrite_EX_MEM_out, 
    output reg [31:0] ReadData2_EX_MEM_out,

    //output_BranchCond
    output reg [2:0] Branch_EX_MEM_out,
    output reg Zero_EX_MEM_out,
    output reg Less_EX_MEM_out,
    
    
    output reg [31:0] ALUResult_EX_MEM_out,
    
    //output_forwarding
    output reg [4:0] rs1_EX_MEM_out,
    output reg [4:0] rs2_EX_MEM_out,

    //output_WriteBack
    output reg [4:0] rd_EX_MEM_out,
    output reg RegWrite_EX_MEM_out,
    output reg MemtoReg_EX_MEM_out
);
    always @(posedge clk) begin
        if(reset || flush)
            begin
                ALUResult_EX_MEM_out <= 32'b0;
                
                MemOp_EX_MEM_out <= 3'b0;
                MemWrite_EX_MEM_out <= 1'b0;
                MemRead_EX_MEM_out <= 1'b0;
                ReadData2_EX_MEM_out <= 32'b0;
                
                Branch_EX_MEM_out <= 3'b0;
                Less_EX_MEM_out <= 1'b0;
                Zero_EX_MEM_out <= 1'b0;

                rs1_EX_MEM_out <= 5'b0;
                rs2_EX_MEM_out <= 5'b0;

                rd_EX_MEM_out <= 5'b0;
                RegWrite_EX_MEM_out <= 1'b0;
                MemtoReg_EX_MEM_out <= 1'b0;
            end
        else
            begin
                ALUResult_EX_MEM_out <= ALUResult_EX_MEM_in;
                
                MemOp_EX_MEM_out <= MemOp_EX_MEM_in;
                MemWrite_EX_MEM_out <= MemOp_EX_MEM_in;
                MemRead_EX_MEM_out <= MemRead_EX_MEM_in;
                ReadData2_EX_MEM_out <= ReadData2_EX_MEM_in;
                
                Branch_EX_MEM_out <= Branch_EX_MEM_in;
                Less_EX_MEM_out <= Less_EX_MEM_in;
                Zero_EX_MEM_out <= Zero_EX_MEM_in;

                rs1_EX_MEM_out <= rs1_EX_MEM_in;
                rs2_EX_MEM_out <= rs2_EX_MEM_in;

                rd_EX_MEM_out <= rd_EX_MEM_in;
                RegWrite_EX_MEM_out <= RegWrite_EX_MEM_in;
                MemtoReg_EX_MEM_out <= MemtoReg_EX_MEM_in;
            end
        
    end
endmodule