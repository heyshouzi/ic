`timescale 1ns/1ps

module BranchControl_tb();
    reg [2:0] Branch;
    reg Less;
    reg Zero;
    wire PCASrc;
    wire PCBSrc;



    BranchControl dut(
        .Branch(Branch),
        .Less(Less),
        .Zero(Zero),
        .PCASrc(PCASrc),
        .PCBSrc(PCBSrc)
    );
    initial begin
            $dumpfile("BranchControl_tb.vcd");    //生成的vcd文件名称
            $dumpvars(0, BranchControl_tb);       //要记录的信号  0代表所有
        end

    initial begin
        Branch = 3'b000;
        Zero = 0;
        Less = 0;
        #1;
        // Branch = 3'b001;
        // #1;
        // Branch = 3'b010;
        // #1;
        // Branch = 3'b100;
        // Zero = 0;
        // #1;
        // Branch = 3'b100;
        // Zero = 1;
        // #1;
        // Branch = 3'b110;
        // Zero = 0;
        // Less = 0;
        // #1;
        // Branch = 3'b110;
        // Zero = 0;
        // Less = 1;
        // #1;
        // Branch = 3'b111;
        // Zero = 0;
        // Less = 0;
        // #1;
        // Branch = 3'b111;
        // Zero = 0;
        // Less = 1;
        // #1;

        $finish();


    end

    


endmodule