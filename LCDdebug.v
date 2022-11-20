module LCDdebug #(parameter n=8, bits=8)(input clk, input [bits+3-1:0]data, output reg [n*bits-1:0]lcdbus);
	
	wire[2:0] i = data[bits+2:bits];
	wire[bits-1:0] val = data[bits-1:0];

	
	always@(posedge clk)
	begin
		begin
			if(i == 0)
				lcdbus = 0;
			lcdbus <= lcdbus | (data << 8*i);
		end
	end
		

endmodule