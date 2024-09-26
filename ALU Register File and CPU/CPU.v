

//// CPU module instantiating all Modules Including Register Files, ALU,


module CPU 
(
    input  clk,
    input  rst,
    input  [4:0] read_reg1,      // Address of the first register to read
    input  [4:0] read_reg2,     	 // Address of the second register to read

    input  [4:0] write_reg,      	// Address of the register to write
    input  [3:0] ALU_Sel,          // ALU operation select signal
    input  [4:0] Shamt,        	 // Shift amount
    input  write_enable,           // Write enable signal

    output [31:0] ALU_result,    // Output of the ALU
    output Zero_flag             // Zero flag from the ALU
);
    wire [31:0] reg_data1;      	 // Data from the first read register
    wire [31:0] reg_data2;     		  // Data from the second read register
    wire [31:0] alu_out;        	 // Output from the ALU

    wire zero_flag;              // Zero flag from the ALU

    											// Instantiate the register file
    register_file_32bit regfile 
(
        .clk(clk),
        .rst(rst),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(alu_out),    	// Write ALU result to the register file
        .write_enable(write_enable),
        .read_data1(reg_data1),  	// Read data 1 from register file
        .read_data2(reg_data2)   // Read data 2 from register file
    );

   													 // Instantiate the ALU
    ALU alu 
(
        .A(reg_data1),           // Operand A comes from the register file
        .B(reg_data2),              // Operand B comes from the register file
        .ALU_Sel(ALU_Sel),        // ALU operation select signal
        .Shamt(Shamt),           // Shift amount
        .ALU_Out(alu_out),        // ALU result output
        .Zero(zero_flag)         // Zero flag output
    );

    // Output the ALU result and Zero flag
    assign ALU_result = alu_out;
    assign Zero_flag = zero_flag;

endmodule
