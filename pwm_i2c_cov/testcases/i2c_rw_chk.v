task test_case();
    integer i;
    begin
        tb.error = 0;

        $display("");
        $display("===============================================");
        $display("==           I2C WRITE - READ CHECK          ==");
        $display("===============================================");

        $display("------------- write-read 16'h5f5f -------------");

        i2c_write(0, 16'h5f5f & 8'hf);
        i2c_read (0, 16'h5f5f & 8'hf);

        for (i = 1; i < 9; i = i + 1)begin
            i2c_write(i, 16'h5f5f);
            i2c_read (i, 16'h5f5f);
        end

        for (i = 10; i < 41; i = i + 4)begin
            i2c_write(i  , 16'h5f5f);            i2c_read (i  , 16'h5f5f);
            i2c_write(i+1, 16'h5f5f);            i2c_read (i+1, 16'h5f5f);
            i2c_write(i+2, 16'h5f5f & 8'hf);     i2c_read (i+2, 16'h5f5f & 8'hf);
            i2c_write(i+3, 16'h5f5f & 8'hf);     i2c_read (i+3, 16'h5f5f & 8'hf);
        end

        for (i = 42; i < 256; i = i + 4)begin
            i2c_write(i  , 16'h5f5f);            i2c_read (i  , 16'h0);
        end

        $display("------------- write-read 16'hf5f5 -------------");

        i2c_write(0, 16'hf5f5 & 8'hf);
        i2c_read (0, 16'hf5f5 & 8'hf);

        for (i = 1; i < 9; i = i + 1)begin
            i2c_write(i, 16'hf5f5);
            i2c_read (i, 16'hf5f5);
        end

        for (i = 10; i < 41; i = i + 4)begin
            i2c_write(i  , 16'hf5f5);            i2c_read (i  , 16'hf5f5);
            i2c_write(i+1, 16'hf5f5);            i2c_read (i+1, 16'hf5f5);
            i2c_write(i+2, 16'hf5f5 & 8'hf);     i2c_read (i+2, 16'hf5f5 & 8'hf);
            i2c_write(i+3, 16'hf5f5 & 8'hf);     i2c_read (i+3, 16'hf5f5 & 8'hf);
        end

        for (i = 42; i < 256; i = i + 4)begin
            i2c_write(i  , 16'hf5f5);            i2c_read (i  , 16'h0);
        end


        $display("------------- write-read 16'h0 -------------");

        i2c_write(0, 16'h0 & 8'hf);
        i2c_read (0, 16'h0 & 8'hf);

        for (i = 1; i < 9; i = i + 1)begin
            i2c_write(i, 16'h0);
            i2c_read (i, 16'h0);
        end

        for (i = 10; i < 41; i = i + 4)begin
            i2c_write(i  , 16'h0);            i2c_read (i  , 16'h0);
            i2c_write(i+1, 16'h0);            i2c_read (i+1, 16'h0);
            i2c_write(i+2, 16'h0 & 8'hf);     i2c_read (i+2, 16'h0 & 8'hf);
            i2c_write(i+3, 16'h0 & 8'hf);     i2c_read (i+3, 16'h0 & 8'hf);
        end

        for (i = 42; i < 256; i = i + 4)begin
            i2c_write(i  , 16'h0);            i2c_read (i  , 16'h0);
        end

        $display("------------- write-read 16'hffff -------------");

        i2c_write(0, 16'hffff & 8'hf);
        i2c_read (0, 16'hffff & 8'hf);

        for (i = 1; i < 9; i = i + 1)begin
            i2c_write(i, 16'hffff);
            i2c_read (i, 16'hffff);
        end

        for (i = 10; i < 41; i = i + 4)begin
            i2c_write(i  , 16'hffff);            i2c_read (i  , 16'hffff);
            i2c_write(i+1, 16'hffff);            i2c_read (i+1, 16'hffff);
            i2c_write(i+2, 16'hffff & 8'hf);     i2c_read (i+2, 16'hffff & 8'hf);
            i2c_write(i+3, 16'hffff & 8'hf);     i2c_read (i+3, 16'hffff & 8'hf);
        end

        for (i = 42; i < 256; i = i + 4)begin
            i2c_write(i  , 16'hffff);            i2c_read (i  , 16'h0);
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