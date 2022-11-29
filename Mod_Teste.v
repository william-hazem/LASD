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
	
	assign LEDG[8] = ~clk;
	
	/// Barramento de dados do banco de registro para o Display LCD
	wire [63:0]LCDBUS = {w_d0x0,w_d0x1,w_d0x2,w_d0x3,w_d1x0,w_d1x1,w_d1x2,w_d1x3};
	assign w_d0x4 = wPC;
	
	wire clk, Z;
	/// Gerador de pulso 1 Hz
	DivFreq #(.nHz(1)) m_Clock1Hz(.Clk_50MHz(CLOCK_50), .clk_out(clk));
	
	
	assign LEDG[0] = Z;
	wire [7:0]wPC, wPC_, w_RData;
	assign wPC_ = wPC + 1;
	
	ModPC PC(.clk(clk), .PCi(wPC_), .PCo(wPC));
	
	wire [31:0] w_Instr;
	RomInstMem(.address(wPC), .clock(CLOCK_50), .q(w_Instr));
	RamDataMem DataMem(
		.address(ULAResult),
		.clock(CLOCK_50),
		.data(rd2),
		.wren(MemWrite),
		.q(w_RData));
	
	mux2x1 MuxDDest(
		.data0x(ULAResult),
		.data1x(w_RData),
		.sel(MemtoReg),
		.result(w_Result));
	
	wire [5:0] OP = w_Instr[31:26];
	wire [5:0] Funct = w_Instr[5:0];
	wire RegWrite, RegDst, ULASrc, Branch, MemWrite, MemtoReg, Jump;
	wire [2:0]ULAControl;
	
	UnidadeControle ControlUnit(
		.OP(OP), .Funct(Funct), .RegWrite(RegWrite), 
		.RegDst(RegDst), .ULASrc(ULASrc), .Branch(Branch), 
		.MemWrite(MemWrite), .MemtoReg(MemtoReg), .Jump(Jump),
		.ULAControl(ULAControl)
	);
	
	wire [7:0]srcA, srcB, rd2, w_Result, ULAResult;
	wire [9:0]data;
	
	wire [2:0]wa3 = RegDst ? w_Instr[15:11] : w_Instr[20:16];
	wire w_clockData;
	RegisterFile bancoReg(
		.clk(clk), .we3(RegWrite),
		.ra1(w_Instr[25:21]), .rd1(srcA),
		.ra2(w_Instr[20:16]), .rd2(rd2),
		.wa3(wa3), .wd3(w_Result),
		.dataClk(CLOCK_50), .data(LCDBUS)
	);
	//DivFreq #(.nHz(1000000)) Divdebug(.Clk_50MHz(CLOCK_50), .clk_out(w_clockData) );
	
	//LCDdebug(.clk(CLOCK_50), .lcdbus(LCDBUS), .data(data));
	
	assign srcB = ULASrc ? w_Instr[7:0] : rd2;
	
	
	
	bcdDecoder(ULAResult[3:0], HEX0);
	bcdDecoder(ULAResult[7:4], HEX1);
	bcdDecoder(data[3:0], HEX4);
	bcdDecoder(data[7:4], HEX5);
	ULA ula(.SrcA(srcA), .SrcB(srcB), .ULAControl(ULAControl), .ULAResult(ULAResult), .Z(Z));
	
	assign LEDR = {RegWrite, RegDst,ULASrc,ULAControl,Branch,MemWrite,MemtoReg,Jump};
	

endmodule

module Animacao(input clk, output reg[17:0] leds);
	
	reg init = 0;
	reg dir = 0; // 0 - esquerda, 1 - direita
	always @(posedge clk)
	begin
		if(!init)
		begin
			leds = 1;
			init = 1;
		end
		/// determina a direção
		if(leds[0])
			dir = 0;
		else if(leds[17])
			dir = 1;
		/// faz shift 
		leds = dir ? leds >> 1 : leds << 1;
		
	end
	
endmodule

