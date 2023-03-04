`timescale 1ns / 1ps

module top_tb();

    reg clk;
    reg reset;
    reg [31:0] Instruction;

    wire [31:0] InstAddr;
    
    top dut (
        .clk(clk),
        .reset(reset),
        .InstAddr(InstAddr),
        .Instruction(Instruction)
    );

    initial begin
            $dumpfile("top_tb.vcd"); //生成的vcd文件名称
            $dumpvars(0, top_tb);    //要记录的信号  0代表所有
           
            
        end

      //建立时钟
        initial begin
            clk = 0;
            forever #5 clk = ~clk;
        end

    // // Reset the top module
    initial begin
        reset = 0;
    end

    initial begin
        Instruction = 32'b11111111111111111111_00010_0110111; //lui x2,0xfffff  x2 = 0xfffff000
        $monitor("x0=%h,x2=%h",dut.core.u_RegisterFile.RegFiles[0],dut.core.u_RegisterFile.RegFiles[2]); 
        #10;
        // Instruction = 32'b0000000_00010_00000_010_00010_0100011; //sw   x[2] >> M[x0]+2
        // #10;
        Instruction =32'b11111111111111111110_00001_0110111; //lui x1,0xffffe  x1 = 0xffffe000
       
        $monitor("x0=%h,x1=%h",dut.core.u_RegisterFile.RegFiles[0],dut.core.u_RegisterFile.RegFiles[1]); 
        #10;
        // Instruction = 32'b000000000010_00010_000_00010_0010011; // addi x2, x0, 2   x2 = 0xfffff002
        // $monitor("x0=%h,x2=%h",dut.core.u_RegisterFile.RegFiles[0],dut.core.u_RegisterFile.RegFiles[2]);
        // #10;
        // Instruction = 32'b000000_000100_00010_001_00011_0010011; // slli x3, x2, 4  x3 = 0xfffff020
        // $monitor("x2=%h,x3=%h",dut.core.u_RegisterFile.RegFiles[2],dut.core.u_RegisterFile.RegFiles[3]);
        // #10;
        // Instruction = 32'b000000000001_00011_000_00011_0010011; // addi x3, x3, 1  x3 = 0xfffff021
        // $monitor("x2=%h,x3=%h",dut.core.u_RegisterFile.RegFiles[2],dut.core.u_RegisterFile.RegFiles[3]);
        // #10;
        // Instruction = 32'b000000000001_00011_000_00011_0010011; // auipc x2, 0xf  x2 = pc + 0xf000
        // $monitor("x2=%h,x3=%h",dut.core.u_RegisterFile.RegFiles[2],dut.core.u_RegisterFile.RegFiles[3]);
        // #10;
        // Instruction = 32'b000000000010_00000_000_00011_0010011; // addi x3, x2, 2
        // #10;
        Instruction = 32'b0000000_00010_00010_000_00100_0110011; // add x4, x2, x1
        #100;
        $finish;
    end

endmodule