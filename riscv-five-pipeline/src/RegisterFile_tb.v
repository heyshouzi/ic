`timescale 1ns/1ns                     //仿真时间单位/时间精度
module RegisterFile_tb;
    reg clk;                          //时钟信号
    reg reset;                        //复位信号  
    reg RegWrite;                    //CU控制单元发出的控制信号，1表示可以将数据写入该寄存器组，0表示不能将数据写入该寄存器组
    reg  [4:0]  ReadRegister1;        //rs1寄存器输入端口
    reg  [4:0]  ReadRegister2;        //rs2寄存器输入端口
    reg  [4:0]  WriteRegister;       //rd寄存器输入端口
    reg [31:0] RegWriteData;           //要写入rd寄存器的数据   
    wire [31:0] ReadData1;          //r1寄存器输出数据的端口
    wire [31:0] ReadData2;            //r2寄存器输出数据的端口

    //声明寄存器组设计单元
    RegisterFile dut(
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .ReadRegister1(ReadRegister1),
        .ReadRegister2(ReadRegister2),
        .WriteRegister(WriteRegister),
        .RegWriteData(RegWriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    //建立时钟
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
            $dumpfile("RegisterFile_tb.vcd");    //生成的vcd文件名称
            $dumpvars(0, RegisterFile_tb);       //要记录的信号  0代表所有

        //测试向x1寄存器写入数据‘2’
            reset = 1'b0;
            RegWrite = 1'b1;
            WriteRegister = 5'd1;
            RegWriteData = 32'd2;
            #5;
        //测试向x0寄存器写入数据‘2’
            reset = 1'b0;
            RegWrite = 1'b1;
            WriteRegister = 5'd0;
            RegWriteData = 32'd2;
            #5;
        //测试向x1寄存器读数据
            reset = 1'b0;
            RegWrite = 1'b0;
            ReadRegister1 = 5'd1;        
            #5;       
            $finish();
            end
endmodule