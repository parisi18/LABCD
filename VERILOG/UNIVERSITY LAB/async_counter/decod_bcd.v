module decod_bcd(SW, HEX4);

input reg [14:17] SW;
output [0:6] HEX4;
reg [0:6] segmentos;

always@ (*)
    case ({SW[17],SW[16],SW[15],SW[14]})
        4'b0000: segmentos = 7'b0000001;
        4'b0001: segmentos = 7'b1001111;
        4'b0010: segmentos = 7'b0010010;
        4'b0011: segmentos = 7'b0000110;
        4'b0100: segmentos = 7'b1001100;
        4'b0101: segmentos = 7'b0100100;
        4'b0110: segmentos = 7'b0100000;
        4'b0111: segmentos = 7'b0001111;
        4'b1000: segmentos = 7'b0000000;
        4'b1001: segmentos = 7'b0000100;
        default: segmentos = 7'b1111111;
    endcase
assign HEX4 = segmentos;

endmodule