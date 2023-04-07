
`timescale 1 ns / 1 ps

	module LSTM_v1_0 #
	(
		// Users to add parameters here
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
        parameter addrSize1 = 9, //18//14 //7 //16 //14 //12 //9// 4//
        parameter addrSize2 = 9, // 8//14 //
        parameter addrSize3 = 9,
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 5
	)
	(
		// Users to add ports here
        output  [31:0] in_stream_Addr_A,
        output  in_stream_EN_A,
        output  [3:0] in_stream_WEN_A,
        output  [31:0] in_stream_Din_A,
        input   [31:0] in_stream_Dout_A,
        
        output [31:0] out_stream_Addr_A,
        output out_stream_EN_A,
        output [3:0] out_stream_WEN_A,
        output [31:0] out_stream_Din_A,
        input [31:0] out_stream_Dout_A,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
// Instantiation of Axi Bus Interface S00_AXI
	LSTM_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH),
		.dataWidth(dataWidth),
        .fracWidth(fracWidth),
        .INPUT_SIZE(INPUT_SIZE),
        .hiddenUnitsLayer1(hiddenUnitsLayer1),
        .hiddenUnitsLayer2(hiddenUnitsLayer2),
        .hiddenUnitsLayer3(hiddenUnitsLayer3),
        .hiddenUnitsLayer(hiddenUnitsLayer),
        .hiddenUnitsLayer1_1(hiddenUnitsLayer1_1),
        .gateReWsize1(gateReWsize1), //0 //262144 //262144 //400 //
        .gateReWsize2(gateReWsize2),
        .gateReWsize3(gateReWsize3),
        .addrSize1(addrSize1), //18//14 //7 //16 //14 //12 //9// 4//
        .addrSize2(addrSize2), // 8//14 //
        .addrSize3(addrSize3)//18//14 //7 //16 //14 //12 //9// 4//
        
	) LSTM_v1_0_S00_AXI_inst (
		.in_stream_Addr_A(in_stream_Addr_A),
        .in_stream_EN_A(in_stream_EN_A),
        .in_stream_WEN_A(in_stream_WEN_A),
        .in_stream_Din_A(in_stream_Din_A),
        .in_stream_Dout_A(in_stream_Dout_A),
        
        .out_stream_Addr_A(out_stream_Addr_A),
        .out_stream_EN_A(out_stream_EN_A),
        .out_stream_WEN_A(out_stream_WEN_A),
        .out_stream_Din_A(out_stream_Din_A),
        .out_stream_Dout_A(out_stream_Dout_A),
        
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule
