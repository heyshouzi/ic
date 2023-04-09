module IF_ID (
    input clk,
    input reset,
    input [31:0] pc_line_in,
    input [31:0] instruction_data_in,
    input flush,
    output reg [31:0] pc_line_out,
    output reg [31:0] instruction_data_out
);
    always @(posedge clk) begin
        if(reset || flush)
            begin
                pc_line_out = 32'b0;
                instruction_data_out = 32'b0;
            end
        else
            begin
            pc_line_out = pc_line_in;
            instruction_data_out = instruction_data_in;
            end
    end
endmodule