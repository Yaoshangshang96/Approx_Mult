`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/04 20:52:01
// Design Name: 
// Module Name: tb
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


module tb_4x4(

    );
    wire [7:0]r;
    reg [3:0]A;
    reg [3:0]B;
    integer i;
    integer j;
    reg [7:0]ErrorCounter = 0;
    reg [15:0]ErrorDistance = 0;
    reg [15:0]MaxError = 0;
    reg [31:0]RED = 0;
    initial 
    begin
     for (i = 0;i < 16;i = i + 1)
      begin
       for (j = 0;j < 16;j = j + 1)
        begin
         A = i;
         B = j;
         #1
         if (r < i * j)
          begin
           ErrorCounter =  ErrorCounter + 1'b1; //Error Occurrences
           ErrorDistance = ErrorDistance + (i * j - r);//Error Distance
           if ((i * j - r) > MaxError)//MaxError
            begin
             MaxError = (i * j - r);
            end
            RED = RED +((i * j - r)*10000)/(i*j);
          end
          
          else if(r > i * j)
          begin
           ErrorCounter = ErrorCounter + 1'b1; 
           ErrorDistance = ErrorDistance + (r - i * j);
           if ((r - i * j) > MaxError)
            begin
             MaxError = (r - i * j);
            end
            RED = RED +((r - i * j)*10000)/(i*j);
          end
        end
      end
    end
 // Due to verilog cannot display decimals, the real result of RED is calcuated as RED/10000.
  N1_4x4_mul M0(.A(A),.B(B),.R(r));
endmodule
