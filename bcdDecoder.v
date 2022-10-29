/// converte de binário para hexadecimal
module bcdDecoder(input[3:0] E, output reg[0:6] S);

	always @(*)
		case(E)
			4'b0000 : S=7'b0000001; // 0 em binário, não acende led 'g'
			4'b0001 : S=7'b1001111;
			4'b0010 : S=7'b0010010;
			4'b0011 : S=7'b0000110;
			4'b0100 : S=7'b1001100;
			4'b0101 : S=7'b0100100;
			4'b0110 : S=7'b0100000;
			4'b0111 : S=7'b0001101;
			4'b1000 : S=7'b0000000;
			4'b1001 : S=7'b0000100; 
			//default : S=7'b1111111; //padrão, todos leds apagados
			4'd10	  : S=7'b0001000; // A
			4'd11	  : S=7'b1100000;	// B
			4'd12	  : S=7'b0110001;	// C
			4'd13	  : S=7'b1000010;	// D
			4'd14	  : S=7'b0110000; // E
			4'd15	  : S=7'b0111000;	// F
		endcase
		
 
endmodule