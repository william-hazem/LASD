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


/// barramento lógico (apenas para tornar menos verboso)
reg [6:0] w_lbus;

always@* begin
	
	case(OP)
	6'b000000: w_lbus = 7'b1100000; 									// Tipo R
	6'b100011: {w_lbus, ULAControl} = {7'b1010010, 3'b010}; 	// LW
	6'b101011: {w_lbus, ULAControl} = {7'b0x101x0, 3'b010}; 	// SW
	6'b000100: {w_lbus, ULAControl} = 10'b0x010x0110; 			// BEQ
	6'b001000: {w_lbus, ULAControl} = 10'b1010000010; 			// ADDi
	6'b000010: w_lbus = 10'b0xxx0x1; 								// J
	default:	w_lbus = 7'b0xx0xx0;										// NOPE
	endcase
	
	case(Funct)
	6'b100000: ULAControl = 3'b010;	// ADD
	6'b100010: ULAControl = 3'b110;  // SUB
	6'b100100: ULAControl = 3'b000;	// AND
	6'b100101: ULAControl = 3'b001;	// OR
	6'b100111: ULAControl = 3'b011;  // NOR
	6'b101010: ULAControl = 3'b111;	// SLT
	endcase

	{RegWrite, RegDst, ULASrc, Branch, MemWrite, MemtoReg, Jump} = w_lbus;
end




endmodule