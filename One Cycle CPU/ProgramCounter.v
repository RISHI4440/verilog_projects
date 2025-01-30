//// Program Counter (PC) MODULE for ONE Cycle CPU


//// A 32-bit register with increment logic for fetching sequential instructions.

/* module ProgramCounter(
    input clk,
    input rst,
    input [31:0] pc_in,				/// input connection
    output reg [31:0] pc_out		//// output connection
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_out <= 0;  // Reset PC to 0
        else
            pc_out <= pc_in;
			
    end
endmodule */


module ProgramCounter(
    input clk,
    input rst,
	input branch,             // Branch control signal
    input jump,               // Jump control signal
    input [31:0] pc_in,				/// input connection  ( pc_in ) is determining the address of the next instruction to execute in the CPU based on certain control signals.
    output reg [31:0] pc_out		//// output connection
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
          //  pc_out <= 0;  // Reset PC to 0
 		pc_out <= -4;  // Reset PC to 0
        end else begin
            // Increment PC by 4 for next instruction (assuming 32-bit instructions)
            pc_out <= pc_out + 4;
		

		
		// If branch or jump is taken, update PC with branch address
            if (branch || jump) begin
                pc_out <= pc_in; // Update PC to branch or jump address
            end
			
			
        end
    end

	
endmodule
