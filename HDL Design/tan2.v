`timescale 1ns / 1ps

module tan2
    #(	
        parameter DATA_WIDTH = 16,
	    parameter FRACT_WIDTH = 12
	 )
	 (
	    input clk,
        input signed [DATA_WIDTH-1:0] X,
        output reg signed [DATA_WIDTH-1:0] Y
     );
	

    reg signed [DATA_WIDTH-1:0] temp, temp1, temp2, ytemp;
    
    //reg [N-1:0] shif_x, out_tmp;
    reg signed [DATA_WIDTH-1:0] abs_x1, abs_x2;
    
 
        
    //reg [3:0] state = 4'b0;
    ///always @(X)
    always @(posedge clk)
    begin
        //abs_x = ((-2)<<FRACT_WIDTH)*X;
        abs_x1 <= -(X<<<1);
        $display("abs_x1 = -2*X  && (X<<1): %b  %b\n", abs_x1, (X<<1));
        temp1 <= abs_x1;
        $display("temp1 = abs_x1 : %b\n", temp1);
        //begin
            if (abs_x1 < 0) 
            begin
                abs_x2 <= -abs_x1;
                $display("if abs_x<0 : %b\n", abs_x2);
            end
            else 
               abs_x2 <= abs_x1;
            if(abs_x2 >= 16'b0101000000000000) // |x| > 5
            begin
                //state = 4'b0001;
                temp <= (1<<<FRACT_WIDTH);
                $display("Temp: %b\n", temp);
            end
            else if((abs_x2 < 16'b0101000000000000) &&  (abs_x2 >= 16'b0010011000000000)) // abs_x2 >= 5'b01001)//2.375) // 2.375 =< |x| < 5
            begin
                //state = 4'b0010;
                //temp = abs_x*0.03125 + 0.84375;
//              temp  <= (((abs_x2 <<< FRACT_WIDTH) >>> 5) + 5'b00110);  //5'b01101; //5'b11011; //
                temp  <= (((abs_x2) >> (5)) + 16'b0000110110000000);
                ////temp  = (abs_x >> 5) + 16'b0011011000000000;
                $display("Temp1: %b\n", temp);
                
            end
            else if((abs_x2 >= 16'b000100000000000) &&  (abs_x2<16'b0010011000000000))// abs_x2 < 5'b01001) //5'b10011)//2.375) // 1 =< |x| < 2.375
            begin
                //state = 4'b0011;
                //temp = 0.125 * abs_x + 0.625;
 //               temp  <= (((abs_x2 <<< FRACT_WIDTH)>>> 3) + 5'b00010); // 5'b01010);
                temp  <= (((abs_x2) >> (3)) + 16'b0000101000000000);
                ////temp  = (abs_x >> 3) + 16'b0010100000000000;
                $display("Temp2: %b\n", temp);
            end
            else if((abs_x2 < 16'b000100000000000) && (abs_x2 >= 0)) // 0=< |x| < 1
            begin
                //state = 4'b0100;
                //temp = 0.25 * abs_x + 0.5;
   //             temp <= (((abs_x2 <<< FRACT_WIDTH) >>> 2) + 5'b00010); // 5'b00010);
                temp <= (((abs_x2) >> (2)) + 16'b0000100000000000);
                ////temp  = (abs_x >> 2) + 16'b0010000000000000;
                $display("Temp3: %b\n", temp);
            end
        //end //case 0000

        //begin
            if (temp1< 0) //temp1 = temp;
            begin
                //else temp1 = (1<<FRACT_WIDTH) - temp; //1 - sig(x)
                temp2 <= ((1<<(FRACT_WIDTH)) - temp); //1 - sig(x)
            end
            else
                temp2 <= temp;
            
            $display("TempFinal: %b\n", temp2);
 //          $display("TempFinal<<1: %b\n", (temp2<<<1));
        //end //case 0101
        //begin
            //Y = (1<<FRACT_WIDTH) - ((2>>FRACT_WIDTH)*temp2);
//           $display("(1<<FRACT_WIDTH) : %b\n", (1<<<FRACT_WIDTH));
//            Y <= ((1<<<FRACT_WIDTH) - (temp2<<<1))>>>FRACT_WIDTH;
                Y <= ((1<<(FRACT_WIDTH))-(temp2<<1));
         $display("Y: %d\n", Y);
        //end //case 0
    
      
    end //always
    
/*    always @(posedge clk)
    begin
        Y <= ytemp;
    end
 */       
endmodule