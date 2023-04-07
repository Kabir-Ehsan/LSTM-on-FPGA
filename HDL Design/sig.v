`timescale 1ns / 1ps

(* keep_hierarchy = "yes" *)
module sig
    #(	
        parameter DATA_WIDTH = 16,
	    parameter FRACT_WIDTH = 12
	 )
	 (
	    input clk,
	    input rst,
        input signed [DATA_WIDTH-1:0] X,
        output reg signed [DATA_WIDTH-1:0] Y
     );
	

    (*dont_touch = "true"*) reg signed [DATA_WIDTH-1:0] temp = 0;
    
    //reg [N-1:0] shif_x, out_tmp;
    (*dont_touch = "true"*) reg signed [DATA_WIDTH-1:0] abs_x = 0;
    //reg [3:0] state = 4'b0;
    //always @(clk,X)
    always @(posedge clk)
    begin
       if (rst == 0)
       begin
            //temp <=0;
            //abs_x <= 0;
            Y = 0;
       end
       else
       begin
            if (X > 0) Y = temp;// >>> FRACT_WIDTH);
            else Y = ((1<<<FRACT_WIDTH) - temp); //>>> FRACT_WIDTH; //1 - sig(x)
       end
       
    end
    always @(posedge clk)
    begin
            if (X < 0) 
            begin
                abs_x = -X;
  //              $display("abs_x = -X: %d  && X = %d", abs_x, X);
            end     
            else
            begin 
                abs_x = X;
 //               $display("abs_x = X: %d  && X = %d", abs_x, X);
            end
    end
    always @(posedge clk)
    begin
            if(abs_x >= 16'b0101000000000000) // |x| > 5
            begin
                //state = 4'b0001;
//                $monitor("entering 1");
                temp = (1<<<FRACT_WIDTH);
   //             $display("Temp: %b\n", temp);
            end
            else if((abs_x <16'b0101000000000000) &&  (abs_x >= 16'b0010011000000000)) // abs_x >= 5'b01001) //5'b10011)//2.375) // 2.375 =< |x| < 5
            begin
                //state = 4'b0010;
                //temp = abs_x*0.03125 + 0.84375;     
//                $monitor("entering 2");           
//                temp  <= (((abs_x <<< FRACT_WIDTH) >>> 5) + 5'b00110);  //5'b01101);
                  
//                  temp  <= (((abs_x<<< FRACT_WIDTH) >>> (FRACT_WIDTH-5)) + 16'b0011011000000000);
                  temp  = (((abs_x) >> (5)) + 16'b0000110110000000);
//                $monitor("Right shift x by 5: %d", ((abs_x << FRACT_WIDTH) >> 5));
    //            $display("Temp1: %b\n", temp);
            end
//            else if(abs_x >= 1 &&  (abs_x <<< FRACT_WIDTH) < 16'b0100110000000000)
            else if((abs_x >= 16'b000100000000000) &&  (abs_x<16'b0010011000000000)) //abs_x < 5'b01001) //5'b10011)//2.375) // 1 =< |x| < 2.375
            begin
                //state = 4'b0011;
                //temp = 0.125 * abs_x + 0.625;
//                $monitor("entering 3");
//                temp  <= (((abs_x <<< FRACT_WIDTH)>>> 3) + 5'b00010); // 5'b01010);

                  temp  = (((abs_x) >> (3)) + 16'b0000101000000000);
                  
//                temp  <= (((abs_x<<< FRACT_WIDTH) >>> (FRACT_WIDTH-3)) + 16'b0010100000000000);
   //             $display("Temp2: %b\n", temp);
//                $monitor("Right shift x by 3: %d", ((abs_x << FRACT_WIDTH)>> 3));
            end
            else if(abs_x <16'b000100000000000 && abs_x >= 0) // 0=< |x| < 1
            begin
                //state = 4'b0100;
                //temp = 0.25 * abs_x + 0.5;
//                $monitor("entering 4");
//               temp  <= (((abs_x <<< FRACT_WIDTH) >>> 2) + 5'b00010); // 5'b00010); 
//                  temp <= (((abs_x<<< FRACT_WIDTH) >>> (FRACT_WIDTH-2)) + 16'b0010000000000000); 

                  temp = (((abs_x) >> (2)) + 16'b0000100000000000);
//                $monitor("Right shift x by 2: %d", ((abs_x << FRACT_WIDTH) >> 2));
//                $display("Temp3: %b\n", temp);
            end
      end //case 0000
/*
    always @(posedge clk)
    begin
        if (X > 0) Y = temp;// >>> FRACT_WIDTH);
        else Y = ((1<<<FRACT_WIDTH) - temp); //>>> FRACT_WIDTH; //1 - sig(x)
 
    end //case 0101
        //5 in 8 bits b1010000
        //1 in 8 bits b00010000
        //2.37 in 8 bits b0100110
        //0.84375 in 8 bits b00001101
        //0.625 in 8 bits b00001010
        //0.25 in 8 bits b00000100
*/
endmodule

