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
    wire [31:0] Instruction_IF_ID_out;
    wire [31:0] pc_IF_ID_out;




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

    pc u_pc(
        .clk(clk),
        .reset(reset),
        .npc(npc),
        .pc(InstAddr)
    );


    IF_ID u_IF_ID(
        .clk(clk),
        .reset(reset),
        .pc_line_in(pc),
        .instruction_data_in(Instruction),
        .pc_line_out(pc_IF_ID_out),
        .instruction_data_out(Instruction_IF_ID_out)
    );

    decode u_decode(
        .Instruction(Instruction_IF_ID_out),
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
    

    ImmGen u_ImmGen(
        .Instruction(Instruction_IF_ID_out),
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

    ID_EX u_ID_EX(
        .clk(clk),
        .reset(reset),
        .imm_line_in(ImmGenOut),
        .RegWrite_line_in(RegWrite),
        .Branch_line_in(Branch),
        .MemWrite_line_in(MemWrite),
        .MemtoReg_line_in(MemtoReg),
        .MemOp_line_in(MemOp),
        .MemRead_line_in(MemRead),
        .ALUASrc_line_in(ALUASrc),
        .ALUBSrc_line_in(ALUBSrc),
        .ALUCtl_line_in(ALUCtl),
        .pc_line_in(pc_IF_ID_out),
        .ReadData1_line_in(ReadData1),
        .ReadData2_line_in(ReadData2),
        .rs1_line_in(Rs1),
        .rs2_line_in(Rs2),
        .rd_line_in(Rd),
        .imm_line_out(ImmGenOut_ID_EX_out),
        .RegWrite_line_out(RegWrite_ID_EX_out),
        .Branch_line_out(Branch_ID_EX_out),
        .MemWrite_line_out(MemWrite_ID_EX_out),
        .MemtoReg_line_out(MemtoReg_ID_EX_out),
        .MemOp_line_out(MemOp_ID_EX_out),
        .MemRead_line_out(MemRead_ID_EX_out),
        .ALUASrc_line_out(ALUASrc_ID_EX_out),
        .ALUBSrc_line_out(ALUBSrc_ID_EX_out),
        .ALUCtl_line_out(ALUCtl_ID_EX_out),
        .pc_line_out(pc_ID_EX_out),
        .ReadData1_line_out(ReadData1_ID_EX_out),
        .ReadData2_line_out(ReadData2_ID_EX_out),
        .rs1_line_out(rs1_ID_EX_out),
        .rs2_line_out(rs2_ID_EX_out),
        .rd_line_out(rd_ID_EX_out)
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
        .MemOp_line_in(MemOp_ID_EX_out), 
        .MemRead_line_in(MemRead_ID_EX_out), 
        .MemWrite_line_in(MemWrite_ID_EX_out), 
        .ReadData2_line_in(ReadData2_ID_EX_out), 
        .Branch_line_in(Branch_ID_EX_out), 
        .Less_line_in(Less), 
        .Zero_line_in(Zero), 
        .ALUResult_line_in(ALUResult), 
        .RegWrite_line_in(RegWrite_ID_EX_out),
        .rs1_line_in(rs1_ID_EX_out),
        .rs2_line_in(rs2_ID_EX_out),
        .rd_line_in(rd_ID_EX_out), 
        .MemtoReg_line_in(MemtoReg_ID_EX_out),
        .MemOp_line_out(MemOp_EX_MEM_out), 
        .MemRead_line_out(MemRead_EX_MEM_out), 
        .MemWrite_line_out(MemWrite_EX_MEM_out), 
        .ReadData2_line_out(ReadData2_EX_MEM_out), 
        .Branch_line_out(Branch_EX_MEM_out), 
        .Zero_line_out(Zero_EX_MEM_out), 
        .Less_line_out(Less_EX_MEM_out), 
        .ALUResult_line_out(ALUResult_EX_MEM_out), 
        .RegWrite_line_out(RegWrite_EX_MEM_out), 
        .rs1_line_out(rs1_EX_MEM_out),
        .rs2_line_out(rs2_EX_MEM_out),
        .rd_line_out(rd_EX_MEM_out), 
        .MemtoReg_line_out(MemtoReg_EX_MEM_out)
    );

        assign DataAddr = ALUResult_EX_MEM_out;
        assign MemDataIn = ReadData2_EX_MEM_out;

    MEM_WB u_MEM_WB (
        .clk(clk),
        .reset(reset),
        .MemReadData_line_in(MemReadDataOut),
        .ALUResult_line_in(ALUResult_EX_MEM_out),
        .MemtoReg_line_in(MemtoReg_EX_MEM_out),
        .RegWrite_line_in(RegWrite_EX_MEM_out),
        .rs1_line_in(rs1_EX_MEM_out),
        .rs2_line_in(rs2_EX_MEM_out),
        .rd_line_in(rd_EX_MEM_out),
        .MemtoReg_line_out(MemtoReg_MEM_WB_out),
        .RegWrite_line_out(RegWrite_MEM_WB_out),
        .rs1_line_out(rs1_MEM_WB_out),
        .rs2_line_out(rs2_MEM_WB_out),
        .rd_line_out(rd_MEM_WB_out),
        .MemReadData_line_out(MemReadData_MEM_WB_out),
        .ALUResult_line_out(ALUResult_MEM_WB_out)

    );
    WriteBack u_WriteBack(
        .ALUResult(ALUResult_MEM_WB_out),
        .MemReadDataOut(MemReadData_MEM_WB_out),
        .MemtoReg(MemtoReg_MEM_WB_out),
        .RegWriteData(RegWriteData)
    );

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
    



endmodule