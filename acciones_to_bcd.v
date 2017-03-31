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
	 input rst,
	 input [1:0] piso, //Indica el piso actual, 0, 1, 2, 3
	 input [1:0] accion, //Indica si est� subiendo o bajando, 0 no se mueve, 1 sube y 2 baja
	 input puertas, //Indica si las puertas est�n abiertas o cerradas, 0 cerradas, 1 abiertas
	 output reg [3:0] BCD1,
	 output reg [3:0] BCD2,
	 output reg [3:0] BCD3,
	 output reg [3:0] BCD4
    );

initial begin
	BCD4 = 1;
	BCD3 = 9;
	BCD2 = 6;
	BCD1 = 0;
end

always @ (posedge clk)
	begin
		if (rst == 1)
			begin
				BCD4 = 4'b1110;
				#10 BCD4 = 4'b0001;
				BCD3 = 4'b0110;
				#10 BCD3 = 4'b1001;
			end
		else
			begin
				if (piso == 2'b00)
					BCD4 = 4'b0001;
				else if (piso == 2'b01)
					BCD4 = 4'b0010;
				else if (piso == 2'b10)
					BCD4 = 4'b0011;
				else
					BCD4 = 4'b0100;
			end
	end

always @ (posedge clk)
	begin
		if (rst == 1)
			begin
				BCD1 = 4'b1111;
				#10 BCD1 = 4'b0000;
			end
		else
			begin
				if (accion == 2'b00)
					BCD1 = 4'b0000;
				else if (accion == 2'b01)
					BCD1 = 4'b0101;
				else if (accion == 2'b10)
					BCD1 = 4'b1000;
				else
					BCD1 = 0;
			end
	end

always @ (posedge clk)
	begin
		if (rst == 1)
			begin
				BCD2 = 4'b1001;
				#10 BCD2 = 4'b0110;
			end
		else
			begin
				if (puertas == 1'b0)
					BCD2 = 4'b0111;
				else
					BCD2 = 4'b0110;
			end
	end

endmodule
