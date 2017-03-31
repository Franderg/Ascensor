`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:45:30 03/31/2017
// Design Name:   maquina_estados
// Module Name:   C:/Users/Pelo/Documents/Projects/testbench.v
// Project Name:  Proyecto2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: maquina_estados
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg clk;
	reg rst;
	reg piso1;
	reg piso2;
	reg piso3;
	reg piso4;
	reg S1;
	reg B2;
	reg S2;
	reg B3;
	reg S3;
	reg B4;

	// Outputs
	wire [7:0] DISPLAY;
	wire [3:0] ANODES;
	/*wire [1:0] piso;
	wire [1:0] accion;
	wire puertas;
	wire [3:0] contador_seg;
	wire [3:0] memoria_m;*/

	// Instantiate the Unit Under Test (UUT)
	maquina_estados uut (
		.clk(clk), 
		.rst(rst), 
		.piso1(piso1), 
		.piso2(piso2), 
		.piso3(piso3), 
		.piso4(piso4), 
		.S1(S1), 
		.B2(B2), 
		.S2(S2), 
		.B3(B3), 
		.S3(S3), 
		.B4(B4), 
		.DISPLAY(DISPLAY), 
		.ANODES(ANODES), 
/*		.piso(piso), 
		.accion(accion), 
		.puertas(puertas),
		.contador_seg(contador_seg),
		.memoria_m(memoria_m)*/
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		piso1 = 0;
		piso2 = 0;
		piso3 = 0;
		piso4 = 0;
		S1 = 0;
		B2 = 0;
		S2 = 0;
		B3 = 0;
		S3 = 0;
		B4 = 0;

		// Wait 100 ns for global reset to finish
		#100;
				#10 rst = 1;
		#10 rst = 0;
		#10 piso2 = 1;
		#10 piso2 = 0;
        
		// Add stimulus here

	end
      
always
	begin
		#1 clk <= ~clk;
	end

        
		// Add stimulus here

      
endmodule

