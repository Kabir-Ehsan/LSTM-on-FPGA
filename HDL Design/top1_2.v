`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arkansas
// Engineer: Ehsan Kabir

module top1_2
    #(
        parameter dataWidth = 16,
        parameter fracWidth = 12,
        parameter INPUT_SIZE = 16,
        parameter hiddenUnitsLayer1 = 15,
        parameter hiddenUnitsLayer2 = 15,
        parameter hiddenUnitsLayer3 = 15,
        parameter hiddenUnitsLayer = 31,
        parameter hiddenUnitsLayer1_1 = 30,
        parameter gateReWsize1 = 465, //0 //262144 //262144 //400 //
        parameter gateReWsize2 = 450,
        parameter gateReWsize3 = 450,
        parameter addrSize1 = 6, //18//14 //7 //16 //14 //12 //9// 4//
        parameter addrSize2 = 6, // 8//14 //
        parameter addrSize3 = 6//18//14 //7 //16 //14 //12 //9// 4//

    )
    (
        ap_clk,
        ap_rst_n,
        ap_start,
        ap_done,
        ap_ready,
        ap_idle,
          
        in_stream_Addr_A,
        in_stream_EN_A,
        in_stream_WEN_A,
        in_stream_Din_A,
        in_stream_Dout_A,
        
        out_stream_Addr_A,
        out_stream_WEN_A,
        out_stream_Din_A,
        out_stream_Dout_A,
        out_stream_EN_A, 
        new_net,
        tempCount,
        tempWeight,
        tempIn,
        temp
        
    );
    
input   ap_clk;
input   ap_rst_n;
input   ap_start;

output ap_done; //[0:0] 
output ap_ready;//[0:0] 
output ap_idle; //[0:0] 

output [31:0] in_stream_Addr_A;
output reg in_stream_EN_A;
output [3:0] in_stream_WEN_A;
output [31:0] in_stream_Din_A;
input  [31:0] in_stream_Dout_A;

output [31:0] out_stream_Addr_A;
output reg out_stream_EN_A;
output reg [3:0] out_stream_WEN_A;
output reg [31:0] out_stream_Din_A;
input [31:0] out_stream_Dout_A;

output [31:0] tempCount;
output [31:0] tempWeight;
output [31:0] tempIn;
output [31:0] temp;
//localparam[3:0] count2 = 4;//2;//

localparam[3:0] count3 = 8;
localparam[3:0] count4 = 7;


reg [31:0] finished = 0;
reg [31:0] finished1 = 0;

//reg signed[dataWidth-1:0] out;
wire [2*dataWidth-1:0] outTemp;

wire ForGateDone1;//, ForGateDone2;//, ForGateDone3, ForGateDone4, ForGateDone5, ForGateDone6;//, ForGateDone7, ForGateDone8, 
wire InGateDone1;///, InGateDone2;//, InGateDone3, InGateDone4, InGateDone5, InGateDone6;//, InGateDone7, InGateDone8;
wire CellGateDone1;//, CellGateDone2;//, CellGateDone3, CellGateDone4, CellGateDone5, CellGateDone6;//, CellGateDone7, CellGateDone8, 
wire OutGateDone1;//, OutGateDone2;//, OutGateDone3, OutGateDone4, OutGateDone5, OutGateDone6;//, OutGateDone7, OutGateDone8;

input [2:0] new_net;

reg [255:0] INPUTS = 0;

reg [31:0] counter = 0;

reg [31:0] inAddrCount;// = {32{1'b0}};

reg in_EN_A;
///always@(*)
//begin
assign in_stream_WEN_A = 4'b0000; //4'b1111; //0;
assign in_stream_Din_A = 32'b0;
    //assign in_stream_EN_A = 0;
//end

always@(posedge ap_clk)
begin
    if (ap_rst_n == 0)
    begin
        in_EN_A <= 0;
        in_stream_EN_A <= 0;
    end
    else 
    begin
        if (ap_start == 1 && inAddrCount<INPUT_SIZE)
        begin
            in_EN_A <= 1;
            in_stream_EN_A <= 1;
        end
        else
        begin
             in_EN_A <= 0;
             in_stream_EN_A <= 0;
        end           
    end
end  

always@(posedge ap_clk)
begin
    if (ap_rst_n == 0)
    begin
        inAddrCount <= 0;
    end
    else 
    begin
        if (in_EN_A == 1)
        begin
            inAddrCount <= inAddrCount+1;
        end
        else
        begin
             inAddrCount <= inAddrCount;
        end           
    end
end 

//always@(inAddrCount)//)//)
//begin
    assign in_stream_Addr_A = inAddrCount; 
//end

always@(posedge ap_clk)//)//)
begin
   if (in_EN_A == 1)
   begin
      INPUTS[dataWidth*(inAddrCount-1)+:dataWidth] <= in_stream_Dout_A ;
   end
end

(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst1;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst2;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst3;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst4;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst5;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst6; 
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst7;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst8;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst9; 
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst10;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst11; 
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst12;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst13;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst14;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst15;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst16;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst17;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst18;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst19;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst20;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst21;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst22;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst23;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst24;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *)reg rst25;



always @(posedge ap_clk)
begin
     rst1 <= ap_rst_n;
     rst2 <= ap_rst_n;
     rst3 <= ap_rst_n;
     rst4 <= ap_rst_n;
     rst5 <= ap_rst_n;
     rst6 <= ap_rst_n;
     rst7 <= ap_rst_n;
     rst8 <= ap_rst_n;
     rst9 <= ap_rst_n;
     rst10 <= ap_rst_n;
     rst11 <= ap_rst_n;
     rst12 <= ap_rst_n;
     rst13 <= ap_rst_n;
     rst14 <= ap_rst_n;
     rst15 <= ap_rst_n;
     rst16 <= ap_rst_n;
     rst17 <= ap_rst_n;
     rst18 <= ap_rst_n;
     rst19 <= ap_rst_n;
     rst20 <= ap_rst_n;
     rst21 <= ap_rst_n;
     rst22 <= ap_rst_n;        
     rst23 <= ap_rst_n;
     rst24 <= ap_rst_n;
     rst25 <= ap_rst_n;        
end

//layer 1
reg inputReWeight_V_ce0, inputReWeight_V_ce0_1, inputReWeight_V_ce0_2, inputReWeight_V_ce0_3, inputReWeight_V_ce0_4, inputReWeight_V_ce0_5, inputReWeight_V_ce0_6, inputReWeight_V_ce0_7;
reg forgetReWeight_V_ce0, forgetReWeight_V_ce0_1, forgetReWeight_V_ce0_2, forgetReWeight_V_ce0_3, forgetReWeight_V_ce0_4, forgetReWeight_V_ce0_5, forgetReWeight_V_ce0_6, forgetReWeight_V_ce0_7;
reg cellReWeight_V_ce0, cellReWeight_V_ce0_1, cellReWeight_V_ce0_2, cellReWeight_V_ce0_3, cellReWeight_V_ce0_4, cellReWeight_V_ce0_5, cellReWeight_V_ce0_6, cellReWeight_V_ce0_7;
reg outputReWeight_V_ce0, outputReWeight_V_ce0_1, outputReWeight_V_ce0_2, outputReWeight_V_ce0_3, outputReWeight_V_ce0_4, outputReWeight_V_ce0_5, outputReWeight_V_ce0_6, outputReWeight_V_ce0_7;

//layer 2
reg inputReWeight_V_ce1, inputReWeight_V_ce1_1, inputReWeight_V_ce1_2, inputReWeight_V_ce1_3, inputReWeight_V_ce1_4, inputReWeight_V_ce1_5, inputReWeight_V_ce1_6, inputReWeight_V_ce1_7;
reg forgetReWeight_V_ce1, forgetReWeight_V_ce1_1, forgetReWeight_V_ce1_2, forgetReWeight_V_ce1_3, forgetReWeight_V_ce1_4, forgetReWeight_V_ce1_5, forgetReWeight_V_ce1_6, forgetReWeight_V_ce1_7;
reg cellReWeight_V_ce1, cellReWeight_V_ce1_1, cellReWeight_V_ce1_2, cellReWeight_V_ce1_3, cellReWeight_V_ce1_4, cellReWeight_V_ce1_5, cellReWeight_V_ce1_6, cellReWeight_V_ce1_7;
reg outputReWeight_V_ce1, outputReWeight_V_ce1_1, outputReWeight_V_ce1_2, outputReWeight_V_ce1_3, outputReWeight_V_ce1_4, outputReWeight_V_ce1_5, outputReWeight_V_ce1_6, outputReWeight_V_ce1_7;

//layer 3
reg inputReWeight_V_ce2, inputReWeight_V_ce2_1, inputReWeight_V_ce2_2, inputReWeight_V_ce2_3, inputReWeight_V_ce2_4, inputReWeight_V_ce2_5, inputReWeight_V_ce2_6, inputReWeight_V_ce2_7;
reg forgetReWeight_V_ce2, forgetReWeight_V_ce2_1, forgetReWeight_V_ce2_2, forgetReWeight_V_ce2_3, forgetReWeight_V_ce2_4, forgetReWeight_V_ce2_5, forgetReWeight_V_ce2_6, forgetReWeight_V_ce2_7;
reg cellReWeight_V_ce2, cellReWeight_V_ce2_1, cellReWeight_V_ce2_2, cellReWeight_V_ce2_3, cellReWeight_V_ce2_4, cellReWeight_V_ce2_5, cellReWeight_V_ce2_6, cellReWeight_V_ce2_7;
reg outputReWeight_V_ce2, outputReWeight_V_ce2_1, outputReWeight_V_ce2_2, outputReWeight_V_ce2_3, outputReWeight_V_ce2_4, outputReWeight_V_ce2_5, outputReWeight_V_ce2_6, outputReWeight_V_ce2_7;

////////read address
// layer 1
reg [addrSize1-1:0] in_ReW_address0_1, in_ReW_address0_1_2, in_ReW_address0_1_3, in_ReW_address0_1_4, in_ReW_address0_1_5, in_ReW_address0_1_6, in_ReW_address0_1_7, in_ReW_address0_1_8;
reg [addrSize1-1:0] for_ReW_address0_1, for_ReW_address0_1_2, for_ReW_address0_1_3, for_ReW_address0_1_4, for_ReW_address0_1_5, for_ReW_address0_1_6, for_ReW_address0_1_7, for_ReW_address0_1_8;
reg [addrSize1-1:0] out_ReW_address0_1, out_ReW_address0_1_2, out_ReW_address0_1_3, out_ReW_address0_1_4, out_ReW_address0_1_5, out_ReW_address0_1_6, out_ReW_address0_1_7, out_ReW_address0_1_8;
reg [addrSize1-1:0] cell_ReW_address0_1, cell_ReW_address0_1_2, cell_ReW_address0_1_3, cell_ReW_address0_1_4, cell_ReW_address0_1_5, cell_ReW_address0_1_6, cell_ReW_address0_1_7, cell_ReW_address0_1_8;

// layer 2
reg [addrSize2-1:0] in_ReW_address0_2, in_ReW_address0_2_2, in_ReW_address0_2_3, in_ReW_address0_2_4, in_ReW_address0_2_5, in_ReW_address0_2_6, in_ReW_address0_2_7, in_ReW_address0_2_8;
reg [addrSize2-1:0] for_ReW_address0_2, for_ReW_address0_2_2, for_ReW_address0_2_3, for_ReW_address0_2_4, for_ReW_address0_2_5, for_ReW_address0_2_6, for_ReW_address0_2_7, for_ReW_address0_2_8;
reg [addrSize2-1:0] out_ReW_address0_2, out_ReW_address0_2_2, out_ReW_address0_2_3, out_ReW_address0_2_4, out_ReW_address0_2_5, out_ReW_address0_2_6, out_ReW_address0_2_7, out_ReW_address0_2_8;
reg [addrSize2-1:0] cell_ReW_address0_2, cell_ReW_address0_2_2, cell_ReW_address0_2_3, cell_ReW_address0_2_4, cell_ReW_address0_2_5, cell_ReW_address0_2_6, cell_ReW_address0_2_7, cell_ReW_address0_2_8;

// layer 3
reg [addrSize3-1:0] in_ReW_address0_3, in_ReW_address0_3_2, in_ReW_address0_3_3, in_ReW_address0_3_4, in_ReW_address0_3_5, in_ReW_address0_3_6, in_ReW_address0_3_7, in_ReW_address0_3_8;
reg [addrSize3-1:0] for_ReW_address0_3, for_ReW_address0_3_2, for_ReW_address0_3_3, for_ReW_address0_3_4, for_ReW_address0_3_5, for_ReW_address0_3_6, for_ReW_address0_3_7, for_ReW_address0_3_8;
reg [addrSize3-1:0] out_ReW_address0_3, out_ReW_address0_3_2, out_ReW_address0_3_3, out_ReW_address0_3_4, out_ReW_address0_3_5, out_ReW_address0_3_6, out_ReW_address0_3_7, out_ReW_address0_3_8;
reg [addrSize3-1:0] cell_ReW_address0_3, cell_ReW_address0_3_2, cell_ReW_address0_3_3, cell_ReW_address0_3_4, cell_ReW_address0_3_5, cell_ReW_address0_3_6, cell_ReW_address0_3_7, cell_ReW_address0_3_8;


reg [addrSize1-1:0] in_ReW_address1_1, in_ReW_address1_1_2, in_ReW_address1_1_3, in_ReW_address1_1_4, in_ReW_address1_1_5, in_ReW_address1_1_6, in_ReW_address1_1_7, in_ReW_address1_1_8;
reg [addrSize2-1:0] in_ReW_address1_2, in_ReW_address1_2_2, in_ReW_address1_2_3, in_ReW_address1_2_4, in_ReW_address1_2_5, in_ReW_address1_2_6, in_ReW_address1_2_7, in_ReW_address1_2_8;
reg [addrSize3-1:0] in_ReW_address1_3, in_ReW_address1_3_2, in_ReW_address1_3_3, in_ReW_address1_3_4, in_ReW_address1_3_5, in_ReW_address1_3_6, in_ReW_address1_3_7, in_ReW_address1_3_8;

reg [addrSize1-1:0] for_ReW_address1_1, for_ReW_address1_1_2, for_ReW_address1_1_3, for_ReW_address1_1_4, for_ReW_address1_1_5, for_ReW_address1_1_6, for_ReW_address1_1_7, for_ReW_address1_1_8;
reg [addrSize2-1:0] for_ReW_address1_2, for_ReW_address1_2_2, for_ReW_address1_2_3, for_ReW_address1_2_4, for_ReW_address1_2_5, for_ReW_address1_2_6, for_ReW_address1_2_7, for_ReW_address1_2_8;
reg [addrSize3-1:0] for_ReW_address1_3, for_ReW_address1_3_2, for_ReW_address1_3_3, for_ReW_address1_3_4, for_ReW_address1_3_5, for_ReW_address1_3_6, for_ReW_address1_3_7, for_ReW_address1_3_8;

reg [addrSize1-1:0] out_ReW_address1_1, out_ReW_address1_1_2, out_ReW_address1_1_3, out_ReW_address1_1_4, out_ReW_address1_1_5, out_ReW_address1_1_6, out_ReW_address1_1_7, out_ReW_address1_1_8;
reg [addrSize2-1:0] out_ReW_address1_2, out_ReW_address1_2_2, out_ReW_address1_2_3, out_ReW_address1_2_4, out_ReW_address1_2_5, out_ReW_address1_2_6, out_ReW_address1_2_7, out_ReW_address1_2_8;
reg [addrSize3-1:0] out_ReW_address1_3, out_ReW_address1_3_2, out_ReW_address1_3_3, out_ReW_address1_3_4, out_ReW_address1_3_5, out_ReW_address1_3_6, out_ReW_address1_3_7, out_ReW_address1_3_8;

reg [addrSize1-1:0] cell_ReW_address1_1, cell_ReW_address1_1_2, cell_ReW_address1_1_3, cell_ReW_address1_1_4, cell_ReW_address1_1_5, cell_ReW_address1_1_6, cell_ReW_address1_1_7, cell_ReW_address1_1_8;
reg [addrSize2-1:0] cell_ReW_address1_2, cell_ReW_address1_2_2, cell_ReW_address1_2_3, cell_ReW_address1_2_4, cell_ReW_address1_2_5, cell_ReW_address1_2_6, cell_ReW_address1_2_7, cell_ReW_address1_2_8;
reg [addrSize3-1:0] cell_ReW_address1_3, cell_ReW_address1_3_2, cell_ReW_address1_3_3, cell_ReW_address1_3_4, cell_ReW_address1_3_5, cell_ReW_address1_3_6, cell_ReW_address1_3_7, cell_ReW_address1_3_8;

reg  [dataWidth-1:0] cellState1 [0:hiddenUnitsLayer1-1];
reg  [dataWidth-1:0] cellState2 [0:hiddenUnitsLayer1-1];
reg  [dataWidth-1:0] cellState3 [0:hiddenUnitsLayer1-1];

reg  [dataWidth-1:0] hiddenStateF [0:hiddenUnitsLayer-1];
reg  [dataWidth-1:0] hiddenStateI [0:hiddenUnitsLayer-1];
reg  [dataWidth-1:0] hiddenStateC [0:hiddenUnitsLayer-1];
reg  [dataWidth-1:0] hiddenStateO [0:hiddenUnitsLayer-1];

reg  [dataWidth-1:0] hiddenStateF1 [0:hiddenUnitsLayer1_1-1];
reg  [dataWidth-1:0] hiddenStateI1 [0:hiddenUnitsLayer1_1-1];
reg  [dataWidth-1:0] hiddenStateC1 [0:hiddenUnitsLayer1_1-1];
reg  [dataWidth-1:0] hiddenStateO1 [0:hiddenUnitsLayer1_1-1];

reg  [dataWidth-1:0] hiddenStateF2 [0:hiddenUnitsLayer1_1-1];
reg  [dataWidth-1:0] hiddenStateI2 [0:hiddenUnitsLayer1_1-1];
reg  [dataWidth-1:0] hiddenStateC2 [0:hiddenUnitsLayer1_1-1];
reg  [dataWidth-1:0] hiddenStateO2 [0:hiddenUnitsLayer1_1-1];

reg  [dataWidth-1:0] weights[hiddenUnitsLayer3-1:0];

reg  [dataWidth-1:0] finalBias[0:0];

reg  [dataWidth-1:0] forgetBias1_1 [count3-1:0];
reg  [dataWidth-1:0] forgetBias1_2 [count3-1:0];

reg  [dataWidth-1:0] inputBias1_1 [count3-1:0];
reg  [dataWidth-1:0] inputBias1_2 [count3-1:0];

reg  [dataWidth-1:0] cellBias1_1 [count3-1:0];
reg  [dataWidth-1:0] cellBias1_2 [count3-1:0];

reg  [dataWidth-1:0] outputBias1_1 [count3-1:0];
reg  [dataWidth-1:0] outputBias1_2 [count3-1:0];

reg  [dataWidth-1:0] forgetBias2_1 [count3-1:0];
reg  [dataWidth-1:0] forgetBias2_2 [count3-1:0];

reg  [dataWidth-1:0] inputBias2_1 [count3-1:0];
reg  [dataWidth-1:0] inputBias2_2 [count3-1:0];

reg  [dataWidth-1:0] cellBias2_1 [count3-1:0];
reg  [dataWidth-1:0] cellBias2_2 [count3-1:0];

reg  [dataWidth-1:0] outputBias2_1 [count3-1:0];
reg  [dataWidth-1:0] outputBias2_2 [count3-1:0];

reg  [dataWidth-1:0] forgetBias3_1 [count3-1:0];
reg  [dataWidth-1:0] forgetBias3_2 [count3-1:0];

reg  [dataWidth-1:0] inputBias3_1 [count3-1:0];
reg  [dataWidth-1:0] inputBias3_2 [count3-1:0];

reg  [dataWidth-1:0] cellBias3_1 [count3-1:0];
reg  [dataWidth-1:0] cellBias3_2 [count3-1:0];

reg  [dataWidth-1:0] outputBias3_1 [count3-1:0];
reg  [dataWidth-1:0] outputBias3_2 [count3-1:0]; 

(* max_fanout = 50 *) reg  [dataWidth*hiddenUnitsLayer-1:0] hidi1 = 0;//(* rw_addr_collision = "yes" *)
(* max_fanout = 50 *) reg  [dataWidth*hiddenUnitsLayer-1:0] hidf1 = 0;//(* rw_addr_collision = "yes" *)
(* max_fanout = 50 *) reg  [dataWidth*hiddenUnitsLayer-1:0] hidc1 = 0;//(* rw_addr_collision = "yes" *)
(* max_fanout = 50 *) reg  [dataWidth*hiddenUnitsLayer-1:0] hido1 = 0;//(* rw_addr_collision = "yes" *)

reg  [dataWidth-1:0] bi[count3-1:0];
reg  [dataWidth-1:0] bf[count3-1:0];
reg  [dataWidth-1:0] bc[count3-1:0];
reg  [dataWidth-1:0] bo[count3-1:0];

reg  [(dataWidth+1)*hiddenUnitsLayer1-1:0] final1_1;
reg  [(dataWidth+1)*hiddenUnitsLayer1-1:0] final2_1;
reg  [(dataWidth+1)*hiddenUnitsLayer1-1:0] final3_1;
reg  [(dataWidth+1)*hiddenUnitsLayer1-1:0] final4_1;

//layer all
wire  [(dataWidth+1)-1:0] final1_1_1[count3-1:0];
wire  [(dataWidth+1)-1:0] final2_1_1[count3-1:0];
wire  [(dataWidth+1)-1:0] final3_1_1[count3-1:0];
wire  [(dataWidth+1)-1:0] final4_1_1[count3-1:0];

reg  [dataWidth*hiddenUnitsLayer1-1:0] cellStateFlat1;
reg  [dataWidth*hiddenUnitsLayer1-1:0] cellStateFlat2;
reg  [dataWidth*hiddenUnitsLayer1-1:0] cellStateFlat3;

reg  [dataWidth*hiddenUnitsLayer1-1:0] weightsFlat1;

reg  [dataWidth-1:0] finalBiasFlat; //[0:0]

wire  [(dataWidth+1)*hiddenUnitsLayer1-1:0] hiddenStateTempFlat1;//[`hiddenUnitsLayer1/(count*count)-1:0];
wire  [(dataWidth+1)*hiddenUnitsLayer1-1:0] cellStateTempFlat1;//[`hiddenUnitsLayer1/(count*count)-1:0];
wire  [(dataWidth+1)*hiddenUnitsLayer1-1:0] hiddenStateTempFlat2;//[`hiddenUnitsLayer1/(count*count)-1:0];
wire  [(dataWidth+1)*hiddenUnitsLayer1-1:0] cellStateTempFlat2;
wire  [(dataWidth+1)*hiddenUnitsLayer1-1:0] hiddenStateTempFlat3;//[`hiddenUnitsLayer1/(count*count)-1:0];
wire  [(dataWidth+1)*hiddenUnitsLayer1-1:0] cellStateTempFlat3;

