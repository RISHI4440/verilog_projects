
//// ALU for One Cycle CPU


module OneCycleALU (
    input [31:0] A,          // First operand
    input [31:0] B,          // Second operand
    input [3:0] ALUOp,       // ALU operation selector
    output reg [31:0] result, // Result of ALU operation
    output reg zero_flag      // Zero flag for branches
);

    always @(*) begin
        case(ALUOp)
            4'b0000: result = A + B;  // ADD, ADDI, LW, SW, JALR
            4'b0001: result = A - B;  // SUB, BEQ
            4'b0010: result = A & B;  // AND, ANDI
            4'b0011: result = A | B;  // OR, ORI
            4'b0100: result = (A != B); // BNE
            4'b0101: result = ($signed(A) < $signed(B)) ? 32'b1 : 32'b0; // BLT
            4'b0110: result = B; // LUI
            default: result = 32'b0;
        endcase
        
        // Zero flag is used for branches (BEQ)
        zero_flag = (result == 32'b0) ? 1'b1 : 1'b0;
    end
endmodule