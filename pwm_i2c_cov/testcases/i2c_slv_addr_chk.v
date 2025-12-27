task test_case();
    reg [15:0] data;
    integer i,j;
    begin
        tb.error = 0;
       

        $display("");
        $display("===============================================");
        $display("==          I2C SLAVE ADDRESS CHECK          ==");
        $display("===============================================");

        for(i =0 ; i< 8; i = i +1) begin
            tb.address_set_pin = i;
            #10 tb.rst_n = 0;
            for(j =0 ; j< 8; j = j +1) begin
                tb.SLAVE_ADD = (7'h50 | j);
                #10 tb.rst_n = 1;
                tb.ack_respone = 0;
                i2c_start();     i2c_send_byte({tb.SLAVE_ADD, 1'b0});  i2c_slave_ack();

                $display("[CHK ] Slave_addr = 0x%0h | I2C_Call_addr = 0x%0h", i, SLAVE_ADD);

                if(!tb.ack_respone) begin
                    if( i == j ) begin
                        tb.error = tb.error + 1;
                        $write("[FAILED] ");
                    end else $write("[PASS  ] ");
                    $display("NACK: Slave not respone");
                end
                else  if( i == j ) $display("[PASS  ] ACK: Slave respone");
            end
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