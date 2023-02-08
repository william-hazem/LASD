/**
 * Módulo PWM 2
 * Frequência do sinal gerado 20 Hz
**/

module PWM2
(
input clock,			/// clock do sistema (50Mhz)
output reg pwm,		/// saida
input[15:0] cr1,		/// compare register 1
input[15:0] cr2		/// compare register 2

);


reg clk_ps;					/// clock prescaled
wire[15:0]contador;		/// contador
wire overflow;				/// overflow bit
reg reset;

DivFreq #(nHz(20000)) prescale(.Clk_50Mhz(clock), .clk_out(clk_ps));	/// saída de 200 kHz

Contador ModContador(.clock(clk_ps), .cont(contador), .of(overflow), .reset(reset));


always @(posedge clk_ps)
begin
	/// lógica de reset do contador
	if(contador >= 10000)
		reset = 0;
	else
		reset = 1;
		
	if(contador >= cr2)
		pwm = 0;
	else if(contador >= cr1)
		pwm = 1;
end

endmodule 