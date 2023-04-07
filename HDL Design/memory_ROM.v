
  //  Xilinx Single Port Read First RAM
  //  This code implements a parameterizable single-port read-first memory where when data
  //  is written to the memory, the output reflects the prior contents of the memory location.
  //  If the output data is not needed during writes or the last read value is desired to be
  //  retained, it is suggested to set WRITE_MODE to NO_CHANGE as it is more power efficient.
  //  If a reset or enable is not necessary, it may be tied off or removed from the code.
  //  Modify the parameters for the desired RAM characteristics.
module memory_ROM 
    #(  
        parameter RAM_WIDTH = 16,                  // Specify RAM data width
        parameter RAM_DEPTH = 400,                  // Specify RAM depth (number of entries)
        parameter RAM_ADDR = 9, 
        parameter RAM_PERFORMANCE = "HIGH_PERFORMANCE", // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
        parameter INIT_FILE = ""                       // Specify name/location of RAM initialization file if using one (leave blank if not)
    ) 
    ( 
    input clk,
    input we0, we1,
    input ce0, ce1,
    input [RAM_ADDR-1:0] addr0, addr1,
    //input [RAM_WIDTH*RAM_DEPTH-1:0] radd,
    input [RAM_WIDTH-1:0] win,
    output reg [RAM_WIDTH-1:0] wout
    );
    
  (* ram_style = "block" *) reg [RAM_WIDTH-1:0] mem [0:RAM_DEPTH-1];
  
always @(posedge clk)  
begin 
    if (ce0) begin
        if (we0) 
            mem[addr0] <= win; 
        wout <= mem[addr0];
    end
end

endmodule					
						