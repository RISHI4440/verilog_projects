//// FULL ADDER MODULE 

module fulladd (
    input wire A, B, Cin,
    output wire S, Cout
);

    wire AxorB, AxorBandCin, AandB;

    assign AxorB = A ^ B;
    assign AxorBandCin = AxorB & Cin;
    assign AandB = A & B;

    assign S = AxorB ^ Cin;
    assign Cout = AxorBandCin | AandB;

endmodule