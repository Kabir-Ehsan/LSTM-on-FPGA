`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
////(* keep_hierarchy = "yes" *)

module oneHidden2
    #(
        parameter dataWidth = 16,
        parameter fracWidth = 12,
        parameter hiddenSize1 = 31,
        parameter hiddenSize2 = 15,
        //parameter reWeightSize = 3,
        parameter act = "tangent"
    )
    (
        input clk,
        input rst,
        input enNeuron,
        input [dataWidth*hiddenSize1-1:0] hid,
        input [dataWidth*hiddenSize1-1:0] ReW,
        input [dataWidth-1:0] b,
        output [2*dataWidth:0] final,
        output done
    );
    
    //(* dont_touch = "true" *) 
    reg doneInside = 0;
    
    localparam[3:0] count = 15;
    
    wire  [2*dataWidth-1:0] inmult1[hiddenSize1-1:0] ;

    wire  [2*dataWidth:0] sum;

    reg  [2*dataWidth:0] partialsum[hiddenSize1-1:0];
    reg  [2*dataWidth:0] s;
    
    reg [7:0] counter = 0;
    
    assign done = doneInside;
    
    genvar j, t;
          generate
             for(j=0;j<(hiddenSize1);j=j+1) //hiddenSize;j=j+1)
             begin
                 mult_use1
                 #(
                        .dataWidth(dataWidth),
                        .fracWidth(fracWidth)
                  )
                  mult1
                  (
                        .clk(clk),
                        .a(hid[(dataWidth*j)+:dataWidth]),
                        .ce(enNeuron),
                        .rst(rst),
                        .b(ReW[(dataWidth*j)+:dataWidth]), 
                        .p(inmult1[j])
                   );
                   
                  // assign t =  inmult1[j];
              end
            /*
             for(t=count;t<hiddenSize1;t=t+1) //hiddenSize;j=j+1)
             begin
                 mult_use2
                 #(
                        .dataWidth(dataWidth),
                        .fracWidth(fracWidth)
                  )
                  mult2
                  (
                        .clk(clk),
                        .a(hid[(dataWidth*t)+:dataWidth]),
                        .ce(enNeuron),
                        .rst(rst),
                        .b(ReW[(dataWidth*t)+:dataWidth]), 
                        .p(inmult1[t])
                   );
                   
                  // assign t =  inmult1[j];
              end
              */
         endgenerate
      
 /*
     genvar j, t;
          generate
             for(j=0;j<(hiddenSize1);j=j+1) //hiddenSize;j=j+1)
             begin
                 mult_use1
                 #(
                        .dataWidth(dataWidth),
                        .fracWidth(fracWidth)
                  )
                  mult1
                  (
                        .clk(clk),
                        .a(hid[(dataWidth*j)+:dataWidth]),
                        .ce(enNeuron),
                        .rst(rst),
                        .b(ReW[(dataWidth*j)+:dataWidth]), 
                        .p(inmult1[j])
                   );
                   
                  // assign t =  inmult1[j];
              end
            
 
         endgenerate
 */ 
   
//        assign s = s+inmult1[k];
//          $monitor("SUM of One Hidden Neuron: %d", s);
         
 //        integer n=0;
 //        always @(s)
 //           n <= n+1;
           integer n=0,k=0;
           always @(posedge clk)
           begin
                if(rst == 0)
                begin
                    s <= 0;
                end
                else if(enNeuron)
                    s <= partialsum[hiddenSize1-1];
                else
                    s <= s;
           end
         
        always @(posedge clk)
        begin
              if(rst == 0)
              begin
                counter <= 0;
              end
              else 
              begin
                if(enNeuron == 1)
                begin
                    if (counter<=39)
                    begin              
                        counter <= counter+1;
                    end
                    else
                        counter <=0;
                end
              end
        end
                        
     always @(posedge clk)
     begin
          if(rst == 0)
          begin
                doneInside <= 0;
          end
          else
          begin
                if(enNeuron==1)
                begin         
                    if(counter >= (hiddenSize1+6))//37)
                    begin
                        doneInside <= 1;                    
                    end
                    else
                        doneInside <= 0;
                end
          end        
          //else
          //     done <= 0;
           //$monitor("K : %d", k);
     end
     
        
    
    
 //       always@(sum)
 //        begin
            //$monitor("SUM after Bias addition: %b", sum);
 //        end
            
     
      
        add2Element2
        #(
               .dataWidth(2*dataWidth+1),
               .fracWidth(fracWidth)
         )
         adder2 
         (
            .clk(clk),
            .rst(rst),
            .m1(s), 
            .m2(b), 
            .m4(sum)
         );

        assign final = sum;
    /*
       generate
          if(act == "sigmoid")
          begin
            sig #(.DATA_WIDTH(2*dataWidth+1), .FRACT_WIDTH(fracWidth)) 
            sigAct
                (
                    .clk(clk),
                    .rst(rst),
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
                    .rst(rst),
                    .X(sum),
                    .Y(final)
                );
           end  
        endgenerate
       */  
         always @(posedge clk)
         begin
            for(k=0;k<hiddenSize1;k=k+1)                  
            begin
                if (rst == 0)
                begin
                    partialsum[k]<= 0;
                end
                else if(enNeuron)
                begin
                    if(k==0)
                    begin
                        partialsum[k] <= inmult1[k];
                    end
                    else 
                    begin
                        partialsum[k] <= partialsum[k-1]+inmult1[k];
                    end
                end
                else
                    partialsum[k]<= 0;
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
