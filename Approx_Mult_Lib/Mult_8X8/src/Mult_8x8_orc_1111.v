module Mult_8x8_orc_1111(
input [7:0] A,
input [7:0] B,
output [15:0]R
);
wire [7:0]prod1;
wire [7:0]prod2;
wire [7:0]prod3;
wire [7:0]prod4;

R1_4x4_mul M0(.A(A[3:0]),.B(B[3:0]),.R(prod1));
R1_4x4_mul M1(.A(A[3:0]),.B(B[7:4]),.R(prod2));
R1_4x4_mul M2(.A(A[7:4]),.B(B[3:0]),.R(prod3));
R1_4x4_mul M3(.A(A[7:4]),.B(B[7:4]),.R(prod4));
OR_C adder0(.prod1(prod1),.prod2(prod2),.prod3(prod3),.prod4(prod4),.PROD(R));
endmodule
