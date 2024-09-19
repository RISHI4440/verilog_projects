
////32-Bit Adder Module

/////Using a fulladder module to create a 32-bit adder:
`timescale 1ns / 1ps
////verilog

module Full_Adder32Bit (
    input wire [31:0] A,   // 32-bit input a
    input wire [31:0] B,   // 32-bit input B
    input wire Cin,         // carry-in
    output wire [31:0] S,  // 32-bit sum
    output wire Cout     // carry-out
);

    wire [31:0] carry;     // Carry signals between stages

    // Instantiate the first full adder
    fulladder fa0 (
        .A(A[0]), .B(B[0]), .Cin(Cin),
        .S(S[0]), .Cout(carry[0])
    );

    // Instantiate the remaining full adders
    genvar i;
    generate  
        for (i = 1; i < 32; i = i + 1) begin : adder_chain
            fulladder fa (
                .A(A[i]), .B(B[i]), .Cin(carry[i-1]),
                .S(S[i]), .Cout(carry[i])
            );
        end
    endgenerate

    // Final carry-out
    assign Cout = carry[31];

endmodule