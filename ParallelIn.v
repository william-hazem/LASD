module ParallelIn(
input [7:0] Address,	/// endereço da memóri
				DataIn,	/// interface de entrada
				MemData,	/// interface da memória
output[7:0] RegData	/// saída p/ RF 
);

assign RegData = Address == 8'hFF ? DataIn : MemData;

endmodule