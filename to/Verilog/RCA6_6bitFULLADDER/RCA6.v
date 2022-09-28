`timescale 1ns / 1ps
module RCA6(
		input [5:0] A,
		input [5:0] B,
		input Cin,
		output [5:0] So,
		output Cout
	);
	
	wire C1,C2,C3,C4,C5;//用於將點連起來的線
	//以下為建立多個子FullAdder的子元件，並將其串起成RTA電路
	FullAdder R1(.A(A[0]),.B(B[0]),.Cin(Cin),.So(So[0]),.Cout(C1));
	FullAdder R2(.A(A[1]),.B(B[1]),.Cin(C1),.So(So[1]),.Cout(C2));
	FullAdder R3(.A(A[2]),.B(B[2]),.Cin(C2),.So(So[2]),.Cout(C3));
	FullAdder R4(.A(A[3]),.B(B[3]),.Cin(C3),.So(So[3]),.Cout(C4));
	FullAdder R5(.A(A[4]),.B(B[4]),.Cin(C4),.So(So[4]),.Cout(C5));
	FullAdder R6(.A(A[5]),.B(B[5]),.Cin(C5),.So(So[5]),.Cout(Cout));
endmodule