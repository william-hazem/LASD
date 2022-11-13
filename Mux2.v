module Mux2 #(parameter n=8)(input control, input [n-1:0]x0, x1, output reg [n-1:0]Y);

	always@(*)
		Y = control ? x1 : x0;

endmodule