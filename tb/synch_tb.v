module synch_tb ();
    

reg [7:0] data_tb ;
wire [7:0] out_tb ;
reg clk ,rst ;





synch #(.data_width(8)) sync_inst(
     .data(data_tb) ,
     .rst(rst),
     .clk(clk),
    .data_out(out_tb)
);


initial begin
    clk=0;
    forever begin
        #5;
        clk=~clk; 
    end
end


initial begin
    rst = 1;
    #50 ;
    rst = 0;
    #20 ;
    data_tb = 0; 
    #50 ;
    data_tb =1;
    #50 ;

end


endmodule