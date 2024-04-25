module empty_flag_logic (
    input wire read_clk ,
    input wire rst ,
    input wire rd_en ,
    input wire [3:0] read_ptr,
    input wire [3:0] synch_write_ptr,
    output wire empty 
);

wire [3:0] write_ptr_bcd ;

 gray_decoder dec_inst (
    .gray_in(synch_write_ptr) ,
    .bcd_out(write_ptr_bcd)
);

assign empty = (write_ptr_bcd == read_ptr )?1:0;

// always @(posedge read_clk) begin
//         if (rst) begin
//             empty <=1;
//             end
//         else begin
//             if ( (write_ptr_bcd == read_ptr ) ) begin
//                 empty<=1 ;
//             end
//             else begin
//                 empty<=0;
//             end

//         end 
            

//     end




endmodule