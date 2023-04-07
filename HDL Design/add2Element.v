`timescale 1ns / 1ps



module add2Element
    #
    (
       parameter dataWidth = 16,
       parameter fracWidth = 14
    ) 
    (
        clk, m1, m2, m4
    );
  input clk;
  input signed [dataWidth-1:0] m1;
  input signed [(dataWidth-1)/2-1:0] m2;
  //input signed [dataWidth-1:0] m3;
  output signed [dataWidth:1] m4;
  
  assign m4 = m1 + m2;
  //always@(clk)
  //begin
    //m4 <= m1 + m2;
    //$monitor("SUM after Bias addition: %d", m4);
  //end
    
endmodule
