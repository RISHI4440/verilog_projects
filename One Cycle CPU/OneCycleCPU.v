//// This is CPU module for one cycle RISC-V CPU 


/// updates we modved the create dump signal module to Control Unite (Decode Logic)

module OneCycleCPU (
    input clk,
    input rst
);
    wire [31:0] instr, imm, read_data1, read_data2, alu_result, mem_data, write_data;
    wire [6:0] opcode = instr[6:0];
    wire [2:0] funct3 = instr[14:12];
    wire [6:0] funct7 = instr[31:25];
    wire [4:0] rs1 = instr[19:15];
    wire [4:0] rs2 = instr[24:20];
    wire [4:0] rd = instr[11:7];
    wire [3:0] alu_sel;
    wire branch, mem_read, mem_write, reg_write, alu_src, jump, zero_flag, branch_taken, select0, select1;   // Sel 0 & Sel 1

	wire [31:0] pc, next_pc;
//	reg [31:0] pc, next_pc; // Declare pc as reg

	
	
      // Declare createdump_signal driven by ControlUnit
    wire createdump_signal;
	
	// Program Counter 
	ProgramCounter pc_reg(
		.clk(clk), 
		.rst(rst),
		.branch(branch),
		.jump(jump),		
		.pc_in(next_pc), 
		.pc_out(pc)     	
		);		//// pc_out connected to instruction memory to fetch instructions based on the current PC value.
	// Corrected output port name


	// Control Unit
	ControlUnit cu (
		.opcode(opcode),       // Connect the opcode input
		.funct3(funct3),      // Connect the funct3 input
		.funct7(funct7),     		 // Connect the funct7 input
		.ALUOp(alu_sel),     		 // Connect ALU operation selection output
		.MemRead(mem_read),   		 // Connect memory read control output
		.MemWrite(mem_write), 		 // Connect memory write control output
		.RegWrite(reg_write),  // Connect register write control output
		.ALUSrc(alu_src),     		 // Connect ALU source selection output
	//	.MemToReg(mem_to_reg),  // connect memory to register data selection output
		.sel0(select0),
        .sel1(select1),
		
		.Branch(branch),       // connect branch control output
		.Jump(jump),           // connect jump control output		
		.createdump(createdump_signal) 					// Pass createdump signal from control unit
	); 
			// Corrected output port name
	
 
// Register File			
	one_register_file_32bit regfile(
    .clk(clk),                // Clock signal
    .rst(rst),              	  // Reset signal (Make sure to connect this signal)
    .read_reg1(rs1),        	 // Select reg 1 (make sure rs1 is defined as i/p)
    .read_reg2(rs2),        	 // Select reg 2 (make sure rs2 is defined as input)
    .write_reg(rd),          	// Select the register to write to (make sure rd is defined as input)
    .write_data(write_data), 	// Data to write (make sure write_data is defined in the CPU module)
    .write_enable(reg_write),	// Write enable signal (make sure reg_write is defined in the CPU module)
    .read_data1(read_data1), 	// Output of register 1
    .read_data2(read_data2)  // Output of register 2
);
	// Corrected output port name


    // Immediate Generator
    ImmediateGenerator imm_gen(.instr(instr), .imm_out(imm));		// Corrected output port name
	
	

    // ALU
    	OneCycleALU alu(
        .A(read_data1),
        .B(alu_src ? imm : read_data2),
        .ALUOp(alu_sel),
        .result(alu_result),
        .zero_flag(zero_flag)
    );
// Corrected output port name
   
  /*  MUX2to1 wb_mux(
        .inn0(imm),			// output from ALU
        .inn1(read_data2),
        .sel(alu_src),			// select signal
        .out(write_data)
    */


   // Branch Logic
   
	BranchLogic branch_logic(
        .reg1(read_data1),
        .reg2(read_data2),
        .funct3(funct3),
        .branch_taken(branch_taken)
    );
// Corrected output port name


/*     // OLD Data Memory
    DataMemory dmem(
    .clk(clk),                // Pass the clock signal
	.rst(rst), 
    .addr(alu_result),        // Address from ALU
    .data_in(read_data2),     // Data to write
    .mem_write(mem_write),    // Memory write signal
    .mem_read(mem_read),      // Memory read signal
    .data_out(mem_data),       // Data read from memory	
	.createdump(createdump_signal) // Connect createdump signal
);// Corrected output port name
 */

////// NEW DATA MEMORY MODULE

Q_DMEM dmem (
    .clock(clk),            // Connect the clock signal
    .address(alu_result),   // Connect the address from ALU
	
    .data(read_data2),      // Connect the data to write
    .wren(mem_write),       // Memory write enable
    .q(mem_data)            // Data read from memory
);
/* 

// Instruction Memory
InstructionMemory imem(
    .clk(clk),                // Pass the clock signal
	.rst(rst), 																	// newly added
    .addr(pc),                // from Program counter (PC)
    .instruction(instr),       // Fetched instruction
	.createdump(createdump_signal) // Connect createdump signal
);	
// Corrected output port name
 */
  /// NEW instruction MEMORY MODULE
  
Q_IMEM imem (
      .address(next_pc[31:2] ),               // add from Program Counter (PC)
      .clock(clk),
	 .q(instr)    // Fetched instruction  
);



  /*   // Write-back stage
	MUX2to1 wb_mux(
        .in0(alu_result),			// output from ALU
        .in1(mem_data),
        .sel(mem_to_reg),			// select signal
        .out(write_data)
    ); */
	// Instantiate MUX4to1_32bit for write-back selection
    MUX4to1_32bit mux_write_back (
        .in0(alu_result),       // ALU result
        .in1(mem_data),         // Memory data
        .in2(imm),         // Immediate data
        .in3(32'b0),            // Additional input (if unused, set to 0)
        .sel0(select0),
        .sel1(select1),
        .out(write_data)
	);
	
	// control flow in your CPU design, allowing it to handle jumps and branches correctly
    //	based on the instruction being executed
	
	// PC Update logic							/// .pc_in(next_pc), is determining the address of the next instruction to execute in the CPU based on certain control signals.
   assign next_pc = (jump) ? (pc + imm) : (branch && branch_taken) ? (pc + imm) : (pc + 4);

	


endmodule
