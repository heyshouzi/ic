module decode (
    input [31:0] Instruction,
    output [6:0] opcode,
    output [2:0] func3,
    output [6:0] func7,
    output [4:0] Rs1,
    output [4:0] Rs2,
    output [4:0] Rd
);
    assign opcode = Instruction[6:0];
    assign Rd     = Instruction[11:7];
    assign Rs1    = Instruction[19:15];
    assign Rs2    = Instruction[24:20];
    assign func3  = Instruction[14:12];
    assign func7  = Instruction[31:25]; 
endmodule