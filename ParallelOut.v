module ParallelOut(
input [7:0] Address,
				RegData,
input 		we,
				clk,
output[7:0] DataOut,
output		wren
);

assign wren = Address != 8'hFF & we;
wire enable = Address == 8'hFF & we;
reg [7:0] register;

always@(posedge clk)
	if(enable) // enable on
		register = RegData;

assign DataOut = register;

endmodule