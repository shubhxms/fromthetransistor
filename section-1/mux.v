module mux(
    input logic a, b, sel,
    output logic y
);

// assign y = sel ? b : a;

always_comb begin
    if (sel)
        y = b;
    else
        y = a; 
end

endmodule
