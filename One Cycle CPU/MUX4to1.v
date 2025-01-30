///// 32 Bit 4 to 1 Mux module

module MUX4to1_32bit (
    input [31:0] in0, 	// ALU result
    input [31:0] in1, 		// Memory data
    input [31:0] in2, 	// Immediate output
    input [31:0] in3, 	// Additional input (if needed)
    input sel0, 
    input sel1,
    output [31:0] out		 // MUX output
); 

    assign out = sel1 ? (sel0 ? in3 : in2) : (sel0 ? in1 : in0); 

endmodule



 /* Multiplexer Select Signals (sel0, sel1)

These signals control which data source is selected in the write-back stage. Since you replaced MemToReg with sel0 and sel1, here’s how they might work:

    sel0 = 0 and sel1 = 0: ALU result
    sel0 = 1 and sel1 = 0: Memory data
    sel0 = 0 and sel1 = 1: Immediate data
    sel0 = 1 and sel1 = 1: Reserved (could be zero or other default value)

For example:

    For R-type and I-type instructions, the ALU result should go to the write-back stage, so set sel0 = 0 and sel1 = 0.
    For Load instructions (LW), set sel0 = 1 and sel1 = 0 to select memory data.


 */


/* 
    Inputs:
        in0, in1, in2, and in3 are 32-bit data inputs.
        sel0 and sel1 are 1-bit selection inputs.
    Output:
        out is a 32-bit output.

The logic works as follows:

    If sel1 = 0 and sel0 = 0, out gets in0.
    If sel1 = 0 and sel0 = 1, out gets in1.
    If sel1 = 1 and sel0 = 0, out gets in2.
    If sel1 = 1 and sel0 = 1, out gets in3.

This code correctly implements a 32-bit 4-to-1 multiplexer. */