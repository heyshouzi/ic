`timescale 1ns/1ps

module RiscvCore_tb();
    reg clk;
    reg reset;
    reg [31:0] Instruction;
    reg [31:0] MemReadData;
    wire DataAddr;
    wire InstAddr;
    wire MemOp;
    wire MemRead;
    wire MemWrite;
    wire [31:0] MemDataIn;

    RiscvCore dut(
        clk(clk),
        .reset(reset),
        .Instruction(Instruction),
        .MemReadData(MemDataOut),
        .InstAddr(InstAddr),
        .DataAddr(DataAddr),
        .MemOp(MemOp),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemDataIn(MemDataIn)
    );

    initial begin
            $dumpfile("RiscvCore_tb.vcd");    //生成的vcd文件名称
            $dumpvars(0, RiscvCore_tb);       //要记录的信号  0代表所有
        end



endmodule