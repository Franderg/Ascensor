`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//deco que pasa de BCD a la salida del display, cada caso es la salida

module bcd_to_display(output reg[6:0] DISPLAY, input [3:0] BCD);

	always @ (BCD) 
		begin
			case (BCD)	
				0:	DISPLAY = 7'b1111110;//  ---- espera
				1: DISPLAY = 7'b1001111;//  Piso 1
				2: DISPLAY = 7'b0010010;//  Piso 2
				3: DISPLAY = 7'b0000110;//  Piso 3
				4: DISPLAY = 7'b1001100;//  Piso 4
				5: DISPLAY = 7'b0100100;//  Sube
				6: DISPLAY = 7'b0001000;//  Abierto
				7: DISPLAY = 7'b0110001;//  Cerrado
				8: DISPLAY = 7'b0000000;//  Baja
				9: DISPLAY = 7'b0011000;//  indica el Piso
				default: DISPLAY = 7'b0;
			endcase
		end

endmodule
