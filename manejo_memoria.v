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
    input [1:0] piso, //piso actual
	 input [3:0] boton, //boton que se presiona
	 output reg [3:0] memoria, //registro con la siguiente instruccion para la maquina de estados
    );

reg [3:0] RAM [0:255];
parameter count = 0;

always @ (posedge clk)
	begin
		
		
endmodule
