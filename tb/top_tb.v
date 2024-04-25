module top_tb ();

reg rd_clk , wr_clk ,rst , wr_en ,rd_en;
reg  [31:0] wr_data;
wire [31:0] rd_data;
wire full,empty ;
integer x;


asycnh_fifo_16_loc #( .data_width (32) ,
.addres_width (4) ) fifo_inst (
   . rd_clk(rd_clk) ,
   . wr_clk(wr_clk) ,
   . rd_en(rd_en)  ,
   . wr_en(wr_en)  ,
   . rst(rst)    ,
   . wr_data(wr_data) ,
   . rd_data(rd_data) ,
   . full(full) ,
   . empty(empty) 
);

task write_full ; 
begin
        for (x =0 ;x<=14 ;x=x+1 ) begin
        @( negedge wr_clk ) 
            wr_en=1;
            #1;
            wr_data=x;
        @( posedge wr_clk ) begin
            #1;
            wr_en=0; 
        end

    end
end

endtask

task read_full ; 
begin
    for (x =0 ;x<=14 ;x=x+1 ) begin
        @( negedge rd_clk ) begin
            rd_en=1;
            #1;
        end
        @( posedge rd_clk ) begin
			#1;
            rd_en=0;
            expect(x);			
        end
    end
end
endtask

task read ; 
begin
        @( negedge rd_clk ) begin
            rd_en=1;
            #1;
        end
        @( posedge rd_clk ) begin
            #1;
            rd_en=0; 
        end
end
endtask

task expect (input integer x) ; 
begin
		if (x == rd_data ) begin
		$display ( "Time : %0t Test Passed  :  Expect %0h rd_data %0h" ,$time , x , rd_data);
		end
		else begin 
		$display ( "Time : %0t  Test Failed  :  Expect %0h rd_data %0h" ,$time , x , rd_data);
		end
end
endtask






task write ; 
       input reg [31:0] y;
       begin
        
               @( negedge wr_clk ) begin
            wr_en=1;
            #1;
            wr_data=y;
        end
        @( posedge wr_clk ) begin
            #1;
            wr_en=0; 
        end
    end


endtask


// write clk
initial begin
    wr_clk=0;
    forever begin
        #5; wr_clk=~wr_clk;
    end
end
// read clk
initial begin
    rd_clk=0;
    forever begin
        #5.26315785; rd_clk=~rd_clk;
    end
end


initial begin
    rst=1;
    wr_en=0;
    rd_en=0;
    wr_data=0;
    #100;
    rst=0;
    write('h11);
    #50;
    read();
	expect('h11);
    write_full();
    #50;
    read_full();
    #50;
    write('hff);
    #50;
    read();
	expect('hff);
    #50;
    write('h55);
    write('hee);
    write('haa);
    #50;
    read();
	expect('h55);
    read();
	expect('hee);
    write('h11);
    #50;
    read();
	expect('haa);
    read();
	expect('h11);
    #50;
    write_full();
    #50;
    read_full();
    $finish;
end


endmodule

