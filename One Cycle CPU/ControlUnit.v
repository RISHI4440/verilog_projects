/// CONTROL UNIT MODULE FOR ONE CYCLE CPU

module ControlUnit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] ALUOp,
    output reg MemRead,
    output reg MemWrite,
    output reg RegWrite,
    output reg ALUSrc,
   // output reg MemToReg,									replaced with sel0 and sel1 signal 
	output reg sel0,
	output reg sel1,
    output reg Branch,
    output reg Jump,	
    output reg createdump // Added createdump signal
);

/* // Default control signals LOGIC
	always @(*) begin
        
        createdump = 0; // Default, no dump
        
        case (opcode)
            7'b0000000: begin
                // eg halt instruction opcode
                createdump = 1; // Set createdump signal when halt instruction detected
            end
            // Other cases for different instructions
            default: begin
                // Default instructions
            end
        endcase
    end

///////////// Create Dump logic */


// Default control signals LOGIC 
    always @(*) begin
        
			ALUOp = 4'b0000;
			MemRead = 0;
			MemWrite = 0;
			RegWrite = 0;
			ALUSrc = 0;
		  //  MemToReg = 0;
			sel0 = 0; // Updated: Default value for sel0
			sel1 = 0; // Updated: Default value for sel1
		  
			Branch = 0;
			Jump = 0;
			createdump = 0;
		

        
        case(opcode)
            7'b0110011: begin // R-type (ADD, SUB, AND, OR)
                RegWrite = 1;
                case(funct3)
                    3'b000: ALUOp = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000; // SUB : ADD
                    3'b111: ALUOp = 4'b0010; // AND
                    3'b110: ALUOp = 4'b0011; // OR
                endcase
				sel0 = 0; // ALU result
                sel1 = 0;
            end

            7'b0010011: begin // I-type (ADDI, ANDI, ORI)
                RegWrite = 1;
                ALUSrc = 1;
                case(funct3)
                    3'b000: ALUOp = 4'b0000; // ADDI
                    3'b111: ALUOp = 4'b0010; // ANDI
                    3'b110: ALUOp = 4'b0011; // ORI
                endcase
				sel0 = 0; // ALU result
                sel1 = 0;
            end

            7'b0000011: begin // LW
                RegWrite = 1;
                ALUSrc = 1;
                MemRead = 1;
           //     MemToReg = 1;
				sel0 = 1; // Select memory data
                sel1 = 0;
                ALUOp = 4'b0000; // ADD for address calculation
            end

            7'b0100011: begin // SW
                MemWrite = 1;
                ALUSrc = 1;
                ALUOp = 4'b0000; // ADD for address calculation
				// No need to set sel0 and sel1 for SW
            end

            7'b1100011: begin // BEQ, BNE, BLT
                Branch = 1;
                case(funct3)
                    3'b000: ALUOp = 4'b0001; // BEQ
                    3'b001: ALUOp = 4'b0100; // BNE
                    3'b100: ALUOp = 4'b0101; // BLT
                endcase
					 // No need to set sel0 and sel1 for branch instructions
            end

            7'b1101111: begin // JAL
                Jump = 1;
                RegWrite = 1;
				 sel0 = 0; // Use immediate (PC-relative)
                sel1 = 1;
            end

            7'b1100111: begin // JALR
                Jump = 1;
                RegWrite = 1;
                ALUOp = 4'b0000; // ADD for JALR
				sel0 = 0; // Use immediate (PC-relative)
                sel1 = 1;
            end

            7'b0010111: begin // AUIPC
                RegWrite = 1;
                ALUOp = 4'b0000; // ADD immediate to PC
				
				sel0 = 0;
                sel1 = 1; // Select immediate as write-back data
            end

            7'b0110111: begin // LUI
                RegWrite = 1;
                ALUOp = 4'b0110; // Load upper immediate
				
				sel0 = 0;
                sel1 = 1; // Select immediate as write-back data
            end

			7'b0000000: begin // HALT or dump signal
                createdump = 1;
            end

            default: begin
			
			//// Default State
			
            end



        endcase
    end
endmodule




/* 

		******** MODIFICATIONS **********

1) sel0 and sel1 Signals:

    sel0 and sel1 are used to control the MUX4to1_32bit multiplexer. They determine which data (ALU result, 
	Memory data, Immediate, or any additional input) should be written back to the register.
    For LUI, JAL, and AUIPC, sel1 is set to 1 to select the Immediate output as the write-back data. 
	
2) Immediate Selection for Write-Back:

    For instructions like LUI, AUIPC, JAL, and JALR, the immediate value needs to be written to the register. 
	sel1 is set to 1 to select the immediate output in these cases. 
	
	*/