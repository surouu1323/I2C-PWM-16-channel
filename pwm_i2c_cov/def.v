task test_case();
    begin
        tb.error = 0;

        $display("=== SLAVE WRITE ===");
        i2c_write(8'h1, 16'h0102); // 8'h0 :cmd , 8'h50 : reg-address; 32'h0102:value

        $display("=== SLAVE READ  ===");
        i2c_read (8'h1, 16'h0102);
        #10000;


        $display("test_case_1");
        if(tb.error != 0 )  $display("Test_result FAILED");
        else                $display("Test_result PASSED");
    end
endtask