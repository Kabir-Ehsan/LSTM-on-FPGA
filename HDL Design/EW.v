`timescale 1ns / 1ps

//`include "C:\Users\ekabir\Desktop\FPGA\VERILOG\project_3\project_1.srcs\sources_1\new\include2.vh"
//(* keep_hierarchy = "yes" *)
module EW
       #(
            parameter dataWidth = 16,
            parameter fracWidth = 12,
            parameter hiddenSize1 = 31,
            parameter hiddenSize2 = 15,
            parameter actType = "sigmoid"
        )
        (
            input clk,
            input enEW,
            input rst,
            input [dataWidth*hiddenSize2-1:0] cellState1,// [0:hiddenSize1-1],
            input [dataWidth*hiddenSize2-1:0] weights1, //[0:`hiddenUnitsLayer2-1],
         
            input [(dataWidth+1)*hiddenSize2-1:0] final_ew1, //[(2*dataWidth+1)*3*3-1:0]
            input [(dataWidth+1)*hiddenSize2-1:0] final_ew2,
            input [(dataWidth+1)*hiddenSize2-1:0] final_ew3,
            input [(dataWidth+1)*hiddenSize2-1:0] final_ew4,
  
            //output reg signed [dataWidth*hiddenSize2-1:0] hiddenStateTemp1, // [0:hiddenSize1-1],
            //output reg signed [dataWidth*hiddenSize2-1:0] cellStateTemp2, // [0:hiddenSize1-1],
            output [2*dataWidth-1:0] out,
            output enOut
        );


(* dont_touch = "true" *) reg [dataWidth-1:0] cellState2[hiddenSize2-1:0];
(* dont_touch = "true" *) reg [(dataWidth+1)-1:0] cellStateNext2 [hiddenSize2-1:0];
(* dont_touch = "true" *) reg [(dataWidth+1)-1:0] hiddenStateTemp1__2 [hiddenSize2-1:0];
(* dont_touch = "true" *) reg [(dataWidth+1)-1:0] cellStateTemp1__2 [hiddenSize2-1:0];
(* dont_touch = "true" *) reg [(dataWidth+1)-1:0] cellStateTemp2__2 [hiddenSize2-1:0];
        
(* dont_touch = "true" *) reg  [(dataWidth+1)-1:0] cellStateNext2_temp1 [hiddenSize2-1:0];
(* dont_touch = "true" *) reg  [(dataWidth+1)-1:0] cellStateTemp1__2_temp1 [hiddenSize2-1:0];
//(* dont_touch = "true" *) reg  [(2*dataWidth+1)-1:0] hiddenStateTemp1__2_temp [hiddenSize2-1:0];
(* dont_touch = "true" *) reg  [(dataWidth+1)-1:0] cellStateNext2_temp2 [hiddenSize2-1:0];
(* dont_touch = "true" *) reg  [(dataWidth+1)-1:0] cellStateTemp1__2_temp2 [hiddenSize2-1:0];

(* dont_touch = "true" *) reg  [(dataWidth+1)-1:0] cellStateNext2_temp3 [hiddenSize2-1:0];
(* dont_touch = "true" *) reg  [(dataWidth+1)-1:0] cellStateTemp1__2_temp3 [hiddenSize2-1:0];


(* dont_touch = "true" *) reg [(dataWidth+1)-1:0] hiddenStateTemp1__2_temp1 [hiddenSize2-1:0];
(* dont_touch = "true" *) reg [(dataWidth+1)-1:0] hiddenStateTemp1__2_temp2 [hiddenSize2-1:0];
(* dont_touch = "true" *) reg [(dataWidth+1)-1:0] hiddenStateTemp1__2_temp3 [hiddenSize2-1:0];

        
reg [dataWidth:0] finalf[hiddenSize2-1:0];
reg [dataWidth:0] finali[hiddenSize2-1:0];
reg [dataWidth:0] finalc[hiddenSize2-1:0];
reg [dataWidth:0] finalo[hiddenSize2-1:0];
        
