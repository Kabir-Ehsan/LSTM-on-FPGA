`timescale 1ns / 1ps


//(* keep_hierarchy = "yes" *)
module add2Element2
    #
    (
       parameter dataWidth = 16,
       parameter fracWidth = 12
    ) 
    (
       m1, m2, m4, clk, rst
    );
  input clk;
  input rst;
  input  [dataWidth-1:0] m1;
  input  [(dataWidth-1)/2-1:0] m2;
  //input signed [dataWidth-1:0] m3;
  output  [dataWidth-1:0] m4;
  
  reg  [dataWidth-1:0] m5;
  
 
  always@(posedge clk)
  begin
    if (rst == 0)
    begin
        m5 <= 0;
    end
    else
        m5 <= m1 + m2;
    //$monitor("SUM after Bias addition: %d", m4);
  end
    
   assign m4 = m5;
     
endmodule
