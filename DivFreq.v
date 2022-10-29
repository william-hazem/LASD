module DivFreq #(parameter nHz = 1)(input Clk_50MHz, output reg clk_out);
	
	reg [31:0] contador = 32'd0;
	
	always @(posedge Clk_50MHz)
	begin
		contador = contador+1;
		if(contador >= 25000000 / nHz)
		begin
			clk_out = !clk_out;
			contador = 32'd0;
		end
	end


endmodule