`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////

///(* keep_hierarchy = "yes" *)
module gateTest2 
    #(
        parameter dataWidth = 16,
        parameter fracWidth = 12,
        parameter hiddenSize1 = 31, //154
        parameter hiddenSize2 = 15, //401
        parameter reWeightSize = 465,
        parameter actType = "sigmoid"
        //parameter hiddenSize = 20,
    )
    (
        input clk,
        input rst,
        input enGate,
        input signed [dataWidth*hiddenSize1-1:0] hid,
        input signed [dataWidth*reWeightSize-1:0] ReW,
        input signed [dataWidth*hiddenSize2-1:0] b,
        output reg signed [(2*dataWidth+1)*hiddenSize2-1:0] final,
        output done
     );     
    localparam[3:0] count = 2;
    
    /////wire neuronDone[hiddenSize2-1:0];
    wire neuronDone1[count-1:0];
    /////wire neuronDone2[hiddenSize2-count-1:0];
    wire done1;  
    reg done2;
    
    integer j=0, k=0, t=0, jj=0;
    
    // (* ram_style="register" *) reg signed [dataWidth*hiddenSize1*count-1:0] tempReW;
    
    reg signed [dataWidth*hiddenSize1-1:0] tempReW[count-1:0];
  
    reg enable = 0;
    reg [7:0] gateCounter = 0;
    reg [7:0] counter = 0;
    
    
    wire signed [(2*dataWidth+1)*count-1:0] tempFinal1;
    ////reg signed [(2*dataWidth+1)*hiddenSize2-1:0] tempFinal2;
    
    always@(posedge clk)
    begin
        if(rst==0)
        begin
            gateCounter <= 0;
        end
        else
        begin
            if((enGate == 1) && (gateCounter < 41))//(j >= count)//
            begin
                gateCounter <= gateCounter+1;
            end
            else
                gateCounter <= 0;
        end

    end 
    
    always@(posedge clk)
    begin
         if(rst==0)
         begin
              j <= 0;
         end
         else
         begin
              if((enGate == 1) && j<=(count-1))
              begin
                    j <= j+1;
              end
              else if(enGate == 0)// || (k==(hiddenSize2-1)))//gateCounter <= 40)
                    j <= 0;
              else
                    j <= j;
         end
    end 
  
    always@(posedge clk)
    begin
         if(rst==0)
         begin
              jj <= 0;
         end
         else
              jj <= j;
    end 
  
  always@(posedge clk)
  begin
        if(rst==0)
        begin
            enable <= 0;
        end
        else
        begin
            if((j == count))//count-1))// || (gateCounter > 40))
            begin
                enable <= 1;
            end
            else if(j == 0)//gateCounter == 41)
            begin
                enable <= 0;
            end
            else
                enable <= enable;
        end
  end 
  
  always@(posedge clk)
  begin
        if(rst==0)
        begin
            k <= 0;
        end
        else 
        begin
            if((enGate == 1) && (j<=count-1) && (k<=hiddenSize2-1))
            begin
                k <= k+1;
            end
            else if(enGate == 0)
                k <= 0;
            else
                k <= k;
        end
  end 
  /*
  always@(posedge clk)
  begin
    if(rst==0)
    begin
        tempReW <= 0;
    end
    else
    begin
        if(k<=count-1)
        begin
            tempReW[dataWidth*hiddenSize1*j+:dataWidth*hiddenSize1] <= ReW[dataWidth*hiddenSize1*(k)+:dataWidth*hiddenSize1];
        end
        else
            tempReW[dataWidth*hiddenSize1*jj+:dataWidth*hiddenSize1] <= ReW[dataWidth*hiddenSize1*(k)+:dataWidth*hiddenSize1];
    end
  end  
  */  
  always@(posedge clk)
  begin
    if(rst==0)
    begin
        tempReW[k] <= 0;
    end
    else
    begin
        if(k<=count-1)
        begin
            tempReW[k] <= ReW[dataWidth*hiddenSize1*(k)+:dataWidth*hiddenSize1];
        end
        else
            tempReW[k] <= tempReW[k];//ReW[dataWidth*hiddenSize1*(k)+:dataWidth*hiddenSize1];
    end
  end   
  
    
  genvar i;//,t;

  generate
     //begin
     //for(i=0;i<hiddenSize2;i=i+1)
     for(i=0;i<count;i=i+1)
     begin
            oneHidden2
            #(
                    .dataWidth(dataWidth),
                    .fracWidth(fracWidth),
                    .hiddenSize1(hiddenSize1),
                    .hiddenSize2(count),
                    //.reWeightSize(hiddenSize1), //changed from hiddenSize2 to hiddenSize1
                    .act(actType)
             )
             neuron1(
                    .clk(clk),
                    .rst(rst),
                    .enNeuron(enable),
                    .hid(hid),
                    ////.ReW(tempReW[dataWidth*hiddenSize1*i+:dataWidth*hiddenSize1]),
                    .ReW(tempReW[i]),
                    .b(b[dataWidth*i+:dataWidth]),
                    .final(tempFinal1[(2*dataWidth+1)*i+:(2*dataWidth+1)]),
                    .done(neuronDone1[i])
        
             );
             assign done1 = neuronDone1[count-1];
     end 
  endgenerate 
  
  
  always@(posedge clk)
  begin
        if(rst==0)
        begin
            t <= 0;
        end
        else
        begin
            if (gateCounter>=41 && t<=count)
            begin
                t <= t+1;
            end
            else
                t <= 0;
        end
  end
  
  always@(posedge clk)
  begin
        if(rst==0)
        begin
            ////tempFinal2 <= 0;
            final <= 0;
        end
        else
            //tempFinal2[(2*dataWidth+1)*t+:(2*dataWidth+1)] <= tempFinal1;
            final[(2*dataWidth+1)*t+:(2*dataWidth+1)] <= tempFinal1;
  end
  
///  assign final = tempFinal2;
 /* 
  generate       
     for(t=count;t<hiddenSize2;t=t+1)
     begin
            oneHidden2
            #(
                    .dataWidth(dataWidth),
                    .fracWidth(fracWidth),
                    .hiddenSize1(hiddenSize1),
                    .hiddenSize2(hiddenSize2),
                    //.reWeightSize(hiddenSize1), //changed from hiddenSize2 to hiddenSize1
                    .act(actType)
             )
             neuron2(
                    .clk(clk),
                    .rst(rst),
                    .enNeuron(done1),
                    .hid(hid),
                    .ReW(ReW[dataWidth*hiddenSize1*t+:dataWidth*hiddenSize1]),
                    .b(b[dataWidth*t+:dataWidth]),
                    .final(final[(2*dataWidth+1)*t+:(2*dataWidth+1)]),
                    .done(neuronDone2[t-count])
        
             );
          
             assign done = neuronDone2[hiddenSize2-count-1];
     end
    //end
    endgenerate    
       
    always@(posedge clk)
    begin
        if(rst==0)
            done2 <= 0;
        else
        begin
            if((k==(hiddenSize2-1)) && (done1==1))
            begin
                done2 <= 1;
            end
            else
                done2 <= done2;
        end
    end
 */
    //   $monitor("Final from Hidden Neuron = %b", final);  

    always@(posedge clk)
    begin
        if(rst == 0 || enGate == 0)
        begin
            counter <=0;
            done2 <= 0;
        end
        else
        begin
            counter <= counter+1;
            if(counter > 172)
            begin
                done2 <= 1;
                counter <= 0;
            end
            else
                done2 <= 0;
        end                       
        //$monitor(" en = %d ", en);          
    end 

     assign done = done2;
 
endmodule