//(* dont_touch = "true" *) 
reg [dataWidth-1:0] weightsTemp[hiddenSize2-1:0];
//(* dont_touch = "true" *) 
(* dont_touch = "true" *) reg [dataWidth-1:0] finalOut[hiddenSize2-1:0];
(* dont_touch = "true" *) reg [dataWidth-1:0] finalOut_temp[hiddenSize2-1:0];

reg [2*dataWidth-1:0] finalPartial[hiddenSize2-1:0];

        genvar i, j1, j2, j3, c, d, e, k; //, d=0;

        generate
             
        for(i=0;i<hiddenSize2;i=i+1)
        begin
            always@(posedge clk)
            begin          
                //if(rst == 0)// || enEW == 0)
                //begin
                //    finalf[i] <=  0;
                //    finali[i] <=  0;
                //    finalc[i] <=  0;
                //    finalo[i] <=  0;
                //end
                //else 
                if(enEW)
                begin
                    finalf[i] <=  final_ew1[(dataWidth+1)*i+:(dataWidth+1)];
                    finali[i] <=  final_ew2[(dataWidth+1)*i+:(dataWidth+1)];
                    finalc[i] <=  final_ew3[(dataWidth+1)*i+:(dataWidth+1)];
                    finalo[i] <=  final_ew4[(dataWidth+1)*i+:(dataWidth+1)];
                end
                else
                begin
                    finalf[i] <=  0;
                    finali[i] <=  0;
                    finalc[i] <=  0;
                    finalo[i] <=  0;
                end
            end
        end
        
        for(j1=0;j1<hiddenSize2;j1=j1+1)
        begin
            always@(posedge clk)
            begin
                //if(rst == 0)// || enEW == 0)
                //begin
                //    weightsTemp[j1] <= 0;
                //    cellState2[j1] <= 0;
                //end
                //else 
                if(enEW)
                begin
                    weightsTemp[j1] <= weights1[dataWidth*j1+:dataWidth];
                    cellState2[j1] <= cellState1[dataWidth*j1+:dataWidth];
                end
/*                else
                begin
                    weightsTemp[j1] <= 0;
                    cellState2[j1] <= 0;
                end  */ 
            end
        end
        endgenerate
/*
        for(j2=0;j2<count2;j2=j2+1)
        begin
            always@(posedge clk)
            begin
                if(rst == 0)
                begin
                    weightsTemp[j2+8] <= 0;
                    cellState2[j2+8] <= 0;
                end
                else
                begin
                    weightsTemp[j2+8] <= weights2[dataWidth*j2+:dataWidth];
                    cellState2[j2+8] <= cellState1_2[dataWidth*j2+:dataWidth];
                end   
            end
        end
        
        for(j3=0;j3<count2;j3=j3+1)
        begin
            always@(posedge clk)
            begin
                if(rst == 0)
                begin
                    weightsTemp[j3+16] <= weights3[dataWidth*j3+:dataWidth];
                    cellState2[j3+16] <= cellState1_3[dataWidth*j3+:dataWidth];   
                end
                else
                begin
                    weightsTemp[j3+16] <= weights3[dataWidth*j3+:dataWidth];
                    cellState2[j3+16] <= cellState1_3[dataWidth*j3+:dataWidth];
                end   
            end
        end                                       
        endgenerate
*/

//        end
/*       always@(posedge clk)
        begin
            $monitor("finalf = %b", finalf[2]);
            $monitor("weightsTemp = %b", weightsTemp[2]);
        end*/
        
//        genvar c,d, e;
        generate
            for(c=0;c<hiddenSize2;c=c+1)
            begin
                always@(posedge clk)
                begin              
                    /*if(rst == 0)// || enEW == 0)
                    begin
                        cellStateNext2[c] <= 0;//final2[(2*dataWidth+1)*c+:(2*dataWidth+1)]*final3[(2*dataWidth+1)*c+:(2*dataWidth+1)];
                        cellStateTemp1__2[c] <= 0; //final1[(2*dataWidth+1)*c+:(2*dataWidth+1)]*cellState[(2*dataWidth+1)*c+:(2*dataWidth+1)];
                        cellStateNext2_temp[c] <= 0;
                        cellStateTemp1__2_temp[c] <= 0; 
                    end
                    else */
                    if(enEW)
                    begin
                        cellStateNext2_temp1[c] <= finali[c]*finalc[c];
                        cellStateTemp1__2_temp1[c] <= finalf[c]*(cellState2[c]);
                    end
