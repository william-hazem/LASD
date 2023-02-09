/**
 * Módulo PWM 1
 * Frequência do sinal gerado 10 kHz
 * Duty cicle controlável por registro de comparadores
**/

module PWM1
(
input clock,		/// clock do sistema (50Mhz)
output reg pwm,		/// saida
input[15:0] cr1,		/// compare register 1
input[15:0] cr2		/// compare register 2

);



wire[15:0]contador;		/// contador
wire overflow;				/// overflow bit
reg reset;
Contador ModContador(.clock(clock), .cont(contador), .of(overflow), .reset(reset));


always @(posedge clock)
begin
	/// lógica de reset do contador
	if(contador >= 5000)
		reset = 0;
	else
		reset = 1;
		
	/// lógica de saida do pwm
	if(contador >= cr2)
		pwm = 0;
	else if(contador >= cr1)
		pwm = 1;
	
	
end

endmodule 