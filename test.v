`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg en;
	reg clk;
	reg rst;
	reg baja;
	reg sube;

	// Outputs
	wire [1:0] piso;

	// Instantiate the Unit Under Test (UUT)
	maquina_estados uut (
		.en(en), 
		.clk(clk), 
		.rst(rst), 
		.baja(baja), 
		.sube(sube), 
		.piso(piso)
	);

	initial begin
		// Initialize Inputs
		en = 0;
		clk = 0;
		rst = 0;
		baja = 0;
		sube = 0;
		#5 rst = 1;
			en=1;
		#10 sube = 1;
		#10
		#10 sube = 0;
		#10 baja = 1;
		#10 baja = 0;
		#10 sube = 1;
	end
	
	always
	begin
	#5 clk <=~ clk;
	end
      
endmodule

