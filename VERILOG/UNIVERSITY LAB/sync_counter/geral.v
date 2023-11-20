module geral(KEY_3, SW17, segments);

input KEY_3, SW17;
wire [0:3] counter;
output [0:6] segments;


sync_counter sync(.KEY_3(KEY_3), .SW17(SW17), .W(counter[0]),.X(counter[1]),.Y(counter[2]),.Z(counter[3]));

decod_bcd(.W(counter[0]),.X(counter[1]),.Y(counter[2]),.Z(counter[3]), 
			.a(segments[0]),.b(segments[1]),.c(segments[2]),.d(segments[3]),.e(segments[4]),.f(segments[5]),.g(segments[6]));
			
endmodule
