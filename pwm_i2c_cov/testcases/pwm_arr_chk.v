task test_case();
    reg [15:0] data;
    integer i;
    reg [15:0] rdata;
    begin
        tb.error = 0;

        $display("");
        $display("===============================================");
        $display("==               Auto-Reload CHECK           ==");
        $display("===============================================");

        i2c_write (8'd1 , 0);
        i2c_write (8'd3 , 0);
        i2c_write (8'd5 , 0);
        i2c_write (8'd7 , 0);

        i2c_write (8'd10,16'd1);
        i2c_write (8'd13,16'h14);

        i2c_write (8'd18,16'd1);
        i2c_write (8'd21,16'h14);

        i2c_write (8'd26,16'd1);
        i2c_write (8'd29,16'h14);

        i2c_write (8'd34,16'd1);
        i2c_write (8'd37,16'h14);

        i2c_write (0, 16'hf);

        $display("------------------- PWM CORE 1 ----------------");
        $display("");     
        $display("--------------------- AAR = 9 -----------------");
        i2c_write (8'd2 ,16'd9);

        @(posedge tb.pwm_ch1_a_o);
        repeat (10) @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch1_a_o) $display("[PASS ] AAR = 9");
        else begin
            $display("[FAILED] AAR != 9");
            tb.error = 1;
        end

        
        $display("------------------- AAR = 65535 ---------------");
        i2c_write (8'd2 ,16'd65535);

        @(posedge tb.pwm_ch1_a_o);
        repeat (65536) @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch1_a_o) $display("[PASS ] AAR = 9");
        else begin
            $display("[FAILED] AAR != 9");
            tb.error = 1;
        end


        

        $display("------------------- PWM CORE 2 ----------------");
        $display("");     
        $display("--------------------- AAR = 9 -----------------");
        i2c_write (8'd4 ,16'd9);
        
        @(posedge tb.pwm_ch3_a_o);
        repeat (10) @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch3_a_o) $display("[PASS ] AAR = 9");
        else begin
            $display("[FAILED] AAR != 9");
            tb.error = 1;
        end

        
        $display("------------------- AAR = 65535 ---------------");
        i2c_write (8'd4 ,16'd65535);

        @(posedge tb.pwm_ch3_a_o);
        repeat (65536) @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch3_a_o) $display("[PASS ] AAR = 9");
        else begin
            $display("[FAILED] AAR != 9");
            tb.error = 1;
        end

       $display("------------------- PWM CORE 3 ----------------");
        $display("");     
        $display("--------------------- AAR = 9 -----------------");
        i2c_write (8'd6 ,16'd9);

        @(posedge tb.pwm_ch5_a_o);
        repeat (10) @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch5_a_o) $display("[PASS ] AAR = 9");
        else begin
            $display("[FAILED] AAR != 9");
            tb.error = 1;
        end

        
        $display("------------------- AAR = 65535 ---------------");
        i2c_write (8'd6 ,16'd65535);

        @(posedge tb.pwm_ch5_a_o);
        repeat (65536) @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch5_a_o) $display("[PASS ] AAR = 9");
        else begin
            $display("[FAILED] AAR != 9");
            tb.error = 1;
        end

        $display("------------------- PWM CORE 4 ----------------");
        $display("");     
        $display("--------------------- AAR = 9 -----------------");
        i2c_write (8'd8 ,16'd9);

        @(posedge tb.pwm_ch7_a_o);
        repeat (10) @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch7_a_o) $display("[PASS ] AAR = 9");
        else begin
            $display("[FAILED] AAR != 9");
            tb.error = 1;
        end

        
        $display("------------------- AAR = 65535 ---------------");
        i2c_write (8'd8 ,16'd65535);

        @(posedge tb.pwm_ch7_a_o);
        repeat (65536) @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch7_a_o) $display("[PASS ] AAR = 9");
        else begin
            $display("[FAILED] AAR != 9");
            tb.error = 1;
        end


        #1000;
        $display("-----------------------------------------------");
        $display("TEST RESULT: %s",   (tb.error != 0) ? "FAILED" : "PASSED");
        $display("-----------------------------------------------");
        $display("");

        // $display("test_case_1");
        // if(tb.error != 0 )  $display("Test_result FAILED");
        // else                $display("Test_result PASSED");
    end
endtask