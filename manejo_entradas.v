`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:54:58 03/24/2017 
// Design Name: 
// Module Name:    manejo_entradas 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: maneja las entradas, convirtiendo lo que entra en un registro para
// poder ser usado por el resto del programa.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module manejo_entradas(
	input clk,
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
	output reg [3:0] boton_pres
    );

initial begin
	boton_pres = 0;
end

always @ (posedge clk)//posedge piso1 or posedge piso2 or posedge piso3 or posedge piso4 or posedge S1 or posedge B2 or posedge S2 or posedge B3 or posedge S3 or posedge B4)
	begin
		if (piso1)
			boton_pres = 1;
		else if (piso2)
			boton_pres = 2;
		else if (piso3)
			boton_pres = 3;
		else if (piso4)
			boton_pres = 4;
		else if (S1)
			boton_pres = 5;
		else if (B2)
			boton_pres = 6;
		else if (S2)
			boton_pres = 7;
		else if (B3)
			boton_pres = 8;
		else if (S3)
			boton_pres = 9;
		else if (B4)
			boton_pres = 10;
		else
			boton_pres = 0;
	end

endmodule
