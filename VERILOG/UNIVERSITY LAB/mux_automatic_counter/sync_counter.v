module sync_counter(PIN_Y2,SW0,SW17,SW16,W,X,Y,Z);

input SW0, SW17, SW16, PIN_Y2;

output W,X,Y,Z;

reg [0:3] counter;
reg [28:0] fullcount;
reg [28:0] frequency;

reg D,Q,Q1,Q2, count_pulse;


always @(SW16 or SW17) begin
    case({SW17, SW16})
        2'b00: frequency=29'd25000000;
        2'b01: frequency=29'd50000000;
        2'b10: frequency=29'd100000000;
        2'b11: frequency=29'd300000000;
    endcase
end

always @(posedge PIN_Y2) begin
    if (fullcount >= frequency) begin
        fullcount <= 29'd0;
        count_pulse <= 1;
    end
    else begin
        fullcount <= fullcount + 1;
        count_pulse <= 0;
    end
end

always @(posedge count_pulse) begin
	  if (SW0) begin
			counter <= 0;
	  end
	  else begin
			counter = counter + 1;
			if(counter > 7) begin
				 counter <= 0;
			end
	 end   
end

assign {W,X,Y,Z} = counter;

endmodule
