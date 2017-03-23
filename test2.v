`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////// 

module test2;
	// Inputs
	reg A;
	reg B;
	// Outputs
	wire S;
	// Instantiate the Unit Under Test (UUT)
	circuit2 uut(A,B,S);
		initial begin
			A = 0; B = 0;
			#10 A = 0; B = 1;
			#10 A = 1; B = 0;
			#10 A = 1; B = 1;
		// Wait 10 ns for global reset to finish
		// #10;        
	end      
endmodule

