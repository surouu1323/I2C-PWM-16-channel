    // Task for writing register
    task write_reg(input [7:0] a, input [WIDTH-1:0] d);
    begin
        @(posedge clk);
        tb.wr_en = 1;
        tb.rd_en = 0;
        tb.addr  = a;
        tb.wdata = d;
        @(posedge clk);
        tb.wr_en = 0;
        $display("WRITE: addr=%0d data=%h", a, d);
    end
    endtask

    // Task for reading register
    task read_reg(input [7:0] a);
    begin
        @(posedge clk);
        tb.wr_en = 0;
        tb.rd_en = 1;
        tb.addr  = a;
        @(posedge clk);
        $display("READ:  addr=%0d data=%h", a, tb.rdata);
        tb.rd_en = 0;
    end
    endtask