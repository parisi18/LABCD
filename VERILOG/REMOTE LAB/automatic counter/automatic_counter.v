module automatic_counter (SW, CLOCK_50, HEX4);

reg [0:3] contador;
input CLOCK_50;
input [17:17] SW;
output [0:6] HEX4;
reg [25:0] fullcount;
reg count_pulse;
reg [0:6] segmentos;

always @(posedge CLOCK_50) begin
    if (fullcount == 26'd50000000) begin
        fullcount <= 26'd0;
        count_pulse <= 1;
    end
    else begin
        fullcount <= fullcount + 1;
        count_pulse <= 0;
    end
end

always @(posedge CLOCK_50) begin
    if(count_pulse) begin
        if (SW[17]) begin
            contador <= 0;
        end
        else begin
            contador = contador + 1;
            if(contador > 7) begin
                contador <= 0;
            end
        end   
    end
end

always@ (*) begin
    case ({contador})
        4'b0000: segmentos=7'b0000001;
        4'b0001: segmentos=7'b1001111;
        4'b0010: segmentos=7'b0010010;
        4'b0011: segmentos=7'b0000110;
        4'b0100: segmentos=7'b1001100;
        4'b0101: segmentos=7'b0100100;
        4'b0110: segmentos=7'b0100000;
        4'b0111: segmentos=7'b0001111;
        4'b1000: segmentos=7'b0000000;
        4'b1001: segmentos=7'b0000100;
        default: segmentos=7'b1111111;
    endcase
end

assign {HEX4[0:6]}=segmentos;

endmodule