`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2021 11:15:26 AM
// Design Name: 
// Module Name: gate
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


module gate_test2 
    #(
        parameter dataWidth = 5,
        parameter fracWidth = 2,
        //parameter inputSize = 1,
        parameter hiddenSize1 = 3,
        parameter hiddenSize2 = 3,
        parameter reWeightSize = 9,
        parameter actType = "sigmoid"
        //parameter hiddenSize = 20,
    )
    (
        input clk,
        input rst,
        //input [dataWidth*inputSize-1:0] In,
        input [dataWidth*hiddenSize2-1:0] hid,
        //input [dataWidth*inWeightSize-1:0] InW,
        input [dataWidth*reWeightSize-1:0] ReW,
        input [dataWidth*hiddenSize1-1:0] b,
        output reg [2*dataWidth*hiddenSize2*hiddenSize1-1:0] finalOut,
        output signed [(2*dataWidth+1)*hiddenSize1-1:0] final
     );
     //reg [2*dataWidth-1:0] inmult1[hiddenSize-1:0][hiddenSize-1:0];  
     wire [2*dataWidth*hiddenSize2-1:0] Out[hiddenSize1-1:0];
     wire [2*dataWidth:0] s;
 //    wire signed [2*dataWidth*hiddenSize1:0] tempFinal;
/*     reg [2*dataWidth-1:0] inmult2[reWeightSize-1:0];
     reg [2*dataWidth:0] sum1[reWeightSize-1:0];      
     wire [dataWidth-1:0] In1 [inputSize-1:0]; 
     wire [dataWidth-1:0] InW1 [inWeightSize-1:0]; 
     wire [dataWidth-1:0] ReW1 [reWeightSize-1:0]; 
     wire [dataWidth-1:0] b1 [hiddenSize-1:0];
*/

     generate
     genvar i;
     
    
     for(i=0;i<hiddenSize1;i=i+1)
     begin
            oneHidden
            #(
                    .dataWidth(dataWidth),
                    .fracWidth(fracWidth),
                    .hiddenSize(hiddenSize2),
                    .reWeightSize(hiddenSize2),
                    .act(actType)
             )
             neuron(
                    .clk(clk),
                    .rst(rst),
                    //.In(In),
                    .hid(hid),
                    //.InW(InW),
                    .ReW(ReW[dataWidth*hiddenSize2*i+:dataWidth*hiddenSize2]),
                    .b(b[dataWidth*i+:dataWidth]),
                    .Out(Out[i]),
                    .s(s),
                    .final(final[(2*dataWidth+1)*i+:(2*dataWidth+1)])
        
             );
          
  //        always@(posedge clk)   
  //           $display("Final result: %d", final);
     end
     endgenerate    
         
 //    assign final = tempFinal;  
       
 //    always @(s)
 //    begin
         //s = s+t ;
 //       $monitor("SUM of One Hidden Neuron: %d", s);
 //    end
     
 //    always@(posedge clk)
 //    begin  
 //       $monitor("Final result after Activation Parent: %d", final);
 //      $display("Temp Final result after Activation Parent: %d", tempFinal);
 //    end
  
     
     integer k;
     always @(posedge clk)
     begin
            for(k=0;k<hiddenSize1;k=k+1)
            begin
                finalOut[(2*dataWidth*hiddenSize2*k)+:2*dataWidth*hiddenSize2] <= Out[k]; 
            end
     end
     
/*          
     generate
         for(j=0;j<hiddenSize;j=j+1)
         begin
             mult_use 
             #(
                    .dataWidth(dataWidth),
                    .fracWidth(fracWidth)
              )
              mult2
              (
                     .clk(clk),
                    .in1(hid[(dataWidth*j)+:dataWidth]),
                    .in2(ReW[(dataWidth*j)+:dataWidth]), 
                    .product(inmult2[j])
               );
          end
     endgenerate 
     
     generate
         for(k=0;k<hiddenSize;k=k+1)
         begin
             add 
             #(
                    .dataWidth(dataWidth),
                    .fracWidth(fracWidth)
              )
              add1
              (
                    .m1(inmult1[k]),
                    .m2(inmult2[k]), 
                    .m3(b[(dataWidth*k-1)+:dataWidth]),
                    .m4(sum1[k])
               );
          end
     endgenerate 
          
      generate
         for(i=0;i<inputSize;i=i+1)
         begin
            //assign In1[i] = In[(dataWidth*(i+1)-1):dataWidth*i];
            assign In1[i] = In[(dataWidth*i-1)+:dataWidth];
         end
      endgenerate
      generate 
         for(i=0;i<inWeightSize;i=i+1)
         begin
            //assign InW1[i] = InW[(dataWidth*(i+1)-1):dataWidth*i];
            assign InW1[i] = InW[(dataWidth*i-1)+:dataWidth];
         end
      endgenerate
      generate  
         for(i=0;i<reWeightSize;i=i+1)
         begin
            //assign ReW1[i] = ReW[(dataWidth*(i+1)-1):dataWidth*i];
            assign ReW1[i] = ReW[(dataWidth*i-1)+:dataWidth];
         end
      endgenerate
      generate                  
         for(i=0;i<hiddenSize;i=i+1)
         begin
            //assign b1[i] = b[(dataWidth*(i+1)-1):dataWidth*i];
            assign b1[i] = b[(dataWidth*i-1)+:dataWidth];
         end
      endgenerate
 */     
      
     
endmodule
