//该模块的功能是确定下一个周期在哪个地址取指
module npc (
    input [31:0] ImmGenOut,
    input [31:0] ReadData1,
    input [31:0] pc,    
    input PCASrc,
    input PCBSrc,            
    output [31:0] npc      //下一个pc
);
    wire [31:0] PCA;
    wire [31:0] PCB;
    assign PCA = (PCASrc == 1'b1)?ImmGenOut:4;
    assign PCB = (PCBSrc == 1'b1)?pc:ReadData1;
    assign npc = PCA + PCB;
endmodule