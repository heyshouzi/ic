module ID_EX (
    input clk,
    input reset,
    //if flush == 1 flush pipeline register
    //if flush == 0  do nothing
    input flush,

    //input_immgen
    input [31:0] imm_ID_EX_in,

    //input_cu
    input  RegWrite_ID_EX_in,
    input MemWrite_ID_EX_in,
    input [2:0] MemOp_ID_EX_in,
    input MemRead_ID_EX_in,
    input MemtoReg_ID_EX_in,
    input ALUASrc_ID_EX_in,
    input [1:0] ALUBSrc_ID_EX_in,
    input [3:0] ALUCtl_ID_EX_in,
    input [2:0] Branch_ID_EX_in,

    //input_pc
    input [31:0] pc_ID_EX_in,

    //input_registerfile
    input     [31:0] ReadData1_ID_EX_in,
    input     [31:0] ReadData2_ID_EX_in,

    //input_decode
    input     [4:0] rs1_ID_EX_in,
    input     [4:0] rs2_ID_EX_in,
    input     [4:0] rd_ID_EX_in,

    //input_bubble
    input   Reg_MemWrite,
    //output_immgen
    output reg [31:0] imm_ID_EX_out,

    //output_cu
    output reg RegWrite_ID_EX_out,
    output reg MemWrite_ID_EX_out,
    output reg [2:0] MemOp_ID_EX_out,
    output reg MemRead_ID_EX_out,
    output reg MemtoReg_ID_EX_out,
    output reg ALUASrc_ID_EX_out,
    output reg [1:0] ALUBSrc_ID_EX_out,
    output reg [3:0] ALUCtl_ID_EX_out,
    output reg [2:0] Branch_ID_EX_out,

    //output_registerfile
    output reg [31:0] ReadData1_ID_EX_out,
    output reg [31:0] ReadData2_ID_EX_out,

    //output_decode
    output reg [4:0]  rs1_ID_EX_out,
    output reg [4:0]  rs2_ID_EX_out,
    output reg [4:0]  rd_ID_EX_out,

    //output_pc
    output reg [31:0] pc_ID_EX_out


);
    always @(posedge clk) begin
        if(reset || flush)
            begin
                ReadData1_ID_EX_out <= 32'b0;
                ReadData2_ID_EX_out <= 32'b0;

                rs1_ID_EX_out <= 5'b0;
                rs2_ID_EX_out <= 5'b0;
                rd_ID_EX_out <= 5'b0;

                pc_ID_EX_out  <= 32'b0;

                RegWrite_ID_EX_out <= 1'b0;
                Branch_ID_EX_out <= 3'b0;
                MemWrite_ID_EX_out <= 1'b0;
                MemOp_ID_EX_out <= 3'b0;
                MemRead_ID_EX_out <= 1'b0;
                ALUASrc_ID_EX_out <= 1'b0;
                ALUBSrc_ID_EX_out <= 2'b0;
                ALUCtl_ID_EX_out <= 4'b0;
                MemtoReg_ID_EX_out <= 1'b0;
                
                imm_ID_EX_out <= 32'b0;
            end
        else
            begin
            ReadData1_ID_EX_out <= ReadData1_ID_EX_in;
            ReadData2_ID_EX_out <= ReadData2_ID_EX_in;

            rs1_ID_EX_out <= rs1_ID_EX_in;
            rs2_ID_EX_out <= rs2_ID_EX_in;
            rd_ID_EX_out <= rd_ID_EX_in;

            pc_ID_EX_out  <= pc_ID_EX_in;
            
            if(Reg_MemWrite)begin
                RegWrite_ID_EX_out <= 1'b0;
                MemWrite_ID_EX_out <= 1'b0;
            end

            Branch_ID_EX_out <= Branch_ID_EX_in;
            MemOp_ID_EX_out <= MemOp_ID_EX_in;
            MemRead_ID_EX_out <= MemRead_ID_EX_in;
            ALUASrc_ID_EX_out <= ALUASrc_ID_EX_in;
            ALUBSrc_ID_EX_out <= ALUBSrc_ID_EX_in;
            ALUCtl_ID_EX_out <= ALUCtl_ID_EX_in;
            MemtoReg_ID_EX_out <= MemtoReg_ID_EX_in;
            
            imm_ID_EX_out <= imm_ID_EX_in;
            end
        
    end
endmodule