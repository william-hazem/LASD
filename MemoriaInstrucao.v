module MemoriaInstrucao(input [7:0]A, output reg[31:0] RD);

	always@*
		case(A)
		8'h00: RD = 32'b001000_00000_00001_00000_00000_000011; 	// ADDi $1, $0, 3
		8'h01: RD = 32'b001000_00000_00010_00000_00000_001001;	// ADDi $2, $0, 9
		8'h02: RD = 32'b000000_00001_00010_00010_00000_100000;  // ADD $2, $1, $2
		8'h03: RD = 32'b000000_00001_00010_00011_00000_100100;	// AND $3, $1, $2
		8'h04: RD = 32'b000000_00001_00010_00100_00000_100101;	// OR $4, $1, $2
		endcase

endmodule