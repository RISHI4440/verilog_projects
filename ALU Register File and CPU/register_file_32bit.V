/// 32 BIT REGISTER FILE 


module register_file_32bit (
    input clk,
    input rst,
    input [4:0] read_reg1,     // Select register 1
    input [4:0] read_reg2,     // select register 2
    input [4:0] write_reg,     // Select the register to Write to
    input [31:0] write_data,   // data to write
    input write_enable,        // Write Enable Signal
    output [31:0] read_data1,  // O/P of register 1
    output [31:0] read_data2   // O/P of register 2
);
    // Declare the 32 registers (each register is 32 bits wide)
    wire [31:0] reg_out [31:0];

    // Instantiate 32 32-bit registers
    register_32bit reg0  (clk, rst, (write_enable && write_reg == 5'd0),  write_data, reg_out[0]);
    register_32bit reg1  (clk, rst, (write_enable && write_reg == 5'd1),  write_data, reg_out[1]);
    register_32bit reg2  (clk, rst, (write_enable && write_reg == 5'd2),  write_data, reg_out[2]);
    register_32bit reg3  (clk, rst, (write_enable && write_reg == 5'd3),  write_data, reg_out[3]);
    register_32bit reg4  (clk, rst, (write_enable && write_reg == 5'd4),  write_data, reg_out[4]);
    register_32bit reg5  (clk, rst, (write_enable && write_reg == 5'd5),  write_data, reg_out[5]);
    register_32bit reg6  (clk, rst, (write_enable && write_reg == 5'd6),  write_data, reg_out[6]);
    register_32bit reg7  (clk, rst, (write_enable && write_reg == 5'd7),  write_data, reg_out[7]);

    register_32bit reg8  (clk, rst, (write_enable && write_reg == 5'd8),  write_data, reg_out[8]);
    register_32bit reg9  (clk, rst, (write_enable && write_reg == 5'd9),  write_data, reg_out[9]);
    register_32bit reg10 (clk, rst, (write_enable && write_reg == 5'd10), write_data, reg_out[10]);
    register_32bit reg11 (clk, rst, (write_enable && write_reg == 5'd11), write_data, reg_out[11]);
    register_32bit reg12 (clk, rst, (write_enable && write_reg == 5'd12), write_data, reg_out[12]);
    register_32bit reg13 (clk, rst, (write_enable && write_reg == 5'd13), write_data, reg_out[13]);
    register_32bit reg14 (clk, rst, (write_enable && write_reg == 5'd14), write_data, reg_out[14]);
    register_32bit reg15 (clk, rst, (write_enable && write_reg == 5'd15), write_data, reg_out[15]);
    register_32bit reg16 (clk, rst, (write_enable && write_reg == 5'd16), write_data, reg_out[16]);

    register_32bit reg17 (clk, rst, (write_enable && write_reg == 5'd17), write_data, reg_out[17]);
    register_32bit reg18 (clk, rst, (write_enable && write_reg == 5'd18), write_data, reg_out[18]);
    register_32bit reg19 (clk, rst, (write_enable && write_reg == 5'd19), write_data, reg_out[19]);
    register_32bit reg20 (clk, rst, (write_enable && write_reg == 5'd20), write_data, reg_out[20]);
    register_32bit reg21 (clk, rst, (write_enable && write_reg == 5'd21), write_data, reg_out[21]);
    register_32bit reg22 (clk, rst, (write_enable && write_reg == 5'd22), write_data, reg_out[22]);
    register_32bit reg23 (clk, rst, (write_enable && write_reg == 5'd23), write_data, reg_out[23]);
    register_32bit reg24 (clk, rst, (write_enable && write_reg == 5'd24), write_data, reg_out[24]);

    register_32bit reg25 (clk, rst, (write_enable && write_reg == 5'd25), write_data, reg_out[25]);
    register_32bit reg26 (clk, rst, (write_enable && write_reg == 5'd26), write_data, reg_out[26]);
    register_32bit reg27 (clk, rst, (write_enable && write_reg == 5'd27), write_data, reg_out[27]);
    register_32bit reg28 (clk, rst, (write_enable && write_reg == 5'd28), write_data, reg_out[28]);
    register_32bit reg29 (clk, rst, (write_enable && write_reg == 5'd29), write_data, reg_out[29]);
    register_32bit reg30 (clk, rst, (write_enable && write_reg == 5'd30), write_data, reg_out[30]);
    register_32bit reg31 (clk, rst, (write_enable && write_reg == 5'd31), write_data, reg_out[31]);

    // Reading from the selected registers using assign statements instead of reg
    assign read_data1 = reg_out[read_reg1];
    assign read_data2 = reg_out[read_reg2];

endmodule
