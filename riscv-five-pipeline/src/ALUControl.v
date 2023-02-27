localparam  ALU_ADD  = 4'b0000; 
localparam  ALU_SUB  = 4'b1000; 
localparam  ALU_SLL  = 4'b0001; 
localparam  ALU_SLT  = 4'b0010; 
localparam  ALU_XOR  = 4'b0100; 
localparam  ALU_SRL  = 4'b0101; 
localparam  ALU_SRA  = 4'b1101; 
localparam  ALU_OR   = 4'b0110; 
localparam  ALU_AND  = 4'b0111; 

module ALUControl (
    input        clk,
    input  [1:0] ALUOp,
    input  [3:0] DataIn,  //instruction[30,14-12]
    output [3:0] ALUCtl,  //ALU控制信号
);
    always @(*)
     begin
        casex(ALUOp)
          2'b00: ALUCtl =  ALU_ADD;
          2'b01: ALUCtl =  ALU_SUB;
          2'b1x: 
            begin
                if     (DataIn == ALU_ADD)   ALUCtl = ALU_ADD;
                else if(DataIn == ALU_SUB)   ALUCtl = ALU_SUB;  
                else if(DataIn == ALU_SLL)   ALUCtl = ALU_SLL;
                else if(DataIn == ALU_SLT)   ALUCtl = ALU_SLT;
                else if(DataIn == ALU_XOR)   ALUCtl = ALU_XOR;
                else if(DataIn == ALU_SRL)   ALUCtl = ALU_SRL;
                else if(DataIn == ALU_SRA)   ALUCtl = ALU_SRA;
                else if(DataIn == ALU_OR )   ALUCtl = ALU_OR ;
                else if(DataIn == ALU_AND)   ALUCtl = ALU_AND;
                else                         ALUCtl = 4'd0;
            end
          default:  ALUCtl = 4'd0; 
        endcase
     end   
endmodule