`timescale 1ns/1ps

module pc_tb();
    reg clk;
    reg reset;
    reg [31:0] npc;
    wire [31:0] pc;

    pc dut(
        .clk(clk),
        .reset(reset),
        .npc(npc),
        .pc(pc)
    );


    //建立时钟
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("pc_tb.vcd");    //生成的vcd文件名称
        $dumpvars(0, pc_tb);       //要记录的信号  0代表所有
    end


    initial begin
        #0 npc = 0;
        #2 npc = 4;
        #4 npc = 12;
        #6 reset = 1;
        #8 npc = 15;
        $finish();
    end

endmodule