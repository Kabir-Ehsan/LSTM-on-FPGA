  
  
module mult_use
    #(
           parameter dataWidth = 16,
           parameter fracWidth = 14
     )
     (
        input clk,
        input signed [dataWidth - 1 : 0] a, // synthesis attribute keep a "true"
        input signed [dataWidth - 1 : 0] b, // synthesis attribute keep b "true"
        output signed [2*dataWidth - 1 : 0] p // synthesis attribute keep p "true"
     );

reg signed [2*dataWidth - 1 : 0] p_reg; 
reg signed [dataWidth - 1 : 0] a_reg; 
reg signed [dataWidth- 1 : 0] b_reg; 

always @ (posedge clk) begin
    //if (ce) begin
        a_reg <= a;
        b_reg <= b;
        p_reg <= $signed (a_reg) * $signed (b_reg);
    //end
end

//always @ (posedge clk) 
//begin
        assign p = p_reg;
//end

//assign p = $signed (a) * $signed (b);

endmodule