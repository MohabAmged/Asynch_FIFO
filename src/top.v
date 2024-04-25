`default_nettype none
module asycnh_fifo_16_loc #( parameter data_width = 32 ,
parameter addres_width = 4) (
    input wire rd_clk ,
    input wire wr_clk ,
    input wire rd_en ,
    input wire wr_en ,
    input wire rst ,
    input wire  [data_width-1:0] wr_data ,
    output wire [data_width-1:0] rd_data ,
    output wire full ,
    output wire empty 
);

wire [addres_width-1:0] read_ptr;
wire [addres_width-1:0] write_ptr;
wire [addres_width-1:0] next_write_ptr;
wire [addres_width-1:0] next_read_ptr;
wire [addres_width-1:0] read_ptr_synch;
wire [addres_width-1:0] write_ptr_synch;
wire [addres_width-1:0] read_ptr_gray;
wire [addres_width-1:0] write_ptr_gray;




// empty flag logic instance 
empty_flag_logic empty_logic_inst (
    . read_clk(rd_clk) ,
    . rst (rst),
    . rd_en(rd_en),
    . read_ptr(read_ptr),
    . synch_write_ptr(write_ptr_synch),
    . empty(empty) 
);



// full flag logic instance 
 full_flag_logic full_logic_inst (
    . write_clk (wr_clk) ,
    . rst (rst),
    . wr_en(wr_en),
    . synch_read_ptr(read_ptr_synch),
    . write_ptr(write_ptr),
    . full(full) 
);

// read ptr instance 
pointer #( .ptr_width(4)
) read_ptr_inst (
    . clk(rd_clk) ,
    . rst(rst) ,
    . en(rd_en)  ,
    . empty(empty) ,
    . full(1'b0),
    . ptr(read_ptr),
    . next_ptr(next_read_ptr) 
);

// 4 bit gray encoder instance for read ptr
gray_encoder read_ptr_gray_encoder_inst (
    .bcd_in(read_ptr) ,
    .gray_out(read_ptr_gray)
);
    
// read_ptr_synch instacne 
synch #(
   .data_width (4)
) read_ptr_synch_inst (
    . data(read_ptr_gray) ,
    . rst(rst)  ,
    . clk(wr_clk)  ,
    . data_out(read_ptr_synch)
);
 

// write ptr instance 
pointer #( .ptr_width(4)
) write_ptr_inst (
    . clk(wr_clk) ,
    . rst(rst) ,
    . empty(1'b0) ,
    . full(full),    
    . en(wr_en)  ,
    . ptr(write_ptr),
    . next_ptr(next_write_ptr)
);
    
// 4 bit gray encoder instance for write ptr
gray_encoder write_ptr_gray_encoder_inst (
    .bcd_in(write_ptr) ,
    .gray_out(write_ptr_gray)
);


// wirte_ptr_synch instacne 
synch #(
   .data_width (4)
) wirte_ptr_synch_inst (
    . data(write_ptr_gray) ,
    . rst(rst)  ,
    . clk(rd_clk)  ,
    . data_out(write_ptr_synch)
);



// fifo memory instance 
 memory #(
    .data_width ('d32) ,
    .address_width ('d4)
 ) fifo_mem_inst(
    .  read_address(read_ptr) ,
    .  write_address(write_ptr) ,
    .  write_data(wr_data) ,
    .  read_data(rd_data) ,
    .  read_clk(rd_clk) ,
    .  write_clk(wr_clk),
    .  rd(rd_en) ,
    .  wr(wr_en) ,
    .  full(full) ,
    .  empty(empty) );


endmodule