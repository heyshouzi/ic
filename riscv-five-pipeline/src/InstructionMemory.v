module InstructionMemory (
    input clk,
    input [31:0] InstAddr,
    output reg [31:0]Instruction
);
    reg [7:0] rom [255:0];

    initial begin
        $readmemb("./rom_binary_file.txt",rom);
    end

    always @(posedge clk) begin
        Instruction <= {rom[InstAddr+3],rom[InstAddr+2],rom[InstAddr+1],rom[InstAddr]};
    end
   
endmodule