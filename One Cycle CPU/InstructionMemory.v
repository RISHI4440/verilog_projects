
/// Here we are instantiate both the Instruction Memory and Data Memory using memory2c  module

//// this module is update for one cpu and Memory 2c module


module InstructionMemory (
    input clk,                // Clock input
	input rst,                 // reset
    input [31:0] addr,       // Program counter (PC)
    input createdump,        // Dump signal
    output [31:0] instruction // Fetched instruction
);
    memory2c imem (
        .clk(clk),
		.rst(rst),
        .addr(addr),
        .data_in(32'b0),      // Dummy data input
        .data_out(instruction),
        .enable(1),           // Always enabled for reading
        .wr(0),                // Read-only
        .createdump(createdump) // Pass the createdump signal
    );
endmodule


/// we update this module to to use the dump feature