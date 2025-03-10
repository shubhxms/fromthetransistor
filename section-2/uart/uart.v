module uart(
    input wire clk, rst, start_tx,
    input wire [7:0] data,
    output reg tx, busy
);

    // BAUD RATE GENERATOR
    // ticks at every CLOCKS_PER_BIT tick-tocks
    parameter CLOCK_FREQ = 50000000;  // system clock
    parameter BAUD_RATE = 9600;       // bits per second
    parameter CLOCKS_PER_BIT = CLOCK_FREQ / BAUD_RATE;

    reg [$clog2(CLOCKS_PER_BIT)-1:0] baud_counter;
    reg baud_tick;

    always_ff @(posedge clk) begin
        if (rst) begin
            baud_counter <= 0;
            baud_tick <= 0;
        end else begin
            if (baud_counter == CLOCKS_PER_BIT- 1) begin
                baud_counter <= 0;
                baud_tick <= 1;
            end else begin
                baud_counter <= baud_counter + 1;
                baud_tick <= 0;
            end
        end
    end


    // STATE MACHINE
    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam DATA = 2'b10;
    localparam STOP = 2'b11;

    reg [1:0] state;
    reg [2:0] bit_counter;
    reg [7:0] shift_reg;
    
    always_ff @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            bit_counter <= 0;
            busy <= 0;
        end else begin
            case (state)
                IDLE: begin
                    tx <= 1; 
                    if (start_tx) begin
                        shift_reg <= data;
                        state <= START;
                        busy <= 1;
                    end
                end
                
                START: begin
                    tx <= 0; 
                    if (baud_tick) begin
                        state <= DATA;
                        bit_counter <= 0;
                    end
                end
                
                DATA: begin
                    tx <= shift_reg[0];
                    if (baud_tick) begin
                        shift_reg <= shift_reg >> 1;
                        if (bit_counter == 7) begin
                            state <= STOP;
                        end else begin
                            bit_counter <= bit_counter + 1;
                        end
                    end
                end
                
                STOP: begin
                    tx <= 1;
                    if (baud_tick) begin
                        state <= IDLE;
                        busy <= 0;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end
    
    
    
endmodule
