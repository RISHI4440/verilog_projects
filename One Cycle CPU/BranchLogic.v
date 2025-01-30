/// MIGHT NEED TO UPDATE IT 


module BranchLogic(
    input [31:0] reg1,
    input [31:0] reg2,
    input [2:0] funct3,
    output reg branch_taken
);
    always @(*) begin
        case(funct3)
            3'b000: branch_taken = (reg1 == reg2); // BEQ
            3'b001: branch_taken = (reg1 != reg2); // BNE
            3'b100: branch_taken = ($signed(reg1) < $signed(reg2)); // BLT
	        3'b101: branch_taken = ($signed(reg1) >= $signed(reg2)); // BGE 
            default: branch_taken = 0;
        endcase
    end
endmodule

