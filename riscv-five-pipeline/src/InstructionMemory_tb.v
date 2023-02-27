`timescale 1ns/1ps

module InstructionMemory_tb;
    reg clk;
    reg [31:0] InstAddr;
    wire [31:0] Instruction;
    InstructionMemory dut (
        .clk(clk),
        .InstAddr(InstAddr),
        .Instruction(Instruction)
    );
    
    initial begin
            $dumpfile("InstructionMemory_tb.vcd");    //生成的vcd文件名称
            $dumpvars(0, InstructionMemory_tb);       //要记录的信号  0代表所有
        end
    initial begin
            clk = 0;
            forever #5 clk = ~clk;
        end
    


    initial begin
        // Initialize inputs
        clk = 0;
        InstAddr = 0;
        #10;
        $finish;
    end


endmodule