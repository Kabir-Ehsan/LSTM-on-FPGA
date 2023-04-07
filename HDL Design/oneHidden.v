`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2022 03:17:58 PM
// Design Name: 
// Module Name: oneHidden
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module oneHidden
    #(
        parameter dataWidth = 5,
        parameter fracWidth = 2,
        //parameter inputSize = 1,
        parameter hiddenSize = 3,
        //parameter inWeightSize = 1,
        parameter reWeightSize = 3,
        parameter act = "tangent"
    )
    (
        input clk,
        input rst,
        //input [dataWidth*inputSize-1:0] In,
        input [dataWidth*hiddenSize-1:0] hid,
        //input [dataWidth*inWeightSize-1:0] InW,
        input [dataWidth*reWeightSize-1:0] ReW,
        //input [dataWidth*hiddenSize-1:0] b,
        input [dataWidth-1:0] b,
        ////output reg [2*dataWidth*hiddenSize-1:0] Out,
        ////output reg signed [2*dataWidth:0] s,
        output signed [2*dataWidth:0] final
    );
    wire signed [2*dataWidth-1:0] inmult1[hiddenSize-1:0] ;
    //wire signed [2*dataWidth:0] tempSum;
    wire signed [2*dataWidth:0] sum;
    wire signed [2*dataWidth:0] tempfinal;
    reg signed [dataWidth-1:0] bias;
    //reg [dataWidth-1:0] tempBias;
    reg signed [2*dataWidth:0] partialsum[hiddenSize-1:0];
    reg signed [2*dataWidth:0] s;
    
    genvar j;
          generate
             for(j=0;j<hiddenSize;j=j+1)
             begin
                 mult_use 
                 #(
                        .dataWidth(dataWidth),
                        .fracWidth(fracWidth)
                  )
                  mult1
                  (
                        .clk(clk),
                        .a(hid[(dataWidth*j)+:dataWidth]),
                        //.in1(In),
                        .b(ReW[(dataWidth*j)+:dataWidth]), 
                        .p(inmult1[j])
                   );
                   
                  // assign t =  inmult1[j];
              end
         endgenerate
         
//        assign s = s+inmult1[k];
//          $monitor("SUM of One Hidden Neuron: %d", s);
         
 //        integer n=0;
 //        always @(s)
 //           n <= n+1;
           integer n=0,k=0;
           always @(posedge clk)
           begin
                s <= partialsum[hiddenSize-1]  ;
           end
         
 
 /*       
         always @(s)
         begin
             $monitor("S in one neuron: %d", s);
             $monitor("Bias in a neuron: %d", b);
         end
         
 
    
        always@(sum)
         begin
            $monitor("SUM after Bias addition: %d", sum);
         end
 */        
 
  
         add2Element
                #(
                    .dataWidth(2*dataWidth+1),
                    .fracWidth(fracWidth)
                )
         adder2 
                (
                    .clk(clk),
                    .m1(s), 
  //                  .m2(bias), 
                    .m2(b), 
                    .m4(sum)
                 );

        //assign tempSum = sum;
       //generate
          if(act == "sigmoid")
          begin
            sig #(.DATA_WIDTH(2*dataWidth+1), .FRACT_WIDTH(fracWidth)) 
            sigAct
                (
                    .clk(clk),
                    .X(sum),
                    .Y(final)
                );
          end
          else if(act == "tangent")
          begin
            tan #(.DATA_WIDTH(2*dataWidth+1), .FRACT_WIDTH(fracWidth)) 
            tanAct
                (
                    .clk(clk),
                    .X(sum),
                    .Y(final)
                );
           end  
        //endgenerate
         
        
         always @(posedge clk)
         begin
            for(k=0;k<hiddenSize;k=k+1)
            begin
              //Out[(2*dataWidth*k)+:2*dataWidth] = inmult1[k];
              
              if(k==0)
              begin
              partialsum[k] = inmult1[k];
              end
              else begin
              partialsum[k] = partialsum[k-1]+inmult1[k];
              end
            end
         end  
        
 /*       always@(s)
        begin
              if(k == hiddenSize)
              begin
                bias = b[dataWidth*n+:dataWidth];
                n = n+1;
              end
        end
 */             //$monitor("Bias: %d", bias);
       
endmodule
