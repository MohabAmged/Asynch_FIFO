module pointer #(parameter ptr_width=4
) (
    input wire clk ,
    input wire rst ,
    input wire en ,
    input wire full ,
    input wire empty ,   
    output reg [ptr_width-1:0] ptr ,
    output wire [ptr_width-1:0] next_ptr 
    
);
    

assign next_ptr=ptr+'b1;

always @(posedge clk) begin

    if (rst) begin
        ptr<=0;
    end
    else begin
        if(en && !full && !empty) begin
            ptr<=next_ptr;
        end

    end

end

endmodule