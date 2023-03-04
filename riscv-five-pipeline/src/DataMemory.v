module DataMemory (
    input clk,
    input [2:0] MemOp,
    input [31:0] DataAddr,
    input [31:0] WriteData,
    input MemRead,
    input MemWrite,
    output reg [31:0] MemReadDataOut
);
    reg [7:0] ram [0:255];
    reg [7:0]  read_data_b;
    reg [15:0] read_data_h;
    reg [31:0] read_data_w;
    integer i;
    initial begin
        for( i = 0; i < 256; i = i+1)
            begin
                ram[i] = 0;
            end
        //$readmemb("./ram_binary_file.txt",ram);
        $writememb("./ram_binary_file.txt",ram);
    end


    always @(DataAddr)
        begin
            read_data_w = {ram[DataAddr+3],ram[DataAddr+2],ram[DataAddr+1],ram[DataAddr]};
            read_data_b = read_data_w[7:0];
            read_data_h = read_data_w[15:0];
            case (MemOp)
                //4字节读写
                3'b010: MemReadDataOut = read_data_w;
                //2字节读写带符号扩展
                3'b001: MemReadDataOut = {{16{read_data_h[15]}},read_data_h[15:0]};
                //1字节读写带符号扩展
                3'b000: MemReadDataOut = {{24{read_data_b[7]}},read_data_b[7:0]};
                //2字节读写无符号扩展
                3'b101: MemReadDataOut = {{16{1'b0}},read_data_h[15:0]};
                //1字节读写无符号扩展
                3'b100: MemReadDataOut = {{24{1'b0}},read_data_b[7:0]};
                default: MemReadDataOut = 32'b0;
            endcase
        end

    always @(posedge clk)
        begin
            if(MemWrite)              
                begin
                    case (MemOp)
                        //4字节读写
                        3'b010: {ram[DataAddr+3],ram[DataAddr+2],ram[DataAddr+1],ram[DataAddr]} <=  WriteData;
                        //2字节读写带符号扩展
                        3'b001: {ram[DataAddr+3],ram[DataAddr+2],ram[DataAddr+1],ram[DataAddr]} <= {{16{WriteData[15]}},WriteData[15:0]};
                        //1字节读写带符号扩展
                        3'b000: {ram[DataAddr+3],ram[DataAddr+2],ram[DataAddr+1],ram[DataAddr]} <= {{24{WriteData[8]}},WriteData[7:0]};
                        //2字节读写无符号扩展
                        3'b101: {ram[DataAddr+3],ram[DataAddr+2],ram[DataAddr+1],ram[DataAddr]} <= {{16{1'b0}},WriteData[15:0]};
                        //1字节读写无符号扩展
                        3'b100: {ram[DataAddr+3],ram[DataAddr+2],ram[DataAddr+1],ram[DataAddr]} <= {{24{1'b0}},WriteData[7:0]};
                        default: {ram[DataAddr+3],ram[DataAddr+2],ram[DataAddr+1],ram[DataAddr]} <= 32'b0;
            endcase
                end
        end
    

endmodule