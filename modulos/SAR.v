module SAR
(
input clock;
input ecmp;						/// comparador externo
input start;					/// flag de inicio
output reg[7:0] adcv;		/// valor da leitura em bits
output reg eoc;				/// flag de conversão
output dacPWM;
  
);


reg internalClock;			/// clock interno do DAC
reg isInit;
reg isReady;

reg [2:0] i;
reg [7:0] temp;

PWM2 Dac(.clock(clock), .cr1(0), .cr2(cr2), .pwm(dacPWM));
/// se cada amostragem têm 20 Hz, então cada iteração deve ocorrer pelo menos 8 vezes mais rápido
DivFreq #(nHz(20*10)) divInternalClock(.Clk_50Mhz(clock), .clk_out(internalClock));

always @(*)
begin
	
	if(!isInit)
	begin
		i = 0;
		temp = 0;
		isInit = 1;
		eoc = 0;
		adcv = 0;
	end	
end

always @(posedge start)
begin
		isReady = 1;	
end

always @(posedge internalClock)
if(isReady)
	temp = 0;
	for(i = 8; i > 0; i--)
	begin
		temp = adcv | 1 << i;
		/// configurar dac
		wire [15:0] cr2 = (temp / 255.f) * 10000d;
		
		/// !configurar dac
		if(ecmp)
			adcv[i - 1] = 1;
	end

endmodule 