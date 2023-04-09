module Bubble (
    input MemRead_ID_EX_in;
    input [4:0] rs1_ID_EX_in;
    input [4:0] rs2_ID_EX_in;
    input [4:0] rd_EX_MEM_in;
    output reg PCdelay;
    output reg RegWrite/MemWrite;
    
);
    reg PCdelay_temp;
    reg RegWrite/MemWrite_temp;
    initial begin
        PCdelay_temp = 1'b0;
        RegWrite/MemWrite_temp= 1'b1;
    end
    always @(*) begin
        if(MemRead_ID_EX_in && (rs1_ID_EX_in == rd_EX_MEM_in || rs2_ID_EX_in == rd_EX_MEM_in))
            begin
                PCdelay_temp = 1'b1;
                RegWrite/MemWrite_tmep = 1'b0;
            end
        else
            begin
                PCdelay_temp = 1'b0;
                RegWrite/MemWrite_temp = 1'b1;
            end
        PCdelay = PCdelay_temp;
        RegWrite/MemWrite = RegWrite/MemWrite_temp;
    end
endmodule