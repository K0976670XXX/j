`timescale 1ns / 10ps
module RTA6_TB;
	reg [5:0] A,B;
	reg Ci;
	wire [5:0] S;
	wire Cout;
	integer i, j;  //等於reg [31:0]
    //因為模擬電路動作檔雖然只控制輸入但是為了做模擬，
    //因此So和Cout才給他線使他能輸出訊號
    RCA6 RCA(.A(A),.B(B),.Cin(Ci),.So(S),.Cout(Cout));
	
	initial 
	begin
		Ci = 1'b0; //1 bit 的 0
		for (i=0;i<64;i=i+1)
		begin
			for (j=0;j<64;j=j+1)
			begin
				A=i;
				B=j;
				#5;  //delay 5 ns
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
		#50 $finish;//結束
	end
endmodule