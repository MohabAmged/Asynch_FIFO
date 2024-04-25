module gray_decoder (
    input wire [3:0] gray_in ,
    output wire [3:0] bcd_out
);

assign bcd_out[3] = gray_in[3];
assign bcd_out[2] = gray_in[3]^gray_in[2];
assign bcd_out[1] = bcd_out[2]^gray_in[1];
assign bcd_out[0] = bcd_out[1]^gray_in[0];
    
endmodule