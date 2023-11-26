module geral(PIN_Y2,SW0,SW17,SW16,segments);

input SW0, SW17, SW16, PIN_Y2;
wire [0:3] counter;
output [0:6] segments;


sync_counter sync(.PIN_Y2(PIN_Y2), .SW0(SW0), .SW17(SW17), .SW16(SW16), .W(counter[0]), .X(counter[1]), .Y(counter[2]), .Z(counter[3]));

decod_bcd(.W(counter[0]),.X(counter[1]),.Y(counter[2]),.Z(counter[3]), 
			.a(segments[0]),.b(segments[1]),.c(segments[2]),.d(segments[3]),.e(segments[4]),.f(segments[5]),.g(segments[6]));
			
endmodule
