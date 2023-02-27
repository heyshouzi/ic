module RiscvCore (
    input clk,
    input reset,
    input [31:0] Instruction,
    input [31:0] MemReadDataOut,
    output [31:0] InstAddr,
    output [31:0] DataAddr,
    output [2:0] MemOp,
    output MemRead,
    output MemWrite,
    output [31:0] MemDataIn
);

    //pc
    reg [31:0] pc;


    // decode
    wire [6:0] opcode;
    wire [2:0] func3;
    wire [6:0] func7;
    wire [4:0] Rs1;
    wire [4:0] Rs2;
    wire [4:0] Rd;
 


    // ImmGenOut
    wire [31:0] ImmGenOut;

    //ControlUnit
    wire RegWrite;
    wire [2:0] Branch;
    wire MemtoReg;
    wire MemWrite;
    wire [2:0] MemOp;
    wire MemRead;
    wire ALUASrc;
    wire [1:0] ALUBSrc;
    wire [3:0] ALUCtl;


    //RegisterFile
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;


    //ALU
    wire [31:0] ALUResult;
    wire Zero;
    wire Less;


    //npc
    wire [31:0] npc;


    // BranchControl
    wire PCASrc;
    wire PCBSrc;


    //WriteBack
    wire [31:0] RegWriteData;

    pc u_pc(
        .clk(clk),
        .reset(reset),
        .npc(npc),
        .pc(InstAddr)
    );


    decode u_decode(
        .Instruction(Instruction),
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .Rs1(Rs1),
        .Rs2(Rs2),
        .Rd(Rd)
    );


    RegisterFile u_RegisterFile(
        .clk(clk),                     
        .reset(reset),                      
        .RegWrite(RegWrite),                   
        .ReadRegister1(Rs1),    
        .ReadRegister2(Rs2),   
        .WriteRegister(Rd),   
        .RegWriteData(RegWriteData),              
        .ReadData1(ReadData1),          
        .ReadData2(ReadData2)
    );
    assign MemDataIn = ReadData2;

    ImmGen u_ImmGen(
        .clk(clk),
        .Instruction(Instruction),
        .opcode(opcode),
        .ImmGenOut(ImmGenOut)
    );

   
    ControlUnit u_ControlUnit(
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .RegWrite(RegWrite),
        .Branch(Branch),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .MemOp(MemOp),
        .MemRead(MemRead),
        .ALUASrc(ALUASrc),
        .ALUBSrc(ALUBSrc),
        .ALUCtl(ALUCtl)
    );



    ALU u_ALU(
        .clk(clk),
        .ALUASrc(ALUASrc),
        .ALUBSrc(ALUBSrc),
        .ALUCtl(ALUCtl),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .pc(pc),
        .ImmGenOut(ImmGenOut),
        .ALUResult(ALUResult),
        .Zero(Zero),
        .Less(Less)
    );

    assign DataAddr = ALUResult;

    BranchControl u_BranchControl(
        .Branch(Branch),
        .Less(Less),
        .Zero(Zero),
        .PCASrc(PCASrc),
        .PCBSrc(PCBSrc)
    );
    


    npc u_npc(
        .ImmGenOut(ImmGenOut),
        .ReadData1(ReadData1),
        .pc(pc),
        .PCASrc(PCASrc),
        .PCBSrc(PCBSrc),
        .npc(npc)
    );



    WriteBack u_WriteBack(
        .clk(clk),
        .ALUResult(ALUResult),
        .MemReadDataOut(MemReadDataOut),
        .MemtoReg(MemtoReg),
        .RegWriteData(RegWriteData)
    );



endmodule