/*                    else
                    begin
                        cellStateNext2_temp1[c] <= 0;
                        cellStateTemp1__2_temp1[c] <= 0;
                    end*/
                end
            end
       endgenerate
 
       generate
            for(c=0;c<hiddenSize2;c=c+1)
            begin
                always@(posedge clk)
                begin              
                    /*if(rst == 0)// || enEW == 0)
                    begin
                        cellStateNext2[c] <= 0;//final2[(2*dataWidth+1)*c+:(2*dataWidth+1)]*final3[(2*dataWidth+1)*c+:(2*dataWidth+1)];
                        cellStateTemp1__2[c] <= 0; //final1[(2*dataWidth+1)*c+:(2*dataWidth+1)]*cellState[(2*dataWidth+1)*c+:(2*dataWidth+1)];
                        cellStateNext2_temp[c] <= 0;
                        cellStateTemp1__2_temp[c] <= 0; 
                    end
                    else */
                    if(enEW)
                    begin
                        cellStateNext2_temp2[c] <= cellStateNext2_temp1[c];
                        cellStateTemp1__2_temp2[c] <= cellStateTemp1__2_temp1[c];
                        cellStateNext2_temp3[c] <= cellStateNext2_temp2[c];
                        cellStateTemp1__2_temp3[c] <= cellStateTemp1__2_temp2[c];                            
                        cellStateNext2[c] <= cellStateNext2_temp3[c];//final2[(2*dataWidth+1)*c+:(2*dataWidth+1)]*final3[(2*dataWidth+1)*c+:(2*dataWidth+1)];
                        cellStateTemp1__2[c] <=  cellStateTemp1__2_temp3[c];
                    end
/*                    else
                    begin
                        cellStateNext2_temp2[c] <= 0;
                        cellStateTemp1__2_temp2[c] <= 0;
                        cellStateNext2_temp3[c] <= 0;
                        cellStateTemp1__2_temp3[c] <= 0;                            
                        cellStateNext2[c] <= 0;
                        cellStateTemp1__2[c] <=  0;
                    end*/
                end
            end
       endgenerate
       
       generate
            for(e=0;e<hiddenSize2;e=e+1)
            begin

                 always@(posedge clk)
                 begin
                    /*if(rst == 0)// || enEW == 0)
                    begin
                        cellStateTemp2__2[e] <= 0;
                        //cellStateTemp2[dataWidth*e+:dataWidth] <= 0;                   
                    end
                    else */
                    if(enEW)
                    begin
                        cellStateTemp2__2[e] <= cellStateTemp1__2[e] + cellStateNext2[e];
                        //cellStateTemp2[dataWidth*e+:dataWidth] <= cellStateTemp2__2[e];
                    end
