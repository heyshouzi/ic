`timescale 1ns/1ps
module pc(
    input clk,
    input reset,   //异步高电平复位
    input [31:0] npc,
    output reg [31:0] pc
);
    //下降沿写入pc寄存器
    always @(negedge clk)
        begin
            if(reset)
                pc <= 32'b0;
            else
                pc <= npc;
        end
   
    
endmodule