module ptr_tb ();
    

reg clk , rst , en ;
wire [3:0] ptr ;
integer x;

pointer #( .ptr_width(4)
) write_ptr_inst (
    . clk(clk) ,
    . rst(rst) ,
    . en(en)  ,
    . ptr(ptr) 
);


initial begin
    clk=0;
    forever begin
        #5; clk=~clk;
    end
end

initial begin
    rst =1;
    en =0;
    #50;
    rst =0;

    for (x =0 ;x<=15 ;x=x+1 ) begin
    @(negedge clk) begin
        en =1;
    end
    @(posedge clk) begin
        #1;en =0;
    end        
    end

    
end

endmodule