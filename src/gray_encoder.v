module gray_encoder (
    input wire [3:0] bcd_in ,
    output wire [3:0] gray_out
);

assign gray_out[3] = bcd_in[3];
assign gray_out[2] = bcd_in[3]^bcd_in[2];
assign gray_out[1] = bcd_in[2]^bcd_in[1];
assign gray_out[0] = bcd_in[1]^bcd_in[0];
    
endmodule