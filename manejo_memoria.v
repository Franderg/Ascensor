`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:00:43 03/24/2017 
// Design Name: 
// Module Name:    manejo_memoria 
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
module manejo_memoria(
    input clk,
	 input [1:0] accion,
    input [1:0] piso, //piso actual
	 input [3:0] boton, //boton que se presiona
	 output reg [3:0] memoria, //registro con la siguiente instruccion para la maquina de estados
    );

reg [3:0] RAM [0:255];
parameter [3:0] anterior;
parameter count = -1, pila = 0;

always @ (posedge clk)
	begin
		if (count==-1) and (boton==0)
		   begin					
				count = count+1;
				RAM[pila] = boton;
				pila = pila+1;
				memoria = boton;
			end
		else
			begin
				if (piso==0)
					if (boton == 5)
						begin
							if (RAM[count] != 5)
								
								
						end
				else if (piso==1)
				
				else if (piso==2)
				
				else
				
			end
endmodule


if (boton!=0)

else
	begin
		if (RAM[count]!=0)
			
