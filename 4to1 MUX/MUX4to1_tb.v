///  Testbench for 4-to-1 MUX

`timescale 1us/100ns
module mux4to1_tb;

    reg D0, D1, D2, D3;
    reg S0, S1;
    wire Y;

    // Instantiate the multiplexer
    mux4to1 uut (
        .D0(D0),
        .D1(D1),
        .D2(D2),
        .D3(D3),
        .S0(S0),
        .S1(S1),
        .Y(Y)
    );

    initial begin
        // Initialize inputs
        D0 = 0; D1 = 0; D2 = 0; D3 = 0; S0 = 0; S1 = 0;

        // Apply test cases
        #10 D0 = 1; D1 = 0; D2 = 0; D3 = 0; S0 = 0; S1 = 0; // Expect Y = D0 = 1
        #10 D0 = 0; D1 = 1; D2 = 0; D3 = 0; S0 = 1; S1 = 0; // Expect Y = D1 = 1
        #10 D0 = 0; D1 = 0; D2 = 1; D3 = 0; S0 = 0; S1 = 1; // Expect Y = D2 = 1
        #10 D0 = 0; D1 = 0; D2 = 0; D3 = 1; S0 = 1; S1 = 1; // Expect Y = D3 = 1
        #10 D0 = 1; D1 = 1; D2 = 1; D3 = 1; S0 = 1; S1 = 0; // Expect Y = D1 = 1
        #10 D0 = 1; D1 = 1; D2 = 1; D3 = 1; S0 = 0; S1 = 1; // Expect Y = D2 = 1
        #10 D0 = 1; D1 = 1; D2 = 1; D3 = 1; S0 = 1; S1 = 1; // Expect Y = D3 = 1

        // Finish simulation
        #10 $finish;
    end

    initial begin
        $monitor("Time=%0t | D0=%b D1=%b D2=%b D3=%b S0=%b S1=%b -> Y=%b", $time, D0, D1, D2, D3, S0, S1, Y);
    end

endmodule
