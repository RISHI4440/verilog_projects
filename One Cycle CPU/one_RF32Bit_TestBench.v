//// Verilog testbench to test the ONE 32-bit register file.


module one_RF32Bit_TestBench;

    // Testbench signals
    reg clk;
    reg rst;
    reg write_enable;
    reg [4:0] write_reg;
    reg [31:0] write_data;
    reg [4:0] read_reg1, read_reg2;
    wire [31:0] read_data1, read_data2;

    // Instantiate the register file
    one_register_file_32bit DUT (
        .clk(clk),
        .rst(rst),
        .write_enable(write_enable),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    always #5 clk = ~clk; // 10-unit time period clock

    // Testbench process
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        write_enable = 0;
        write_reg = 5'b00000;
        write_data = 32'h00000000;
        read_reg1 = 5'b00000;
        read_reg2 = 5'b00001;

        // Reset the register file
        #10 rst = 0;
        
        // Wait for reset deassertion
        #10;

        // Test 1: Write to register 1
        write_enable = 1;
        write_reg = 5'b00001;    // Register 1
        write_data = 32'hA5A5A5A5; // Data to write
        #10;
        
        // Test 2: Write to register 2
        write_reg = 5'b00010;    // Register 2
        write_data = 32'h5A5A5A5A; // Data to write
        #10;
        
        // Disable writing
        write_enable = 0;

        // Test 3: Read from register 1 and 2
        read_reg1 = 5'b00001; // Register 1
        read_reg2 = 5'b00010; // Register 2
        #10;
        
        // Test 4: Reset and check if registers are cleared
        rst = 1;
        #10 rst = 0; // Deassert reset
        
        // Test 5: Read after reset
        read_reg1 = 5'b00001; // Register 1 (should be reset)
        read_reg2 = 5'b00010; // Register 2 (should be reset)
        #10;
        
        // Stop the simulation
        $stop;
    end

endmodule