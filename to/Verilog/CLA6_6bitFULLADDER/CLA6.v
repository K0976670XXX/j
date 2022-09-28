`timescale 1ns / 1ps
module CLA6(
		input [5:0] A,
		input [5:0] B,
		input Cin,
		output [5:0] So,
		output Cout
	);
	
	wire C1,C2,C3,C4,C5;
	wire [5:0] G,P;
	//assign可以將其用邏輯運算單元(p.s:算術運算也可以)做處裡省去額外寫and(G,A,B);
	assign G = A & B;//AND
	assign P = A ^ B;//XOR
	
	assign C1 	= G[0] | (P[0] & Cin);
	assign C2 	= G[1] | (P[1] & (G[0] | (P[0] & Cin)));
	assign C3 	= G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & Cin)))));
	assign C4 	= G[3] | (P[3] & (G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & Cin)))))));
	assign C5 	= G[4] | (P[4] & (G[3] | (P[3] & (G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & Cin)))))))));
	assign Cout = G[5] | (P[5] & (G[4] | (P[4] & (G[3] | (P[3] & (G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & Cin)))))))))));
	FullAdder u1_FullAdder(.A(A[0]),.B(B[0]),.Cin(Cin),.So(So[0]),.Cout());
	FullAdder u2_FullAdder(.A(A[1]),.B(B[1]),.Cin(C1),.So(So[1]),.Cout());
	FullAdder u3_FullAdder(.A(A[2]),.B(B[2]),.Cin(C2),.So(So[2]),.Cout());
	FullAdder u4_FullAdder(.A(A[3]),.B(B[3]),.Cin(C3),.So(So[3]),.Cout());
	FullAdder u5_FullAdder(.A(A[4]),.B(B[4]),.Cin(C4),.So(So[4]),.Cout());
	FullAdder u6_FullAdder(.A(A[5]),.B(B[5]),.Cin(C5),.So(So[5]),.Cout());
	
endmodule