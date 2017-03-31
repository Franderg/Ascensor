`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:10:28 03/31/2017
// Design Name:   maquina_estados
// Module Name:   C:/Users/Pelo/Documents/ISE/Proyecto2/testbench.v
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
		.ANODES(ANODES)
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
		#1000 rst = 1;
		#1000 rst = 0;
		#1000 piso2 = 1;
		#1000 piso2 = 0;
		
        
		// Add stimulus here

	end
	
	always
		begin
		clk =~ clk;
	end
      
endmodule