reg [dataWidth*hiddenUnitsLayer-1:0] inputReWeight1_1[count3-1:0];
reg [dataWidth*hiddenUnitsLayer-1:0] forReWeight1_1[count3-1:0];
reg [dataWidth*hiddenUnitsLayer-1:0] cellReWeight1_1[count3-1:0];
reg [dataWidth*hiddenUnitsLayer-1:0] outReWeight1_1[count3-1:0];

wire  [dataWidth-1:0] inputReW1[count3-1:0];//, inputReW1_2, inputReW1_3, inputReW1_4, inputReW1_5, inputReW1_6, inputReW1_7, inputReW1_8;
wire  [dataWidth-1:0] inputReW2[count3-1:0];//, inputReW2_2, inputReW2_3, inputReW2_4, inputReW2_5, inputReW2_6, inputReW2_7, inputReW2_8;
wire  [dataWidth-1:0] inputReW3[count3-1:0];//, inputReW3_2, inputReW3_3, inputReW3_4, inputReW3_5, inputReW3_6, inputReW3_7, inputReW3_8;

wire  [dataWidth-1:0] forReW1[count3-1:0];//, forReW1_2, forReW1_3, forReW1_4, forReW1_5, forReW1_6, forReW1_7, forReW1_8;
wire  [dataWidth-1:0] forReW2[count3-1:0];//, forReW2_2, forReW2_3, forReW2_4, forReW2_5, forReW2_6, forReW2_7, forReW2_8;
wire  [dataWidth-1:0] forReW3[count3-1:0];//, forReW3_2, forReW3_3, forReW3_4, forReW3_5, forReW3_6, forReW3_7, forReW3_8;

wire  [dataWidth-1:0] cellReW1[count3-1:0];//, cellReW1_2, cellReW1_3, cellReW1_4, cellReW1_5, cellReW1_6, cellReW1_7, cellReW1_8;
wire  [dataWidth-1:0] cellReW2[count3-1:0];//, cellReW2_2, cellReW2_3, cellReW2_4, cellReW2_5, cellReW2_6, cellReW2_7, cellReW2_8;
wire  [dataWidth-1:0] cellReW3[count3-1:0];//, cellReW3_2, cellReW3_3, cellReW3_4, cellReW3_5, cellReW3_6, cellReW3_7, cellReW3_8;

wire  [dataWidth-1:0] outReW1[count3-1:0];//, outReW1_2, outReW1_3, outReW1_4, outReW1_5, outReW1_6, outReW1_7, outReW1_8;
wire  [dataWidth-1:0] outReW2[count3-1:0];//, outReW2_2, outReW2_3, outReW2_4, outReW2_5, outReW2_6, outReW2_7, outReW2_8;
wire  [dataWidth-1:0] outReW3[count3-1:0];//, outReW3_2, outReW3_3, outReW3_4, outReW3_5, outReW3_6, outReW3_7, outReW3_8;


(* max_fanout = 50 *) reg[9:0] l = 0;
(* max_fanout = 50 *) reg[9:0] m = 0;
(* max_fanout = 50 *) reg[9:0] n = 0;
(* max_fanout = 50 *) reg[9:0] o = 0;

(* max_fanout = 50 *) reg[9:0] m1 = 0;
(* max_fanout = 50 *) reg[9:0] m2 = 0;
(* max_fanout = 50 *) reg[9:0] m3 = 0;
(* max_fanout = 50 *) reg[9:0] m4 = 0;

(* max_fanout = 50 *) reg[9:0] l1 = 0;
(* max_fanout = 50 *) reg[9:0] l2 = 0;
(* max_fanout = 50 *) reg[9:0] l3 = 0;
(* max_fanout = 50 *) reg[9:0] l4 = 0;

(* max_fanout = 50 *) reg[9:0] ll = 0;
(* max_fanout = 50 *) reg[7:0] mm = 0;
(* max_fanout = 50 *) reg[7:0] nn = 0;
(* max_fanout = 50 *) reg[9:0] oo = 0;

(* max_fanout = 50 *) reg[9:0] l5 = 0;
(* max_fanout = 50 *) reg[9:0] l6 = 0;
(* max_fanout = 50 *) reg[9:0] l7 = 0;

integer k = 0;
integer i = 0;

reg [dataWidth-1:0] win = 0;

