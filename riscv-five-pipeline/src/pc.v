`timescale 1ns/1ps
module pc(
    input clk,
    input reset,   
    input [31:0] npc,
    input predictor,
    input PCdelay,
    output reg [31:0] pc
);
    reg [31:0] pc_temp;

    always @(posedge clk)
        begin
            if(reset)
                pc_temp <= 32'b0;
            else begin
                pc_temp <= PCdelay ? pc : (predictor ? npc : pc + 4);
            end
            pc = pc_temp;
        end
    
endmodule