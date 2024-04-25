module memory #(
    parameter data_width = 32 ,
    parameter address_width =4
) (
    input wire [address_width-1:0] read_address ,
    input wire [address_width-1:0] write_address ,
    input wire [data_width-1:0] write_data ,
    output wire [data_width-1:0]read_data ,
    input wire read_clk ,
    input wire write_clk,
    input wire rd ,
    input wire wr ,
    input wire full ,
    input wire empty 
         
);

reg [data_width-1:0] mem [(2**address_width)-1 : 0] ;
reg [data_width-1:0] data_rd;

assign read_data = data_rd;

always @(posedge read_clk ) begin
    if (rd && !empty) begin
    data_rd = mem[read_address];
    end
end


always @(posedge write_clk ) begin
    if (wr && !full) begin
    mem[write_address] = write_data;
    end
end


    
endmodule