//                    else 
//                       cellStateTemp2__2[e] <= 0;
                 end
             end
        endgenerate
        
 //      integer d;
 //       always @(posedge clk)
 
 /*
        generate
        for(d=0;d<count1*count2;d=d+1)
        begin
              //always@(posedge clk)
              //begin
                  if(actType == "sigmoid")
                  begin
                    sig #(.DATA_WIDTH(dataWidth), .FRACT_WIDTH(fracWidth)) 
                    sigAct
                        (
                            .clk(clk),
                            .rst(rst),
                            .X(cellStateTemp2__2[d]),
                            .Y(cellStateTemp3[d])
                        );
                  end
                  else if(actType == "tangent")
                  begin
                    tan #(.DATA_WIDTH(dataWidth), .FRACT_WIDTH(fracWidth)) 
                    tanAct
                        (
                            .clk(clk),
                            .rst(rst),
                            .X(cellStateTemp2__2[d]),
                            .Y(cellStateTemp3[d])
                        );
                  end

           end
         endgenerate 
*/         
         //generate
         //genvar k;  
      generate      
         for(k=0;k<hiddenSize2;k=k+1)
         begin
            always@(posedge clk)
            begin
                /*if(rst == 0)// || enEW == 0)
                begin
                    hiddenStateTemp1__2[k] <= 0;//final2[(2*dataWidth+1)*c+:(2*dataWidth+1)]*final3[(2*dataWidth+1)*c+:(2*dataWidth+1)];               
                    hiddenStateTemp1__2_temp[k] <= 0;
                    finalOut[k] <= 0;
                end
                else */
                if(enEW)
                begin
                    hiddenStateTemp1__2_temp1[k] <= cellStateTemp2__2[k]*finalo[k];
                    hiddenStateTemp1__2_temp2[k] <= hiddenStateTemp1__2_temp1[k];
                    hiddenStateTemp1__2_temp3[k] <= hiddenStateTemp1__2_temp2[k];
                    hiddenStateTemp1__2[k] <= hiddenStateTemp1__2_temp3[k];
                end
/*                else
                begin
                    hiddenStateTemp1__2_temp1[k] <= 0;
                    hiddenStateTemp1__2_temp2[k] <= 0;
                    hiddenStateTemp1__2_temp3[k] <= 0;                    
                    hiddenStateTemp1__2[k] <= 0;
                end*/
            end
         end
       endgenerate
 
       generate      
         for(k=0;k<hiddenSize2;k=k+1)
         begin
            always@(posedge clk)
            begin
                /*if(rst == 0)// || enEW == 0)
                begin
                    hiddenStateTemp1__2[k] <= 0;//final2[(2*dataWidth+1)*c+:(2*dataWidth+1)]*final3[(2*dataWidth+1)*c+:(2*dataWidth+1)];               
                    hiddenStateTemp1__2_temp[k] <= 0;
                    finalOut[k] <= 0;
                end
                else */
                if(enEW)
                begin                  
                    finalOut_temp[k] <= hiddenStateTemp1__2[k]*weightsTemp[k];
                    finalOut[k] <= finalOut_temp[k];
                end
/*                else
                begin
                    finalOut_temp[k] <= 0;
                    finalOut[k] <= 0;
                end*/
            end
         end
       endgenerate
       
         reg[9:0] kk, counter = 0;
         reg en = 0;
         always@(posedge clk)
         begin
            for(kk = 0;kk<hiddenSize2;kk = kk+1)
            begin
                if(en == 1)//(rst == 0 || enEW == 0)
                begin
                    finalPartial[kk] <= finalPartial[kk];
                end
                else if(enEW)
                begin
                    if(kk==0)
                        finalPartial[kk] <=  finalOut[kk];
                    else
                    begin
                        finalPartial[kk] <= finalPartial[kk-1] + finalOut[kk];
                    end         
                end
                else
                    finalPartial[kk] <= 0;
            end
            
            //counter <= counter+1;
            //$monitor(" counter = %d ", counter); 
        end

        //endgenerate
       
        always@(posedge clk)
        begin
            if(rst == 0)// || enEW == 0)
            begin
                counter <=0;
                en <= 0;
                //outTemp <= 0;
            end
            else
            begin
               if(enEW)
               begin
                    counter <= counter+1;
                    if(counter > (hiddenSize2+5*2))//25)
                    begin
                        en <= 1;
                        counter <= counter;
                        //outTemp <= finalPartial[hiddenSize2-1];
                    end
                    else
                    begin
                        en <= en;
                        //outTemp <= outTemp;
                    end
                end
                else
                begin
                    en <= en;
                    //outTemp <= outTemp;
                end
            end                       
            //$monitor(" en = %d ", en);          
        end     
        
        assign out = finalPartial[hiddenSize2-1];//outTemp;
        assign enOut = en;

endmodule
