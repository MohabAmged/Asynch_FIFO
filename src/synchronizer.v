module synch #(
   parameter data_width = 8
) (
    input wire [data_width-1:0] data ,
    input wire rst,
    input wire clk,
    output reg [data_width-1:0] data_out
);

reg [data_width-1:0] Q ;


always @(posedge clk) begin
	if (rst ) begin 
	    Q<=0;
    	data_out<=0;
	end
	else begin
	    Q<=data;
    	data_out<=Q;
	end
end



    
endmodule