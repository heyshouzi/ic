`timescale 1ns/1ns
module npc_tb();
    reg [31:0] ImmGenOut;
    reg [31:0] ReadData1;
    reg [31:0] pc;
    reg PCASrc;
    reg PCBSrc;
    wire [31:0] npc;
    npc dut(
        .ImmGenOut(ImmGenOut),
        .ReadData1(ReadData1),
        .pc(pc),
        .PCASrc(PCASrc),
        .PCBSrc(PCBSrc),
        .npc(npc)
    );



        initial begin
            $dumpfile("npc_tb.vcd");    //生成的vcd文件名称
            $dumpvars(0, npc_tb);       //要记录的信号  0代表所有
        end

        initial begin
            ImmGenOut = 32'b1;
            ReadData1 = 32'b10;
            pc = 32'b100;
            PCASrc = 1;
            PCBSrc = 0;
            #2;
            PCASrc = 0;
            PCBSrc = 1;
            #2;
            PCASrc = 0;
            PCBSrc = 0;
            #2;
            PCASrc = 1;
            PCBSrc = 1;
            #2;    
             $finish();
        end

endmodule