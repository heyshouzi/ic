/* 这是一个ALU模块的代码，它实现了九种操作，分别是加、减、逻辑左移、小于则置位、异或、逻辑右移、算术右移、或、与。它有以下输入和输出：

输入：

ALUASrc：用于选择A输入端的数据来源，如果为1则选择PC，否则选择ReadData1。
ALUBSrc：用于选择B输入端的数据来源，包括ReadData2、ImmGenOut和4。
ALUCtl：用于选择ALU执行的操作，决定了ALUResult的计算方式。
ReadData1：来自寄存器堆的第一个数据输入。
ReadData2：来自寄存器堆的第二个数据输入。
pc：当前指令的地址。
ImmGenOut：立即数生成模块输出的值。
输出：

ALUResult：ALU执行的结果。
Zero：如果ALUResult为0，则Zero为1，否则为0。
Less：如果执行的是小于操作（SLT或SLTU），并且A小于B，则Less为1，否则为0。 */

module  ALU(
    input clk,
    input ALUASrc,
    input [1:0] ALUBSrc,             
    input [3:0] ALUCtl,  // 对 ALU 输入端所进行的操作
    input [31:0] ReadData1,
    input [31:0] ReadData2,
    input [31:0] pc,     
    input [31:0] ImmGenOut,
    output reg [31:0] ALUResult, // ALU 输出的结果
    output reg  Zero, 
    output reg Less // 在执行B型指令时设置为1，如果A < B，则为1，否则为0
);
     // 定义操作码
    parameter ALU_ADD = 4'b0000;
    parameter ALU_SUB = 4'b1000;
    parameter ALU_SLL = 4'b0001;
    parameter ALU_SLTU = 4'b1010;
    parameter ALU_SLT = 4'b0010;
    parameter ALU_XOR = 4'b0100;
    parameter ALU_SRL = 4'b0101;
    parameter ALU_SRA = 4'b1101;
    parameter ALU_OR = 4'b0110;
    parameter ALU_AND = 4'b0111;
    parameter ALU_LOADIMM = 4'b0011;

    reg[31:0] A,B;


    // 根据 ALUASrc 和 ALUBSrc 来确定 A 和 B 的值
    always @(*) begin       
            A = (ALUASrc)? pc:ReadData1;
            case (ALUBSrc)
                2'b00: B = ReadData2;
                2'b01: B = ImmGenOut;
                2'b10: B = 32'd4;
                default: B = 32'd0;
            endcase
        end

             

    // 根据 ALUCtl 来计算 ALUResult、Zero 和 Less
    always @(*) begin
        case(ALUCtl)        
            ALU_ADD:     
                ALUResult = A + B;
            ALU_SUB:     
                ALUResult = A - B; 
            ALU_OR :     
                ALUResult = A | B; 
            ALU_AND:     
                ALUResult = A & B;
            ALU_SLL:     
                ALUResult = A << B[4:0]; 
            ALU_SLT: 
                begin
                    Less      = $signed(A) < $signed(B);         
                    ALUResult = Less;
                end    
                
            ALU_SLTU: 
                begin
                    Less      = A < B;
                    ALUResult = Less; 
                end   
            ALU_XOR:     
                ALUResult = A ^ B; 
            ALU_SRL:     
                ALUResult = A >> B[4:0]; 
            ALU_SRA:     
                ALUResult = $signed(A) >>> B[4:0];             
            ALU_LOADIMM: 
                ALUResult = B;    
            default:     ALUResult = 32'd0;
        endcase

        Zero = (ALUResult == 0);
    end
 
endmodule