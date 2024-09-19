///// 4-to-1 multiplexer (MUX) 

`timescale 1us/100ns
module mux4to1 (
    input wire D0,     // Data input 0
    input wire D1,     // Data input 1
    input wire D2,     // Data input 2
    input wire D3,     // Data input 3
    input wire S0,     // Select line 0
    input wire S1,     // Select line 1
    output wire Y      // Output
);

    wire S0_bar, S1_bar;
    wire T0, T1, T2, T3;

    // Generate inverses of select lines
    not (S0_bar, S0);
    not (S1_bar, S1);

    // AND gates to select data inputs
    and (T0, D0, S0_bar, S1_bar); // T0 = D0 when S0=0 and S1=0
    and (T1, D1, S0, S1_bar);     // T1 = D1 when S0=1 and S1=0
    and (T2, D2, S0_bar, S1);     // T2 = D2 when S0=0 and S1=1
    and (T3, D3, S0, S1);         // T3 = D3 when S0=1 and S1=1

    // OR gate to produce the final output
    or (Y, T0, T1, T2, T3);

endmodule
