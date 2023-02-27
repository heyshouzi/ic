`timescale  1ns/1ps

module ALU_tb();
    reg clk;
    reg ALUASrc;
    reg [1:0] ALUBSrc;
    reg [3:0] ALUCtl;
    reg [31:0] ReadData1, ReadData2, pc, ImmGenOut;
    wire [31:0] ALUResult;
    wire Zero, Less;

    // 实例化被测模块
    ALU dut(.clk(clk), 
            .ALUASrc(ALUASrc), 
            .ALUBSrc(ALUBSrc), 
            .ALUCtl(ALUCtl),
            .ReadData1(ReadData1), 
            .ReadData2(ReadData2),
            .pc(pc), 
            .ImmGenOut(ImmGenOut),
            .ALUResult(ALUResult), 
            .Zero(Zero), 
            .Less(Less));

    initial begin
            $dumpfile("ALU_tb.vcd");    //生成的vcd文件名称
            $dumpvars(0, ALU_tb);       //要记录的信号  0代表所有
        end


    // 初始化
    initial begin
        clk = 0;
        ALUASrc = 0;
        ALUBSrc = 2'b00;
        ALUCtl = 4'b0000;
        ReadData1 = 32'h0000_0000;
        ReadData2 = 32'h0000_0000;
        pc = 32'h0000_0000;
        ImmGenOut = 32'h0000_0000;
        #10;
    end

    // 时钟信号
    always begin
        #5 clk = ~clk;
    end

    
    initial begin
    // 用于测试加法的输入
    ALUASrc = 0;
    ALUBSrc = 2'b00;
    ALUCtl = 4'b0000;
    ReadData1 = 32'd10;
    ReadData2 = 32'd20;
    pc = 32'd0;
    ImmGenOut = 32'd0;

    // 用于测试减法的输入
    #10;
    ALUASrc = 0;
    ALUBSrc = 2'b00;
    ALUCtl = 4'b1000;
    ReadData1 = 32'd100;
    ReadData2 = 32'd50;
    pc = 32'd0;
    ImmGenOut = 32'd0;

    // 用于测试逻辑左移的输入
    #10;
    ALUASrc = 1;
    ALUBSrc = 2'b01;
    ALUCtl = 4'b0001;
    ReadData1 = 32'd0;
    ReadData2 = 32'd0;
    pc = 32'd10;
    ImmGenOut = 32'd4;

    // 用于测试小于则置位的输入
    #10;
    ALUASrc = 0;
    ALUBSrc = 2'b00;
    ALUCtl = 4'b0010;
    ReadData1 = 32'd10;
    ReadData2 = 32'd20;
    pc = 32'd0;
    ImmGenOut = 32'd0;

    // 用于测试异或的输入
    #10;
    ALUASrc = 1;
    ALUBSrc = 2'b10;
    ALUCtl = 4'b0100;
    ReadData1 = 32'd0;
    ReadData2 = 32'd0;
    pc = 32'd0;
    ImmGenOut = 32'd5;

    // 用于测试逻辑右移的输入
    #10;
    ALUASrc = 0;
    ALUBSrc = 2'b01;
    ALUCtl = 4'b0101;
    ReadData1 = 32'd32;
    ReadData2 = 32'd0;
    pc = 32'd0;
    ImmGenOut = 32'd2;

    // 用于测试算术右移的输入
    #10;
    ALUASrc = 0;
    ALUBSrc = 2'b01;
    ALUCtl = 4'b1101;
    ReadData1 = 32'hffff_fffc;
    ReadData2 = 32'd0;
    pc = 32'd0;
    ImmGenOut = 32'd2;  //ffff_ffff

    //用于测试或的输入
    #10;
    ALUASrc = 0;
    ALUBSrc = 2'b00;
    ALUCtl = 4'b0110;
    ReadData1 = 32'd32;
    ReadData2 = 32'd0;
    pc = 32'd0;
    ImmGenOut = 32'd0;


    //用于测试与的输入
    #10;
    ALUASrc = 0;
    ALUBSrc = 2'b00;
    ALUCtl = 4'b0111;
    ReadData1 = 32'd32;
    ReadData2 = 32'd32;
    pc = 32'd0;
    ImmGenOut = 32'd0;
    
    
    #10;
    $finish();
    end

endmodule