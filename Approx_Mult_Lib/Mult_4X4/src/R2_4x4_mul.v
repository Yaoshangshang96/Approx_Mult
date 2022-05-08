`timescale 1ns / 1ps

module R2_4x4_mul(
input [3:0] A,
input [3:0] B,

output [7:0]R
    );
    reg [7:0] CNT=0;
    always@(*)
    begin
    if (A[0]&B[3]&C1)
    begin
    CNT = CNT +1'b1;
    end
    end
    // O6 = (I3 & I2) ^ (I1 & I0)
    // O5 = (I1 & I2) 
    LUT6_2 #(
      .INIT(64'h78887888C0C0C0C0)  
   ) LUT6_2_inst0 (
      .O6(P1),
      .O5(P0),
      .I0(B[1]), 
      .I1(A[0]),
      .I2(B[0]), 
      .I3(A[1]), 
      .I4(1'b1), 
      .I5(1'b1)  
   );
   
    // O6 = (I5 & I4) ^ (I3 & I2) ^ (I1 & I0) ^ (I4 & I3 & I2 & I1)
    LUT6_2 #(
      .INIT(64'hC7777888B8887888) //C7777888B8887888 c
      //47777888B8887888 o
   ) LUT6_2_inst1 (
      .O6(P2),
      //.O5(),
      .I0(B[2]), 
      .I1(A[0]),
      .I2(B[1]), 
      .I3(A[1]), 
      .I4(B[0]), 
      .I5(A[2])  
   ); 
   
     // O6 = (I5 & I4 & I3 & I2) | (I3 & I2 & I1 & I0) | (I5 & I4 & I1 & I0) | (I4 & I3 & I2 & I1)
     LUT6_2 #(
      .INIT(64'hF8888000C0008000) 
   ) LUT6_inst3 (
      .O6(C1),
      .O5(),
      .I0(B[2]), 
      .I1(A[0]),
      .I2(B[1]), 
      .I3(A[1]), 
      .I4(B[0]), 
      .I5(A[2])  
   ); 
   
     // O6 = (I5 & I4 & I3 & I2) | (I5 & I4 & I1 & I0) | (I3 & I2 & I1 & I0)
     LUT6_2 #(
      .INIT(64'h8000800078887888) 
   ) LUT6_inst5 (
      .O6(C2),
      .O5(S0),
      .I0(B[2]), 
      .I1(A[1]),
      .I2(B[1]), 
      .I3(A[2]), 
      .I4(1'b1), 
      .I5(1'b1)  
   ); 
   
   
     LUT6_2 #(
      .INIT(64'h07787878F8808080) //07787878F8808080
      //8778787878808080
   ) LUT6_2_inst6 (
      .O6(Prop0),
      .O5(Gen0),
      .I0(B[3]), 
      .I1(A[0]),
      .I2(S0), 
      .I3(B[0]), 
      .I4(A[3]), 
      .I5(1'b1)  
   );  
   
     // O6 = (I5 & I4 & I3 & I2) | (I5 & I4 & I1 & I0) | (I3 & I2 & I1 & I0)
     LUT6_2 #(
      .INIT(64'h8000800078887888) 
   ) LUT6_inst8 (
      .O6(C3),
      .O5(S1),
      .I0(B[2]), 
      .I1(A[2]),
      .I2(B[1]), 
      .I3(A[3]), 
      .I4(1'b1), 
      .I5(1'b1)  
   );  
   
   
     // O6 = (I1 & I0) ^ (I3 ^ I2)
     // O5 = (I1 & I0) & (I3 ^ I2)
     LUT6_2 #(
      .INIT(64'h8778877808800880) 
   ) LUT6_2_inst9 (
      .O6(Prop1),
      .O5(Gen1),
      .I0(B[3]), 
      .I1(A[1]),
      .I2(S1), 
      .I3(C2), 
      .I4(1'b1), 
      .I5(1'b1)  
   ); 
   
     // O6 = (I3 & I2) & (I1 & I0)
     // O5 = (I3 & I2) ^ (I1 & I0)
     LUT6_2 #(
      .INIT(64'h8000800078887888) 
   ) LUT6_2_inst10 (
      .O6(C4),
      .O5(S2),
      .I0(B[3]), 
      .I1(A[2]),
      .I2(B[2]), 
      .I3(A[3]), 
      .I4(1'b1), 
      .I5(1'b1)  
   ); 
   
     // O6 = (I1 & I0) ^ (I3 ^ I2)
     // O5 = (I1 & I0) & (I3 ^ I2)
     LUT6_2 #(
      .INIT(64'h8778877808800880) 
   ) LUT6_2_inst11 (
      .O6(Prop2),
      .O5(Gen2),
      .I0(C2), 
      .I1(S1),
      .I2(C3), 
      .I3(S2), 
      .I4(1'b1), 
      .I5(1'b1)  
   ); 
   
     // O6 = I4 ^ (I3 & I2) ^ (I1 & I0)
     // O5 = I4 & (I3 & I2) ^ (I1 & I0) | (I3 & I2 & I1 & I0)
     LUT6_2 #(
      .INIT(64'h87777888F8888000) 
   ) LUT6_2_inst12 (
      .O6(Prop3),
      .O5(Gen3),
      .I0(B[3]), 
      .I1(A[3]),
      .I2(C3), 
      .I3(S2), 
      .I4(C4), 
      .I5(1'b1)  
   ); 
   
   wire [3:0]carry_o;
   
   CARRY4 CARRY4_inst (
      .CO(carry_o),        
      .O({P6,P5,P4,P3}),           
      .CI(C1),       
      .CYINIT(1'b0), 
      .DI({Gen3,Gen2,Gen1,Gen0}),         
      .S({Prop3,Prop2,Prop1,Prop0})           
   );
   
   assign P7 = carry_o[3];
   assign R = {P7,P6,P5,P4,P3,P2,P1,P0};
endmodule
