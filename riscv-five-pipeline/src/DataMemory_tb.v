`timescale 1ns/1ps

module DataMemory_tb();
        reg clk;
        reg [2:0] MemOp;
        reg [31:0] addr;
        reg [31:0] WriteData;
        reg MemRead;
        reg MemWrite;
        wire [31:0] ReadData;
        DataMemory dut(
            .clk(clk),
            .MemOp(MemOp),
            .addr(addr),
            .WriteData(WriteData),
            .MemRead(MemRead),
            .MemWrite(MemWrite),
            .ReadData(ReadData)
        );
        //建立时钟
        initial begin
            clk = 0;
            forever #1 clk = ~clk;
        end

        initial begin
            $dumpfile("DataMemory_tb.vcd");    //生成的vcd文件名称
            $dumpvars(0, DataMemory_tb);       //要记录的信号  0代表所有
        end

        initial begin
            addr = 32'b0;
            MemOp = 3'b000;
            MemWrite = 1'b1;
            WriteData = 32'hff;
            #2;
            addr = 32'b10;
            MemOp = 3'b001;
            MemWrite = 1'b1;
            WriteData = 32'heeee;
            #2;
            addr = 32'b100;
            MemOp = 3'b000;
            MemWrite = 1'b0;
            #2;
            // addr = 32'b0;
            // MemOp = 3'b001;
            // #2;
            $finish();
        end




endmodule