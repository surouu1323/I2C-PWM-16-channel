task test_case();
    reg [15:0] data;
    integer i, j, k;
    reg [15:0] rdata;
    begin
        tb.error = 0;

        $display("");
        $display("===============================================");
        $display("==               I2C FRAME CHECK             ==");
        $display("===============================================");

        $display("");
        $display("------------------1 Byte Write-----------------");
        i2c_write(1, 16'h5f5f);
        i2c_read (1, 16'h5f5f);
        data = $random & 8'hff;
        $display("[WRITE ] addr = 0x%0h    | data = 0x%0h", 1, data);
        tb.ack_respone = 0;
        i2c_start();
        i2c_send_byte({tb.SLAVE_ADD, 1'b0});  i2c_slave_ack();
        i2c_send_byte(data[7:0]);  i2c_slave_ack();
        i2c_stop();
        i2c_read (1, 16'h5f5f);

        $display("");
        $display("---------1 Byte Reg + 1 Byte Data Write--------");
        i2c_write(1, 16'h5f5f);
        // i2c_read (1, 16'h5f5f);
        data = $random & 8'hff;
        $display("[WRITE ] addr = 0x%0h    | data = 0x%0h", 1, data);
        tb.ack_respone = 0;
        i2c_start();
        i2c_send_byte({tb.SLAVE_ADD, 1'b0});  i2c_slave_ack();
        i2c_send_byte(1);  i2c_slave_ack();
        i2c_send_byte(data[7:0]);  i2c_slave_ack();
        i2c_stop();
        i2c_read (1, 16'h5f5f);

        $display("");
        $display("------------------1 Byte Read-----------------");
        i2c_write(1, 16'h5f5f);
        // i2c_read (1, 16'h5f5f);
        $display("[READ  ] addr = 0x%0h ", 1);
        tb.ack_respone = 0;
            i2c_start();
            i2c_send_byte({tb.SLAVE_ADD, 1'b0});  i2c_slave_ack();
            i2c_send_byte(1);  i2c_slave_ack();
            i2c_start();
            i2c_send_byte({tb.SLAVE_ADD, 1'b1});  i2c_slave_ack();
            i2c_read_byte(rdata);  i2c_master_ack(0);
            i2c_stop();
        i2c_read (1, 16'h5f5f);
// 
        $display("");
        $display("---------1 Byte Reg + 1 Byte Data Read--------");
        i2c_write(1, 16'h5f5f);
        // i2c_read (1, 16'h5f5f);
        $display("[READ  ] addr = 0x%0h    | data = 0x%0h", 1, data);
        tb.ack_respone = 0;
            i2c_start();
            i2c_send_byte({tb.SLAVE_ADD, 1'b0});  i2c_slave_ack();
            i2c_send_byte(1);  i2c_slave_ack();
            i2c_start();
            i2c_send_byte({tb.SLAVE_ADD, 1'b1});  i2c_slave_ack();
            i2c_read_byte(rdata);  i2c_master_ack(1);
            i2c_read_byte(rdata);  i2c_master_ack(0);
            i2c_stop();
        i2c_read (1, 16'h5f5f);


        // $display("");
        // $display("-------------slave addr -> stop------------");
        // i2c_write(1, 16'h5f5f);
        // i2c_read (1, 16'h5f5f);
        // $display("[READ  ] addr = 0x%0h    | data = 0x%0h", 1, data);
        // tb.ack_respone = 0;
        //     i2c_start();
        //     for (i=7; i > 0; i=i-1) begin
        //         @(negedge tb.clk)  ;
        //         @(negedge tb.scl) ;
        //     end
        //     i2c_stop();
        // i2c_read (1, 16'h5f5f);


        // $display("");
        // $display("-------------slave addr + rw -> stop------------");
        // i2c_write(1, 16'h5f5f);
        // i2c_read (1, 16'h5f5f);
        // $display("[READ  ] addr = 0x%0h    | data = 0x%0h", 1, data);
        // tb.ack_respone = 0;
        //     i2c_start();
        //     i2c_send_byte({tb.SLAVE_ADD, 1'b0});  i2c_slave_ack();
        //     i2c_stop();
        // i2c_read (1, 16'h5f5f);


        $display("");
        $display("-------------slave addr + rw +ack loop------------");

        for ( i=0 ; i< 37 ; i=i+1) begin
            j = {8'd50,1'b0,$random};
            i2c_start();
            repeat(i)  @(posedge tb.scl) tb.sda_drive = j[i-1];
            i2c_stop();
        end

        for ( i=0 ; i< 18 ; i=i+1) begin
            i2c_start();
            i2c_send_byte({tb.SLAVE_ADD, 1'b0});  i2c_slave_ack();
            i2c_send_byte(8'd1);  i2c_slave_ack();

            i2c_start();
            i2c_send_byte({tb.SLAVE_ADD, 1'b1});
            repeat(i)  @(posedge tb.scl) ;
            i2c_stop();
        end


        $display("");
        $display("-------------slave addr + rw reset loop------------");

        for ( i=0 ; i< 37 ; i=i+1) begin
            j = {8'd50,1'b0,$random};
            i2c_start();
            repeat(i)  @(posedge tb.scl) tb.sda_drive = j[i-1];
            tb.rst_n = 0; #10 tb.rst_n = 1;
        end

        for ( i=0 ; i< 18 ; i=i+1) begin
            i2c_start();
            i2c_send_byte({tb.SLAVE_ADD, 1'b0});  i2c_slave_ack();
            i2c_send_byte(8'd1);  i2c_slave_ack();

            i2c_start();
            i2c_send_byte({tb.SLAVE_ADD, 1'b1});
            repeat(i)  @(posedge tb.scl) ;
            tb.rst_n = 0; #10 tb.rst_n = 1;
        end






        $display("-----------------------------------------------");
        $display("TEST RESULT: %s",   (tb.error != 0) ? "FAILED" : "PASSED");
        $display("-----------------------------------------------");
        $display("");

        // $display("test_case_1");
        // if(tb.error != 0 )  $display("Test_result FAILED");
        // else                $display("Test_result PASSED");
    end
endtask