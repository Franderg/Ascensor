`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module maquina_estados(
	 //0: nadie ha mandado nada//
	 //1: ir a piso 1
	 //2: ir a piso 2
	 //3: ir a piso 3//
	 //4: ir a piso 4//
	 //5: piso 1, bot�n de subir
	 //6: piso 2, bot�n de bajar
	 //7: piso 2, bot�n de subir
	 //8: piso 3, bot�n de bajar//
	 //9: piso 3, bot�n de subir
	 //10: piso 4, bot�n de bajar//
	 input clk, //clock
	 input rst, //reset
	 input piso1,
	 input piso2,
	 input piso3,
	 input piso4,
	 input S1,
	 input B2,
	 input S2,
	 input B3,
	 input S3,
	 input B4,
	 output reg[7:0] DISPLAY, 
	 output reg[3:0] ANODES
	/* output reg [1:0] piso, //Indica el piso actual, 0, 1, 2, 3
	 output reg [1:0] accion, //Indica si est� subiendo o bajando, 0 no se mueve, 1 sube y 2 baja
	 output reg puertas, //Indica si las puertas est�n abiertas o cerradas, 0 cerradas, 1 abiertas
	 output reg [3:0] contador_seg,
	 output reg [3:0] memoria_m*/
    );

	parameter P1=0, P2=1, P3=2, P4=3; //Estados
	
	reg [1:0] e_actual = P1; //estado actual (piso)
	reg [1:0] e_siguiente = P1; // estado siguiente
	reg agregar = 0;
	reg obtener = 0;
	wire [3:0] memoria; //registro con la siguiente instruccion para la maquina de estados

	reg [26:0] contador_ciclos = 0;
	//integer memoria_input;
	//wire [3:0] boton_pres1;
	wire [3:0] boton_pres; //entradas donde se guardan todos los botones de los pisos
	wire [3:0] BCD4, BCD3, BCD2, BCD1;
	wire [7:0] DISPLAY4, DISPLAY3, DISPLAY2, DISPLAY1;
	
	reg [1:0] piso = 0;
	reg [1:0] accion = 0;
	reg puertas = 0;
	reg [3:0] contador_seg = 0;
		
	
	
	//assign boton_pres1 = boton_pres;
	
	reg LE = 1;

			/* HERE STARTS THE REFRESHING MACHINE */
	
	reg [1:0] Prstate, Nxtstate;
	parameter State0 = 2'b00, State1 = 2'b01, State2 = 2'b10, State3 = 2'b11;

	initial 
		begin
			Prstate = State0;
			piso = 0;
			accion = 0;
			puertas = 0;
			contador_seg = 0;
			//memoria_m = 0;
		end
	
	
	//frecuencia de cambio entre cada display (agregar al informe, en el manual de Xilinx de la Nexys3 viene)
	(* keep="soft" *)
	wire CLK_1Hz;
	(* keep="soft" *)
	wire CLK_2Hz;
	wire CLK_1KHz;
	frequency_divider divisor (CLK_1Hz, CLK_2Hz, CLK_1KHz, clk);

	manejo_entradas entradas(
	clk,
	piso1,
	piso2,
	piso3,
	piso4,
	S1,
	B2,
	S2,
	B3,
	S3,
	B4,
	boton_pres
    );
	 
	 manejo_memoria memory(
    clk,
	 rst,
	 LE,
	 puertas,
	 accion,
    piso, //piso actual
	 boton_pres, //boton que se presiona
	 memoria //registro con la siguiente instruccion para la maquina de estados
    );
	 
	 acciones_to_bcd obtenerbcd(
	 clk,
	 rst,
	 piso,
	 accion,
	 puertas,
	 BCD1,
	 BCD2,
	 BCD3,
	 BCD4
	 );
	 
	 bcd_to_display deco1(
	 clk,
	 rst,
	 BCD1,
	 DISPLAY4
	 );
	 
	 bcd_to_display deco2(
	 clk,
	 rst,
	 BCD2,
	 DISPLAY3
	 );
	 
	 bcd_to_display deco3(
	 clk,
	 rst,
	 BCD3,
	 DISPLAY2
	 );
	 
	 bcd_to_display deco4(
	 clk,
	 rst,
	 BCD4,
	 DISPLAY1
	 );
	
	always @ (posedge clk)
	   begin
			if(rst)
			   begin
			      accion = 0;
	            piso = 0;
	            puertas = 0;	
				   e_actual = P1;
					LE = 1;
					contador_seg = 4'b0;
				end
			else			
				begin
					//memoria_m = memoria;
					LE = 1;
					if (contador_ciclos == 100000000)
						begin
							contador_seg = contador_seg + 4'b0001;
						end
					else if (contador_seg == 2)
						begin
							contador_seg = 4'b0;
						   LE = 0;
						   //accion_m = accion;
							//piso_m = piso;
							//puertas_m = puertas;
							//memoria_input = memoria;
							#200;
							case(e_actual)
							
				//************ Estado: Piso 1*****************//
								P1:begin
									case(memoria)
										0:
											begin
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
										2,3,4,6,7,8,9,10:
											begin
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
									case(memoria)
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
									case(memoria)
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
									case(memoria)
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
								default: e_siguiente=P1;//por defecto está en el piso 1
							endcase
							e_actual = e_siguiente;
							
						end
				end
		end

	always @ (posedge clk)
		begin
			if (rst)
				begin
					contador_ciclos = 27'b0;
				end
			else
				begin
					contador_ciclos = contador_ciclos + 4'b000000000000000000000000001;
					if (contador_ciclos == 100000100)
						begin
							contador_ciclos = 27'b0;
						end
				end
		end
		


	always @ (posedge CLK_1KHz) begin
		Prstate = Nxtstate;
		case (Prstate)
			State0: Nxtstate = State1;
			State1: Nxtstate = State2;
			State2: Nxtstate = State3;
			State3: Nxtstate = State0;
			default: Nxtstate = State0;
		endcase
	end		
	
	always @ (posedge clk)
		case (Prstate)
			State0: // 1,2,3 o 4, en caso de espera es in -
				begin 
					ANODES = 4'b1110;//se indica con un 0 el display 
					DISPLAY = DISPLAY1;
				end
			State1: // P
				begin 
					ANODES = 4'b1101;
					DISPLAY = DISPLAY2;
				end
			State2: // A o C
				begin 
					ANODES = 4'b1011;
					DISPLAY = DISPLAY3;
				end
			State3: // S o B
				begin 
					ANODES = 4'b0111;
					DISPLAY = DISPLAY4;
				end
			default: 
				begin // por defecto esta en espera ----
					ANODES = 4'b0000;
					DISPLAY = 7'b1111110;
				end
		endcase


endmodule
