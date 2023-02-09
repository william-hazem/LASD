module SAR
(
input clock,
input ecmp,						/// comparador externo
input start,					/// flag de inicio
output reg[7:0] adcv,		/// valor da leitura em bits
output reg eoc,				/// flag de conversão
output dacPWM,					/// Digital-Analog
output swtPWM,					/// Sinal de chaveamento
output reg [3:0]i  
);


wire internalClock;			/// clock interno do DAC
reg isReady;

wire [15:0] cr2;

//reg [2:0] i;
wire [7:0] temp;

PWM2 Swt(.clock(clock), .cr1(0), .cr2(1000), .pwm(swtPWM));
PWM1 Dac(.clock(clock), .cr1(0), .cr2(cr2), .pwm(dacPWM));

/// se cada amostragem têm 200 Hz, então cada iteração deve ocorrer pelo menos 8 vezes mais rápido
DivFreq #(.nHz(1)) divInternalClock(.Clk_50MHz(clock), .clk_out(internalClock));

assign cr2 = (temp) * (16'd5000 / 255);
assign temp = adcv | (1 << i); /// palpite

always @(posedge internalClock or negedge start)
begin
	if(!start)
	begin
		isReady = 1;
		i = 7;
		eoc = 0;
		adcv = 0;	
	end else
	if (isReady)
	begin
		if(ecmp)
			adcv = temp;
			
		i <= i - 1;
		
		if(i == 0)
		begin
			isReady = 0;
			eoc = 1;
		end
	
	end // !if
	
end //!always 

endmodule