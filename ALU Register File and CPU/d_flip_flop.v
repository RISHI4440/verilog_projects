/// D-FLIP FLOP FOR REGISTER FILES

/////    A D flip-flop used to store 1 bit of data.
 

module d_flip_flop (
    input clk,
    input rst,
    input d,
    output reg q
);
    always @(posedge clk or posedge rst) begin
        if (rst) 
            q <= 0;
        else 
            q <= d;
    end
endmodule