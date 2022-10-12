`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);
//---------- modifique a partir daqui --------

assign LEDG[0] = KEY[1];

/// ver somador-wave (testa soma e subtração)
ULA somador(SW[3:0], SW[7:4], SW[17], LEDR[3:0]);

/// ver shift-wave (testa as operações de shifts)
ULA shift(SW[3:0], SW[7:4], SW[17:16], LEDR[7:4]);

endmodule

//// Parte 1 do exercicio

module ULA_1(input [3:0]A, B, input op, output reg[3:0]R);
	
//	always@(A or B or op) begin
//		if(op == 0)
//			R = A + B;
//		else
//			R = A - B;
//			
//	end //!always
	
	/// a solução em uma linha de código
	always@(*) R = op == 1? A - B : A + B;
	
endmodule


//// Parte 2 - extra
/// 0 - soma 
/// 1 - subtrai
/// 2 - right shift
/// 3 - left shift
module ULA(input [3:0]A, B, input[1:0] Sel, output reg[3:0]Res);
	
	always@(*) begin
		if(Sel == 2'b00)
			Res = A + B;
		else if(Sel == 2'b01)
			Res = A - B;
		else if(Sel == 2'b10)
			Res = A >> B;
		else //(Sel == 2'b11)
			Res = A << B;
	end
	
endmodule 