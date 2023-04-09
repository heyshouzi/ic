module forwarding (
    input [4:0] rs1_ID_EX_in,
    input [4:0] rs2_ID_EX_in,
    input [4:0] rd_EX_MEM_in,
    input [4:0] rd_MEM_WB_in,
    input RegWrite_EX_MEM_in,
    input RegWrite_MEM_WB_in,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);
    reg [1:0] forwardA_temp;
    reg [1:0] forwardB_temp;


    initial begin
        forwardA_temp = 2'b00;
        forwardB_temp = 2'b00;
    end   

    always @(*) begin
        
        if(RegWrite_EX_MEM_in && (rd_EX_MEM_in != 0) && rd_EX_MEM_in == rs1_ID_EX_in)
            forwardA_temp = 2'b10;
        else if(RegWrite_EX_MEM_in && (rd_EX_MEM_in != 0) && rd_EX_MEM_in == rs2_ID_EX_in)
            forwardB_temp = 2'b10;
        else if(RegWrite_EX_MEM_in && (rd_MEM_WB_in != 0) && rd_MEM_WB_in == rs1_ID_EX_in)
            forwardA_temp = 2'b01;
        else if(RegWrite_EX_MEM_in && (rd_MEM_WB_in != 0) && rd_MEM_WB_in == rs2_ID_EX_in)
            forwardB_temp = 2'b01;
        else begin
            forwardA_temp = 2'b00;
            forwardB_temp = 2'b00;
        end
        forwardA = forwardA_temp;
        forwardB = forwardB_temp;
    end


endmodule