module Contador
#
(
parameter n = 16 		/// bitwise do contador
)
(
input clock,				/// clock de entrada do contador
output reg[n-1:0] cont, /// contador
output reg of,				/// overflow
input reset
);

always @(posedge clock)
begin
	cont = cont + 1;
	if(cont == (2 << n - 1))
		of = 1;
	else
		of = 0;
end

always @(negedge clock)
	if(!reset)
	begin
		cont = 0;
		of = 0;
	end

endmodule 