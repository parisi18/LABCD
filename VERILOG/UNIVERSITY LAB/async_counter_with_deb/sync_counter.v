module sync_counter(PIN_Y2,KEY_3,SW17,W,X,Y,Z);

input KEY_3, SW17, PIN_Y2;

output W,X,Y,Z;

reg [0:3] counter;
reg D,Q,Q1,Q2;

wire filtered;


always @(posedge PIN_Y2) begin
    
    if(KEY_3) begin
        D <= KEY_3;
        
        if(SW17) begin
            Q <= 1'b0;
            Q1 <= 1'b0;
            Q2 <= 1'b0;
        end
        else begin
            Q <= D;
            Q1 <= Q;
            Q2 <= Q1;
        end
    end
end

assign filtered = Q & Q1 & Q2;

always @(posedge KEY_3 or posedge SW17) begin

    if (SW17) begin
        counter <= 0;
    end 
    else begin
        if(filtered) begin
            counter = counter + 1;
            if(counter > 9) begin
                counter <= 0;
            end
        end
    end   
end

assign {W,X,Y,Z} = counter;

endmodule
