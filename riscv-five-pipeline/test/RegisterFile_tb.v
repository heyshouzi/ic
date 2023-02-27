`timescale 1ns/1ps
module RegisterFile_tb ();
    reg clk;                        //时钟信号
    reg reset;                        //复位信号  
    reg RegWrite;                     //CU控制单元发出的控制信号，1表示可以将数据写入该寄存器组，0表示不能将数据写入该寄存器组
    reg  [4:0]  ReadRegister1;        //rs1寄存器输入端口
    reg  [4:0]  ReadRegister2;        //rs2寄存器输入端口
    reg  [4:0]  WriteRegister;       //rd寄存器输入端口
    reg  [31:0] WriterData;           //要写入rd寄存器的数据   
    wire [31:0] ReadData1;            //r1寄存器输出数据的端口
    wire [31:0] ReadData2;             //r2寄存器输出数据的端口

    //声明寄存器组设计单元
    RegisterFile uut(
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .ReadRegister1(ReadRegister1),
        .ReadRegister2(ReadRegister2),
        .WriteRegister(WriteRegister),
        .WriterData(WriterData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );



    //建立时钟
    initial begin
        clk = 0;
        forever # 50 clock = ~ clock;
    end

    initial begin
        //测试向x1寄存器写入数据‘2’
        reset = 1'b0;
        RegWrite = 1'b1;
        WriteRegister = 5'd1;
        WriterData = 32'd2;
        #50
    end


endmodule