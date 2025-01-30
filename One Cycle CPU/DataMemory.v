// Data Memory module for One cycle RISC-V CPU

/// Here we are instantiate Data Memory using memory2c  module

/// The data memory stores data values and can be read from or written to by the CPU.

//// this module is update for one cpu and Memory 2c module

module DataMemory (
    input clk,                 //  clock input				/// getting the clock from CPU module and passing it to the MEmory2c module 
    input rst,                 // reset
	input [31:0] addr,        // Address from ALU
    input [31:0] data_in,     // Data to write
    input mem_write,          // Write enable
    input mem_read,           // Read enable
	input createdump,        // Dump signal
    output [31:0] data_out    // Data read from memory
);
  //  wire createdump;          // If we plan to use this feature, define this signal

    memory2c dmem (
        .clk(clk),             // Pass clock to memory2c
		.rst(rst),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out),
        .enable(mem_read | mem_write), // Enable read or write based on signals
        .wr(mem_write),       // Write signal
        .createdump(createdump) // Optional if we plan to use this
    );
endmodule



/// we update this module to to use the dump feature