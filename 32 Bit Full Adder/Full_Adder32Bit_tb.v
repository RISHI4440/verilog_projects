`timescale 1ns / 1ps

// full adder32bit test bench module

module Full_Adder32Bit_tb;

    // Inputs
    reg [31:0] A;
    reg [31:0] B;
    reg Cin;

    // Outputs
    wire [31:0] S;
    wire Cout;

    // Instantiate the adder32 module
    Full_Adder32Bit uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    // Test stimulus
    initial begin
        // 1: Add two small numbers without carry-in
        A = 32'd5;
        B = 32'd10;
        Cin = 0;
        #10;
        $display("Test 1: A=5, B=10, Cin=0 -> S=%d, Cout=%b", S, Cout);

        // 2: Add two large numbers without carry-in
        A = 32'd100000;
        B = 32'd200000;
        Cin = 0;
        #10;
        $display("Test 2: A=100000, B=200000, Cin=0 -> S=%d, Cout=%b", S, Cout);

        // 3: Add two numbers with carry-in
        A = 32'd15;
        B = 32'd20;
        Cin = 1;
        #10;
        $display("Test 3: A=15, B=20, Cin=1 -> S=%d, Cout=%b", S, Cout);

        // Test case 4: Add maximum 32-bit numbers
        A = 32'hFFFFFFFF;  //  32-bit number
        B = 32'hFFFFFFFF;  //  32-bit number
        Cin = 1;           // Carry-in is 1
        #10;
        $display("Test 4: A=FFFFFFFF, B=FFFFFFFF, Cin=1 -> S=%h, Cout=%b", S, Cout);

        // finish
        #10;
        $finish;
    end

endmodule
