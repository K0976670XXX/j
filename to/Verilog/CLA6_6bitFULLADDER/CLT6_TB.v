`timescale 1ns / 10ps

module CLA6_TB;
	reg [5:0] A,B;
	reg Ci;
	wire [5:0] S;
	wire Cout;
	
	integer i, j;
	CLA6 CLA (.A(A),.B(B),.Cin(Ci),.So(S),.Cout(Cout));
	
	initial 
	begin
		Ci = 1'b0; //1 bit ªº 0
		for (i=0;i<64;i=i+1)
		begin
			for (j=0;j<64;j=j+1)
			begin
				A=i;
				B=j;
				#5;  //5 ns
			end
		end
		
		Ci = 1'b1;
		for (i=0;i<64;i=i+1)
		begin
			for (j=0;j<64;j=j+1)
			begin
				A=i;
				B=j;
				#5;
			end
		end
		
		
		#50 $finish;
	end


endmodule