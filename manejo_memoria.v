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
	 input agregar,
	 input obtener,
	 input puertas_m,
	 input [1:0] accion_m,
    input [1:0] piso_m, //piso actual
	 input [3:0] boton_pres, //boton que se presiona
	 output reg [3:0] memoria //registro con la siguiente instruccion para la maquina de estados
    );

reg [3:0] RAM [0:11];
reg [4:0] indice_encontrado = 11;
reg encontrar = 0;
integer contador = 0;


	
	
always @ (posedge obtener or posedge agregar)
	if (agregar == 1)
		begin
			contador = 0;
			indice_encontrado = 11;
			for (contador = 0; contador <= 10; contador = contador + 1)
				if (RAM[contador] == boton_pres)
					begin
						indice_encontrado = contador;
					end
			if (indice_encontrado == 11)
				begin
					for (contador = 10; contador >= 0; contador = contador - 1)
						if (RAM[contador] == 0)
							begin
								RAM[contador+1] = 0;
								RAM[contador] = boton_pres;
							end
				end
		end
	else if (obtener == 1)
		begin
			if (piso_m == 0) //piso 1
				begin
					if (accion_m == 0) //no se mueve
						begin
							indice_encontrado = 11;
							for (contador = 0; contador <= 10; contador = contador + 1)
								if (RAM[contador] == 1 || RAM[contador] == 5)
									begin
										if (puertas_m == 0)
											begin
												indice_encontrado = contador;
												memoria = RAM[contador];
											end
										RAM[contador] = 0;
									end
							if (indice_encontrado == 11)
								begin
									for (contador = 10; contador >= 0; contador = contador - 1)
										if (RAM[contador] != 0)
											begin
												memoria = RAM[contador];
												indice_encontrado = contador;
											end
									if (indice_encontrado == 11)
										memoria = 0;
								end
						end
					else if (accion_m == 1)
						begin
							indice_encontrado = 11;
							for (contador = 0; contador <= 10; contador = contador + 1)
								if (RAM[contador] == 2 || RAM[contador] == 7)
									begin																			
										indice_encontrado = contador;
										memoria = RAM[contador];
										RAM[contador] = 0;
									end
							if (indice_encontrado == 11)
								begin
									for (contador = 10; contador >= 0; contador = contador - 1)
										if (RAM[contador] != 0 || RAM[contador] != 1 || RAM[contador] != 5)
											begin
												memoria = RAM[contador];
												indice_encontrado = contador;
											end
									if (indice_encontrado == 11)
										memoria = 0;
								end
						end
				end
			else if (piso_m == 1) //piso2
				begin
					if (accion_m == 0) //no se mueve
						begin
							indice_encontrado = 11;
							for (contador = 0; contador <= 10; contador = contador + 1)
								if (RAM[contador] == 2 || RAM[contador] == 6 || RAM[contador] == 7)
									begin
										if (puertas_m == 0)
											begin
												indice_encontrado = contador;
												memoria = RAM[contador];
											end
										RAM[contador] = 0;
									end
							if (indice_encontrado == 11)
								begin
									for (contador = 10; contador >= 0; contador = contador - 1)
										if (RAM[contador] != 0)
											begin
												memoria = RAM[contador];
												indice_encontrado = contador;
											end
									if (indice_encontrado == 11)
										memoria = 0;
								end
						end
					else if (accion_m == 1)
						begin
							indice_encontrado = 11;
							for (contador = 0; contador <= 10; contador = contador + 1)
								if (RAM[contador] == 3 || RAM[contador] == 9)
									begin																			
										indice_encontrado = contador;
										memoria = RAM[contador];
										RAM[contador] = 0;
									end
							if (indice_encontrado == 11)
								begin
									for (contador = 10; contador >= 0; contador = contador - 1)
										if (RAM[contador] == 4 || RAM[contador] == 10 || RAM[contador] == 8)
											begin
												memoria = RAM[contador];
												indice_encontrado = contador;
											end
									if (indice_encontrado == 11)
										memoria = 0;
								end
						end
					else if (accion_m == 2)
						begin
							indice_encontrado = 11;
							for (contador = 0; contador <= 10; contador = contador + 1)
								if (RAM[contador] == 1 || RAM[contador] == 5)
									begin																			
										indice_encontrado = contador;
										memoria = RAM[contador];
										RAM[contador] = 0;
									end
							if (indice_encontrado == 11)
								memoria = 0;
						end
				end
			else if (piso_m==2) //piso 3
				begin
					if (accion_m == 0) //no se mueve
						begin
							indice_encontrado = 11;
							for (contador = 0; contador <= 10; contador = contador + 1)
								if (RAM[contador] == 3 || RAM[contador] == 8 || RAM[contador] == 9)
									begin
										if (puertas_m == 0)
											begin
												indice_encontrado = contador;
												memoria = RAM[contador];
											end
										RAM[contador] = 0;
									end
							if (indice_encontrado == 11)
								begin
									for (contador = 10; contador >= 0; contador = contador - 1)
										if (RAM[contador] != 0)
											begin
												memoria = RAM[contador];
												indice_encontrado = contador;
											end
									if (indice_encontrado == 11)
										memoria = 0;
								end
						end
					else if (accion_m == 1)
						begin
							indice_encontrado = 11;
							for (contador = 0; contador <= 10; contador = contador + 1)
								if (RAM[contador] == 4 || RAM[contador] == 10)
									begin																			
										indice_encontrado = contador;
										memoria = RAM[contador];
										RAM[contador] = 0;
									end
							if (indice_encontrado == 11)
								memoria = 0;
						end
					else if (accion_m == 2)
						begin
							indice_encontrado = 11;
							for (contador = 0; contador <= 10; contador = contador + 1)
								if (RAM[contador] == 2 || RAM[contador] == 6)
									begin																			
										indice_encontrado = contador;
										memoria = RAM[contador];
										RAM[contador] = 0;
									end
							if (indice_encontrado == 11)
								begin
									for (contador = 10; contador >= 0; contador = contador - 1)
										if (RAM[contador] == 1 || RAM[contador] == 5 || RAM[contador] == 7)
											begin
												memoria = RAM[contador];
												indice_encontrado = contador;
											end
									if (indice_encontrado == 11)
										memoria = 0;
								end
						end
				end
			else //piso 4
				begin
					if (accion_m == 0) //no se mueve
						begin
							indice_encontrado = 11;
							for (contador = 0; contador <= 10; contador = contador + 1)
								if (RAM[contador] == 4 || RAM[contador] == 10)
									begin
										if (puertas_m == 0)
											begin
												indice_encontrado = contador;
												memoria = RAM[contador];
											end
										RAM[contador] = 0;
									end
							if (indice_encontrado == 11)
								begin
									for (contador = 10; contador >= 0; contador = contador - 1)
										if (RAM[contador] != 0)
											begin
												memoria = RAM[contador];
												indice_encontrado = contador;
											end
									if (indice_encontrado == 11)
										memoria = 0;
								end
						end
					else if (accion_m == 2)
						begin
							indice_encontrado = 11;
							for (contador = 0; contador <= 10; contador = contador + 1)
								if (RAM[contador] == 3 || RAM[contador] == 8)
									begin																			
										indice_encontrado = contador;
										memoria = RAM[contador];
										RAM[contador] = 0;
									end
							if (indice_encontrado == 11)
								begin
									for (contador = 10; contador >= 0; contador = contador - 1)
										if (RAM[contador] != 0 || RAM[contador] != 4 || RAM[contador] != 10)
											begin
												memoria = RAM[contador];
												indice_encontrado = contador;
											end
									if (indice_encontrado == 11)
										memoria = 0;
								end
						end
				end
		end
	
endmodule
