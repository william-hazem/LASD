module Cont_M10(input clk, input res, output reg[3:0] contador);
	
	always @(posedge clk)
		if(!res)
			contador = contador == 0 ? 9 : contador - 1;
		else
			contador = 9;

endmodule