`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module maquina_estados(
	 input b_piso1,//botones para llamar al ascensor
	 input b_piso2,
	 input b_piso3,
	 input b_piso4,
	 input ir_a_piso1,//botones para ir al piso una vez dentro del ascensor
	 input ir_a_piso2,
	 input ir_a_piso3,
	 input ir_a_piso4,
    input en,
	 input clk,
	 input rst,
    input baja, //se indica cuando baja
	 input sube, //se indica cuando sube
    output reg [1:0] piso // 
    );

	parameter S0=0, S1=1, S2=2, S3=3; //Estados
	
	reg [1:0] e_actual; //estado actual
	reg [1:0] e_siguiente; // estado siguiente
	
		
	always @ *
		begin
			case(e_actual)
				S0:begin
					if(sube==1)
						e_siguiente=S1;//si sube es 1, sube piso
					else
						e_siguiente=S0;//Si no recibe instruccion se mantiene
					end
				S1:begin
					if(sube==1)
						e_siguiente=S2;//si sube es 1, sube piso
					else if(baja==1)
						e_siguiente=S0; //si baja = 1, baja un piso
					else
						e_siguiente=S1;//Si no recibe instruccion se mantiene
					end
				S2:begin
					if(sube==1)
						e_siguiente=S3;//si sube es 1, sube piso
					else if(baja==1)
						e_siguiente=S1; //si baja = 1, baja un piso
					else
						e_siguiente=S2;//Si no recibe instruccion se mantiene					
					end
				S3:begin
					if(baja==1)
						e_siguiente=S2; //si baja = 1, baja un piso
					else
						e_siguiente=S3;//Si no recibe instruccion se mantiene
					end
				default: e_siguiente=S0;//por defecto está en el piso 1
			endcase
		end
	
	always @ (posedge clk or negedge rst)
		begin
			if(!rst)
				e_actual <= S0;
			else if(en)
				e_actual <= e_siguiente;
		end
			
	always @*
		begin
			piso=e_actual; //de manera inmediara piso tiene el estado actual
		end

endmodule
