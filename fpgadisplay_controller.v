`timescale 1ns / 1ps

module fpgadisplay_controller(
	output reg[6:0] DISPLAY, 
	output reg[3:0] DIGITS,
	
	input CLK);

	wire [3:0] N_PISO, PISO, PUERTAS, ACCION;//se pueden dejar o quitar, depende la implementacion
	
	wire [6:0] DISPLAY3, DISPLAY2, DISPLAY1, DISPLAY0;
	
	/* Se define el deco de cada display, el modulo es bcd_to_display deco de cada display y (salida, entrada)
	Las entradas son el numero de piso, si sube o baja, puertas abiertas o cerradas...
	
	bcd_to_display decoX (DISPLAYX,entradas); lo que varia en cada uno es la entrada
	*/
	bcd_to_display deco3 (DISPLAY3,5);
	bcd_to_display deco2 (DISPLAY2,7);
	bcd_to_display deco1 (DISPLAY1,9);
	bcd_to_display deco0 (DISPLAY0,1);
	
	/* HERE STARTS THE REFRESHING MACHINE */
	
	reg [1:0] Prstate, Nxtstate;
	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

	initial begin Prstate = S0; end
	
	
	//frecuencia de cambio entre cada display (agregar al informe, en el manual de Xilinx de la Nexys3 viene)
	(* keep="soft" *)
	wire CLK_1Hz;
	(* keep="soft" *)
	wire CLK_2Hz;
	wire CLK_1KHz;
	frequency_divider divisor (CLK_1Hz, CLK_2Hz, CLK_1KHz, CLK);

	always @ (posedge CLK_1KHz) begin
		Prstate = Nxtstate;
	end
	
	
	always @ (Prstate)
		case (Prstate)
			S0: Nxtstate = S1;
			S1: Nxtstate = S2;
			S2: Nxtstate = S3;
			S3: Nxtstate = S0;
			default: Nxtstate = S0;
		endcase
	
	always @ (*)
		case (Prstate)
			S0: // 1,2,3 o 4, en caso de espera es in -
				begin 
					DIGITS = 4'b1110;//se indica con un 0 el display 
					DISPLAY = DISPLAY0;
				end
			S1: // P
				begin 
					DIGITS = 4'b1101;
					DISPLAY = DISPLAY1;
				end
			S2: // A o C
				begin 
					DIGITS = 4'b1011;
					DISPLAY = DISPLAY2;
				end
			S3: // S o B
				begin 
					DIGITS = 4'b0111;
					DISPLAY = DISPLAY3;
				end
			default: 
				begin // por defecto esta en espera ----
					DIGITS = 4'b0000;
					DISPLAY = 7'b1111110;
				end
		endcase

endmodule
