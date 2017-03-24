`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg en;
	reg clk;
	reg rst;
	reg [3:0] memoria;

	// Outputs
	wire [1:0] piso;
	wire [1:0] accion;
	wire puertas;

	// Instantiate the Unit Under Test (UUT)
	maquina_estados uut (
	   .memoria(memoria),
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
		memoria <= 0;
		#5 rst = 1;
			en=1;
		#15 memoria <= 2;
		#20 memoria <= 2;
		#20 memoria <= 5;
		#20 memoria <= 1;
		#20 memoria <= 2;
		#20 memoria <= 3;
		#20 memoria <= 4;
		#20 memoria <= 4;
		#20 memoria <= 3;
		#20 memoria <= 3;
		#20 memoria <= 0;
		#20 memoria <= 2;
	end
	
	always
	begin
	#10 clk <=~ clk;
	end
      
endmodule

