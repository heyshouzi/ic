module decode (
    input [31:0] Instruction,
    output reg [6:0] opcode,
    output  reg [2:0] func3,
    output  reg [6:0] func7,
    output  reg [4:0] Rs1,
    output  reg [4:0] Rs2,
    output  reg [4:0] Rd
);
    parameter R_Type  =   7'b0110011;
    parameter I_Type  =   7'b0010011;
    parameter Il_Type =   7'b0000011;
    parameter S_Type  =   7'b0100011;
    parameter B_Type  =   7'b1100011;
    parameter lui     =   7'b0110111;
    parameter auipc   =   7'b0010111;
    parameter Jal     =   7'b1101111;
    parameter Jalr    =   7'b1100111;
    always @(*) begin
        opcode = Instruction[6:0];
        case (opcode)
            Jalr: 
                begin
                    Rd     = Instruction[11:7];
                    Rs1    = Instruction[19:15];
                    func3  = Instruction[14:12];
                end
            Jal:
                begin
                    Rd     = Instruction[11:7];
                end
            auipc:
                begin
                    Rd     = Instruction[11:7];
                end
            lui:
                begin
                    Rd     = Instruction[11:7];
                end 
            B_Type:
                begin
                    Rs1    = Instruction[19:15];
                    Rs2    = Instruction[24:20];
                    func3  = Instruction[14:12];
                end
            S_Type:
                begin
                    Rs1    = Instruction[19:15];
                    Rs2    = Instruction[24:20];
                    func3  = Instruction[14:12];
                end 
            Il_Type:
                begin
                    Rd     = Instruction[11:7];
                    Rs1    = Instruction[19:15];
                    func3  = Instruction[14:12];
                end
            I_Type:
                begin
                    Rd     = Instruction[11:7];
                    Rs1    = Instruction[19:15];
                    func3  = Instruction[14:12];
                end
            R_Type:
                begin
                    Rd     = Instruction[11:7];
                    Rs1    = Instruction[19:15];
                    Rs2    = Instruction[24:20];
                    func3  = Instruction[14:12];
                end
            default: 
                begin
                    Rd     = Instruction[11:7];
                    Rs1    = Instruction[19:15];
                    Rs2    = Instruction[24:20];
                    func3  = Instruction[14:12];
                end
        endcase
    end
    assign func7  = Instruction[31:25]; 
endmodule