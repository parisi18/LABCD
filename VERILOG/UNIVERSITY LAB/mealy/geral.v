module geral(SW17,SW16,SW0,PIN_Y2,segments);

input SW17,SW16,SW0,PIN_Y2;
wire [0:3] counter;
output [0:6] segments;


mealy_machine(.SW17(SW17),.SW16(SW16),.SW0(SW0),.PIN_Y2(PIN_Y2),.output_z(counter));

decod_bcd(.z(counter),.a(segments[0]),.b(segments[1]),.c(segments[2]),.d(segments[3]),.e(segments[4]),.f(segments[5]),.g(segments[6]));
			

endmodule
