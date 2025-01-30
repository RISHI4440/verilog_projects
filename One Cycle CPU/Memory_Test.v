

`timescale 1ns / 1ps


//// Ensure the loadfile_all.img file is present at the specified path 
//// when running the simulation, or adjust the path in the memory2c module as needed.

module Memory_Test;

    reg clk;
    reg rst;
    reg mem_write;
    reg mem_read;
    reg createdump;
    reg [31:0] addr;
    reg [31:0] data_in;
    wire [31:0] data_out;
    wire [31:0] instruction;

    // Instantiate the DataMemory and InstructionMemory modules
    DataMemory dmem (
        .clk(clk),
        .addr(addr),
        .data_in(data_in),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .createdump(createdump),
        .data_out(data_out)
    );

    InstructionMemory imem (
        .clk(clk),
        .addr(addr),
        .createdump(createdump),
        .instruction(instruction)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end


// Test reading from different instruction memory addresses
initial begin
    rst = 1;
    mem_write = 0;
    mem_read = 0;
    createdump = 0;
    addr = 0;

    // Reset the memory
    #10;
    rst = 0;
    #10;

    // Test reading from instruction memory at address 0x00000004
    addr = 32'h00000004;
    mem_read = 1;
    #10;
    mem_read = 0;
    $display("Instruction at 0x%h: 0x%h", addr, instruction);
    if (instruction !== 32'hDEADBEEF) begin
        $display("Error: Expected 0xDEADBEEF, got 0x%h", instruction);
    end else begin
        $display("Success: Correct instruction at 0x00000004");
    end

    // Test reading from instruction memory at address 0x00000008
    addr = 32'h00000008;
    mem_read = 1;
    #10;
    mem_read = 0;
    $display("Instruction at 0x%h: 0x%h", addr, instruction);
    if (instruction !== 32'hCAFEBABE) begin
        $display("Error: Expected 0xCAFEBABE, got 0x%h", instruction);
    end else begin
        $display("Success: Correct instruction at 0x00000008");
    end

    // Test reading from instruction memory at address 0x0000000C
    addr = 32'h0000000C;
    mem_read = 1;
    #10;
    mem_read = 0;
    $display("Instruction at 0x%h: 0x%h", addr, instruction);
    if (instruction !== 32'h12345678) begin
        $display("Error: Expected 0x12345678, got 0x%h", instruction);
    end else begin
        $display("Success: Correct instruction at 0x0000000C");
    end

    // Finish simulation
    #50;
    $finish;
end

endmodule


/* 1) Clock Generation: A clock is generated with a period of 10 ns (100 MHz).

2) Reset: The memory is reset initially to load the contents from loadfile_all.img.

3) Testing Instruction Memory:

    The address is set to 0x00000000, and a read operation is performed.
    The instruction fetched from the instruction memory is displayed.

4) Testing Data Memory:

    A write operation is performed to write the value 0xAABBCCDD to the address 0x00000000.
    Then a read operation is performed to read back the data from the same address, and the result is displayed.

5) Dumping Memory: The createdump signal is activated to generate a dump of the memory contents to the file.

6) Simulation Finish: The simulation runs for a set time and then finishes. */