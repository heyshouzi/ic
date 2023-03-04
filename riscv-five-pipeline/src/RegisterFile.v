//该部分是实现32位的寄存器组，其包含了32个寄存器   riscv的第一个寄存器x0恒为0，不能改写数据
module RegisterFile (
    input clk,                          //时钟信号
    input reset,                        //复位信号 1 代表 复位
    input RegWrite,                     //CU控制单元发出的控制信号，1表示可以将数据写入该寄存器组，0表示不能将数据写入该寄存器组
    input  [4:0]  ReadRegister1,        //rs1寄存器输入端口
    input  [4:0]  ReadRegister2,        //rs2寄存器输入端口
    input  [4:0]  WriteRegister,        //rd寄存器输入端口
    input  [31:0] RegWriteData,           //要写入rd寄存器的数据   
    output  reg [31:0] ReadData1,            //r1寄存器输出数据的端口
    output  reg [31:0] ReadData2            //r2寄存器输出数据的端口
);
    reg [31:0] RegFiles [0:31];         //声明32个32位寄存器
    integer  i;
    //初始化寄存器组
    initial begin
        for(i = 0; i < 32; i= i+1)
            RegFiles[i] = 0;
    end
    
    //复位
    always @(posedge reset)begin
        if(reset)
            begin
                for(i = 0; i < 32; i= i+1)
                RegFiles[i] = 0;
            end
    end
    //组合逻辑读出
    assign ReadData1 = RegFiles[ReadRegister1];
    assign ReadData2 = RegFiles[ReadRegister2];

    //时钟上升沿写入
    always @(posedge clk) begin
        if(RegWrite)
            if(WriteRegister != 5'b0)      //允许编号不为0的寄存器写入数据
                RegFiles[WriteRegister] <= RegWriteData;
    end

    // //  时钟后半部分读出
    // always @(posedge clk) begin
    //     ReadData1 <= RegFiles[ReadRegister1];
    //     ReadData2 <= RegFiles[ReadRegister2];
    // end

endmodule