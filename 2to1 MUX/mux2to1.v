`timescale 1us/100ns
module mux2to1 (
    input wire A,    // Input 1
    input wire B,    // Input 2
    input wire sel,  // Select signal
    output wire Y    // Output
);

    // If sel is 0, Y = A; if sel is 1, Y = B
    assign Y = sel ? B : A;

endmodule
