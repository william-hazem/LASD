module ModPC(input clk, input [7:0]PCi, output reg PCo);

	always@ (posedge clk)
		PCo = PCi;

endmodule 