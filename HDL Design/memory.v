`timescale 1ns / 1ps
  //  Xilinx Single Port Read First RAM
  //  This code implements a parameterizable single-port read-first memory where when data
  //  is written to the memory, the output reflects the prior contents of the memory location.
  //  If the output data is not needed during writes or the last read value is desired to be
  //  retained, it is suggested to set WRITE_MODE to NO_CHANGE as it is more power efficient.
  //  If a reset or enable is not necessary, it may be tied off or removed from the code.
  //  Modify the parameters for the desired RAM characteristics.
(* keep_hierarchy = "yes" *)

module memory 
    #(  
        parameter RAM_WIDTH = 16,                  // Specify RAM data width
        parameter RAM_DEPTH = 400,                  // Specify RAM depth (number of entries)
        parameter RAM_ADDR = 9, 
        parameter RAM_PERFORMANCE = "HIGH_PERFORMANCE", // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
        parameter INIT_FILE = ""                       // Specify name/location of RAM initialization file if using one (leave blank if not)
    ) 
    ( 
    input clk,
    input we1,
    input ce0, ce1,
    input [RAM_ADDR-1:0] addr0, addr1, 
    input reset,
    input [RAM_WIDTH-1:0] win,
    //output reg [RAM_WIDTH-1:0] wout,
    ////////////output reg [RAM_WIDTH*RAM_DEPTH-1:0] wout_all
    output reg [RAM_WIDTH-1:0] wout_all
    );
    
  (* ram_style = "block" *) reg [RAM_WIDTH-1:0] mem [0:RAM_DEPTH-1];
  reg [RAM_WIDTH-1:0] tempOut;
  

  // The following code either initializes the memory values to a specified file or to all zeros to match hardware
  generate
    if (INIT_FILE != "") begin: use_init_file
      initial
        $readmemb(INIT_FILE, mem, 0, RAM_DEPTH-1);
    end else begin: init_bram_to_zero
      integer ram_index;
      initial
        for (ram_index = 0; ram_index < RAM_DEPTH; ram_index = ram_index + 1)
          mem[ram_index] = {RAM_WIDTH{1'b0}};
    end
  endgenerate

//generate

/*    reg [RAM_ADDR-1:0] i;
    always @(posedge clk)
    begin
        if(i<RAM_DEPTH)
            i<=i+1;
        else
            i<=0;
    end
*/      
    always @(posedge clk)
    begin: ramread
    //integer i;
        //for(i=0;i<RAM_DEPTH;i=i+1)
        if(reset==0)
        begin
             wout_all <= 0;
             tempOut <= 0;
        end
        else
        begin
            if (ce0==1) 
            begin
                    tempOut <= mem[addr0];
                    wout_all <= tempOut;
                    //$monitor("wout_all: %b\n", wout_all);
                    //i = i+1;
            end
        end
    end
//endgenerate

/*always @(posedge clk)
begin
    if (i<RAM_DEPTH)
        i = i+1;
    else
        i = 0;
end*/

always @(posedge clk)  
begin    
    //begin
    if (ce1) 
    begin
        if(reset == 0)
        begin
            mem[addr1] <= 0;
        end
        else if (we1) 
            mem[addr1] <= win; 
    end
    //end
end

endmodule				