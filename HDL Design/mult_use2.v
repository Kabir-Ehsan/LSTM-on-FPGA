`timescale 1ns / 1ps
  
(* keep_hierarchy = "yes" *)  
(* use_dsp="no" *)
module mult_use2
    #(
           parameter dataWidth = 16,
           parameter fracWidth = 14
     )
     (
        input clk,
        input rst,
        input ce,
        input signed [dataWidth - 1 : 0] a, // synthesis attribute keep a "true"
        input signed [dataWidth - 1 : 0] b, // synthesis attribute keep b "true"
        output signed [2*dataWidth - 1 : 0] p // synthesis attribute keep p "true"
        //output multEnd
     );

(* keep = "true" *) reg signed [2*dataWidth - 1 : 0] p_reg1;
(* keep = "true" *) reg signed [2*dataWidth - 1 : 0] p_reg2;
(* keep = "true" *) reg signed [2*dataWidth - 1 : 0] p_reg3; 

(* keep = "true" *) reg signed [dataWidth - 1 : 0] a_reg; 
(* keep = "true" *) reg signed [dataWidth- 1 : 0] b_reg; 

always @ (posedge clk) begin
    if(rst == 0)
    begin
        a_reg <= 0;
        b_reg <= 0;
        p_reg1 <= 0;
        //p_reg2 <= 0;
        //p_reg3 <= 0;
    end
    else 
    begin
        if (ce)
        begin
            a_reg <= a;
            b_reg <= b;
            p_reg1 <= a_reg*b_reg; //$signed (a_reg) * $signed (b_reg);
        end
    end
end

always @ (posedge clk) 
begin
    if(rst == 0)
    begin
        //a_reg <= 0;
        //b_reg <= 0;
        //p_reg1 <= 0;
        p_reg2 <= 0;
        p_reg3 <= 0;
    end
    else
       if (ce)
       begin 
            p_reg2 <= p_reg1;
            p_reg3 <= p_reg2;
       end
end
assign p = p_reg3;
//assign p = $signed (a) * $signed (b);

endmodule