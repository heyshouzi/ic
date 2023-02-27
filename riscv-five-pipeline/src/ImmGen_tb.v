`include "riscv.v"
`timescale 1ns/1ps
module ImmGen_tb();
    reg [6:0] opcode;
    reg [31:0] Instruction;
    wire [31:0] ImmGenOut;
    ImmGen dut(
        .opcode(opcode),
        .Instruction(Instruction),
        .ImmGenOut(ImmGenOut)
    );


    initial begin
        $dumpfile("ImmGen_tb.vcd");    //生成的vcd文件名称
        $dumpvars(0, ImmGen_tb);       //要记录的信号  0代表所有
        end

    initial begin
        opcode = Jalr;
        Instruction = 32'b1000010000000011100111;    //d2
        #1;
        opcode = Il_Type;
        Instruction = 32'b1000010000000010000011;    //d2
        #1;
        opcode = I_Type;
        Instruction = 32'b1000010000000010010011;    //d2
        #1;
        opcode = S_Type;
        Instruction = 32'b10001000001100000010100011;  //100001 d33
        #1;
        opcode = lui;
        Instruction = 32'b1000010110111;   //1 0000 0000 0000 4096
        #1;
        opcode = auipc;
        Instruction = 32'b1000010010111;   //4096
        #1;
        opcode = B_Type;
        Instruction = 32'b00000010001000001000000101100011;  // 10 0010 34
        #1;
        opcode = Jal;
        Instruction = 32'b1000011101111;  // 4096
        #1;
        $finish();
    end



endmodule