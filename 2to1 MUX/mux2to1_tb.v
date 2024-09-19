`timescale 1us/100ns
module mux2to1_tb;

    reg A, B, sel;
    wire Y;

    // Instantiate the module
    mux2to1 uut (
        .A(A), 
        .B(B), 
        .sel(sel), 
        .Y(Y)
    );

    initial begin
        // Initialize inputs
        A = 0;
        B = 0;
        sel = 0;

         // Apply test cases
        #5  A = 0; B = 1; sel = 0; // Expect Y = A = 0
        #5  A = 1; B = 0; sel = 1; // Expect Y = B = 0
        #5  A = 1; B = 1; sel = 0; // Expect Y = A = 1
        #5  A = 0; B = 1; sel = 1; // Expect Y = B = 1
        #5  A = 0; B = 0; sel = 0; // Expect Y = A = 0
        #5  A = 1; B = 0; sel = 1; // Expect Y = B = 0
        #5  A = 0; B = 1; sel = 1; // Expect Y = B = 1
        #5  A = 1; B = 1; sel = 1; // Expect Y = B = 1

        // Finish simulation
        #10 $finish;
    end

    initial begin
        $monitor("Time=%0t | A=%b B=%b sel=%b -> Y=%b", $time, A, B, sel, Y);
    end

endmodule
