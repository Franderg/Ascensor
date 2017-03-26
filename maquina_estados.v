`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module maquina_estados(
	 input [3:0] boton_pres, //entradas donde se guardan todos los botones de los pisos
	 //0: nadie ha mandado nada
	 //1: ir a piso 1
	 //2: ir a piso 2
	 //3: ir a piso 3
	 //4: ir a piso 4
	 //5: piso 1, botón de subir
	 //6: piso 2, botón de bajar
	 //7: piso 2, botón de subir
	 //8: piso 3, botón de bajar
	 //9: piso 3, botón de subir
	 //10: piso 4, botón de bajar
    input en, //enable
	 input clk, //clock
	 input rst, //reset
    output reg [1:0] piso, //Indica el piso actual, 0, 1, 2, 3
	 output reg [1:0] accion, //Indica si está subiendo o bajando, 0 no se mueve, 1 sube y 2 baja
	 output reg puertas //Indica si las puertas están abiertas o cerradas, 0 cerradas, 1 abiertas
    );

	parameter P1=0, P2=1, P3=2, P4=3; //Estados
	
	reg [1:0] e_actual = P1; //estado actual (piso)
	reg [1:0] e_siguiente = P1; // estado siguiente
	reg agregar = 0;
	reg obtener = 0;
	reg puertas_m = 0;
	reg [1:0] accion_m;
   reg [1:0] piso_m; //piso actual
	wire [3:0] memoria; //registro con la siguiente instruccion para la maquina de estados
	reg contador_seg = 0;
	reg contador_ciclos = 0;
	reg [3:0] memoria_input;
	
	manejo_memoria memory(
    .clk(clk),
	 .agregar(agregar),
	 .obtener(obtener),
	 .puertas_m(puertas_m),
	 .accion_m(accion_m),
    .piso_m(piso_m), //piso actual
	 .boton_pres(boton_pres), //boton que se presiona
	 .memoria(memoria) //registro con la siguiente instruccion para la maquina de estados
    );
	
	always @ (posedge clk or negedge rst)
	   begin
			if(!rst)
			   begin
			      accion = 0;
	            piso = 0;
	            puertas = 0;	
				   e_actual = P1;
				end
			else if(en)				
				begin
					agregar = 1;
					agregar = 0;
					if (contador_seg == 10)
						begin
						   accion_m = accion;
							piso_m = piso;
							puertas_m = puertas;
							obtener = 1;
							#100 obtener = 0;
							contador_seg = 0;
							memoria_input <= memoria;
							case(e_actual)
							
				//************ Estado: Piso 1*****************//
								P1:begin
									case(memoria_input)
										0:begin
												piso = 0;
												accion = 0;
												puertas = 0;
												e_siguiente=P1;
											end
										1,5:
											begin
												piso = 0;
												accion = 0;
												puertas = 1;
												e_siguiente=P1;
											end
										2,3,4,6,7,8,9,10:begin
												piso = 0; //piso1
												accion = 1; //sube
												puertas = 0; //cerra	das
												e_siguiente=P2;
											end	
										default:e_siguiente=P1;
									endcase
								end

				//************ Estado: Piso 2*****************//
								P2:begin
									case(memoria_input)
										0:begin
												piso = 1; //piso 2
												accion = 0; //nada
												puertas = 0; //cerradas
												e_siguiente=P2;
											end
										1,5:
											begin
												piso = 1;//piso 2
												accion = 2;//baja
												puertas = 0; //cerradas
												e_siguiente=P1;
											end
										2,6,7:begin
												piso = 1; //piso 2
												accion = 0; //nada
												puertas = 1;//abiertas
												e_siguiente=P2; //se queda en piso 2
											end	
										3,4,8,9,10:begin
												piso = 1; //piso 2
												accion = 1; //sube
												puertas = 0;//cerradas
												e_siguiente=P3; //vamos para piso 3
											end
										default:e_siguiente=P1;
									endcase
									end
									
				//************ Estado: Piso 3*****************//
								P3:begin
									case(memoria_input)
										0:begin
												piso = 2; //piso 3
												accion = 0; //nada
												puertas = 0; //cerradas
												e_siguiente=P3;
											end
										1,2,5,6,7:
											begin
												piso = 2;//piso 3
												accion = 2;//baja
												puertas = 0; //cerradas
												e_siguiente=P2;
											end
										3,8,9:begin
												piso = 2; //piso 3
												accion = 0; //nada
												puertas = 1;//abiertas
												e_siguiente=P3; //se queda en piso 2
											end	
										4,10:begin
												piso = 2; //piso 3
												accion = 1; //sube
												puertas = 0;//cerradas
												e_siguiente=P4; //vamos para piso 4
											end
										default:e_siguiente=P1;
									endcase
									end

				//************ Estado: Piso 4*****************//
								P4:begin
									case(memoria_input)
										0:begin
												piso = 3; //piso 4
												accion = 0; //nada
												puertas = 0; //cerradas
												e_siguiente=P4;
											end
										1,2,3,5,6,7,8,9:
											begin
												piso = 3;//piso 3
												accion = 2;//baja
												puertas = 0; //cerradas
												e_siguiente=P3; //bajamos al piso 3
											end
										4,10:begin
												piso = 3; //piso 3
												accion = 0; //nada
												puertas = 1;//abiertas
												e_siguiente=P4; //se queda en el piso 4
											end
										default:e_siguiente=P1;
									endcase
									end
									
				//************ Estado: Defecto*****************//					
								default: e_siguiente=P1;//por defecto estÃ¡ en el piso 1
							endcase
							e_actual = e_siguiente;
						end	
				end
		end
	/*always @ (posedge clk or negedge rst)
		begin
			if(!rst)
			   begin
			      accion = 0;
	            piso = 0;
	            puertas = 0;	
				   e_actual = P1;
				end
			else if(en)
				e_actual = e_siguiente;
		end
*/

	always @ (posedge clk or negedge rst)
		begin
			if (~rst)
				contador_ciclos = 0;
			else
				if (contador_ciclos == 100000000)
					begin
						contador_ciclos = 0;
						contador_seg = contador_seg + 1;
					end
		end
endmodule
