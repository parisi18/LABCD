module sync_counter(KEY_3,SW17,W,X,Y,Z);

input KEY_3;
input SW17;

output W,X,Y,Z;
reg [0:3] counter;


always @(posedge KEY_3) begin
    if (SW17) begin
        counter = 0;
    end else begin
        counter = counter + 1;
        if(counter > 7) begin
            counter = 0;
        end
    end   
end

assign {W,X,Y,Z} = counter;

endmodule
