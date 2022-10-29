//// ULA
/// 0 - soma 
/// 1 - subtrai
/// 2 - right shift
/// 3 - left shift

module ULA(input [3:0]A, B, input[1:0] Sel, output reg[3:0]Res);
	
	always@(*) begin
		if(Sel == 2'b00)
			Res = A + B;
		else if(Sel == 2'b01)
			Res = A - B;
		else if(Sel == 2'b10)
			Res = A >> B;
		else //(Sel == 2'b11)
			Res = A << B;
	end
	
endmodule 