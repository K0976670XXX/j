`timescale 1ns / 1ps
module FullAdder(
		input A,
		input B,
		input Cin,
		output So,
		output Cout
	);
	
	wire Net1,Net2,Net3,Net4,Net5;
	xor u0(Net1,Cin,A);
	xor u1(So,Net1,B);
	
	and u2(Net2,Cin,A);
	and u3(Net3,Cin,B);
	and u4(Net4,A,B);
	
	or u5(Net5,Net2,Net3);
	or u6(Cout,Net4,Net5);
	
	// wire Net1,Net2,Net3;
	// HalfAdder u1_HalfAdder(.A(A),.B(B),.So(Net1),.Cout(Net2));
	// HalfAdder u2_HalfAdder(.A(Net1),.B(Cin),.So(So),.Cout(Net3));
	// or u1(Cout,Net2,Net3);
	
endmodule