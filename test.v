`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg en;
	reg clk;
	reg rst;
	reg [3:0] boton_pres;

	// Outputs
	wire [1:0] piso;
	wire [1:0] accion;
	wire puertas;

	// Instantiate the Unit Under Test (UUT)
	maquina_estados uut(
	   .boton_pres(boton_pres),
		.en(en), 
		.clk(clk), 
		.rst(rst), 
		.piso(piso),
		.accion(accion),
		.puertas(puertas)
	);

initial begin
		// Initialize Inputs
		en = 0;
		clk = 0;
		rst = 0;
		boton_pres <= 0;
		#5 rst = 1;
			en=1;
		#15 boton_pres <= 2;
		#20 boton_pres <= 2;
		#20 boton_pres <= 5;
		#20 boton_pres <= 1;
		#20 boton_pres <= 2;
		#20 boton_pres <= 3;
		#20 boton_pres <= 4;
		#20 boton_pres <= 4;
		#20 boton_pres <= 3;
		#20 boton_pres <= 3;
		#20 boton_pres <= 0;
		#20 boton_pres <= 2;
	end
	
	always
	begin
	#10 clk <=~ clk;
	end
      
endmodule

