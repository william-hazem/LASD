//// ULA
/// 0 - soma 
/// 1 - subtrai
/// 2 - right shift
/// 3 - left shift

module ULA(input [7:0]SrcA, SrcB, input[2:0] ULAControl, output reg[7:0]ULAResult, output reg Z);
	
	always@(*) begin
		case (ULAControl)
		3'b000: ULAResult = SrcA & SrcB;
		3'b001: ULAResult = SrcA | SrcB;
		3'b010: ULAResult = SrcA + SrcB;
		3'b011: ULAResult = ~(SrcA | SrcB);
		3'b110: ULAResult = SrcA - SrcB;
		3'b111: ULAResult = SrcA < SrcB;
		default: ULAResult = 0;
		endcase
		
		
		Z = !ULAResult ? 1 : 0;
	end
	
endmodule 