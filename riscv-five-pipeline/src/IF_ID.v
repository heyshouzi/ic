module IF_ID (
    input clk,
    input reset,
    input [31:0] pc_IF_ID_in,
    input [31:0] instruction_IF_ID_in,
    input flush,
    input [2:0] func3_IF_ID_in,
    input [6:0] func7_IF_ID_in,
    input [6:0] opcode_IF_ID_in,
    input [4:0] rs1_IF_ID_in,
    input [4:0] rs2_IF_ID_in,
    input [4:0] rd_IF_ID_in,
    output reg [2:0] func3_IF_ID_out,
    output reg [6:0] func7_IF_ID_out,
    output reg [6:0] opcode_IF_ID_out,
    output reg [4:0] rs1_IF_ID_out,
    output reg [4:0] rs2_IF_ID_out,
    output reg [4:0] rd_IF_ID_out,
    output reg [31:0] pc_IF_ID_out,
    output reg [31:0] instruction_IF_ID_out
);
    always @(posedge clk) begin
        if(reset || flush)
            begin
                pc_IF_ID_out = 32'b0;
                instruction_IF_ID_out = 32'b0;
                func3_IF_ID_out = 3'b0;
                func7_IF_ID_out = 7'b0;
                opcode_IF_ID_out = 7'b0;
                rs1_IF_ID_out = 5'b0;
                rs2_IF_ID_out = 5'b0;
                rd_IF_ID_out = 5'b0;
            end
        else
            begin
            pc_IF_ID_out = pc_IF_ID_in;
            instruction_IF_ID_out = instruction_IF_ID_in;
            func3_IF_ID_out = func3_IF_ID_in;
            func7_IF_ID_out = func7_IF_ID_in;
            opcode_IF_ID_out = opcode_IF_ID_in;
            rs1_IF_ID_out = rs1_IF_ID_in;
            rs2_IF_ID_out = rs2_IF_ID_in;
            rd_IF_ID_out = rd_IF_ID_in;
            end
    end
endmodule