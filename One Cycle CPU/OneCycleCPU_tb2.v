
`timescale 1ns / 1ps

module OneCycleCPU_tb2;

// Testbench signals
reg clk;
reg rst;

// Instantiate the CPU
OneCycleCPU uut (
    .clk(clk),
    .rst(rst)
);

// Clock generation (50MHz)
always #10 clk = ~clk;

// Initialize testbench
initial begin
    // Initialize clock and reset
    clk = 0;
    rst = 1;
    
    // Hold reset for a few cycles
    #20 rst = 0;

    // Add some delay to observe the output behavior
    #500;
    
    // Apply reset again to check PC reset functionality
    rst = 1;
    #20 rst = 0;
    
    // Observe more cycles
    #500;

    // Finish simulation
    $stop;
end

// Monitor signals for debugging
initial begin
    $monitor("Time = %0d, PC = %h, ALU Result = %h, Instruction = %h", 
             $time, uut.pc, uut.alu_result, uut.instr);
end

endmodule