reg [31:0] outAddrCount = {32{1'b0}};
reg [31:0] outAddrCount1 = {32{1'b0}};

wire enable_tt;
wire enable_tt2;
wire enable_tt3;

//integer tt = 0;
(* max_fanout = 50 *) reg [7:0] ii=0;
(* max_fanout = 50 *) reg [7:0] kk=0;
(* max_fanout = 50 *) reg [7:0] tt=0;

(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *) reg ew  = 0;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *) reg ew2 = 0;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *) reg ew3 = 0;


//integer index2 = 0;
(* max_fanout = 100 *) reg [6:0] j1 = 0;
(* max_fanout = 100 *) reg [6:0] j2 = 0;
(* max_fanout = 100 *) reg [6:0] j3 = 0;
(* max_fanout = 100 *) reg [6:0] j4 = 0;
(* max_fanout = 100 *) reg [6:0] j5 = 0;
(* max_fanout = 100 *) reg [6:0] j6 = 0;

(* max_fanout = 100 *) reg [6:0] jjj1 = 0;
(* max_fanout = 100 *) reg [6:0] jj1 = 0; 
(* max_fanout = 100 *) reg [6:0] jjj3 = 0; 
(* max_fanout = 100 *) reg [6:0] jj3 = 0; 
(* max_fanout = 100 *) reg [6:0] jjj5 = 0; 
(* max_fanout = 100 *) reg [6:0] jj5 = 0; 

(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *) reg [8:0] ca1 = 0;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *) reg [8:0] ca3 = 0;
(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *) reg [8:0] ca5 = 0;


initial begin
//always@(*)
//begin
//    if(ap_start == 1)
//    begin
        $readmemb("FcW.mem", weights, 0, 14);
        $readmemb("inBias.mem", inputBias1_1, 0, 7);
        $readmemb("forBias.mem", forgetBias1_1, 0, 7);
        $readmemb("cellBias.mem", cellBias1_1, 0, 7);
        $readmemb("outBias.mem", outputBias1_1, 0, 7);
        $readmemb("inBias.mem", inputBias1_2, 0, 7);
        $readmemb("forBias.mem", forgetBias1_2, 0, 7);
        $readmemb("cellBias.mem", cellBias1_2, 0, 7);
        $readmemb("outBias.mem", outputBias1_2, 0, 7);
        
        $readmemb("inBias2.mem", inputBias2_1, 0, 7);
        $readmemb("forBias2.mem", forgetBias2_1, 0, 7);
        $readmemb("cellBias2.mem", cellBias2_1, 0, 7);
        $readmemb("outBias2.mem", outputBias2_1, 0, 7);
        $readmemb("inBias2.mem", inputBias2_2, 0, 7);
        $readmemb("forBias2.mem", forgetBias2_2, 0, 7);
        $readmemb("cellBias2.mem", cellBias2_2, 0, 7);
        $readmemb("outBias2.mem", outputBias2_2, 0, 7);
        
        $readmemb("inBias2.mem", inputBias3_1, 0, 7);
        $readmemb("forBias2.mem", forgetBias3_1, 0, 7);
        $readmemb("cellBias2.mem", cellBias3_1, 0, 7);
        $readmemb("outBias2.mem", outputBias3_1, 0, 7);
        $readmemb("inBias2.mem", inputBias3_2, 0, 7);
        $readmemb("forBias2.mem", forgetBias3_2, 0, 7);
        $readmemb("cellBias2.mem", cellBias3_2, 0, 7);
        $readmemb("outBias2.mem", outputBias3_2, 0, 7);
        
        $readmemb("finalBias.mem", finalBias, 0, 0);
//    end
end


assign ap_done = finished[0];
assign ap_idle = finished[0];
assign ap_ready = ~finished[0]; //{{31{1'b0}},~finished[0]}; //~finished;

reg [7:0] doneCount = 0;
reg [7:0] doneBias = 0;

always@(posedge ap_clk)
begin
    if(InGateDone1 == 1 && doneCount<12)
    begin
        doneCount <= doneCount+1;
        doneBias <= doneBias+1;
    end
    else
    begin
        doneCount <= doneCount;
        doneBias <= doneBias;
    end
end

always@(posedge ap_clk)  
begin
    if((ap_start == 1) && (finished == 0))
    begin
        if(ca1 < (hiddenUnitsLayer) && doneCount<4)
        begin
            ca1 <= ca1+1;
        end
        else if(InGateDone1 == 1)
            ca1 <= 0;
        else
            ca1 <= ca1;
     
        if(ca3 < (hiddenUnitsLayer1_1) && (enable_tt==1) && doneCount<8)
        begin
            ca3 <= ca3+1;
        end
        else if(CellGateDone1 == 1)
            ca3 <= 0;
        else
            ca3 <= ca3;      
                
        if(ca5 < (hiddenUnitsLayer1_1) && (enable_tt2==1) && doneCount<12)
        begin
            ca5 <= ca5+1;
        end
        else if(OutGateDone1 == 1)
            ca5 <= 0;
        else
            ca5 <= ca5; 
          
   end        
end

// 1st layer
always@(posedge ap_clk)  
begin
    /*if ((ap_rst_n == 0) || ((finished == 0) && (ca1 >= (hiddenUnitsLayer))))//(in_ReW_address0_1 >= (hiddenUnitsLayer*count3))))
    begin
        inputReWeight_V_ce0 <= 0;
        forgetReWeight_V_ce0 <= 0;
        cellReWeight_V_ce0 <= 0;
        outputReWeight_V_ce0 <= 0;
    end
    else*/
    begin 
        if ((ap_start == 1)  && (finished == 0) &&  (ca1 < (hiddenUnitsLayer)) && doneCount<4)//(in_ReW_address0_1 < (hiddenUnitsLayer*count3)))
        begin
            inputReWeight_V_ce0 <= 1;
            inputReWeight_V_ce0_1 <= 1;
            inputReWeight_V_ce0_2 <= 1;
            inputReWeight_V_ce0_3 <= 1;
            inputReWeight_V_ce0_4 <= 1;
            inputReWeight_V_ce0_5 <= 1;
            inputReWeight_V_ce0_6 <= 1;
            inputReWeight_V_ce0_7 <= 1;

            forgetReWeight_V_ce0 <= 1;
            forgetReWeight_V_ce0_1 <= 1;
            forgetReWeight_V_ce0_2 <= 1;
            forgetReWeight_V_ce0_3 <= 1;
            forgetReWeight_V_ce0_4 <= 1;
            forgetReWeight_V_ce0_5 <= 1;
            forgetReWeight_V_ce0_6 <= 1;
            forgetReWeight_V_ce0_7 <= 1;

            cellReWeight_V_ce0 <= 1;
            cellReWeight_V_ce0_1 <= 1;
            cellReWeight_V_ce0_2 <= 1;
            cellReWeight_V_ce0_3 <= 1;
            cellReWeight_V_ce0_4 <= 1;
            cellReWeight_V_ce0_5 <= 1;
            cellReWeight_V_ce0_6 <= 1;
            cellReWeight_V_ce0_7 <= 1;
            
            outputReWeight_V_ce0 <= 1;
            outputReWeight_V_ce0_1 <= 1;
            outputReWeight_V_ce0_2 <= 1;
            outputReWeight_V_ce0_3 <= 1;
            outputReWeight_V_ce0_4 <= 1;
            outputReWeight_V_ce0_5 <= 1;
            outputReWeight_V_ce0_6 <= 1;
            outputReWeight_V_ce0_7 <= 1;
        end 
        else
        begin            
            inputReWeight_V_ce0 <= 0;
            inputReWeight_V_ce0_1 <= 0;
            inputReWeight_V_ce0_2 <= 0;
            inputReWeight_V_ce0_3 <= 0;
            inputReWeight_V_ce0_4 <= 0;
            inputReWeight_V_ce0_5 <= 0;
            inputReWeight_V_ce0_6 <= 0;
            inputReWeight_V_ce0_7 <= 0;

            forgetReWeight_V_ce0 <= 0;
            forgetReWeight_V_ce0_1 <= 0;
            forgetReWeight_V_ce0_2 <= 0;
            forgetReWeight_V_ce0_3 <= 0;
            forgetReWeight_V_ce0_4 <= 0;
            forgetReWeight_V_ce0_5 <= 0;
            forgetReWeight_V_ce0_6 <= 0;
            forgetReWeight_V_ce0_7 <= 0;

            cellReWeight_V_ce0 <= 0;
            cellReWeight_V_ce0_1 <= 0;
            cellReWeight_V_ce0_2 <= 0;
            cellReWeight_V_ce0_3 <= 0;
            cellReWeight_V_ce0_4 <= 0;
            cellReWeight_V_ce0_5 <= 0;
            cellReWeight_V_ce0_6 <= 0;
            cellReWeight_V_ce0_7 <= 0;
            
            outputReWeight_V_ce0 <= 0;
            outputReWeight_V_ce0_1 <= 0;
            outputReWeight_V_ce0_2 <= 0;
            outputReWeight_V_ce0_3 <= 0;
            outputReWeight_V_ce0_4 <= 0;
            outputReWeight_V_ce0_5 <= 0;
            outputReWeight_V_ce0_6 <= 0;
            outputReWeight_V_ce0_7 <= 0;
        end
    end
end

//
// 2nd layer
always@(posedge ap_clk)  
begin
    /*if ((ap_rst_n == 0) || ((finished == 0) && (ca3 >= (hiddenUnitsLayer1_1))))//(in_ReW_address0_2 >= (hiddenUnitsLayer1_1*count3))))
    begin
        inputReWeight_V_ce1 <= 0;
        forgetReWeight_V_ce1 <= 0;
        cellReWeight_V_ce1 <= 0;
        outputReWeight_V_ce1 <= 0;
    end
    else*/
    begin 
        if ((ap_start == 1)  && (finished == 0) &&  (ca3 < (hiddenUnitsLayer1_1))  && (enable_tt == 1) && doneCount<8)//(in_ReW_address0_2 < (hiddenUnitsLayer1_1*count3))  && (ew == 1)  && (enGate1_1 == 0))
        begin
            inputReWeight_V_ce1 <= 1;
            inputReWeight_V_ce1_1 <= 1;
            inputReWeight_V_ce1_2 <= 1;
            inputReWeight_V_ce1_3 <= 1;
            inputReWeight_V_ce1_4 <= 1;
            inputReWeight_V_ce1_5 <= 1;
            inputReWeight_V_ce1_6 <= 1;
            inputReWeight_V_ce1_7 <= 1;
            
            forgetReWeight_V_ce1 <= 1;
            forgetReWeight_V_ce1_1 <= 1;
            forgetReWeight_V_ce1_2 <= 1;
            forgetReWeight_V_ce1_3 <= 1;
            forgetReWeight_V_ce1_4 <= 1;
            forgetReWeight_V_ce1_5 <= 1;
            forgetReWeight_V_ce1_6 <= 1;
            forgetReWeight_V_ce1_7 <= 1;
            
            cellReWeight_V_ce1 <= 1;
            cellReWeight_V_ce1_1 <= 1;
            cellReWeight_V_ce1_2 <= 1;
            cellReWeight_V_ce1_3 <= 1;
            cellReWeight_V_ce1_4 <= 1;
            cellReWeight_V_ce1_5 <= 1;
            cellReWeight_V_ce1_6 <= 1;
            cellReWeight_V_ce1_7 <= 1;
            
            outputReWeight_V_ce1 <= 1;
            outputReWeight_V_ce1_1 <= 1;
            outputReWeight_V_ce1_2 <= 1;
            outputReWeight_V_ce1_3 <= 1;
            outputReWeight_V_ce1_4 <= 1;
            outputReWeight_V_ce1_5 <= 1;
            outputReWeight_V_ce1_6 <= 1;
            outputReWeight_V_ce1_7 <= 1;
           
        end 
        else
        begin            
            inputReWeight_V_ce1 <= 0;
            inputReWeight_V_ce1_1 <= 0;
            inputReWeight_V_ce1_2 <= 0;
            inputReWeight_V_ce1_3 <= 0;
            inputReWeight_V_ce1_4 <= 0;
            inputReWeight_V_ce1_5 <= 0;
            inputReWeight_V_ce1_6 <= 0;
            inputReWeight_V_ce1_7 <= 0;
            
            forgetReWeight_V_ce1 <= 0;
            forgetReWeight_V_ce1_1 <= 0;
            forgetReWeight_V_ce1_2 <= 0;
            forgetReWeight_V_ce1_3 <= 0;
            forgetReWeight_V_ce1_4 <= 0;
            forgetReWeight_V_ce1_5 <= 0;
            forgetReWeight_V_ce1_6 <= 0;
            forgetReWeight_V_ce1_7 <= 0;
            
            cellReWeight_V_ce1 <= 0;
            cellReWeight_V_ce1_1 <= 0;
            cellReWeight_V_ce1_2 <= 0;
            cellReWeight_V_ce1_3 <= 0;
            cellReWeight_V_ce1_4 <= 0;
            cellReWeight_V_ce1_5 <= 0;
            cellReWeight_V_ce1_6 <= 0;
            cellReWeight_V_ce1_7 <= 0;
            
            outputReWeight_V_ce1 <= 0;
            outputReWeight_V_ce1_1 <= 0;
            outputReWeight_V_ce1_2 <= 0;
            outputReWeight_V_ce1_3 <= 0;
            outputReWeight_V_ce1_4 <= 0;
            outputReWeight_V_ce1_5 <= 0;
            outputReWeight_V_ce1_6 <= 0;
            outputReWeight_V_ce1_7 <= 0;
        end
    end
end


// 3rd Layer
always@(posedge ap_clk)  
begin
    /*if ((ap_rst_n == 0) || ((finished == 0) && (ca5 >= (hiddenUnitsLayer1_1*count1))))//(in_ReW_address0_3 >= (hiddenUnitsLayer1_1*count3))))
    begin
        inputReWeight_V_ce2 <= 0;
        forgetReWeight_V_ce2 <= 0;
        cellReWeight_V_ce2 <= 0;
        outputReWeight_V_ce2 <= 0;
    end
    else*/
    begin 
        if ((ap_start == 1)  && (finished == 0) &&  (ca5 < (hiddenUnitsLayer1_1))  && (enable_tt2 == 1) && doneCount<12)//(in_ReW_address0_3 < (hiddenUnitsLayer1_1*count3)) && (ew2 == 1)  && (enGate1_1 == 0))
        begin
            inputReWeight_V_ce2 <= 1;
            inputReWeight_V_ce2_1 <= 1;
            inputReWeight_V_ce2_2 <= 1;
            inputReWeight_V_ce2_3 <= 1;
            inputReWeight_V_ce2_4 <= 1;
            inputReWeight_V_ce2_5 <= 1;
            inputReWeight_V_ce2_6 <= 1;
            inputReWeight_V_ce2_7 <= 1;
            
            forgetReWeight_V_ce2 <= 1;
            forgetReWeight_V_ce2_1 <= 1;
            forgetReWeight_V_ce2_2 <= 1;
            forgetReWeight_V_ce2_3 <= 1;
            forgetReWeight_V_ce2_4 <= 1;
            forgetReWeight_V_ce2_5 <= 1;
            forgetReWeight_V_ce2_6 <= 1;
            forgetReWeight_V_ce2_7 <= 1;
            
            cellReWeight_V_ce2 <= 1;
            cellReWeight_V_ce2_1 <= 1;
            cellReWeight_V_ce2_2 <= 1;
            cellReWeight_V_ce2_3 <= 1;
            cellReWeight_V_ce2_4 <= 1;
            cellReWeight_V_ce2_5 <= 1;
            cellReWeight_V_ce2_6 <= 1;
            cellReWeight_V_ce2_7 <= 1;
            
            outputReWeight_V_ce2 <= 1;
            outputReWeight_V_ce2_1 <= 1;
            outputReWeight_V_ce2_2 <= 1;
            outputReWeight_V_ce2_3 <= 1;
            outputReWeight_V_ce2_4 <= 1;
            outputReWeight_V_ce2_5 <= 1;
            outputReWeight_V_ce2_6 <= 1;
            outputReWeight_V_ce2_7 <= 1;
        end 
        else
        begin            
            inputReWeight_V_ce2 <= 0;
            inputReWeight_V_ce2_1 <= 0;
            inputReWeight_V_ce2_2 <= 0;
            inputReWeight_V_ce2_3 <= 0;
            inputReWeight_V_ce2_4 <= 0;
            inputReWeight_V_ce2_5 <= 0;
            inputReWeight_V_ce2_6 <= 0;
            inputReWeight_V_ce2_7 <= 0;
            
            forgetReWeight_V_ce2 <= 0;
            forgetReWeight_V_ce2_1 <= 0;
            forgetReWeight_V_ce2_2 <= 0;
            forgetReWeight_V_ce2_3 <= 0;
            forgetReWeight_V_ce2_4 <= 0;
            forgetReWeight_V_ce2_5 <= 0;
            forgetReWeight_V_ce2_6 <= 0;
            forgetReWeight_V_ce2_7 <= 0;
            
            cellReWeight_V_ce2 <= 0;
            cellReWeight_V_ce2_1 <= 0;
            cellReWeight_V_ce2_2 <= 0;
            cellReWeight_V_ce2_3 <= 0;
            cellReWeight_V_ce2_4 <= 0;
            cellReWeight_V_ce2_5 <= 0;
            cellReWeight_V_ce2_6 <= 0;
            cellReWeight_V_ce2_7 <= 0;
            
            outputReWeight_V_ce2 <= 0;
            outputReWeight_V_ce2_1 <= 0;
            outputReWeight_V_ce2_2 <= 0;
            outputReWeight_V_ce2_3 <= 0;
            outputReWeight_V_ce2_4 <= 0;
            outputReWeight_V_ce2_5 <= 0;
            outputReWeight_V_ce2_6 <= 0;
            outputReWeight_V_ce2_7 <= 0;
        end
    end
end

// 1st layer
always@(posedge ap_clk)
begin
    if (ap_rst_n == 0)
    begin
            in_ReW_address0_1 <= 0;
            for_ReW_address0_1 <= 0;
            cell_ReW_address0_1 <= 0;
            out_ReW_address0_1 <= 0;
            
            in_ReW_address0_1_2 <= 0;
            for_ReW_address0_1_2 <= 0;
            cell_ReW_address0_1_2 <= 0;
            out_ReW_address0_1_2 <= 0;
            
            in_ReW_address0_1_3 <= 0;
            for_ReW_address0_1_3 <= 0;
            cell_ReW_address0_1_3 <= 0;
            out_ReW_address0_1_3 <= 0;
            
            in_ReW_address0_1_4 <= 0;
            for_ReW_address0_1_4 <= 0;
            cell_ReW_address0_1_4 <= 0;
            out_ReW_address0_1_4 <= 0;

            in_ReW_address0_1_5 <= 0;
            for_ReW_address0_1_5 <= 0;
            cell_ReW_address0_1_5 <= 0;
            out_ReW_address0_1_5 <= 0;
            
            in_ReW_address0_1_6 <= 0;
            for_ReW_address0_1_6 <= 0;
            cell_ReW_address0_1_6 <= 0;
            out_ReW_address0_1_6 <= 0;            

            in_ReW_address0_1_7 <= 0;
            for_ReW_address0_1_7 <= 0;
            cell_ReW_address0_1_7 <= 0;
            out_ReW_address0_1_7 <= 0; 
            
            in_ReW_address0_1_8 <= 0;
            for_ReW_address0_1_8 <= 0;
            cell_ReW_address0_1_8 <= 0;
            out_ReW_address0_1_8 <= 0;  
                                            
            in_ReW_address1_1 <= 0;
            in_ReW_address1_2 <= 0;
            in_ReW_address1_3 <= 0;
            in_ReW_address1_1_2 <= 0;
            in_ReW_address1_2_2 <= 0;
            in_ReW_address1_3_2 <= 0;
            in_ReW_address1_1_3 <= 0;
            in_ReW_address1_2_3 <= 0;
            in_ReW_address1_3_3 <= 0;
            in_ReW_address1_1_4 <= 0;
            in_ReW_address1_2_4 <= 0;
            in_ReW_address1_3_4 <= 0;
            in_ReW_address1_1_5 <= 0;
            in_ReW_address1_2_5 <= 0;
            in_ReW_address1_3_5 <= 0;
            in_ReW_address1_1_6 <= 0;
            in_ReW_address1_2_6 <= 0;
            in_ReW_address1_3_6 <= 0;
            in_ReW_address1_1_7 <= 0;
            in_ReW_address1_2_7 <= 0;
            in_ReW_address1_3_7 <= 0;
            in_ReW_address1_1_8 <= 0;
            in_ReW_address1_2_8 <= 0;
            in_ReW_address1_3_8 <= 0;  
                                                         
            for_ReW_address1_1 <= 0;
            for_ReW_address1_2 <= 0;
            for_ReW_address1_3 <= 0;
            for_ReW_address1_1_2 <= 0;
            for_ReW_address1_2_2 <= 0;
            for_ReW_address1_3_2 <= 0;
            for_ReW_address1_1_3 <= 0;
            for_ReW_address1_2_3 <= 0;
            for_ReW_address1_3_3 <= 0; 
            for_ReW_address1_1_4 <= 0;
            for_ReW_address1_2_4 <= 0;
            for_ReW_address1_3_4 <= 0;           
            for_ReW_address1_1_5 <= 0;
            for_ReW_address1_2_5 <= 0;
            for_ReW_address1_3_5 <= 0;
            for_ReW_address1_1_6 <= 0;
            for_ReW_address1_2_6 <= 0;
            for_ReW_address1_3_6 <= 0;
            for_ReW_address1_1_7 <= 0;
            for_ReW_address1_2_7 <= 0;
            for_ReW_address1_3_7 <= 0;
            for_ReW_address1_1_8 <= 0;
            for_ReW_address1_2_8 <= 0;
            for_ReW_address1_3_8 <= 0;           
                                                 
            out_ReW_address1_1 <= 0;
            out_ReW_address1_2 <= 0;
            out_ReW_address1_3 <= 0;           
            out_ReW_address1_1_2 <= 0;
            out_ReW_address1_2_2 <= 0;
            out_ReW_address1_3_2 <= 0;
            out_ReW_address1_1_3 <= 0;
            out_ReW_address1_2_3 <= 0;
            out_ReW_address1_3_3 <= 0;
            out_ReW_address1_1_4 <= 0;
            out_ReW_address1_2_4 <= 0;
            out_ReW_address1_3_4 <= 0;            
            out_ReW_address1_1_5 <= 0;
            out_ReW_address1_2_5 <= 0;
            out_ReW_address1_3_5 <= 0;                        
            out_ReW_address1_1_6 <= 0;
            out_ReW_address1_2_6 <= 0;
            out_ReW_address1_3_6 <= 0;
            out_ReW_address1_1_7 <= 0;
            out_ReW_address1_2_7 <= 0;
            out_ReW_address1_3_7 <= 0;
            out_ReW_address1_1_8 <= 0;
            out_ReW_address1_2_8 <= 0;
            out_ReW_address1_3_8 <= 0;
                                                            
            cell_ReW_address1_1 <= 0;
            cell_ReW_address1_2 <= 0;
            cell_ReW_address1_3 <= 0;
            cell_ReW_address1_1_2 <= 0;
            cell_ReW_address1_2_2 <= 0;
            cell_ReW_address1_3_2 <= 0;   
            cell_ReW_address1_1_3 <= 0;
            cell_ReW_address1_2_3 <= 0;
            cell_ReW_address1_3_3 <= 0; 
            cell_ReW_address1_1_4 <= 0;
            cell_ReW_address1_2_4 <= 0;
            cell_ReW_address1_3_4 <= 0; 
            cell_ReW_address1_1_5 <= 0;
            cell_ReW_address1_2_5 <= 0;
            cell_ReW_address1_3_5 <= 0; 
            cell_ReW_address1_1_6 <= 0;
            cell_ReW_address1_2_6 <= 0;
            cell_ReW_address1_3_6 <= 0; 
            cell_ReW_address1_1_7 <= 0;
            cell_ReW_address1_2_7 <= 0;
            cell_ReW_address1_3_7 <= 0;                                                             
            cell_ReW_address1_1_8 <= 0;
            cell_ReW_address1_2_8 <= 0;
            cell_ReW_address1_3_8 <= 0;            
            j1 <= 0;    
            //j2 <= 0;  
    end
    else
    begin
        if (inputReWeight_V_ce0 == 1 || forgetReWeight_V_ce0 == 1 || cellReWeight_V_ce0 == 1 || outputReWeight_V_ce0 == 1)
        begin
            if(in_ReW_address0_1<(hiddenUnitsLayer*2)) //-1
            begin    
                    in_ReW_address0_1 <= in_ReW_address0_1+1;
                    for_ReW_address0_1 <= for_ReW_address0_1+1;
                    cell_ReW_address0_1 <= cell_ReW_address0_1+1;
                    out_ReW_address0_1 <= out_ReW_address0_1+1; 
                    
                    in_ReW_address0_1_2 <= in_ReW_address0_1_2+1;
                    for_ReW_address0_1_2 <= for_ReW_address0_1_2+1;
                    cell_ReW_address0_1_2 <= cell_ReW_address0_1_2+1;
                    out_ReW_address0_1_2 <= out_ReW_address0_1_2+1;  
                    
                    in_ReW_address0_1_3 <= in_ReW_address0_1_3+1;
                    for_ReW_address0_1_3 <= for_ReW_address0_1_3+1;
                    cell_ReW_address0_1_3 <= cell_ReW_address0_1_3+1;
                    out_ReW_address0_1_3 <= out_ReW_address0_1_3+1;
                    
                    in_ReW_address0_1_4 <= in_ReW_address0_1_4+1;
                    for_ReW_address0_1_4 <= for_ReW_address0_1_4+1;
                    cell_ReW_address0_1_4 <= cell_ReW_address0_1_4+1;
                    out_ReW_address0_1_4 <= out_ReW_address0_1_4+1;
                    
                    in_ReW_address0_1_5 <= in_ReW_address0_1_5+1;
                    for_ReW_address0_1_5 <= for_ReW_address0_1_5+1;
                    cell_ReW_address0_1_5 <= cell_ReW_address0_1_5+1;
                    out_ReW_address0_1_5 <= out_ReW_address0_1_5+1;
                    
                    in_ReW_address0_1_6 <= in_ReW_address0_1_6+1;
                    for_ReW_address0_1_6 <= for_ReW_address0_1_6+1;
                    cell_ReW_address0_1_6 <= cell_ReW_address0_1_6+1;
                    out_ReW_address0_1_6 <= out_ReW_address0_1_6+1;
                    
                    in_ReW_address0_1_7 <= in_ReW_address0_1_7+1;
                    for_ReW_address0_1_7 <= for_ReW_address0_1_7+1;
                    cell_ReW_address0_1_7 <= cell_ReW_address0_1_7+1;
                    out_ReW_address0_1_7 <= out_ReW_address0_1_7+1;
                    
                    in_ReW_address0_1_8 <= in_ReW_address0_1_8+1;
                    for_ReW_address0_1_8 <= for_ReW_address0_1_8+1;
                    cell_ReW_address0_1_8 <= cell_ReW_address0_1_8+1;
                    out_ReW_address0_1_8 <= out_ReW_address0_1_8+1;
                    
                    j1 <= j1+1;                
            end
            else
            begin
                    in_ReW_address0_1 <= in_ReW_address0_1;
                    for_ReW_address0_1 <= for_ReW_address0_1;
                    cell_ReW_address0_1 <= cell_ReW_address0_1;
                    out_ReW_address0_1 <= out_ReW_address0_1; 
                    
                    in_ReW_address0_1_2 <= in_ReW_address0_1_2;
                    for_ReW_address0_1_2 <= for_ReW_address0_1_2;
                    cell_ReW_address0_1_2 <= cell_ReW_address0_1_2;
                    out_ReW_address0_1_2 <= out_ReW_address0_1_2;  
                    
                    in_ReW_address0_1_3 <= in_ReW_address0_1_3;
                    for_ReW_address0_1_3 <= for_ReW_address0_1_3;
                    cell_ReW_address0_1_3 <= cell_ReW_address0_1_3;
                    out_ReW_address0_1_3 <= out_ReW_address0_1_3;
                    
                    in_ReW_address0_1_4 <= in_ReW_address0_1_4;
                    for_ReW_address0_1_4 <= for_ReW_address0_1_4;
                    cell_ReW_address0_1_4 <= cell_ReW_address0_1_4;
                    out_ReW_address0_1_4 <= out_ReW_address0_1_4;
                    
                    in_ReW_address0_1_5 <= in_ReW_address0_1_5;
                    for_ReW_address0_1_5 <= for_ReW_address0_1_5;
                    cell_ReW_address0_1_5 <= cell_ReW_address0_1_5;
                    out_ReW_address0_1_5 <= out_ReW_address0_1_5;
                    
                    in_ReW_address0_1_6 <= in_ReW_address0_1_6;
                    for_ReW_address0_1_6 <= for_ReW_address0_1_6;
                    cell_ReW_address0_1_6 <= cell_ReW_address0_1_6;
                    out_ReW_address0_1_6 <= out_ReW_address0_1_6;
                    
                    in_ReW_address0_1_7 <= in_ReW_address0_1_7;
                    for_ReW_address0_1_7 <= for_ReW_address0_1_7;
                    cell_ReW_address0_1_7 <= cell_ReW_address0_1_7;
                    out_ReW_address0_1_7 <= out_ReW_address0_1_7;
                    
                    in_ReW_address0_1_8 <= in_ReW_address0_1_8;
                    for_ReW_address0_1_8 <= for_ReW_address0_1_8;
                    cell_ReW_address0_1_8 <= cell_ReW_address0_1_8;
                    out_ReW_address0_1_8 <= out_ReW_address0_1_8;
                    
                    j1 <= 0;   
            end
        end
    end  
end        
// 2nd layer
always@(posedge ap_clk)
begin
    if (ap_rst_n == 0)
    begin
            in_ReW_address0_2 <= 0;
            for_ReW_address0_2 <= 0;
            cell_ReW_address0_2 <= 0;
            out_ReW_address0_2 <= 0;
            
            in_ReW_address0_2_2 <= 0;
            for_ReW_address0_2_2 <= 0;
            cell_ReW_address0_2_2 <= 0;
            out_ReW_address0_2_2 <= 0;
            
            in_ReW_address0_2_3 <= 0;
            for_ReW_address0_2_3 <= 0;
            cell_ReW_address0_2_3 <= 0;
            out_ReW_address0_2_3 <= 0;
            
            in_ReW_address0_2_4 <= 0;
            for_ReW_address0_2_4 <= 0;
            cell_ReW_address0_2_4 <= 0;
            out_ReW_address0_2_4 <= 0;
            
            in_ReW_address0_2_5 <= 0;
            for_ReW_address0_2_5 <= 0;
            cell_ReW_address0_2_5 <= 0;
            out_ReW_address0_2_5 <= 0;
            
            in_ReW_address0_2_6 <= 0;
            for_ReW_address0_2_6 <= 0;
            cell_ReW_address0_2_6 <= 0;
            out_ReW_address0_2_6 <= 0;
            
            in_ReW_address0_2_7 <= 0;
            for_ReW_address0_2_7 <= 0;
            cell_ReW_address0_2_7 <= 0;
            out_ReW_address0_2_7 <= 0;
            
            in_ReW_address0_2_8 <= 0;
            for_ReW_address0_2_8 <= 0;
            cell_ReW_address0_2_8 <= 0;
            out_ReW_address0_2_8 <= 0;
                                  
            j3 <= 0;
 //           j4 <= 0;
    end
    else
    begin
        if (inputReWeight_V_ce1 == 1 || forgetReWeight_V_ce1 == 1 || cellReWeight_V_ce1 == 1 || outputReWeight_V_ce1 == 1)
        begin

            if(in_ReW_address0_2<(hiddenUnitsLayer1_1*2))//-1
            begin    
                    in_ReW_address0_2 <= in_ReW_address0_2+1;//4'b0001;
                    for_ReW_address0_2 <= for_ReW_address0_2+1;//4'b0001;
                    cell_ReW_address0_2 <= cell_ReW_address0_2+1;//4'b0001;
                    out_ReW_address0_2 <= out_ReW_address0_2+1;//4'b0001;
                    
                    in_ReW_address0_2_2 <= in_ReW_address0_2_2+1;//4'b0001;
                    for_ReW_address0_2_2 <= for_ReW_address0_2_2+1;//4'b0001;
                    cell_ReW_address0_2_2 <= cell_ReW_address0_2_2+1;//4'b0001;
                    out_ReW_address0_2_2 <= out_ReW_address0_2_2+1;//4'b0001;
                    
                    in_ReW_address0_2_3 <= in_ReW_address0_2_3+1;//4'b0001;
                    for_ReW_address0_2_3 <= for_ReW_address0_2_3+1;//4'b0001;
                    cell_ReW_address0_2_3 <= cell_ReW_address0_2_3+1;//4'b0001;
                    out_ReW_address0_2_3 <= out_ReW_address0_2_3+1;//4'b0001;
                    
                    in_ReW_address0_2_4 <= in_ReW_address0_2_4+1;//4'b0001;
                    for_ReW_address0_2_4 <= for_ReW_address0_2_4+1;//4'b0001;
                    cell_ReW_address0_2_4 <= cell_ReW_address0_2_4+1;//4'b0001;
                    out_ReW_address0_2_4 <= out_ReW_address0_2_4+1;//4'b0001;
                    
                    in_ReW_address0_2_5 <= in_ReW_address0_2_5+1;//4'b0001;
                    for_ReW_address0_2_5 <= for_ReW_address0_2_5+1;//4'b0001;
                    cell_ReW_address0_2_5 <= cell_ReW_address0_2_5+1;//4'b0001;
                    out_ReW_address0_2_5 <= out_ReW_address0_2_5+1;//4'b0001;
                    
                    in_ReW_address0_2_6 <= in_ReW_address0_2_6+1;//4'b0001;
                    for_ReW_address0_2_6 <= for_ReW_address0_2_6+1;//4'b0001;
                    cell_ReW_address0_2_6 <= cell_ReW_address0_2_6+1;//4'b0001;
                    out_ReW_address0_2_6 <= out_ReW_address0_2_6+1;//4'b0001;
                    
                    in_ReW_address0_2_7 <= in_ReW_address0_2_7+1;//4'b0001;
                    for_ReW_address0_2_7 <= for_ReW_address0_2_7+1;//4'b0001;
                    cell_ReW_address0_2_7 <= cell_ReW_address0_2_7+1;//4'b0001;
                    out_ReW_address0_2_7 <= out_ReW_address0_2_7+1;//4'b0001;
                    
                    in_ReW_address0_2_8 <= in_ReW_address0_2_8+1;//4'b0001;
                    for_ReW_address0_2_8 <= for_ReW_address0_2_8+1;//4'b0001;
                    cell_ReW_address0_2_8 <= cell_ReW_address0_2_8+1;//4'b0001;
                    out_ReW_address0_2_8 <= out_ReW_address0_2_8+1;//4'b0001;                                                                                                                                                         

                    j3 <= j3+1;                         
             end
             else
             begin                   
                    in_ReW_address0_2 <= in_ReW_address0_2;
                    for_ReW_address0_2 <= for_ReW_address0_2;
                    cell_ReW_address0_2 <= cell_ReW_address0_2;
                    out_ReW_address0_2 <= out_ReW_address0_2;
                    
                    in_ReW_address0_2_2 <= in_ReW_address0_2_2;
                    for_ReW_address0_2_2 <= for_ReW_address0_2_2;
                    cell_ReW_address0_2_2 <= cell_ReW_address0_2_2;
                    out_ReW_address0_2_2 <= out_ReW_address0_2_2;
                    
                    in_ReW_address0_2_3 <= in_ReW_address0_2_3;
                    for_ReW_address0_2_3 <= for_ReW_address0_2_3;
                    cell_ReW_address0_2_3 <= cell_ReW_address0_2_3;
                    out_ReW_address0_2_3 <= out_ReW_address0_2_3;
                    
                    in_ReW_address0_2_4 <= in_ReW_address0_2_4;
                    for_ReW_address0_2_4 <= for_ReW_address0_2_4;
                    cell_ReW_address0_2_4 <= cell_ReW_address0_2_4;
                    out_ReW_address0_2_4 <= out_ReW_address0_2_4;
                    
                    in_ReW_address0_2_5 <= in_ReW_address0_2_5;
                    for_ReW_address0_2_5 <= for_ReW_address0_2_5;
                    cell_ReW_address0_2_5 <= cell_ReW_address0_2_5;
                    out_ReW_address0_2_5 <= out_ReW_address0_2_5;
                    
                    in_ReW_address0_2_6 <= in_ReW_address0_2_6;
                    for_ReW_address0_2_6 <= for_ReW_address0_2_6;
                    cell_ReW_address0_2_6 <= cell_ReW_address0_2_6;
                    out_ReW_address0_2_6 <= out_ReW_address0_2_6;
                    
                    in_ReW_address0_2_7 <= in_ReW_address0_2_7;
                    for_ReW_address0_2_7 <= for_ReW_address0_2_7;
                    cell_ReW_address0_2_7 <= cell_ReW_address0_2_7;
                    out_ReW_address0_2_7 <= out_ReW_address0_2_7;
                    
                    in_ReW_address0_2_8 <= in_ReW_address0_2_8;
                    for_ReW_address0_2_8 <= for_ReW_address0_2_8;
                    cell_ReW_address0_2_8 <= cell_ReW_address0_2_8;
                    out_ReW_address0_2_8 <= out_ReW_address0_2_8;
                    
                    j3 <= j3;
             end
         
         end          
      end
end

// 3rd Layer
always@(posedge ap_clk)
begin
    if (ap_rst_n == 0)
    begin            
            in_ReW_address0_3 <= 0;
            for_ReW_address0_3 <= 0;
            cell_ReW_address0_3 <= 0;
            out_ReW_address0_3 <= 0;
            
            in_ReW_address0_3_2 <= 0;
            for_ReW_address0_3_2 <= 0;
            cell_ReW_address0_3_2 <= 0;
            out_ReW_address0_3_2 <= 0;
            
            in_ReW_address0_3_3 <= 0;
            for_ReW_address0_3_3 <= 0;
            cell_ReW_address0_3_3 <= 0;
            out_ReW_address0_3_3 <= 0;
            
            in_ReW_address0_3_4 <= 0;
            for_ReW_address0_3_4 <= 0;
            cell_ReW_address0_3_4 <= 0;
            out_ReW_address0_3_4 <= 0;
            
            in_ReW_address0_3_5 <= 0;
            for_ReW_address0_3_5 <= 0;
            cell_ReW_address0_3_5 <= 0;
            out_ReW_address0_3_5 <= 0;
            
            in_ReW_address0_3_6 <= 0;
            for_ReW_address0_3_6 <= 0;
            cell_ReW_address0_3_6 <= 0;
            out_ReW_address0_3_6 <= 0;
            
            in_ReW_address0_3_7 <= 0;
            for_ReW_address0_3_7 <= 0;
            cell_ReW_address0_3_7 <= 0;
            out_ReW_address0_3_7 <= 0;
            
            in_ReW_address0_3_8 <= 0;
            for_ReW_address0_3_8 <= 0;
            cell_ReW_address0_3_8 <= 0;
            out_ReW_address0_3_8 <= 0;
            
            j5 <= 0;
    //        j6 <= 0;
    end
    else
    begin
        if (inputReWeight_V_ce2 == 1 || forgetReWeight_V_ce2 == 1 || cellReWeight_V_ce2 == 1 || outputReWeight_V_ce2 == 1)
        begin

            if(in_ReW_address0_3<(hiddenUnitsLayer1_1*2))//-1
            begin    
                    
                    in_ReW_address0_3 <= in_ReW_address0_3+1;//4'b0001;
                    for_ReW_address0_3 <= for_ReW_address0_3+1;//4'b0001;
                    cell_ReW_address0_3 <= cell_ReW_address0_3+1;//4'b0001;
                    out_ReW_address0_3 <= out_ReW_address0_3+1;//4'b0001;        
                    
                    in_ReW_address0_3_2 <= in_ReW_address0_3_2+1;
                    for_ReW_address0_3_2 <= for_ReW_address0_3_2+1;
                    cell_ReW_address0_3_2 <= cell_ReW_address0_3_2+1;
                    out_ReW_address0_3_2 <= out_ReW_address0_3_2+1;         
                    
                    in_ReW_address0_3_3 <= in_ReW_address0_3_3+1;
                    for_ReW_address0_3_3 <= for_ReW_address0_3_3+1;
                    cell_ReW_address0_3_3 <= cell_ReW_address0_3_3+1;
                    out_ReW_address0_3_3 <= out_ReW_address0_3_3+1;     

                    in_ReW_address0_3_4 <= in_ReW_address0_3_4+1;
                    for_ReW_address0_3_4 <= for_ReW_address0_3_4+1;
                    cell_ReW_address0_3_4 <= cell_ReW_address0_3_4+1;
                    out_ReW_address0_3_4 <= out_ReW_address0_3_4+1;     
                    
                    in_ReW_address0_3_5 <= in_ReW_address0_3_5+1;
                    for_ReW_address0_3_5 <= for_ReW_address0_3_5+1;
                    cell_ReW_address0_3_5 <= cell_ReW_address0_3_5+1;
                    out_ReW_address0_3_5 <= out_ReW_address0_3_5+1;     
                    
                    in_ReW_address0_3_6 <= in_ReW_address0_3_6+1;
                    for_ReW_address0_3_6 <= for_ReW_address0_3_6+1;
                    cell_ReW_address0_3_6 <= cell_ReW_address0_3_6+1;
                    out_ReW_address0_3_6 <= out_ReW_address0_3_6+1;     
                    
                    in_ReW_address0_3_7 <= in_ReW_address0_3_7+1;
                    for_ReW_address0_3_7 <= for_ReW_address0_3_7+1;
                    cell_ReW_address0_3_7 <= cell_ReW_address0_3_7+1;
                    out_ReW_address0_3_7 <= out_ReW_address0_3_7+1;     
                    
                    in_ReW_address0_3_8 <= in_ReW_address0_3_8+1;
                    for_ReW_address0_3_8 <= for_ReW_address0_3_8+1;
                    cell_ReW_address0_3_8 <= cell_ReW_address0_3_8+1;
                    out_ReW_address0_3_8 <= out_ReW_address0_3_8+1;
                                                                                
                    j5 <= j5+1;                         
             end
             else
             begin                   
                    in_ReW_address0_3 <= in_ReW_address0_3;
                    for_ReW_address0_3 <= for_ReW_address0_3;
                    cell_ReW_address0_3 <= cell_ReW_address0_3;
                    out_ReW_address0_3 <= out_ReW_address0_3;      
                    
                    in_ReW_address0_3_2 <= in_ReW_address0_3_2;
                    for_ReW_address0_3_2 <= for_ReW_address0_3_2;
                    cell_ReW_address0_3_2 <= cell_ReW_address0_3_2;
                    out_ReW_address0_3_2 <= out_ReW_address0_3_2;         
                    
                    in_ReW_address0_3_3 <= in_ReW_address0_3_3;
                    for_ReW_address0_3_3 <= for_ReW_address0_3_3;
                    cell_ReW_address0_3_3 <= cell_ReW_address0_3_3;
                    out_ReW_address0_3_3 <= out_ReW_address0_3_3;     

                    in_ReW_address0_3_4 <= in_ReW_address0_3_4;
                    for_ReW_address0_3_4 <= for_ReW_address0_3_4;
                    cell_ReW_address0_3_4 <= cell_ReW_address0_3_4;
                    out_ReW_address0_3_4 <= out_ReW_address0_3_4;     
                    
                    in_ReW_address0_3_5 <= in_ReW_address0_3_5;
                    for_ReW_address0_3_5 <= for_ReW_address0_3_5;
                    cell_ReW_address0_3_5 <= cell_ReW_address0_3_5;
                    out_ReW_address0_3_5 <= out_ReW_address0_3_5;     
                    
                    in_ReW_address0_3_6 <= in_ReW_address0_3_6;
                    for_ReW_address0_3_6 <= for_ReW_address0_3_6;
                    cell_ReW_address0_3_6 <= cell_ReW_address0_3_6;
                    out_ReW_address0_3_6 <= out_ReW_address0_3_6;     
                    
                    in_ReW_address0_3_7 <= in_ReW_address0_3_7;
                    for_ReW_address0_3_7 <= for_ReW_address0_3_7;
                    cell_ReW_address0_3_7 <= cell_ReW_address0_3_7;
                    out_ReW_address0_3_7 <= out_ReW_address0_3_7;     
                    
                    in_ReW_address0_3_8 <= in_ReW_address0_3_8;
                    for_ReW_address0_3_8 <= for_ReW_address0_3_8;
                    cell_ReW_address0_3_8 <= cell_ReW_address0_3_8;
                    out_ReW_address0_3_8 <= out_ReW_address0_3_8;  
                    
                    j5 <= j5;
             end
         end         
      end
end

/*
always@(posedge ap_clk)
begin
    if (ap_rst_n == 0)
    begin
        jjj1 <= 0;
    end
    else
    begin
            jjj1 <= j1+1;
    end
end

always@(posedge ap_clk)
begin
    if (ap_rst_n == 0)
    begin
        jjj3 <= 0;
    end
    else
    begin
            jjj3 <= j3+1;
    end
end

always@(posedge ap_clk)
begin
    if (ap_rst_n == 0)
    begin
        jjj5 <= 0;
    end
    else
    begin
            jjj5 <= j5+1;
    end
end
*/

always@(posedge ap_clk)
begin
    if(inputReWeight_V_ce0 == 1 && jjj1 <= hiddenUnitsLayer)
    begin
         //jjjj1 <= jjjj1+1;
         jj1   <= jj1+1;//jj1;
         jjj1  <= jj1;
    end
    else if(CellGateDone1 == 1)
    begin
       //jjjj1 <= 0;
         jj1 <= 0;
        jjj1 <= 0;
    end
    else
    begin
        //jjjj1 <= jjjj1;
         jj1 <= jj1;
        jjj1 <= jjj1;
    end
end

always@(posedge ap_clk)
begin
    if(inputReWeight_V_ce1 == 1 && jjj3 <= hiddenUnitsLayer1_1)
    begin
        //jjjj3 <= jjjj3+1;
         jj3 <= jj3+1;//jj3;
        jjj3 <= jj3;
    end
    else if(InGateDone1 == 1)
    begin
        //jjjj3 <= 0;
        jj3 <= 0;
        jjj3 <= 0;
    end
    else
    begin
        //jjjj3 <= jjjj3;
        jj3 <= jj3;
        jjj3 <= jjj3;
    end
end


always@(posedge ap_clk)
begin 
    if(inputReWeight_V_ce2 == 1 && jjj5 <= hiddenUnitsLayer1_1)
    begin
        //jjjj5 <= jjjj5+1;
        jj5 <= jj5+1;//jj5;
        jjj5 <= jj5;
    end
    else if(OutGateDone1 == 1)
    begin
        //jjjj5 <= 0;
        jj5 <= 0;
        jjj5 <= 0;
    end
    else
    begin
        //jjjj5 <= jjjj5;
        jj5 <= jj5;
        jjj5 <= jjj5;
    end
end

//(* max_fanout = 50 *)(*EQUIVALENT_REGISTER_REMOVAL = "NO" *) 
(*EQUIVALENT_REGISTER_REMOVAL = "NO" *) reg enable1 = 0;
(*EQUIVALENT_REGISTER_REMOVAL = "NO" *) reg enable2 = 0;
(*EQUIVALENT_REGISTER_REMOVAL = "NO" *) reg enable3 = 0;
(*EQUIVALENT_REGISTER_REMOVAL = "NO" *) reg enable4 = 0;

always@(posedge ap_clk)
begin
    if(((ca1 == hiddenUnitsLayer) || (ca3 == hiddenUnitsLayer1_1) || (ca5 == hiddenUnitsLayer1_1))&& (OutGateDone1 == 0) && doneCount<12)
    begin
         enable1 <= 1;   
         enable2 <= 1;
         enable3 <= 1;
         enable4 <= 1;    
    end
    else if(OutGateDone1 == 1)
    begin
         enable1 <= 0;
         enable2 <= 0;
         enable3 <= 0;
         enable4 <= 0;
    end
    else
    begin
         enable1 <= enable1;
         enable2 <= enable2;
         enable3 <= enable3;
         enable4 <= enable4;
    end
end


genvar p, q;
generate
    for(p=0;p<INPUT_SIZE;p=p+1)
    begin       
        always @(posedge ap_clk)
        begin
            if (rst2 == 0)
            begin
                hiddenStateF[p] <= 0;
                hiddenStateI[p] <= 0;
                hiddenStateC[p] <= 0;
                hiddenStateO[p] <= 0;
            end
            else
            begin 
                if(finished == 0 && ap_start == 1) // && new_net == 1)
                begin   
                    hiddenStateF[p] <= INPUTS[dataWidth*p+:dataWidth];
                    hiddenStateI[p] <= INPUTS[dataWidth*p+:dataWidth];
                    hiddenStateC[p] <= INPUTS[dataWidth*p+:dataWidth];
                    hiddenStateO[p] <= INPUTS[dataWidth*p+:dataWidth];
                end
            end                   
        end
    end
endgenerate

generate
    for(p=16;p<hiddenUnitsLayer;p=p+1)
    begin       
        ///initial
        always @(posedge ap_clk)
        begin
            if (rst2 == 0)
            begin
                hiddenStateF[p] <= 0;
                hiddenStateI[p] <= 0;
                hiddenStateC[p] <= 0;
                hiddenStateO[p] <= 0;
            end
            else
            begin 
                if(finished == 0 && ap_start == 1) // && new_net == 1)
                begin
      
                    hiddenStateF[p] <= 1;
                    hiddenStateI[p] <= 1;
                    hiddenStateC[p] <= 1;
                    hiddenStateO[p] <= 1;
                end
            end                   
        end
    end
endgenerate

generate
    for(q=0;q<hiddenUnitsLayer1;q=q+1)
    begin
        always @(posedge ap_clk)
        begin        
            if (rst3 == 0)
            begin
                cellState1[q] <= 0;
                cellState2[q] <= 0;
                cellState3[q] <= 0;
            end
            else 
            begin
                if((finished == 0) && (ap_start == 1)) // && new_net == 1)
                begin      
                    cellState1[q]  <= 1;
                    cellState2[q]  <= 1;
                    cellState3[q]  <= 1;
                end
            end
        end
    end
endgenerate

// input recurrent weights
// Layer 1
memory #(.RAM_WIDTH(dataWidth), .RAM_DEPTH(hiddenUnitsLayer*2), .RAM_ADDR(6), .INIT_FILE("inReW1.mem"))
inputReWeight_1_1(.clk(ap_clk),.reset(rst5), .addr0(in_ReW_address0_1), .ce0(inputReWeight_V_ce0), .wout_all(inputReW1[0]), .addr1(in_ReW_address1_1), .ce1(1'b0), .we1(1'b0), .win(win));

memory #(.RAM_WIDTH(dataWidth), .RAM_DEPTH(hiddenUnitsLayer*2), .RAM_ADDR(6), .INIT_FILE("inReW1_2.mem"))
inputReWeight_1_2(.clk(ap_clk), .reset(rst5), .addr0(in_ReW_address0_1_2), .ce0(inputReWeight_V_ce0_1), .wout_all(inputReW1[1]), .addr1(in_ReW_address1_1_2), .ce1(1'b0), .we1(1'b0), .win(win));

memory #(.RAM_WIDTH(dataWidth), .RAM_DEPTH(hiddenUnitsLayer*2), .RAM_ADDR(6), .INIT_FILE("inReW1.mem"))
inputReWeight_1_3(.clk(ap_clk), .reset(rst5), .addr0(in_ReW_address0_1_3), .ce0(inputReWeight_V_ce0_2), .wout_all(inputReW1[2]), .addr1(in_ReW_address1_1_3), .ce1(1'b0), .we1(1'b0), .win(win));

memory #(.RAM_WIDTH(dataWidth), .RAM_DEPTH(hiddenUnitsLayer*2), .RAM_ADDR(6), .INIT_FILE("inReW1_2.mem"))
inputReWeight_1_4(.clk(ap_clk), .reset(rst5), .addr0(in_ReW_address0_1_4), .ce0(inputReWeight_V_ce0_3), .wout_all(inputReW1[3]), .addr1(in_ReW_address1_1_4), .ce1(1'b0), .we1(1'b0), .win(win));

memory #(.RAM_WIDTH(dataWidth), .RAM_DEPTH(hiddenUnitsLayer*2), .RAM_ADDR(6), .INIT_FILE("inReW1.mem"))
inputReWeight_1_5(.clk(ap_clk), .reset(rst5), .addr0(in_ReW_address0_1_5), .ce0(inputReWeight_V_ce0_4), .wout_all(inputReW1[4]), .addr1(in_ReW_address1_1_5), .ce1(1'b0), .we1(1'b0), .win(win));

memory #(.RAM_WIDTH(dataWidth), .RAM_DEPTH(hiddenUnitsLayer*2), .RAM_ADDR(6), .INIT_FILE("inReW1_2.mem"))
inputReWeight_1_6(.clk(ap_clk), .reset(rst5), .addr0(in_ReW_address0_1_6), .ce0(inputReWeight_V_ce0_5), .wout_all(inputReW1[5]), .addr1(in_ReW_address1_1_6), .ce1(1'b0), .we1(1'b0), .win(win));

memory #(.RAM_WIDTH(dataWidth), .RAM_DEPTH(hiddenUnitsLayer*2), .RAM_ADDR(6), .INIT_FILE("inReW1.mem"))
inputReWeight_1_7(.clk(ap_clk), .reset(rst5), .addr0(in_ReW_address0_1_7), .ce0(inputReWeight_V_ce0_6), .wout_all(inputReW1[6]), .addr1(in_ReW_address1_1_7), .ce1(1'b0), .we1(1'b0), .win(win));

memory #(.RAM_WIDTH(dataWidth), .RAM_DEPTH(hiddenUnitsLayer*2), .RAM_ADDR(6), .INIT_FILE("inReW1_2.mem"))
inputReWeight_1_8(.clk(ap_clk), .reset(rst5), .addr0(in_ReW_address0_1_8), .ce0(inputReWeight_V_ce0_7), .wout_all(inputReW1[7]), .addr1(in_ReW_address1_1_8), .ce1(1'b0), .we1(1'b0), .win(win));

// Layer 2
memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW2.mem"))
inputReWeight_2_1(.clk(ap_clk),.reset(rst6),.addr0(in_ReW_address0_2),.ce0(inputReWeight_V_ce1),.wout_all(inputReW2[0]),.addr1(in_ReW_address1_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW2_2.mem"))
inputReWeight_2_2(.clk(ap_clk),.reset(rst6),.addr0(in_ReW_address0_2_2),.ce0(inputReWeight_V_ce1_1),.wout_all(inputReW2[1]),.addr1(in_ReW_address1_2_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW2.mem"))
inputReWeight_2_3(.clk(ap_clk),.reset(rst6),.addr0(in_ReW_address0_2_3),.ce0(inputReWeight_V_ce1_2),.wout_all(inputReW2[2]),.addr1(in_ReW_address1_2_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW2_2.mem"))
inputReWeight_2_4(.clk(ap_clk),.reset(rst6),.addr0(in_ReW_address0_2_4),.ce0(inputReWeight_V_ce1_3),.wout_all(inputReW2[3]),.addr1(in_ReW_address1_2_4),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW2.mem"))
inputReWeight_2_5(.clk(ap_clk),.reset(rst6),.addr0(in_ReW_address0_2_5),.ce0(inputReWeight_V_ce1_4),.wout_all(inputReW2[4]),.addr1(in_ReW_address1_2_5),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW2_2.mem"))
inputReWeight_2_6(.clk(ap_clk),.reset(rst6),.addr0(in_ReW_address0_2_6),.ce0(inputReWeight_V_ce1_5),.wout_all(inputReW2[5]),.addr1(in_ReW_address1_2_6),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW2.mem"))
inputReWeight_2_7(.clk(ap_clk),.reset(rst6),.addr0(in_ReW_address0_2_7),.ce0(inputReWeight_V_ce1_6),.wout_all(inputReW2[6]),.addr1(in_ReW_address1_2_7),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW2_2.mem"))
inputReWeight_2_8(.clk(ap_clk),.reset(rst6),.addr0(in_ReW_address0_2_8),.ce0(inputReWeight_V_ce1_7),.wout_all(inputReW2[7]),.addr1(in_ReW_address1_2_8),.ce1(1'b0),.we1(1'b0),.win(win));


//Layer 3
memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW3.mem"))
inputReWeight_3_1(.clk(ap_clk),.reset(rst7),.addr0(in_ReW_address0_3),.ce0(inputReWeight_V_ce2),.wout_all(inputReW3[0]),.addr1(in_ReW_address1_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW3_2.mem"))
inputReWeight_3_2(.clk(ap_clk),.reset(rst7),.addr0(in_ReW_address0_3_2),.ce0(inputReWeight_V_ce2_1),.wout_all(inputReW3[1]),.addr1(in_ReW_address1_3_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW3.mem"))
inputReWeight_3_3(.clk(ap_clk),.reset(rst7),.addr0(in_ReW_address0_3_3),.ce0(inputReWeight_V_ce2_2),.wout_all(inputReW3[2]),.addr1(in_ReW_address1_3_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW3_2.mem"))
inputReWeight_3_4(.clk(ap_clk),.reset(rst7),.addr0(in_ReW_address0_3_4),.ce0(inputReWeight_V_ce2_3),.wout_all(inputReW3[3]),.addr1(in_ReW_address1_3_4),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW3.mem"))
inputReWeight_3_5(.clk(ap_clk),.reset(rst7),.addr0(in_ReW_address0_3_5),.ce0(inputReWeight_V_ce2_4),.wout_all(inputReW3[4]),.addr1(in_ReW_address1_3_5),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW3_2.mem"))
inputReWeight_3_6(.clk(ap_clk),.reset(rst7),.addr0(in_ReW_address0_3_6),.ce0(inputReWeight_V_ce2_5),.wout_all(inputReW3[5]),.addr1(in_ReW_address1_3_6),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW3.mem"))
inputReWeight_3_7(.clk(ap_clk),.reset(rst7),.addr0(in_ReW_address0_3_7),.ce0(inputReWeight_V_ce2_6),.wout_all(inputReW3[6]),.addr1(in_ReW_address1_3_7),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("inReW3.mem"))
inputReWeight_3_8(.clk(ap_clk),.reset(rst7),.addr0(in_ReW_address0_3_8),.ce0(inputReWeight_V_ce2_7),.wout_all(inputReW3[7]),.addr1(in_ReW_address1_3_8),.ce1(1'b0),.we1(1'b0),.win(win));


// forget recurrent weights
//layer1
memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("forReW1.mem"))
forgetReWeight_1_1(.clk(ap_clk),.reset(rst8),.addr0(for_ReW_address0_1),.ce0(forgetReWeight_V_ce0),.wout_all(forReW1[0]),.addr1(for_ReW_address1_1),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("forReW1_2.mem"))
forgetReWeight_1_2(.clk(ap_clk),.reset(rst8),.addr0(for_ReW_address0_1_2),.ce0(forgetReWeight_V_ce0_1),.wout_all(forReW1[1]),.addr1(for_ReW_address1_1_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("forReW1.mem"))
forgetReWeight_1_3(.clk(ap_clk),.reset(rst8),.addr0(for_ReW_address0_1_3),.ce0(forgetReWeight_V_ce0_2),.wout_all(forReW1[2]),.addr1(for_ReW_address1_1_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("forReW1_2.mem"))
forgetReWeight_1_4(.clk(ap_clk),.reset(rst8),.addr0(for_ReW_address0_1_4),.ce0(forgetReWeight_V_ce0_3),.wout_all(forReW1[3]),.addr1(for_ReW_address1_1_4),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("forReW1.mem"))
forgetReWeight_1_5(.clk(ap_clk),.reset(rst8),.addr0(for_ReW_address0_1_5),.ce0(forgetReWeight_V_ce0_4),.wout_all(forReW1[4]),.addr1(for_ReW_address1_1_5),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("forReW1_2.mem"))
forgetReWeight_1_6(.clk(ap_clk),.reset(rst8),.addr0(for_ReW_address0_1_6),.ce0(forgetReWeight_V_ce0_5),.wout_all(forReW1[5]),.addr1(for_ReW_address1_1_6),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("forReW1.mem"))
forgetReWeight_1_7(.clk(ap_clk),.reset(rst8),.addr0(for_ReW_address0_1_7),.ce0(forgetReWeight_V_ce0_6),.wout_all(forReW1[6]),.addr1(for_ReW_address1_1_7),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("forReW1_2.mem"))
forgetReWeight_1_8(.clk(ap_clk),.reset(rst8),.addr0(for_ReW_address0_1_8),.ce0(forgetReWeight_V_ce0_7),.wout_all(forReW1[7]),.addr1(for_ReW_address1_1_8),.ce1(1'b0),.we1(1'b0),.win(win));

//layer 2
memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW2.mem"))
forgetReWeight_2_1(.clk(ap_clk),.reset(rst6),.addr0(for_ReW_address0_2),.ce0(forgetReWeight_V_ce1),.wout_all(forReW2[0]),.addr1(for_ReW_address1_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW2_2.mem"))
forgetReWeight_2_2(.clk(ap_clk),.reset(rst6),.addr0(for_ReW_address0_2_2),.ce0(forgetReWeight_V_ce1_1),.wout_all(forReW2[1]),.addr1(for_ReW_address1_2_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW2.mem"))
forgetReWeight_2_3(.clk(ap_clk),.reset(rst6),.addr0(for_ReW_address0_2_3),.ce0(forgetReWeight_V_ce1_2),.wout_all(forReW2[2]),.addr1(for_ReW_address1_2_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW2_2.mem"))
forgetReWeight_2_4(.clk(ap_clk),.reset(rst6),.addr0(for_ReW_address0_2_4),.ce0(forgetReWeight_V_ce1_3),.wout_all(forReW2[3]),.addr1(for_ReW_address1_2_4),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW2.mem"))
forgetReWeight_2_5(.clk(ap_clk),.reset(rst6),.addr0(for_ReW_address0_2_5),.ce0(forgetReWeight_V_ce1_4),.wout_all(forReW2[4]),.addr1(for_ReW_address1_2_5),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW2_2.mem"))
forgetReWeight_2_6(.clk(ap_clk),.reset(rst6),.addr0(for_ReW_address0_2_6),.ce0(forgetReWeight_V_ce1_5),.wout_all(forReW2[5]),.addr1(for_ReW_address1_2_6),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW2.mem"))
forgetReWeight_2_7(.clk(ap_clk),.reset(rst6),.addr0(for_ReW_address0_2_7),.ce0(forgetReWeight_V_ce1_6),.wout_all(forReW2[6]),.addr1(for_ReW_address1_2_7),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW2_2.mem"))
forgetReWeight_2_8(.clk(ap_clk),.reset(rst6),.addr0(for_ReW_address0_2_8),.ce0(forgetReWeight_V_ce1_7),.wout_all(forReW2[7]),.addr1(for_ReW_address1_2_8),.ce1(1'b0),.we1(1'b0),.win(win));

// layer 3
memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW3.mem"))
forgetReWeight_3_1(.clk(ap_clk),.reset(rst7),.addr0(for_ReW_address0_3),.ce0(forgetReWeight_V_ce2),.wout_all(forReW3[0]),.addr1(for_ReW_address1_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW3_2.mem"))
forgetReWeight_3_2(.clk(ap_clk),.reset(rst7),.addr0(for_ReW_address0_3_2),.ce0(forgetReWeight_V_ce2_1),.wout_all(forReW3[1]),.addr1(for_ReW_address1_3_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW3.mem"))
forgetReWeight_3_3(.clk(ap_clk),.reset(rst7),.addr0(for_ReW_address0_3_3),.ce0(forgetReWeight_V_ce2_2),.wout_all(forReW3[2]),.addr1(for_ReW_address1_3_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW3_2.mem"))
forgetReWeight_3_4(.clk(ap_clk),.reset(rst7),.addr0(for_ReW_address0_3_4),.ce0(forgetReWeight_V_ce2_3),.wout_all(forReW3[3]),.addr1(for_ReW_address1_3_4),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW3.mem"))
forgetReWeight_3_5(.clk(ap_clk),.reset(rst7),.addr0(for_ReW_address0_3_5),.ce0(forgetReWeight_V_ce2_4),.wout_all(forReW3[4]),.addr1(for_ReW_address1_3_5),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW3_2.mem"))
forgetReWeight_3_6(.clk(ap_clk),.reset(rst7),.addr0(for_ReW_address0_3_6),.ce0(forgetReWeight_V_ce2_5),.wout_all(forReW3[5]),.addr1(for_ReW_address1_3_6),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW3.mem"))
forgetReWeight_3_7(.clk(ap_clk),.reset(rst7),.addr0(for_ReW_address0_3_7),.ce0(forgetReWeight_V_ce2_6),.wout_all(forReW3[6]),.addr1(for_ReW_address1_3_7),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("forReW3_2.mem"))
forgetReWeight_3_8(.clk(ap_clk),.reset(rst7),.addr0(for_ReW_address0_3_8),.ce0(forgetReWeight_V_ce2_7),.wout_all(forReW3[7]),.addr1(for_ReW_address1_3_8),.ce1(1'b0),.we1(1'b0),.win(win));

// cell recurrent weights
//layer 1
memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("cellReW1.mem"))
cellReWeight_1_1(.clk(ap_clk),.reset(rst8),.addr0(cell_ReW_address0_1),.ce0(cellReWeight_V_ce0),.wout_all(cellReW1[0]),.addr1(cell_ReW_address1_1),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("cellReW1_2.mem"))
cellReWeight_1_2(.clk(ap_clk),.reset(rst8),.addr0(cell_ReW_address0_1_2),.ce0(cellReWeight_V_ce0_1),.wout_all(cellReW1[1]),.addr1(cell_ReW_address1_1_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("cellReW1.mem"))
cellReWeight_1_3(.clk(ap_clk),.reset(rst8),.addr0(cell_ReW_address0_1_3),.ce0(cellReWeight_V_ce0_2),.wout_all(cellReW1[2]),.addr1(cell_ReW_address1_1_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("cellReW1_2.mem"))
cellReWeight_1_4(.clk(ap_clk),.reset(rst8),.addr0(cell_ReW_address0_1_4),.ce0(cellReWeight_V_ce0_3),.wout_all(cellReW1[3]),.addr1(cell_ReW_address1_1_4),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("cellReW1.mem"))
cellReWeight_1_5(.clk(ap_clk),.reset(rst8),.addr0(cell_ReW_address0_1_5),.ce0(cellReWeight_V_ce0_4),.wout_all(cellReW1[4]),.addr1(cell_ReW_address1_1_5),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("cellReW1_2.mem"))
cellReWeight_1_6(.clk(ap_clk),.reset(rst8),.addr0(cell_ReW_address0_1_6),.ce0(cellReWeight_V_ce0_5),.wout_all(cellReW1[5]),.addr1(cell_ReW_address1_1_6),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("cellReW1.mem"))
cellReWeight_1_7(.clk(ap_clk),.reset(rst8),.addr0(cell_ReW_address0_1_7),.ce0(cellReWeight_V_ce0_6),.wout_all(cellReW1[6]),.addr1(cell_ReW_address1_1_7),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("cellReW1_2.mem"))
cellReWeight_1_8(.clk(ap_clk),.reset(rst8),.addr0(cell_ReW_address0_1_8),.ce0(cellReWeight_V_ce0_7),.wout_all(cellReW1[7]),.addr1(cell_ReW_address1_1_8),.ce1(1'b0),.we1(1'b0),.win(win));

// layer 2
memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW2.mem"))
cellReWeight_2_1(.clk(ap_clk),.reset(rst9),.addr0(cell_ReW_address0_2),.ce0(cellReWeight_V_ce1),.wout_all(cellReW2[0]),.addr1(cell_ReW_address1_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW2_2.mem"))
cellReWeight_2_2(.clk(ap_clk),.reset(rst9),.addr0(cell_ReW_address0_2_2),.ce0(cellReWeight_V_ce1_1),.wout_all(cellReW2[1]),.addr1(cell_ReW_address1_2_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW2.mem"))
cellReWeight_2_3(.clk(ap_clk),.reset(rst9),.addr0(cell_ReW_address0_2_3),.ce0(cellReWeight_V_ce1_2),.wout_all(cellReW2[2]),.addr1(cell_ReW_address1_2_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW2_2.mem"))
cellReWeight_2_4(.clk(ap_clk),.reset(rst9),.addr0(cell_ReW_address0_2_4),.ce0(cellReWeight_V_ce1_3),.wout_all(cellReW2[3]),.addr1(cell_ReW_address1_2_4),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW2.mem"))
cellReWeight_2_5(.clk(ap_clk),.reset(rst9),.addr0(cell_ReW_address0_2_5),.ce0(cellReWeight_V_ce1_4),.wout_all(cellReW2[4]),.addr1(cell_ReW_address1_2_5),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW2_2.mem"))
cellReWeight_2_6(.clk(ap_clk),.reset(rst9),.addr0(cell_ReW_address0_2_6),.ce0(cellReWeight_V_ce1_5),.wout_all(cellReW2[5]),.addr1(cell_ReW_address1_2_6),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW2.mem"))
cellReWeight_2_7(.clk(ap_clk),.reset(rst9),.addr0(cell_ReW_address0_2_7),.ce0(cellReWeight_V_ce1_6),.wout_all(cellReW2[6]),.addr1(cell_ReW_address1_2_7),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW2_2.mem"))
cellReWeight_2_8(.clk(ap_clk),.reset(rst9),.addr0(cell_ReW_address0_2_8),.ce0(cellReWeight_V_ce1_7),.wout_all(cellReW2[7]),.addr1(cell_ReW_address1_2_8),.ce1(1'b0),.we1(1'b0),.win(win));

// layer 3
memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW3.mem"))
cellReWeight_3_1(.clk(ap_clk),.reset(rst10),.addr0(cell_ReW_address0_3),.ce0(cellReWeight_V_ce2),.wout_all(cellReW3[0]),.addr1(cell_ReW_address1_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW3_2.mem"))
cellReWeight_3_2(.clk(ap_clk),.reset(rst10),.addr0(cell_ReW_address0_3_2),.ce0(cellReWeight_V_ce2_1),.wout_all(cellReW3[1]),.addr1(cell_ReW_address1_3_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW3.mem"))
cellReWeight_3_3(.clk(ap_clk),.reset(rst10),.addr0(cell_ReW_address0_3_3),.ce0(cellReWeight_V_ce2_2),.wout_all(cellReW3[2]),.addr1(cell_ReW_address1_3_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW3_2.mem"))
cellReWeight_3_4(.clk(ap_clk),.reset(rst10),.addr0(cell_ReW_address0_3_4),.ce0(cellReWeight_V_ce2_3),.wout_all(cellReW3[3]),.addr1(cell_ReW_address1_3_4),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW3.mem"))
cellReWeight_3_5(.clk(ap_clk),.reset(rst10),.addr0(cell_ReW_address0_3_5),.ce0(cellReWeight_V_ce2_4),.wout_all(cellReW3[4]),.addr1(cell_ReW_address1_3_5),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW3_2.mem"))
cellReWeight_3_6(.clk(ap_clk),.reset(rst10),.addr0(cell_ReW_address0_3_6),.ce0(cellReWeight_V_ce2_5),.wout_all(cellReW3[5]),.addr1(cell_ReW_address1_3_6),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW3.mem"))
cellReWeight_3_7(.clk(ap_clk),.reset(rst10),.addr0(cell_ReW_address0_3_7),.ce0(cellReWeight_V_ce2_6),.wout_all(cellReW3[6]),.addr1(cell_ReW_address1_3_7),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("cellReW3_2.mem"))
cellReWeight_3_8(.clk(ap_clk),.reset(rst10),.addr0(cell_ReW_address0_3_8),.ce0(cellReWeight_V_ce2_7),.wout_all(cellReW3[7]),.addr1(cell_ReW_address1_3_8),.ce1(1'b0),.we1(1'b0),.win(win));

//output recurrent weights
// Layer 1
memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("outReW1.mem"))
outputReWeight_1_1(.clk(ap_clk),.reset(rst11),.addr0(out_ReW_address0_1),.ce0(outputReWeight_V_ce0),.wout_all(outReW1[0]),.addr1(out_ReW_address1_1),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("outReW1_2.mem"))
outputReWeight_1_2(.clk(ap_clk),.reset(rst11),.addr0(out_ReW_address0_1_2),.ce0(outputReWeight_V_ce0_1),.wout_all(outReW1[1]),.addr1(out_ReW_address1_1_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("outReW1.mem"))
outputReWeight_1_3(.clk(ap_clk),.reset(rst11),.addr0(out_ReW_address0_1_3),.ce0(outputReWeight_V_ce0_2),.wout_all(outReW1[2]),.addr1(out_ReW_address1_1_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("outReW1_2.mem"))
outputReWeight_1_4(.clk(ap_clk),.reset(rst11),.addr0(out_ReW_address0_1_4),.ce0(outputReWeight_V_ce0_3),.wout_all(outReW1[3]),.addr1(out_ReW_address1_1_4),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("outReW1.mem"))
outputReWeight_1_5(.clk(ap_clk),.reset(rst11),.addr0(out_ReW_address0_1_5),.ce0(outputReWeight_V_ce0_4),.wout_all(outReW1[4]),.addr1(out_ReW_address1_1_5),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("outReW1_2.mem"))
outputReWeight_1_6(.clk(ap_clk),.reset(rst11),.addr0(out_ReW_address0_1_6),.ce0(outputReWeight_V_ce0_5),.wout_all(outReW1[5]),.addr1(out_ReW_address1_1_6),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("outReW1.mem"))
outputReWeight_1_7(.clk(ap_clk),.reset(rst11),.addr0(out_ReW_address0_1_7),.ce0(outputReWeight_V_ce0_6),.wout_all(outReW1[6]),.addr1(out_ReW_address1_1_7),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer*2)),.RAM_ADDR(6),.INIT_FILE("outReW1_2.mem"))
outputReWeight_1_8(.clk(ap_clk),.reset(rst11),.addr0(out_ReW_address0_1_8),.ce0(outputReWeight_V_ce0_7),.wout_all(outReW1[7]),.addr1(out_ReW_address1_1_8),.ce1(1'b0),.we1(1'b0),.win(win));


// Layer 2
memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW2.mem"))
outputReWeight_2_1(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_2),.ce0(outputReWeight_V_ce1),.wout_all(outReW2[0]),.addr1(out_ReW_address1_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW2_2.mem"))
outputReWeight_2_2(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_2_2),.ce0(outputReWeight_V_ce1_1),.wout_all(outReW2[1]),.addr1(out_ReW_address1_2_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW2.mem"))
outputReWeight_2_3(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_2_3),.ce0(outputReWeight_V_ce1_2),.wout_all(outReW2[2]),.addr1(out_ReW_address1_2_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW2_2.mem"))
outputReWeight_2_4(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_2_4),.ce0(outputReWeight_V_ce1_3),.wout_all(outReW2[3]),.addr1(out_ReW_address1_2_4),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW2.mem"))
outputReWeight_2_5(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_2_5),.ce0(outputReWeight_V_ce1_4),.wout_all(outReW2[4]),.addr1(out_ReW_address1_2_5),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW2_2.mem"))
outputReWeight_2_6(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_2_6),.ce0(outputReWeight_V_ce1_5),.wout_all(outReW2[5]),.addr1(out_ReW_address1_2_6),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW2.mem"))
outputReWeight_2_7(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_2_7),.ce0(outputReWeight_V_ce1_6),.wout_all(outReW2[6]),.addr1(out_ReW_address1_2_7),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW2_2.mem"))
outputReWeight_2_8(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_2_8),.ce0(outputReWeight_V_ce1_7),.wout_all(outReW2[7]),.addr1(out_ReW_address1_2_8),.ce1(1'b0),.we1(1'b0),.win(win));

// Layer 3
memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW3.mem"))
outputReWeight_3_1(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_3),.ce0(outputReWeight_V_ce2),.wout_all(outReW3[0]),.addr1(out_ReW_address1_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW3_2.mem"))
outputReWeight_3_2(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_3_2),.ce0(outputReWeight_V_ce2_1),.wout_all(outReW3[1]),.addr1(out_ReW_address1_3_2),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW3.mem"))
outputReWeight_3_3(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_3_3),.ce0(outputReWeight_V_ce2_2),.wout_all(outReW3[2]),.addr1(out_ReW_address1_3_3),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW3_2.mem"))
outputReWeight_3_4(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_3_4),.ce0(outputReWeight_V_ce2_3),.wout_all(outReW3[3]),.addr1(out_ReW_address1_3_4),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW3.mem"))
outputReWeight_3_5(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_3_5),.ce0(outputReWeight_V_ce2_4),.wout_all(outReW3[4]),.addr1(out_ReW_address1_3_5),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW3_2.mem"))
outputReWeight_3_6(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_3_6),.ce0(outputReWeight_V_ce2_5),.wout_all(outReW3[5]),.addr1(out_ReW_address1_3_6),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW3.mem"))
outputReWeight_3_7(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_3_7),.ce0(outputReWeight_V_ce2_6),.wout_all(outReW3[6]),.addr1(out_ReW_address1_3_7),.ce1(1'b0),.we1(1'b0),.win(win));

memory #(.RAM_WIDTH(dataWidth),.RAM_DEPTH((hiddenUnitsLayer1_1*2)),.RAM_ADDR(6),.INIT_FILE("outReW3_2.mem"))
outputReWeight_3_8(.clk(ap_clk),.reset(rst8),.addr0(out_ReW_address0_3_8),.ce0(outputReWeight_V_ce2_7),.wout_all(outReW3[7]),.addr1(out_ReW_address1_3_8),.ce1(1'b0),.we1(1'b0),.win(win));

genvar iiii, jjjj;
generate
    for(iiii=0;iiii<count3;iiii=iiii+1)
    begin
        always @(posedge ap_clk)
        begin
 
                if (jjj1<=(hiddenUnitsLayer) && enable_tt == 0)
                begin
                    inputReWeight1_1[iiii][dataWidth*(jjj1)+:dataWidth] <= inputReW1[iiii];
                    forReWeight1_1[iiii][dataWidth*(jjj1)+:dataWidth] <= forReW1[iiii];
                    cellReWeight1_1[iiii][dataWidth*(jjj1)+:dataWidth] <= cellReW1[iiii];
                    outReWeight1_1[iiii][dataWidth*(jjj1)+:dataWidth] <= outReW1[iiii];
                end
                else if (jjj3<=(hiddenUnitsLayer1_1) && enable_tt == 1)
                begin
                    inputReWeight1_1[iiii][dataWidth*(jjj3)+:dataWidth] <= inputReW2[iiii];
                    forReWeight1_1[iiii][dataWidth*(jjj3)+:dataWidth] <= forReW2[iiii];
                    cellReWeight1_1[iiii][dataWidth*(jjj3)+:dataWidth] <= cellReW2[iiii];
                    outReWeight1_1[iiii][dataWidth*(jjj3)+:dataWidth] <= outReW2[iiii];
                end
                else if (jjj5<=(hiddenUnitsLayer1_1) && enable_tt2 == 1)
                begin
                    inputReWeight1_1[iiii][dataWidth*(j5)+:dataWidth] <= inputReW3[iiii];
                    forReWeight1_1[iiii][dataWidth*(j5)+:dataWidth] <= forReW3[iiii];
                    cellReWeight1_1[iiii][dataWidth*(j5)+:dataWidth] <= cellReW3[iiii];
                    outReWeight1_1[iiii][dataWidth*(j5)+:dataWidth] <= outReW3[iiii];
                end                              
           end
       end
       
endgenerate  


always@(posedge ap_clk)
begin
     /*if(rst11 == 0)
     begin
        hidi1 <= {dataWidth*hiddenUnitsLayer{1'b0}};
        hidf1 <= {dataWidth*hiddenUnitsLayer{1'b0}};
        hido1 <= {dataWidth*hiddenUnitsLayer{1'b0}};
        hidc1 <= {dataWidth*hiddenUnitsLayer{1'b0}};
     end
     else*/
     begin
        if(enable_tt == 1 && enable_tt2 == 0)
        begin
            for(i=0;i<hiddenUnitsLayer1_1;i=i+1)
            begin
                hidi1[dataWidth*i+:dataWidth] <= hiddenStateI1[i];
                hidf1[dataWidth*i+:dataWidth] <= hiddenStateF1[i];
                hidc1[dataWidth*i+:dataWidth] <= hiddenStateC1[i];
                hido1[dataWidth*i+:dataWidth] <= hiddenStateO1[i];
            end
        end
        else if(enable_tt == 1 && enable_tt2 == 1)
        begin
            for(i=0;i<hiddenUnitsLayer1_1;i=i+1)
            begin
                hidi1[dataWidth*i+:dataWidth] <= hiddenStateI2[i];
                hidf1[dataWidth*i+:dataWidth] <= hiddenStateF2[i];
                hidc1[dataWidth*i+:dataWidth] <= hiddenStateC2[i];
                hido1[dataWidth*i+:dataWidth] <= hiddenStateO2[i];
            end
        end
        else if(enable_tt == 0 && enable_tt2 == 0)
        begin
            for(i=0;i<hiddenUnitsLayer;i=i+1)
            begin
                hidi1[dataWidth*i+:dataWidth] <= hiddenStateI[i];
                hidf1[dataWidth*i+:dataWidth] <= hiddenStateF[i];
                hidc1[dataWidth*i+:dataWidth] <= hiddenStateC[i];
                hido1[dataWidth*i+:dataWidth] <= hiddenStateO[i];
            end
        end
        else
        begin
            hidi1 <= {dataWidth*hiddenUnitsLayer{1'b0}};
            hidf1 <= {dataWidth*hiddenUnitsLayer{1'b0}};
            hido1 <= {dataWidth*hiddenUnitsLayer{1'b0}};
            hidc1 <= {dataWidth*hiddenUnitsLayer{1'b0}};       
        end
     end
end
/*
always@(posedge ap_clk)
begin
     l1<=l1+1;
end

always@(posedge ap_clk)
begin
        m1<=m1+1;
end
*/
always@(posedge ap_clk)
begin
    if(ap_start==1 && l<count3)
    begin
        l<=l+1;
    end
    else if(ap_start==1 && CellGateDone1==1)
        l<=0;
    else
        l<=l;
end

/*
always@(posedge ap_clk)
begin
    if(l1>2 && l2<count2)
    begin
        l2<=l2+1;
    end
    else
        l2<=l2;
end
*/
always@(posedge ap_clk)
begin
   if(ap_start==1 && m<hiddenUnitsLayer1+2)
    begin
        m <= m+1;
    end
    else
        m <= m;
end

always@(posedge ap_clk)
begin     
     if(rst12 == 0)
     begin
        cellStateFlat1 <= {(dataWidth*hiddenUnitsLayer1){1'b0}};
        cellStateFlat2 <= {(dataWidth*hiddenUnitsLayer1){1'b0}};
        cellStateFlat3 <= {(dataWidth*hiddenUnitsLayer1){1'b0}};
        weightsFlat1   <= {(dataWidth*hiddenUnitsLayer1){1'b0}};
     end
     else
     begin
        cellStateFlat1[dataWidth*(m-2)+:dataWidth] <= cellState1[(m-2)];//, cellState[l2+6], cellState[l2+5], cellState[l2+4], cellState[l2+3], cellState[l2+2], cellState[l2+1], cellState[l2]};
        cellStateFlat2[dataWidth*(m-2)+:dataWidth] <= cellState2[(m-2)];//, cellState[l3+14], cellState[l3+13], cellState[l3+12], cellState[l3+11], cellState[l3+10], cellState[l3+9], cellState[l3+8]};
        cellStateFlat3[dataWidth*(m-2)+:dataWidth] <= cellState3[(m-2)];//, cellState[l4+22], cellState[l4+21], cellState[l4+20], cellState[l4+19], cellState[l4+18], cellState[l4+17], cellState[l4+16]};
        weightsFlat1[dataWidth*(m-2)+:dataWidth]   <= weights[(m-2)];//, weights[l5+6], weights[l5+5], weights[l5+4], weights[l5+3], weights[l5+2], weights[l5+1], weights[l5]};
    end
end

always@(posedge ap_clk)
begin
    begin 
        if(enable_tt == 0 && doneBias == 0)
        begin                 
           bi[l] <= forgetBias1_1[l];//, forgetBias1[mm+1], forgetBias1[mm]};
           bf[l] <= inputBias1_1[l];//, inputBias1[mm+1], inputBias1[mm]};
           bc[l] <= cellBias1_1[l];//, cellBias1[mm+1], cellBias1[mm]} ;
           bo[l] <= outputBias1_1[l];//, outputBias1[mm+1], outputBias1[mm]};
        end
        else if(enable_tt == 0 && doneBias == 2)
        begin                 
           bi[l] <= forgetBias1_2[l];//, forgetBias1[mm+1], forgetBias1[mm]};
           bf[l] <= inputBias1_2[l];//, inputBias1[mm+1], inputBias1[mm]};
           bc[l] <= cellBias1_2[l];//, cellBias1[mm+1], cellBias1[mm]} ;
           bo[l] <= outputBias1_2[l];//, outputBias1[mm+1], outputBias1[mm]};
        end
        else if(enable_tt == 1 && doneBias == 4 && enable_tt2 == 0)
        begin                 
           bi[l] <= forgetBias2_1[l];//, forgetBias1[mm+1], forgetBias1[mm]};
           bf[l] <= inputBias2_1[l];//, inputBias1[mm+1], inputBias1[mm]};
           bc[l] <= cellBias2_1[l];//, cellBias1[mm+1], cellBias1[mm]} ;
           bo[l] <= outputBias2_1[l];//, outputBias1[mm+1], outputBias1[mm]};
        end
        else if(enable_tt == 1 && doneBias == 6 && enable_tt2 == 0)
        begin                 
           bi[l] <= forgetBias2_2[l];//, forgetBias1[mm+1], forgetBias1[mm]};
           bf[l] <= inputBias2_2[l];//, inputBias1[mm+1], inputBias1[mm]};
           bc[l] <= cellBias2_2[l];//, cellBias1[mm+1], cellBias1[mm]} ;
           bo[l] <= outputBias2_2[l];//, outputBias1[mm+1], outputBias1[mm]};
        end
        else if(doneBias == 8 && enable_tt2 == 1)
        begin                 
           bi[l] <= forgetBias3_1[l];//, forgetBias1[mm+1], forgetBias1[mm]};
           bf[l] <= inputBias3_1[l];//, inputBias1[mm+1], inputBias1[mm]};
           bc[l] <= cellBias3_1[l];//, cellBias1[mm+1], cellBias1[mm]} ;
           bo[l] <= outputBias3_1[l];//, outputBias1[mm+1], outputBias1[mm]};
        end
        else if(doneBias == 10 && enable_tt2 == 1)
        begin                 
           bi[l] <= forgetBias3_2[l];//, forgetBias1[mm+1], forgetBias1[mm]};
           bf[l] <= inputBias3_2[l];//, inputBias1[mm+1], inputBias1[mm]};
           bc[l] <= cellBias3_2[l];//, cellBias1[mm+1], cellBias1[mm]} ;
           bo[l] <= outputBias3_2[l];//, outputBias1[mm+1], outputBias1[mm]};
        end        
    end
end

always @(*)
begin
     begin
        finalBiasFlat = finalBias[k];
     end
end

  wire neuronDoneF[count3-1:0];
  wire neuronDoneI[count3-1:0];
  wire neuronDoneC[count3-1:0];
  wire neuronDoneO[count3-1:0];

// 1st Layer
  //inputGate starts
  genvar fi, ff, fc, fo;//,t;
  generate
     for(fi=0;fi<count3;fi=fi+1)
     begin
            oneHidden2
            #(
                    .dataWidth(dataWidth),
                    .fracWidth(fracWidth),
                    .hiddenSize1(hiddenUnitsLayer),
                    .act("sigmoid")
             )
             neuron1(
                    .clk(ap_clk),
                    .rst(ap_rst_n),
                    .enNeuron(enable1),
                    .hid(hidi1),
                    .ReW(inputReWeight1_1[fi]),
                    .b(bi[fi]),
                    .final(final1_1_1[fi]),
                    .done(neuronDoneI[fi])
        
             );
             assign InGateDone1 = neuronDoneI[count3-1];
     end 
  endgenerate 

//forgetGate starts    
  generate
     for(ff=0;ff<count3;ff=ff+1)
     begin
            oneHidden2
            #(
                    .dataWidth(dataWidth),
                    .fracWidth(fracWidth),
                    .hiddenSize1(hiddenUnitsLayer),
                    .act("sigmoid")
             )
             neuron1(
                    .clk(ap_clk),
                    .rst(ap_rst_n),
                    .enNeuron(enable2),
                    .hid(hidf1),
                    .ReW(forReWeight1_1[ff]),
                    .b(bf[ff]),
                    .final(final2_1_1[ff]),
                    .done(neuronDoneF[ff])
        
             );
             assign ForGateDone1 = neuronDoneF[count3-1];
     end 
  endgenerate 
//cellGate starts   
   generate
     for(fc=0;fc<count3;fc=fc+1)
     begin
            oneHidden2
            #(
                    .dataWidth(dataWidth),
                    .fracWidth(fracWidth),
                    .hiddenSize1(hiddenUnitsLayer),
                    .act("sigmoid")
             )
             neuron1(
                    .clk(ap_clk),
                    .rst(ap_rst_n),
                    .enNeuron(enable3),
                    .hid(hidc1),
                    .ReW(cellReWeight1_1[fc]),
                    .b(bc[fc]),
                    .final(final3_1_1[fc]),
                    .done(neuronDoneC[fc])
        
             );
             assign CellGateDone1 = neuronDoneC[count3-1];
     end 
  endgenerate 
  
//outGate starts
generate
     for(fo=0;fo<count3;fo=fo+1)
     begin
            oneHidden2
            #(
                    .dataWidth(dataWidth),
                    .fracWidth(fracWidth),
                    .hiddenSize1(hiddenUnitsLayer),
                    .act("sigmoid")
             )
             neuron1(
                    .clk(ap_clk),
                    .rst(ap_rst_n),
                    .enNeuron(enable4),
                    .hid(hido1),
                    .ReW(outReWeight1_1[fo]),
                    .b(bo[fo]),
                    .final(final4_1_1[fo]),//(2*dataWidth+1)*f+:(2*dataWidth+1)]),
                    .done(neuronDoneO[fo])
        
             );
             assign OutGateDone1 = neuronDoneO[count3-1];
     end 
 endgenerate 
 
 
genvar kkk, mmm;
generate
    for(kkk=0;kkk<count3;kkk=kkk+1)
    begin
        always@(posedge ap_clk)
        begin
            //if(rst19[kkk] == 0)
            //begin
            //    final1_1 <= {495{1'b0}};
            //    final2_1 <= {495{1'b0}};
            //    final3_1 <= {495{1'b0}};
            //    final4_1 <= {495{1'b0}};
        //mm <= 0;
    //end
        if (OutGateDone1==1 && ((doneCount==1) || (doneCount==5) || (doneCount==9)))
        begin
            final1_1[(dataWidth+1)*kkk+:(dataWidth+1)] <= {final1_1_1[kkk]};//, final1_1_2};
            final2_1[(dataWidth+1)*kkk+:(dataWidth+1)] <= {final2_1_1[kkk]};//, final2_1_2};
            final3_1[(dataWidth+1)*kkk+:(dataWidth+1)] <= {final3_1_1[kkk]};
            final4_1[(dataWidth+1)*kkk+:(dataWidth+1)] <= {final4_1_1[kkk]};
        end
     end
   end
endgenerate

generate
    for(mmm=count3;mmm<hiddenUnitsLayer1;mmm=mmm+1)
    begin
        always@(posedge ap_clk)
        begin
            //if(rst19[kkk] == 0)
            //begin
            //    final1_1 <= {495{1'b0}};
            //    final2_1 <= {495{1'b0}};
            //    final3_1 <= {495{1'b0}};
            //    final4_1 <= {495{1'b0}};
        //mm <= 0;
    //end
        if (OutGateDone1==1 && ((doneCount == 3) || (doneCount == 7) || (doneCount == 11)))
        begin
            final1_1[(dataWidth+1)*mmm+:(dataWidth+1)] <= {final1_1_1[mmm-count3]};//, final1_1_2};
            final2_1[(dataWidth+1)*mmm+:(dataWidth+1)] <= {final2_1_1[mmm-count3]};//, final2_1_2};
            final3_1[(dataWidth+1)*mmm+:(dataWidth+1)] <= {final3_1_1[mmm-count3]};
            final4_1[(dataWidth+1)*mmm+:(dataWidth+1)] <= {final4_1_1[mmm-count3]};
        end
     end
   end
endgenerate


always@(posedge ap_clk)
begin
    if(counter >= 142 && enable_tt == 0)
        ew <= 1;
    else if (enable_tt)
        ew <= 0;
    else
        ew <= ew;
end

        EW2
        #(
            .dataWidth(dataWidth),
            .fracWidth(fracWidth),
            .hiddenSize1(hiddenUnitsLayer1),
            .hiddenSize2(hiddenUnitsLayer1),
            //.reWeightSize(`gateReWsize),
            .actType("tangent")
        )
        elementWise
        (
            .clk(ap_clk),
            .rst(rst21),
            .enEW(ew),
            .final_ew1(final1_1),
            .final_ew2(final2_1),
            .final_ew3(final3_1),
            .final_ew4(final4_1),
            
            .cellState1(cellStateFlat1),// [0:`hiddenUnitsLayer1-1],

            .hiddenStateTemp1(hiddenStateTempFlat1),//(hiddenStateTempFlat[`dataWidth*count*tt+:`dataWidth*count]), // [0:`hiddenUnitsLayer1-1],
            .cellStateTemp2(cellStateTempFlat1),//(cellStateTempFlat[`dataWidth*count*tt+:`dataWidth*count]), // [0:`hiddenUnitsLayer1-1],

            .enOut(enable_tt)
        );



//Second layer starts        
generate
    for(p=0;p<hiddenUnitsLayer1;p=p+1)
    begin       
        ///initial
        always @(posedge ap_clk)
        begin
            if (rst2 == 0)
            begin
                hiddenStateF1[p] <= 0;
                hiddenStateI1[p] <= 0;
                hiddenStateC1[p] <= 0;
                hiddenStateO1[p] <= 0;
            end
            else
            begin 
                if(finished == 0 && ap_start == 1 && enable_tt == 1)
                begin
      
                    hiddenStateF1[p] <= hiddenStateTempFlat1[(dataWidth+1)*p+:(dataWidth+1)];
                    hiddenStateI1[p] <= hiddenStateTempFlat1[(dataWidth+1)*p+:(dataWidth+1)];
                    hiddenStateC1[p] <= hiddenStateTempFlat1[(dataWidth+1)*p+:(dataWidth+1)];
                    hiddenStateO1[p] <= hiddenStateTempFlat1[(dataWidth+1)*p+:(dataWidth+1)];
                end
            end                   
        end
    end
endgenerate

generate
    for(p=15;p<hiddenUnitsLayer1_1;p=p+1)
    begin       
        ///initial
        always @(posedge ap_clk)
        begin
            if (rst2 == 0)
            begin
                hiddenStateF1[p] <= 0;
                hiddenStateI1[p] <= 0;
                hiddenStateC1[p] <= 0;
                hiddenStateO1[p] <= 0;
            end
            else
            begin 
                if(finished == 0 && ap_start == 1 && enable_tt == 1) // && new_net == 1)
                begin      
                    hiddenStateF1[p] <= 1;
                    hiddenStateI1[p] <= 1;
                    hiddenStateC1[p] <= 1;
                    hiddenStateO1[p] <= 1;
                end
            end                   
        end
    end
endgenerate


always@(posedge ap_clk)
begin
    if(counter >= 295 && enable_tt2 == 0 && enable_tt == 1)
        ew2 <= 1;
    else if (enable_tt2)
        ew2 <= 0;
    else
        ew2 <= ew2;
end    
     
     EW2
        #(
            .dataWidth(dataWidth),
            .fracWidth(fracWidth),
            .hiddenSize1(hiddenUnitsLayer1),
            .hiddenSize2(hiddenUnitsLayer1),
            //.reWeightSize(`gateReWsize),
            .actType("tangent")
        )
        elementWise2
        (
            .clk(ap_clk),
            .rst(rst21),
            .enEW(ew2),
            .final_ew1(final1_1),
            .final_ew2(final2_1),
            .final_ew3(final3_1),
            .final_ew4(final4_1),
            
            .cellState1(cellStateFlat2),// [0:`hiddenUnitsLayer1-1],

            .hiddenStateTemp1(hiddenStateTempFlat2),//(hiddenStateTempFlat[`dataWidth*count*tt+:`dataWidth*count]), // [0:`hiddenUnitsLayer1-1],
            .cellStateTemp2(cellStateTempFlat2),//(cellStateTempFlat[`dataWidth*count*tt+:`dataWidth*count]), // [0:`hiddenUnitsLayer1-1],
            
            .enOut(enable_tt2)
        );

//Third layer starts        
generate
    for(p=0;p<hiddenUnitsLayer1;p=p+1)
    begin       
        ///initial
        always @(posedge ap_clk)
        begin
            if (rst5 == 0)
            begin
                hiddenStateF2[p] <= 0;
                hiddenStateI2[p] <= 0;
                hiddenStateC2[p] <= 0;
                hiddenStateO2[p] <= 0;
            end
            else
            begin 
                if(finished == 0 && ap_start == 1 && enable_tt2 == 1) // && new_net == 1)
                begin
      
                    hiddenStateF2[p] <= hiddenStateTempFlat2[(dataWidth+1)*p+:(dataWidth+1)];
                    hiddenStateI2[p] <= hiddenStateTempFlat2[(dataWidth+1)*p+:(dataWidth+1)];
                    hiddenStateC2[p] <= hiddenStateTempFlat2[(dataWidth+1)*p+:(dataWidth+1)];
                    hiddenStateO2[p] <= hiddenStateTempFlat2[(dataWidth+1)*p+:(dataWidth+1)];
                end
            end                   
        end
    end
endgenerate

generate
    for(p=15;p<hiddenUnitsLayer1_1;p=p+1)
    begin       
        ///initial
        always @(posedge ap_clk)
        begin
            if (rst2 == 0)
            begin
                hiddenStateF2[p] <= 0;
                hiddenStateI2[p] <= 0;
                hiddenStateC2[p] <= 0;
                hiddenStateO2[p] <= 0;
            end
            else
            begin 
                if(finished == 0 && ap_start == 1 && enable_tt2 == 1) // && new_net == 1)
                begin      
                    hiddenStateF2[p] <= 1;
                    hiddenStateI2[p] <= 1;
                    hiddenStateC2[p] <= 1;
                    hiddenStateO2[p] <= 1;
                end
            end                   
        end
    end
endgenerate

always@(posedge ap_clk)
begin
    if(counter >= 442 && enable_tt3 == 0 && enable_tt2 == 1)
        ew3 <= 1;
    else if (enable_tt3)
        ew3 <= 0;
    else
        ew3 <= ew3;
end     
     
     EW
        #(
            .dataWidth(dataWidth),
            .fracWidth(fracWidth),
            .hiddenSize1(hiddenUnitsLayer1),
            .hiddenSize2(hiddenUnitsLayer1),
            .actType("tangent")
        )
        elementWise3
        (
            .clk(ap_clk),
            .rst(rst21),
            .enEW(ew3),
            .final_ew1(final1_1),
            .final_ew2(final2_1),
            .final_ew3(final3_1),
            .final_ew4(final4_1),
            
            .cellState1(cellStateFlat3),// [0:`hiddenUnitsLayer1-1],

//            .hiddenStateTemp1(hiddenStateTempFlat3),//(hiddenStateTempFlat[`dataWidth*count*tt+:`dataWidth*count]), // [0:`hiddenUnitsLayer1-1],
//            .cellStateTemp2(cellStateTempFlat3),//(cellStateTempFlat[`dataWidth*count*tt+:`dataWidth*count]), // [0:`hiddenUnitsLayer1-1],
            
            .weights1(weightsFlat1), //[0:`hiddenUnitsLayer2-1],
            
            .out(outTemp),
            .enOut(enable_tt3)
        );
   
   

assign out_stream_Addr_A = outAddrCount;

always @(posedge ap_clk)
begin

    if(ap_rst_n == 0)
        counter <= 0;
    else
    begin
        if(ap_start == 1)//enGate1_1 == 1)
        begin
            if((enable_tt3==0))//1249)//1089)//2082)//1686) //502)//1218)(counter < 500) && 
            begin
                counter <= counter+1;
            end
            else
                counter <= counter;
        end
    end
end

reg [31:0] out_stream_temp = 0;


/*always @(*)
begin
    if(counter == 436)
    begin
        tempCount = final1_1[31:0];
    end
end*/
assign tempCount = {hiddenStateTempFlat1[31:0]};
assign tempWeight = out_stream_temp;
assign tempIn = {INPUTS[31:0]};
assign temp = counter;

always @(posedge ap_clk)
begin
   /* if(ap_rst_n == 0)
    begin
        outAddrCount <= 0;
        finished <= 32'b0;
        out_stream_Din_A <= 0;
        out_stream_temp <= 0;
    end
    else*/
    begin
        //if(counter >= 3000)//1249)//1089)//2082)//1686) //502)//if(tt>=23)//134)
        if(enable_tt3 == 1 && finished == 0)
        begin
            finished1 <= {{31{1'b0}},1'b1};
            outAddrCount1 <= outAddrCount1+1;
            finished <= finished1;
            outAddrCount <= outAddrCount1;
        end
        else
        begin
            finished <= finished;
            outAddrCount <= outAddrCount;
            finished1 <= finished1;
            outAddrCount1 <= outAddrCount1;
        end
   end
end


always @(posedge ap_clk)
begin
    /*if(ap_rst_n == 0)
    begin
        out_stream_WEN_A <= 0;
        out_stream_EN_A <= 0;
        out_stream_Din_A <= 0;
        out_stream_temp <= 0;
    end
    else
    begin*/        
        if(finished == 1)//enable_tt3 == 1)// && finished == 0)
        begin
            out_stream_WEN_A <= 4'b1111;
            out_stream_EN_A <= 1;
            out_stream_Din_A <= outTemp;
            out_stream_temp <= outTemp;
        end
        else
        begin
            out_stream_EN_A <= 0;
            out_stream_WEN_A <= 0;
            out_stream_Din_A <= out_stream_Din_A;
            out_stream_temp <= out_stream_temp;
        end
   //end
end

endmodule
