`timescale 1ns / 1ps

module display_refresher(
	input clk,
   input DISPLAY1,
	input DISPLAY2,
	input DISPLAY3,
	input DISPLAY4,
	output reg [6:0] DISPLAY, 
	output reg [3:0] ANODES,
	output reg contador_seg
	);
	
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
	frequency_divider divisor (CLK_1Hz, CLK_2Hz, CLK_1KHz, clk);

	always @ (posedge CLK_1KHz) begin
		Prstate = Nxtstate;
	end
	
	always @ (posedge CLK_1Hz)
		begin
			contador_seg = contador_seg + 1;
			if (contador_seg == 10)
				contador_seg = 0;
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
					ANODES = 4'b1110;//se indica con un 0 el display 
					DISPLAY = DISPLAY1;
				end
			S1: // P
				begin 
					ANODES = 4'b1101;
					DISPLAY = DISPLAY2;
				end
			S2: // A o C
				begin 
					ANODES = 4'b1011;
					DISPLAY = DISPLAY3;
				end
			S3: // S o B
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
