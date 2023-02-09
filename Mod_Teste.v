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


	
	/*assign LEDG[8] = ~clk;
	
	/// Barramento de dados do banco de registro para o Display LCD
	wire [63:0]LCDBUS = {w_d0x0,w_d0x1,w_d0x2,w_d0x3,w_d1x0,w_d1x1,w_d1x2,w_d1x3};
	assign w_d0x4 = w_PC;
	
	
	
	
	
	wire clk, w_Z;
	/// Gerador de pulso 1 Hz
	DivFreq #(.nHz(2)) m_Clock1Hz(.Clk_50MHz(CLOCK_50), .clk_out(clk));
	
	
	assign LEDG[0] = w_Z;
	wire [7:0]w_PC, wPC_, w_RData, w_m1, w_nPC;
	
	/// somadores de endereço
	assign wPC_ = w_PC + 1;
	wire [7:0] AdderBranch = wPC_ + w_Instr[7:0];
	
	/// sinais de controle
	wire w_PCSrc = w_Branch & w_Z;
	
	/// Seletores de endereço
	Mux2 MuxPCSrc(.x0(wPC_), .x1(AdderBranch),.Y(w_m1), .sel(w_PCSrc));
	Mux2 MuxJump(.x0(w_m1), .x1(w_Instr[7:0]),.Y(w_nPC), .sel(w_Jump));
	
	
	ModPC PC(.clk(clk), .PCi(w_nPC), .PCo(w_PC));
	
	wire [31:0] w_Instr;
	RomInstMem(.address(w_PC), .clock(CLOCK_50), .q(w_Instr));
	
	
	RamDataMem DataMem(
		.address(ULAResult),
		.clock(CLOCK_50),
		.data(w_rd2),
		.wren(w_We),
		.q(w_RData));
	
	wire w_We;					/// MemData write enable
	wire [7:0] w_DataOut = w_d1x4;
	ParallelOut Pout(			/// Parallel Output
		.Address(ULAResult),
		.RegData(w_rd2),
		.we(MemWrite),
		.wren(w_We),
		.clk(clk),
		.DataOut(w_DataOut)
	);
	
	wire [7:0] w_DataIn = SW[7:0]; 	/// fio de entrada externa
	wire [7:0] w_RegData; 	/// dados de saida do seletor interno do ParallelIn
	ParallelIn pin(
		.Address(ULAResult),
		.DataIn(w_DataIn),
		.MemData(w_RData),
		.RegData(w_RegData)
	);
	
	mux2x1 MuxDDest(			/// Seletor p/ write_data do RF
		.data0x(ULAResult),
		.data1x(w_RegData),
		.sel(MemtoReg),
		.result(w_Result));
	
	wire [5:0] OP = w_Instr[31:26];
	wire [5:0] Funct = w_Instr[5:0];
	wire RegWrite, RegDst, ULASrc, w_Branch, MemWrite, MemtoReg, w_Jump;
	wire [2:0]ULAControl;
	
	UnidadeControle ControlUnit(
		.OP(OP), .Funct(Funct), .RegWrite(RegWrite), 
		.RegDst(RegDst), .ULASrc(ULASrc), .Branch(w_Branch), 
		.MemWrite(MemWrite), .MemtoReg(MemtoReg), .Jump(w_Jump),
		.ULAControl(ULAControl)
	);
	
	wire [7:0]srcA, srcB, w_rd2, w_Result, ULAResult;
	wire [9:0]data;
	
	wire [2:0]wa3 = RegDst ? w_Instr[15:11] : w_Instr[20:16];
	wire w_clockData;
	RegisterFile bancoReg(
		.clk(clk), .we3(RegWrite),
		.ra1(w_Instr[25:21]), .rd1(srcA),
		.ra2(w_Instr[20:16]), .rd2(w_rd2),
		.wa3(wa3), .wd3(w_Result),
		.dataClk(CLOCK_50), .data(LCDBUS)
	);
	//DivFreq #(.nHz(1000000)) Divdebug(.Clk_50MHz(CLOCK_50), .clk_out(w_clockData) );
	
	//LCDdebug(.clk(CLOCK_50), .lcdbus(LCDBUS), .data(data));
	
	assign srcB = ULASrc ? w_Instr[7:0] : w_rd2;
	
	
	
	bcdDecoder(ULAResult[3:0], HEX0);
	bcdDecoder(ULAResult[7:4], HEX1);
	bcdDecoder(data[3:0], HEX4);
	bcdDecoder(data[7:4], HEX5);
	ULA ula(.SrcA(srcA), .SrcB(srcB), .ULAControl(ULAControl), .ULAResult(ULAResult), .Z(w_Z));
	
	assign LEDR = {RegWrite, RegDst,ULASrc,ULAControl,w_Branch,MemWrite,MemtoReg,w_Jump};
	

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
		
	end*/
	
	wire [7:0] sarResult;
	wire [3:0] i;
	bcdDecoder(sarResult[3:0], HEX0);
	bcdDecoder(sarResult[7:4], HEX1);
	bcdDecoder(i, HEX3);
	assign LEDG[5] = KEY[2];
	assign LEDG[3] = GPIO_0[3];
	SAR _SAR (.clock(CLOCK_50), .ecmp(GPIO_0[3]), .start(KEY[2]), .adcv(sarResult), .eoc(LEDG[7]), .dacPWM(GPIO_0[0]), .swtPWM(GPIO_0[1]), .i(i));
	
	
	
endmodule

