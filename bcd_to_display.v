`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//deco que pasa de BCD a la salida del display, cada caso es la salida

module bcd_to_display(
	input clk,
	input rst,
	input [3:0] BCD,
	output reg[7:0] DISPLAY
	);
	
initial begin
	DISPLAY = 8'b11111111;
	#10 DISPLAY = 8'b00000000;
end

	always @ (posedge clk)
		begin
			if (rst)
				begin
					DISPLAY = 8'b11111111;
					#10 DISPLAY = 8'b00000000;
				end
			else
				begin
					case (BCD)	
						4'b0000:	DISPLAY = 8'b11111110;//  ---- espera
						4'b0001: DISPLAY = 8'b11001111;//  Piso 1
						4'b0010: DISPLAY = 8'b10010010;//  Piso 2
						4'b0011: DISPLAY = 8'b10000110;//  Piso 3
						4'b0100: DISPLAY = 8'b11001100;//  Piso 4
						4'b0101: DISPLAY = 8'b10100100;//  Sube
						4'b0110: DISPLAY = 8'b10001000;//  Abierto
						4'b0111: DISPLAY = 8'b10110001;//  Cerrado
						4'b1000: DISPLAY = 8'b10000000;//  Baja
						4'b1001: DISPLAY = 8'b10011000;//  indica el Piso
						default: DISPLAY = 8'b0;
					endcase
				end
		end

endmodule
