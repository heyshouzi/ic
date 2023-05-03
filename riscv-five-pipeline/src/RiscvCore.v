module RiscvCore (
    input clk,
    input reset,
    input [31:0] Instruction,
    input [31:0] MemReadDataOut,
    output [31:0] InstAddr,
    output [31:0] DataAddr,
    output [2:0] MemOp_EX_MEM_out,
    output MemRead_EX_MEM_out,
    output MemWrite_EX_MEM_out,
    output [31:0] MemDataIn
);

    //pc
    reg [31:0] pc;

    // IF_ID
    wire [2:0] func3_IF_ID_out;
    wire [6:0] func7_IF_ID_out;
    wire [6:0] opcode_IF_ID_out;
    wire [4:0] rs1_IF_ID_out;
    wire [4:0] rs2_IF_ID_out;
    wire [4:0] rd_IF_ID_out;
    wire [31:0] pc_IF_ID_out;
    wire [31:0] instruction_IF_ID_out;


    // decode
    wire [6:0] opcode;
    wire [2:0] func3;
    wire [6:0] func7;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
 


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


    //ID_EX
    wire [31:0] ImmGenOut_ID_EX_out;
    wire  RegWrite_ID_EX_out;
    wire [2:0]Branch_ID_EX_out;
    wire MemWrite_ID_EX_out;
    wire MemtoReg_ID_EX_out;
    wire [2:0] MemOp_ID_EX_out;
    wire MemRead_ID_EX_out;
    wire ALUASrc_ID_EX_out;
    wire [1:0] ALUBSrc_ID_EX_out;
    wire [3:0] ALUCtl_ID_EX_out;
    wire [31:0] pc_ID_EX_out;
    wire [31:0] ReadData1_ID_EX_out;
    wire [31:0] ReadData2_ID_EX_out;
    wire [4:0] rs1_ID_EX_out;
    wire [4:0] rs2_ID_EX_out;
    wire [4:0] rd_ID_EX_out;

    //ALU
    wire [31:0] ALUResult;
    wire Zero;
    wire Less;


    //npc
    wire [31:0] npc;


    // BranchControl
    wire PCASrc;
    wire PCBSrc;

    //EX_MEM
    wire [2:0] MemOp_EX_MEM_out; 
    wire MemRead_EX_MEM_out; 
    wire MemWrite_EX_MEM_out; 
    wire [31:0] ReadData2_EX_MEM_out; 
    wire [2:0] Branch_EX_MEM_out; 
    wire Zero_EX_MEM_out; 
    wire Less_EX_MEM_out; 
    wire [31:0] ALUResult_EX_MEM_out; 
    wire RegWrite_EX_MEM_out; 
    wire [4:0] rs1_EX_MEM_out;
    wire [4:0] rs2_EX_MEM_out;
    wire [4:0] rd_EX_MEM_out; 
    wire MemtoReg_EX_MEM_out;



    //MEM_WB
    wire MemtoReg_MEM_WB_out;
    wire RegWrite_MEM_WB_out;
    wire [4:0] rs1_MEM_WB_out;
    wire [4:0] rs2_MEM_WB_out;
    wire [4:0] rd_MEM_WB_out;
    wire [31:0] MemReadData_MEM_WB_out;
    wire [31:0] ALUResult_MEM_WB_out;

    //WriteBack
    wire [31:0] RegWriteData;
    
    //forwarding
    wire [1:0] forwardA;
    wire [1:0] forwardB;

    //HazardDctectionUnit
    wire predictor;
    wire flush;

    //bubble
    wire Reg_MemWrite;
    wire PCdelay;

    
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
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd)
    );



    IF_ID u_IF_ID(
        .clk(clk),
        .reset(reset),
        .pc_IF_ID_in(pc),
        .instruction_IF_ID_in(Instruction),
        .flush(flush),
        .func3_IF_ID_in(func3),
        .func7_IF_ID_in(func7),
        .opcode_IF_ID_in(opcode),
        .rs1_IF_ID_in(rs1),
        .rs2_IF_ID_in(rs2),
        .rd_IF_ID_in(rd),
        .func3_IF_ID_out(func3_IF_ID_out),
        .func7_IF_ID_out(func7_IF_ID_out),
        .opcode_IF_ID_out(opcode_IF_ID_out),
        .rs1_IF_ID_out(rs1_IF_ID_out),
        .rs2_IF_ID_out(rs2_IF_ID_out),
        .rd_IF_ID_out(rd_IF_ID_out),
        .pc_IF_ID_out(pc_IF_ID_out),
        .instruction_IF_ID_out(instruction_IF_ID_out)

    );

    
    HazardDetection u_HazardDetection(
        .opcode(opcode_IF_ID_out),
        .PCASrc(PCASrc),
        .PCBSrc(PCBSrc),
        .predictor(predictor),
        .flush(flush)
    );

    ControlUnit u_ControlUnit(
        .opcode(opcode_IF_ID_out),
        .func3(func3_IF_ID_out),
        .func7(func7_IF_ID_out),
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


    RegisterFile u_RegisterFile(
        .clk(clk),                     
        .reset(reset),                      
        .RegWrite(RegWrite),                   
        .rs1(rs1_IF_ID_out),    
        .rs2(rs2_IF_ID_out),   
        .rd(rd_IF_ID_out),   
        .RegWriteData(RegWriteData),              
        .ReadData1(ReadData1),          
        .ReadData2(ReadData2)
    );
    

    ImmGen u_ImmGen(
        .Instruction(instruction_IF_ID_out),
        .opcode(opcode_IF_ID_out),
        .ImmGenOut(ImmGenOut)
    );

    Bubble u_Bubble(
        .MemRead_ID_EX_in(MemRead),
        .rs1_ID_EX_in(rs1_IF_ID_out),
        .rs2_ID_EX_in(rs2_IF_ID_out),
        .rd_EX_MEM_in(rd_ID_EX_out),
        .PCdelay(PCdelay),
        .Reg_MemWrite(Reg_MemWrite)
    );
    

    
    ID_EX u_ID_EX(
        .clk(clk),
        .reset(reset),
        .flush(flush),
        .imm_ID_EX_in(ImmGenOut),
        .RegWrite_ID_EX_in(RegWrite),
        .Branch_ID_EX_in(Branch),
        .MemWrite_ID_EX_in(MemWrite),
        .MemtoReg_ID_EX_in(MemtoReg),
        .MemOp_ID_EX_in(MemOp),
        .MemRead_ID_EX_in(MemRead),
        .ALUASrc_ID_EX_in(ALUASrc),
        .ALUBSrc_ID_EX_in(ALUBSrc),
        .ALUCtl_ID_EX_in(ALUCtl),
        .pc_ID_EX_in(pc_IF_ID_out),
        .ReadData1_ID_EX_in(ReadData1),
        .ReadData2_ID_EX_in(ReadData2),
        .rs1_ID_EX_in(rs1_IF_ID_out),
        .rs2_ID_EX_in(rs2_IF_ID_out),
        .rd_ID_EX_in(rd_IF_ID_out),
        .Reg_MemWrite(Reg_MemWrite),
        .imm_ID_EX_out(ImmGenOut_ID_EX_out),
        .RegWrite_ID_EX_out(RegWrite_ID_EX_out),
        .Branch_ID_EX_out(Branch_ID_EX_out),
        .MemWrite_ID_EX_out(MemWrite_ID_EX_out),
        .MemtoReg_ID_EX_out(MemtoReg_ID_EX_out),
        .MemOp_ID_EX_out(MemOp_ID_EX_out),
        .MemRead_ID_EX_out(MemRead_ID_EX_out),
        .ALUASrc_ID_EX_out(ALUASrc_ID_EX_out),
        .ALUBSrc_ID_EX_out(ALUBSrc_ID_EX_out),
        .ALUCtl_ID_EX_out(ALUCtl_ID_EX_out),
        .pc_ID_EX_out(pc_ID_EX_out),
        .ReadData1_ID_EX_out(ReadData1_ID_EX_out),
        .ReadData2_ID_EX_out(ReadData2_ID_EX_out),
        .rs1_ID_EX_out(rs1_ID_EX_out),
        .rs2_ID_EX_out(rs2_ID_EX_out),
        .rd_ID_EX_out(rd_ID_EX_out)
    );

    ALU u_ALU(
        .ALUASrc(ALUASrc_ID_EX_out),
        .ALUBSrc(ALUBSrc_ID_EX_out),
        .ALUCtl(ALUCtl_ID_EX_out),
        .ReadData1(ReadData1_ID_EX_out),
        .ReadData2(ReadData2_ID_EX_out),
        .pc(pc_ID_EX_out),
        .ImmGenOut(ImmGenOut_ID_EX_out),
        .forwardA(forwardA),
        .forwardB(forwardB),
        .ALUResult_EX_MEM_out(ALUResult_EX_MEM_out),
        .RegWriteData(RegWriteData),
        .ALUResult(ALUResult),
        .Zero(Zero),
        .Less(Less)
    );

    

    BranchControl u_BranchControl(
        .Branch(Branch_EX_MEM_out),
        .Less(Less_EX_MEM_out),
        .Zero(Zero_EX_MEM_out),
        .PCASrc(PCASrc),
        .PCBSrc(PCBSrc)
    );
    


    npc u_npc(
        .ImmGenOut(ImmGenOut_ID_EX_out),
        .ReadData1(ReadData1_ID_EX_out),
        .pc(pc_ID_EX_out),  
        .PCASrc(PCASrc),
        .PCBSrc(PCBSrc),
        .npc(npc)
    );

    EX_MEM u_EX_MEM(
        .clk(clk), 
        .reset(reset), 
        .flush(flush),
        .MemOp_EX_MEM_in(MemOp_ID_EX_out), 
        .MemRead_EX_MEM_in(MemRead_ID_EX_out), 
        .MemWrite_EX_MEM_in(MemWrite_ID_EX_out), 
        .ReadData2_EX_MEM_in(ReadData2_ID_EX_out), 
        .Branch_EX_MEM_in(Branch_ID_EX_out), 
        .Less_EX_MEM_in(Less), 
        .Zero_EX_MEM_in(Zero), 
        .ALUResult_EX_MEM_in(ALUResult), 
        .RegWrite_EX_MEM_in(RegWrite_ID_EX_out),
        .rs1_EX_MEM_in(rs1_ID_EX_out),
        .rs2_EX_MEM_in(rs2_ID_EX_out),
        .rd_EX_MEM_in(rd_ID_EX_out), 
        .MemtoReg_EX_MEM_in(MemtoReg_ID_EX_out),
        .MemOp_EX_MEM_out(MemOp_EX_MEM_out), 
        .MemRead_EX_MEM_out(MemRead_EX_MEM_out), 
        .MemWrite_EX_MEM_out(MemWrite_EX_MEM_out), 
        .ReadData2_EX_MEM_out(ReadData2_EX_MEM_out), 
        .Branch_EX_MEM_out(Branch_EX_MEM_out), 
        .Zero_EX_MEM_out(Zero_EX_MEM_out), 
        .Less_EX_MEM_out(Less_EX_MEM_out), 
        .ALUResult_EX_MEM_out(ALUResult_EX_MEM_out), 
        .RegWrite_EX_MEM_out(RegWrite_EX_MEM_out), 
        .rs1_EX_MEM_out(rs1_EX_MEM_out),
        .rs2_EX_MEM_out(rs2_EX_MEM_out),
        .rd_EX_MEM_out(rd_EX_MEM_out), 
        .MemtoReg_EX_MEM_out(MemtoReg_EX_MEM_out)
    );

        assign DataAddr = ALUResult_EX_MEM_out;
        assign MemDataIn = ReadData2_EX_MEM_out;

    forwarding u_forwarding(
        .rs1_ID_EX_in(rs1_ID_EX_out),
        .rs2_ID_EX_in(rs2_ID_EX_out),
        .rd_EX_MEM_in(rd_EX_MEM_out),
        .rd_MEM_WB_in(rd_MEM_WB_out),
        .RegWrite_EX_MEM_in(RegWrite_EX_MEM_out),
        .RegWrite_MEM_WB_in(RegWrite_MEM_WB_out),
        .forwardA(forwardA),
        .forwardB(forwardB)
    );


    MEM_WB u_MEM_WB (
        .clk(clk),
        .reset(reset),
        .MemReadData_MEM_WB_in(MemReadDataOut),
        .ALUResult_MEM_WB_in(ALUResult_EX_MEM_out),
        .MemtoReg_MEM_WB_in(MemtoReg_EX_MEM_out),
        .RegWrite_MEM_WB_in(RegWrite_EX_MEM_out),
        .rs1_MEM_WB_in(rs1_EX_MEM_out),
        .rs2_MEM_WB_in(rs2_EX_MEM_out),
        .rd_MEM_WB_in(rd_EX_MEM_out),
        .MemtoReg_MEM_WB_out(MemtoReg_MEM_WB_out),
        .RegWrite_MEM_WB_out(RegWrite_MEM_WB_out),
        .rs1_MEM_WB_out(rs1_MEM_WB_out),
        .rs2_MEM_WB_out(rs2_MEM_WB_out),
        .rd_MEM_WB_out(rd_MEM_WB_out),
        .MemReadData_MEM_WB_out(MemReadData_MEM_WB_out),
        .ALUResult_MEM_WB_out(ALUResult_MEM_WB_out)
    );
    WriteBack u_WriteBack(
        .ALUResult(ALUResult_MEM_WB_out),
        .MemReadDataOut(MemReadData_MEM_WB_out),
        .MemtoReg(MemtoReg_MEM_WB_out),
        .RegWriteData(RegWriteData)
    );


endmodule