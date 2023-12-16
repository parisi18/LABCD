module mealy_machine(SW17,SW16,SW0,PIN_Y2,output_z);

// Switches, reset && clock
input SW17,SW16,SW0,PIN_Y2;

// Segments output
reg [0:3] z;

output [0:3] output_z;

// Actual && next state
reg [0:3] y;
reg [0:3] Y;

//Counter for frequency divisor
reg [25:0] fullcount;

//Counter pulse
reg count_pulse;

// Mealy states references
parameter A=4'b0001, B=4'b0010, C=4'b0011, D=4'b0100, E=4'b0101, F=4'b0110, G=4'b0111, H=4'b1000, I=4'b1001, CLEAN=4'b1010;

// Segments outputs
parameter out0=4'b0000, out1=4'b0001, out2=4'b0010, out3=4'b0011, out4=4'b0100, out5=4'b0101,
          out6=4'b0110,out7=4'b0111,out8=4'b1000,out9=4'b1001,out10=4'b1010;

// 1 second frequency
always @(posedge PIN_Y2) begin
    if (fullcount == 26'd50000000) begin
        fullcount <= 26'd0;
        count_pulse <= 1;
    end
    else begin
        fullcount <= fullcount + 1;
        count_pulse <= 0;
    end
end

// Combinational input/output circuit (Blocking)

always @(SW17 or SW16 or y)
begin
	case (y)

		// A
		A:
		begin
			if (SW17==0 && SW16==0)
					begin
						Y=A;
						z=out8;
					end
			if(SW17==0 && SW16==1)
					begin
						Y=I;
						z=out1;
					end
			if(SW17==1 && SW16==0)
					begin
						Y=B;
						z=out3;
					end 
			if(SW17==1 && SW16==1)
					begin
						Y=A;
						z=out10;
					end
		end

		// B
		B: 
		begin
			if (SW17==0 && SW16==0)
					begin
						Y=B;
						z=out3;
					end
			if(SW17==0 && SW16==1)
					begin
						Y=A;
						z=out8;
					end
			if(SW17==1 && SW16==0)
					begin
						Y=C;
						z=out0;
					end 
			if(SW17==1 && SW16==1)
					begin
						Y=CLEAN;
						z=out10;
					end
		end
		
		// C
		C: 
		begin
			if (SW17==0 && SW16==0)
					begin
						Y=C;
						z=out0;
					end
			if(SW17==0 && SW16==1)
					begin
						Y=B;
						z=out3;
					end
			if(SW17==1 && SW16==0)
					begin
						Y=D;
						z=out8;
					end 
			if(SW17==1 && SW16==1)
					begin
						Y=CLEAN;
						z=out10;
					end
		end
		
		// D
		D: 
		begin
			if (SW17==0 && SW16==0)
					begin
						Y=D;
						z=out8;
					end
			if(SW17==0 && SW16==1)
					begin
						Y=C;
						z=out0;
					end
			if(SW17==1 && SW16==0)
					begin
						Y=E;
						z=out2;
					end 
			if(SW17==1 && SW16==1)
					begin
						Y=CLEAN;
						z=out10;
					end
		end
		
		// E
		E: 
		begin
			if (SW17==0 && SW16==0)
					begin
						Y=E;
						z=out2;
					end
			if(SW17==0 && SW16==1)
					begin
						Y=D;
						z=out8;
					end
			if(SW17==1 && SW16==0)
					begin
						Y=F;
						z=out4;
					end 
			if(SW17==1 && SW16==1)
					begin
						Y=CLEAN;
						z=out10;
					end
		end
		
		// F
		F: 
		begin
			if(SW17==0 && SW16==0)
					begin
						Y=F;
						z=out4;
					end
			if(SW17==0 && SW16==1)
					begin
						Y=E;
						z=out2;
					end
			if(SW17==1 && SW16==0)
					begin
						Y=G;
						z=out3;
					end 
			if(SW17==1 && SW16==1)
					begin
						Y=CLEAN;
						z=out10;
					end
		end
		
		// G
		G: 
		begin
			if(SW17==0 && SW16==0)
					begin
						Y=G;
						z=out3;
					end
			if(SW17==0 && SW16==1)
					begin
						Y=F;
						z=out4;
					end
			if(SW17==1 && SW16==0)
					begin
						Y=H;
						z=out5;
					end 
			if(SW17==1 && SW16==1)
					begin
						Y=CLEAN;
						z=out10;
					end
		end
		
		// H
		H: 
		begin
			if(SW17==0 && SW16==0)
					begin
						Y=H;
						z=out5;
					end
			if(SW17==0 && SW16==1)
					begin
						Y=G;
						z=out3;
					end
			if(SW17==1 && SW16==0)
					begin
						Y=I;
						z=out1;
					end
			if(SW17==1 && SW16==1)
					begin
						Y=CLEAN;
						z=out10;
					end
		end
		
		// I
		I: 
		begin
			if(SW17==0 && SW16==0)
					begin
						Y=I;
						z=out1;
					end
			if(SW17==0 && SW16==1)
					begin
						Y=H;
						z=out5;
					end
			if(SW17==1 && SW16==0)
					begin
						Y=A;
						z=out8;
					end 
			if(SW17==1 && SW16==1)
					begin
						Y=CLEAN;
						z=out10;
					end
		end
		
		// OUT
		CLEAN: 
		begin
			if (SW17==0 && SW16==0)
					begin
						Y=CLEAN;
						z=out10;
					end
			if(SW17==0 && SW16==1)
					begin
						Y=A;
						z=out8;
					end
			if(SW17==1 && SW16==0)
					begin
						Y=A;
						z=out8;
					end 
			if(SW17==1 && SW16==1)
					begin
						Y=CLEAN;
						z=out10;
					end
		end
	endcase
end

// Sequential circuit
always @(posedge count_pulse or posedge SW0)
begin
	if (SW0 == 1'b1)
		y <=A;
	else
		y <=Y;
end

assign output_z = z;

endmodule
