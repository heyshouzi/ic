module Bubble (
    input MemRead_ID_EX_in,
    input [4:0] rs1_ID_EX_in,
    input [4:0] rs2_ID_EX_in,
    input [4:0] rd_EX_MEM_in,
    output reg PCdelay,
    output reg Reg_MemWrite
    
);
    reg PCdelay_temp;
    reg Reg_MemWrite_temp;
    initial begin
        PCdelay_temp = 1'b0;
        Reg_MemWrite_temp= 1'b1;
    end
    always @(*) begin
        if(MemRead_ID_EX_in && (rs1_ID_EX_in == rd_EX_MEM_in || rs2_ID_EX_in == rd_EX_MEM_in))
            begin
                PCdelay_temp = 1'b1;
                Reg_MemWrite_temp = 1'b0;
            end
        else
            begin
                PCdelay_temp = 1'b0;
                Reg_MemWrite_temp = 1'b1;
            end
        PCdelay = PCdelay_temp;
        Reg_MemWrite = Reg_MemWrite_temp;
    end
endmodule