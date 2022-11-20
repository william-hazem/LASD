module ModPC(input clk, input [7:0]PCi, output reg[7:0] PCo);

	always@ (posedge clk)
		PCo = PCi;

endmodule 