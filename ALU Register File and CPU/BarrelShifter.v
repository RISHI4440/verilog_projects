
///// Barel Shifter MOdule 

// It is instantiated in ALU module

module BarrelShifter 
(
    input  [31:0] data_in,     // Input data to shift
    input  [4:0]  shamt,       // Shift amount (5-bit for 32-bit data)
    input  [1:0]  shift_type,  // Shift : 00 = SLL, 01 = SRL, 10 = SRA
    output reg [31:0] data_out // Output data after shift
);

    always @(*) begin
        case (shift_type)
            2'b00: data_out = data_in << shamt;                      // SLL (Logical Left Shift)

            2'b01: data_out = data_in >> shamt;                      // SRL (Logical Right Shift)

            2'b10: data_out = $signed(data_in) >>> shamt;            // SRA (Arithmetic Right Shift)
            default: data_out = data_in;
        endcase
    end

endmodule
