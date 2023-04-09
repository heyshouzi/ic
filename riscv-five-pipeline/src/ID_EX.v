module ID_EX (
    input clk,
    input reset,
    //if flush == 1 flush pipeline register
    //if flush == 0  do nothing
    input flush,

    //input_immgen
    input [31:0] imm_line_in,

    //input_cu
    input  RegWrite_line_in,
    input MemWrite_line_in,
    input [2:0] MemOp_line_in,
    input MemRead_line_in,
    input MemtoReg_line_in,
    input ALUASrc_line_in,
    input [1:0] ALUBSrc_line_in,
    input [3:0] ALUCtl_line_in,
    input [2:0] Branch_line_in,

    //input_pc
    input [31:0] pc_line_in,

    //input_registerfile
    input     [31:0] ReadData1_line_in,
    input     [31:0] ReadData2_line_in,

    //input_decode
    input     [4:0] rs1_line_in,
    input     [4:0] rs2_line_in,
    input     [4:0] rd_line_in,

    //input_bubble
    input   RegWrite/MemWrite,
    //output_immgen
    output reg [31:0] imm_line_out,

    //output_cu
    output reg RegWrite_line_out,
    output reg MemWrite_line_out,
    output reg [2:0] MemOp_line_out,
    output reg MemRead_line_out,
    output reg MemtoReg_line_out,
    output reg ALUASrc_line_out,
    output reg [1:0] ALUBSrc_line_out,
    output reg [3:0] ALUCtl_line_out,
    output reg [2:0] Branch_line_out,

    //output_registerfile
    output reg [31:0] ReadData1_line_out,
    output reg [31:0] ReadData2_line_out,

    //output_decode
    output reg [4:0]  rs1_line_out,
    output reg [4:0]  rs2_line_out,
    output reg [4:0]  rd_line_out,

    //output_pc
    output reg [31:0] pc_line_out


);
    always @(posedge clk) begin
        if(reset || flush)
            begin
                ReadData1_line_out <= 32'b0;
                ReadData2_line_out <= 32'b0;

                rs1_line_out <= 5'b0;
                rs2_line_out <= 5'b0;
                rd_line_out <= 5'b0;

                pc_line_out  <= 32'b0;

                RegWrite_line_out <= 1'b0;
                Branch_line_out <= 3'b0;
                MemWrite_line_out <= 1'b0;
                MemOp_line_out <= 3'b0;
                MemRead_line_out <= 1'b0;
                ALUASrc_line_out <= 1'b0;
                ALUBSrc_line_out <= 2'b0;
                ALUCtl_line_out <= 4'b0;
                MemtoReg_line_out <= 1'b0;
                
                imm_line_out <= 32'b0;
            end
        else
            begin
            ReadData1_line_out <= ReadData1_line_in;
            ReadData2_line_out <= ReadData2_line_in;

            rs1_line_out <= rs1_line_in;
            rs2_line_out <= rs2_line_in;
            rd_line_out <= rd_line_in;

            pc_line_out  <= pc_line_in;
            
            if(RegWrite/MemWrite)begin
                RegWrite_line_out <= 1'b0;
                MemWrite_line_out <= 1'b0;
            end

            Branch_line_out <= Branch_line_in;
            MemOp_line_out <= MemOp_line_in;
            MemRead_line_out <= MemRead_line_in;
            ALUASrc_line_out <= ALUASrc_line_in;
            ALUBSrc_line_out <= ALUBSrc_line_in;
            ALUCtl_line_out <= ALUCtl_line_in;
            MemtoReg_line_out <= MemtoReg_line_in;
            
            imm_line_out <= imm_line_in;
            end
        
    end
endmodule