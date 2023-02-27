module top (
    input clk,
    input reset,
    input  [31:0] Instruction,
    output reg [31:0] InstAddr
    
);

    // wire [31:0] Instruction;
    wire [31:0] MemReadDataOut;
    // wire [31:0] InstAddr;
    wire [31:0] DataAddr;
    wire [2:0] MemOp;
    wire [31:0] MemDataIn;
    wire MemRead;
    wire MemWrite;
    
    RiscvCore core (
        .clk(clk),
        .reset(reset),
        .Instruction(Instruction),
        .MemReadDataOut(MemReadDataOut),
        .InstAddr(InstAddr),
        .DataAddr(DataAddr),
        .MemOp(MemOp),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemDataIn(MemDataIn)
    );

    // InstructionMemory im (
    //     .clk(clk),
    //     .InstAddr(InstAddr),
    //     .Instruction(Instruction)
    // );

    DataMemory dm (
        .clk(clk),
        .MemOp(MemOp),
        .DataAddr(DataAddr),
        .WriteData(MemDataIn),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemReadDataOut(MemReadDataOut)
    );



endmodule