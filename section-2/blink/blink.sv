module blink(
    input logic clk, reset,
    output logic q
);

parameter integer COUNTER_MAX = 10;

logic [24:0] counter;

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 0;
        q <= 0;
    end else begin
        if (counter >= COUNTER_MAX - 1) begin
            counter <= 0;
            q <= ~q;
        end else begin
            counter <= counter + 1;
        end
    end
end

endmodule
