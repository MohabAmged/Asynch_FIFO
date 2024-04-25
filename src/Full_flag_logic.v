module full_flag_logic (
    input wire write_clk ,
    input wire rst ,
    input wire wr_en ,
    input wire [3:0] synch_read_ptr,
    input wire [3:0] write_ptr,
    output wire full 
);


wire [3:0] read_ptr_bcd ;

assign full = ( write_ptr+1'b1 == read_ptr_bcd )?1:0;

//wire wrap_around;
 gray_decoder dec_inst (
    .gray_in(synch_read_ptr) ,
    .bcd_out(read_ptr_bcd)
);

//assign wrap_around = read_ptr_bcd[3] ^ write_ptr[3];
// always @(posedge write_clk) begin
//         if (rst) begin
//             full <=0;
//             end
//         else begin
//             if ( ( write_ptr+1'b1 == read_ptr_bcd )  ) begin
//                 full<=1 ;
//             end
//             else begin
//                 full<=0;
//             end

//         end 
            

//     end




endmodule