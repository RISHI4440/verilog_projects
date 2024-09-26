
module ALU 
(
    input  [31:0] A,           // Operand A
    input  [31:0] B,           // Operand B
    input  [3:0] ALU_Sel,      // ALU Operation Select (4-bit control signal)
    input  [4:0] Shamt,        // Shift amount (5-bit for 32-bit shift)
    output reg [31:0] ALU_Out, // ALU output
    output Zero                // Zero flag
);

    wire [31:0] barrel_out; // Output of barrel shifter

    // ALU operations

    always @(*) begin
        case (ALU_Sel)
            4'b0000: ALU_Out = A + B;          // ADD
            4'b0001: ALU_Out = A - B;          // SUB

            4'b0010: ALU_Out = A & B;          // AND
            4'b0011: ALU_Out = A | B;          // OR
            4'b0100: ALU_Out = A ^ B;          // XOR

            4'b0101: ALU_Out = barrel_out;     // Logical left shift (SLL)
            4'b0110: ALU_Out = barrel_out;     // Logical right shift (SRL)
            4'b0111: ALU_Out = barrel_out;     // Arithmetic right shift (SRA)

            default: ALU_Out = 32'b0;          // Default to zero
        endcase
    end

    // Zero flag (set when ALU_Out is zero)
    assign Zero = (ALU_Out == 0);

    // Barrel shifter instantiation
    BarrelShifter barrelShifter 
(
        .data_in(A),
        .shamt(Shamt),
        .shift_type(ALU_Sel[1:0]), // Choose shift type (SLL, SRL, SRA)
        .data_out(barrel_out)
    );

endmodule
