module sync_counter(PIN_Y2,KEY_3,SW17,W,X,Y,Z);

input KEY_3, SW17, PIN_Y2;

output W,X,Y,Z;

reg [0:3] counter;
reg [25:0] fullcount;

reg D,Q,Q1,Q2, count_pulse;


wire filtered;


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

always @(posedge PIN_Y2) begin
    if(count_pulse) begin
        if (SW17) begin
            counter <= 0;
        end
        else begin
            counter = counter + 1;
            if(counter > 7) begin
                counter <= 0;
            end
        end   
    end
end

assign {W,X,Y,Z} = counter;

endmodule
