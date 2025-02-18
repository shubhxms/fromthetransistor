module dff_rst(
    input logic clk, rst, d,
    output logic q
);

    always_ff @(posedge clk or posedge rst)
        if (rst)
            q <= 1'b0;
        else
            q <= d;

endmodule
