
/// 32 BIT REGISTER FOR REGISTER FILE  FOR ONE CYCLE CPU

////  Each 32-bit register is implemented using 32 D flip-flops.

module one_register_32bit (
    input clk,
    input rst,
    input write_enable,
    input [31:0] d_in,
    output [31:0] q_out
);
    // Here we Instantiate 32 D flip-flops, one for each bit
	
    one_d_flip_flop dff0  (clk, rst, write_enable ? d_in[0]  : q_out[0],  q_out[0]);
    one_d_flip_flop dff1  (clk, rst, write_enable ? d_in[1]  : q_out[1],  q_out[1]);
    one_d_flip_flop dff2  (clk, rst, write_enable ? d_in[2]  : q_out[2],  q_out[2]);
    one_d_flip_flop dff3  (clk, rst, write_enable ? d_in[3]  : q_out[3],  q_out[3]);
    one_d_flip_flop dff4  (clk, rst, write_enable ? d_in[4]  : q_out[4],  q_out[4]);
    one_d_flip_flop dff5  (clk, rst, write_enable ? d_in[5]  : q_out[5],  q_out[5]);
    one_d_flip_flop dff6  (clk, rst, write_enable ? d_in[6]  : q_out[6],  q_out[6]);
    one_d_flip_flop dff7  (clk, rst, write_enable ? d_in[7]  : q_out[7],  q_out[7]);

    one_d_flip_flop dff8  (clk, rst, write_enable ? d_in[8]  : q_out[8],  q_out[8]);
    one_d_flip_flop dff9  (clk, rst, write_enable ? d_in[9]  : q_out[9],  q_out[9]);
    one_d_flip_flop dff10 (clk, rst, write_enable ? d_in[10] : q_out[10], q_out[10]);
    one_d_flip_flop dff11 (clk, rst, write_enable ? d_in[11] : q_out[11], q_out[11]);
    one_d_flip_flop dff12 (clk, rst, write_enable ? d_in[12] : q_out[12], q_out[12]);
    one_d_flip_flop dff13 (clk, rst, write_enable ? d_in[13] : q_out[13], q_out[13]);
    one_d_flip_flop dff14 (clk, rst, write_enable ? d_in[14] : q_out[14], q_out[14]);
    one_d_flip_flop dff15 (clk, rst, write_enable ? d_in[15] : q_out[15], q_out[15]);
    one_d_flip_flop dff16 (clk, rst, write_enable ? d_in[16] : q_out[16], q_out[16]);

    one_d_flip_flop dff17 (clk, rst, write_enable ? d_in[17] : q_out[17], q_out[17]);
    one_d_flip_flop dff18 (clk, rst, write_enable ? d_in[18] : q_out[18], q_out[18]);
    one_d_flip_flop dff19 (clk, rst, write_enable ? d_in[19] : q_out[19], q_out[19]);
    one_d_flip_flop dff20 (clk, rst, write_enable ? d_in[20] : q_out[20], q_out[20]);
    one_d_flip_flop dff21 (clk, rst, write_enable ? d_in[21] : q_out[21], q_out[21]);
    one_d_flip_flop dff22 (clk, rst, write_enable ? d_in[22] : q_out[22], q_out[22]);
    one_d_flip_flop dff23 (clk, rst, write_enable ? d_in[23] : q_out[23], q_out[23]);
    one_d_flip_flop dff24 (clk, rst, write_enable ? d_in[24] : q_out[24], q_out[24]);

    one_d_flip_flop dff25 (clk, rst, write_enable ? d_in[25] : q_out[25], q_out[25]);
    one_d_flip_flop dff26 (clk, rst, write_enable ? d_in[26] : q_out[26], q_out[26]);
    one_d_flip_flop dff27 (clk, rst, write_enable ? d_in[27] : q_out[27], q_out[27]);
    one_d_flip_flop dff28 (clk, rst, write_enable ? d_in[28] : q_out[28], q_out[28]);
    one_d_flip_flop dff29 (clk, rst, write_enable ? d_in[29] : q_out[29], q_out[29]);
    one_d_flip_flop dff30 (clk, rst, write_enable ? d_in[30] : q_out[30], q_out[30]);
    one_d_flip_flop dff31 (clk, rst, write_enable ? d_in[31] : q_out[31], q_out[31]);

endmodule







