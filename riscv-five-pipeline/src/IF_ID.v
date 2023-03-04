module IF_ID (
    input clk,
    input reset,
    input [31:0] pc_line_in,
    input [31:0] instruction_data_in,
    output reg [31:0] pc_line_out,
    output reg [31:0] instruction_data_out
);
    always @(posedge clk) begin
        if(!reset)begin
            pc_line_out = pc_line_in;
            instruction_data_out = instruction_data_in;
        end
        else
            pc_line_out = 32'b0;
    end
endmodule