`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:15:47 03/25/2017 
// Design Name: 
// Module Name:    memory_finder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module memory_finder(
	input [3:0] RAM [0:10],
	input [3:0] boton,
	input encontrar,
	input pila,
	output reg encontrado,
	output reg [3:0] indice_encontrado);

reg contador = 0;

always @ (posedge encontrar)
   begin
	   encontrado = 0;
		indice_encontrado = 11;
		begin
			for (contador = 0; contador <= pila; contador = contador + 1)
				if (RAM[contador] == boton)
					begin
						encontrado = 1;
						indice_encontrado = contador;
					end
		end
	end

endmodule
