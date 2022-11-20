/**
 *	Implementação do banco de registrados de um MIPS 8-bits
**/

module RegisterFile(
input [7:0] 	wd3, 	///< entrada de dados para escrita
input	[2:0]		wa3, 	///< endereço de escrita
input 			we3,	///< habilita escrita
input				clk,	///< clock
input [2:0] 	ra1,	///< endereço de leitura 1
					ra2,	///< endereço de leitura 2
output reg[7:0]rd1,	///< saida de dados 1
					rd2,	///< saida de dados 2
input dataClk,			///< clock auxiliar para comutar a saída
output [63:0]data  ///< saida de dados auxiliar para debug
);

	/// instância um banco de registradores
	reg [7:0] registradores[7:0];

	/// escrita nos registradores
	always@(posedge clk)
		if(we3 && wa3)	/// se a escrita estivar habilitada
			registradores[wa3][7:0] <= wd3;
		
	/// leitura dos registradores
	always@(*)
	begin
		rd1 = registradores[ra1];
		rd2 = registradores[ra2];
	end
	
	
	

	assign data = {registradores[0], registradores[1], registradores[2], registradores[3], registradores[4], registradores[5], registradores[6], registradores[7]};
		


endmodule