`timescale 1ns / 1ps


module mult
    #
    (
       parameter dataWidth = 18,
       parameter fracWidth = 14
    )
    (
        input [dataWidth-1:0] in1, in2,
        output [2*dataWidth-1:0] product
    );
    
    assign product = (in1*in2)>>>fracWidth;
    
endmodule
