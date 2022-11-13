module UnidadeControle(
input [5:0]		OP,
					Funct,
output reg 		RegWrite,
					RegDst,
					ULASrc,
					Branch,
					MemWrite,
					MemtoReg,
					Jump,
output reg[2:0]ULAControl
);


always@* begin
	case(OP)
	6'b000000: {RegWrite, RegDst, ULASrc, Branch, MemWrite, MemtoReg, Jump} = 7'b1100000; // Tipo R
	6'b100011: {RegWrite, RegDst, ULASrc, Branch, MemWrite, MemtoReg, 
																Jump, ULAControl} = {7'b1010010, 3'b101}; // LW
	6'b101011: {RegWrite, RegDst, ULASrc, Branch, MemWrite, MemtoReg,
																Jump, ULAControl} = {7'b0x101x0, 3'b010}; // SW
	6'b000100: {RegWrite, RegDst, ULASrc, Branch, MemWrite, MemtoReg, 
																		Jump, ULAControl} = 10'b0x010x0110; // BEQ
	6'b001000: {RegWrite, RegDst, ULASrc, Branch, MemWrite, MemtoReg,
																		Jump, ULAControl} = 10'b1010000010; // ADDi
	6'b000010: {RegWrite, RegDst, ULASrc, Branch, MemWrite, MemtoReg, Jump} = 10'b0xxx0x1; // J
	endcase
	
	case(Funct)
	6'b100000: ULAControl = 3'b010;	// ADD
	6'b100010: ULAControl = 3'b110;  // SUB
	6'b100100: ULAControl = 3'b000;	// AND
	6'b100101: ULAControl = 3'b001;	// OR
	6'b101010: ULAControl = 3'b111;	// SLT
	endcase

end

endmodule