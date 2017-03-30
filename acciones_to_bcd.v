`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:42:48 03/29/2017 
// Design Name: 
// Module Name:    acciones_to_bcd 
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
module acciones_to_bcd(
	 input clk,
	 input [1:0] piso, //Indica el piso actual, 0, 1, 2, 3
	 input [1:0] accion, //Indica si está subiendo o bajando, 0 no se mueve, 1 sube y 2 baja
	 input puertas, //Indica si las puertas están abiertas o cerradas, 0 cerradas, 1 abiertas
	 output reg [3:0] BCD1,
	 output reg [3:0] BCD2,
	 output reg [3:0] BCD3,
	 output reg [3:0] BCD4
    );

initial begin
	BCD4 = 1;
	BCD3 = 9;
	BCD2 = 7;
	BCD1 = 0;
end

always @ (posedge clk)
	begin
		if (piso == 0)
			BCD4 = 4'b0001;
		else if (piso == 1)
			BCD4 = 4'b0010;
		else if (piso == 2)
			BCD4 = 4'b0011;
		else if (piso == 3)
			BCD4 = 4'b0100;
		
		if (accion == 0)
			BCD1 = 4'b0000;
		else if (accion == 1)
			BCD1 = 4'b0101;
		else if (accion == 2)
			BCD1 = 4'b1000;
			
		if (puertas == 0)
			BCD2 = 4'b0111;
		else if (puertas == 1)
			BCD2 = 4'b0110;
		else
			begin
				BCD4 = 1;
				BCD2 = 7;
				BCD1 = 0;
			end
	end

endmodule
