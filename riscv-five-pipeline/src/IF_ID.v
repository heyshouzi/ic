module IF_ID (
    input clk,
    input reset,
    input [31:0] pc_line_in,
    input [31:0] instruction_data_in,
    output reg [31:0] pc_line_out,
    output [31:0] instruction_data_out
);
    always @(posedge clk) begin
        if(!reset)
            pc_line_out = pc_line_in;
        else
            pc_line_out = 32'b0;
    end
    assign instruction_data_out = instruction_data_in;
endmodule