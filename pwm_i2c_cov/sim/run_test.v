task test_case();
    integer base;
    begin
        tb.error = 0;

        $display("");
        $display("===============================================");
        $display("==                 PWM CMP CHECK              ==");
        $display("===============================================");


        $display("------------------- PWM CORE 1 ----------------");
        $display("");
        $display("--------------------- CMP = 0 -----------------");
        base = 10;
        i2c_write (0, 0);
        i2c_write (8'd1     , 0);
        i2c_write (8'd2     , 2);
        i2c_write (base     , 0);
        i2c_write (base + 1 , 0);
        i2c_write (base + 3 ,{8'b0,8'h14});
        i2c_write (base + 4 , 0);
        i2c_write (base + 5 , 0);
        i2c_write (base + 7 ,{8'b0,8'h14});
        i2c_write (0, 16'hf);

        
        @(posedge tb.clk_pwm); @(posedge tb.clk_pwm);
        if(tb.pwm_ch1_a_o)begin
            $display("[FAILED] tb.pwm_ch1_a_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch1_a_o = 0");
        if(tb.pwm_ch1_b_o) begin
            $display("[FAILED] tb.pwm_ch1_b_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch1_b_o = 0");

        if(tb.pwm_ch2_a_o)begin
            $display("[FAILED] tb.pwm_ch2_a_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch2_a_o = 0");
        if(tb.pwm_ch2_b_o) begin
            $display("[FAILED] tb.pwm_ch2_b_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch2_b_o = 0");


        $display("");
        $display("----------------- CMP = 16'hffff --------------");
        
        base = 10;
        i2c_write (0, 0);
        i2c_write (8'd1     , 0);
        i2c_write (8'd2     , 2);
        i2c_write (base     , 16'hffff);
        i2c_write (base + 1 , 16'hffff);
        i2c_write (base + 3 ,{8'b0,8'h14});
        i2c_write (base + 4 , 16'hffff);
        i2c_write (base + 5 , 16'hffff);
        i2c_write (base + 7 ,{8'b0,8'h14});
        i2c_write (0, 16'hf);

        
        @(posedge tb.clk_pwm); @(posedge tb.clk_pwm);
        if(!tb.pwm_ch1_a_o)begin
            $display("[FAILED] tb.pwm_ch1_a_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch1_a_o = 1");
        if(!tb.pwm_ch1_b_o) begin
            $display("[FAILED] tb.pwm_ch1_b_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch1_b_o = 1");

        if(!tb.pwm_ch2_a_o)begin
            $display("[FAILED] tb.pwm_ch2_a_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch2_a_o = 1");
        if(!tb.pwm_ch2_b_o) begin
            $display("[FAILED] tb.pwm_ch2_b_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch2_b_o = 1");


        $display("------------------- PWM CORE 2 ----------------");
        $display("");
        $display("--------------------- CMP = 0 -----------------");
        base = 18;
        i2c_write (0, 0);
        i2c_write (8'd3     , 0);
        i2c_write (8'd4     , 2);
        i2c_write (base     , 0);
        i2c_write (base + 1 , 0);
        i2c_write (base + 3 ,{8'b0,8'h14});
        i2c_write (base + 4 , 0);
        i2c_write (base + 5 , 0);
        i2c_write (base + 7 ,{8'b0,8'h14});
        i2c_write (0, 16'hf);

        
        @(posedge tb.clk_pwm); @(posedge tb.clk_pwm);
        if(tb.pwm_ch3_a_o)begin
            $display("[FAILED] tb.pwm_ch3_a_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch3_a_o = 0");
        if(tb.pwm_ch3_b_o) begin
            $display("[FAILED] tb.pwm_ch3_b_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch3_b_o = 0");

        if(tb.pwm_ch4_a_o)begin
            $display("[FAILED] tb.pwm_ch4_a_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch4_a_o = 0");
        if(tb.pwm_ch4_b_o) begin
            $display("[FAILED] tb.pwm_ch4_b_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch4_b_o = 0");


        $display("");
        $display("----------------- CMP = 16'hffff --------------");
        
        base = 18;
        i2c_write (0, 0);
        i2c_write (8'd3     , 0);
        i2c_write (8'd4     , 2);
        i2c_write (base     , 16'hffff);
        i2c_write (base + 1 , 16'hffff);
        i2c_write (base + 3 ,{8'b0,8'h14});
        i2c_write (base + 4 , 16'hffff);
        i2c_write (base + 5 , 16'hffff);
        i2c_write (base + 7 ,{8'b0,8'h14});
        i2c_write (0, 16'hf);

        
        @(posedge tb.clk_pwm); @(posedge tb.clk_pwm);
        if(!tb.pwm_ch3_a_o)begin
            $display("[FAILED] tb.pwm_ch3_a_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch3_a_o = 1");
        if(!tb.pwm_ch3_b_o) begin
            $display("[FAILED] tb.pwm_ch3_b_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch3_b_o = 1");

        if(!tb.pwm_ch4_a_o)begin
            $display("[FAILED] tb.pwm_ch4_a_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch4_a_o = 1");
        if(!tb.pwm_ch4_b_o) begin
            $display("[FAILED] tb.pwm_ch4_b_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch4_b_o = 1");


        $display("------------------- PWM CORE 3 ----------------");
        $display("");
        $display("--------------------- CMP = 0 -----------------");
        base = 26;
        i2c_write (0, 0);
        i2c_write (8'd5     , 0);
        i2c_write (8'd6     , 2);
        i2c_write (base     , 0);
        i2c_write (base + 1 , 0);
        i2c_write (base + 3 ,{8'b0,8'h14});
        i2c_write (base + 4 , 0);
        i2c_write (base + 5 , 0);
        i2c_write (base + 7 ,{8'b0,8'h14});
        i2c_write (0, 16'hf);

        
        @(posedge tb.clk_pwm); @(posedge tb.clk_pwm);
        if(tb.pwm_ch5_a_o)begin
            $display("[FAILED] tb.pwm_ch5_a_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch5_a_o = 0");
        if(tb.pwm_ch5_b_o) begin
            $display("[FAILED] tb.pwm_ch5_b_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch5_b_o = 0");

        if(tb.pwm_ch6_a_o)begin
            $display("[FAILED] tb.pwm_ch6_a_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch6_a_o = 0");
        if(tb.pwm_ch6_b_o) begin
            $display("[FAILED] tb.pwm_ch6_b_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch6_b_o = 0");


        $display("");
        $display("----------------- CMP = 16'hffff --------------");
        
        base = 26;
        i2c_write (0, 0);
        i2c_write (8'd5     , 0);
        i2c_write (8'd6     , 2);
        i2c_write (base     , 16'hffff);
        i2c_write (base + 1 , 16'hffff);
        i2c_write (base + 3 ,{8'b0,8'h14});
        i2c_write (base + 4 , 16'hffff);
        i2c_write (base + 5 , 16'hffff);
        i2c_write (base + 7 ,{8'b0,8'h14});
        i2c_write (0, 16'hf);

        
        @(posedge tb.clk_pwm); @(posedge tb.clk_pwm);
        if(!tb.pwm_ch5_a_o)begin
            $display("[FAILED] tb.pwm_ch5_a_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch5_a_o = 1");
        if(!tb.pwm_ch5_b_o) begin
            $display("[FAILED] tb.pwm_ch5_b_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch5_b_o = 1");

        if(!tb.pwm_ch6_a_o)begin
            $display("[FAILED] tb.pwm_ch6_a_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch6_a_o = 1");
        if(!tb.pwm_ch6_b_o) begin
            $display("[FAILED] tb.pwm_ch6_b_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch6_b_o = 1");


        $display("------------------- PWM CORE 4 ----------------");
        $display("");
        $display("--------------------- CMP = 0 -----------------");
        base = 34;
        i2c_write (0, 0);
        i2c_write (8'd7     , 0);
        i2c_write (8'd8     , 2);
        i2c_write (base     , 0);
        i2c_write (base + 1 , 0);
        i2c_write (base + 3 ,{8'b0,8'h14});
        i2c_write (base + 4 , 0);
        i2c_write (base + 5 , 0);
        i2c_write (base + 7 ,{8'b0,8'h14});
        i2c_write (0, 16'hf);

        
        @(posedge tb.clk_pwm); @(posedge tb.clk_pwm);
        if(tb.pwm_ch7_a_o)begin
            $display("[FAILED] tb.pwm_ch7_a_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch7_a_o = 0");
        if(tb.pwm_ch7_b_o) begin
            $display("[FAILED] tb.pwm_ch7_b_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch7_b_o = 0");

        if(tb.pwm_ch7_a_o)begin
            $display("[FAILED] tb.pwm_ch8_a_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch8_a_o = 0");
        if(tb.pwm_ch8_b_o) begin
            $display("[FAILED] tb.pwm_ch8_b_o = 1");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch8_b_o = 0");


        $display("");
        $display("----------------- CMP = 16'hffff --------------");
        
        base = 34;
        i2c_write (0, 0);
        i2c_write (8'd7     , 0);
        i2c_write (8'd8     , 2);
        i2c_write (base     , 16'hffff);
        i2c_write (base + 1 , 16'hffff);
        i2c_write (base + 3 ,{8'b0,8'h14});
        i2c_write (base + 4 , 16'hffff);
        i2c_write (base + 5 , 16'hffff);
        i2c_write (base + 7 ,{8'b0,8'h14});
        i2c_write (0, 16'hf);

        
        @(posedge tb.clk_pwm); @(posedge tb.clk_pwm);
        if(!tb.pwm_ch7_a_o)begin
            $display("[FAILED] tb.pwm_ch7_a_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch7_a_o = 1");
        if(!tb.pwm_ch7_b_o) begin
            $display("[FAILED] tb.pwm_ch7_b_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch7_b_o = 1");

        if(!tb.pwm_ch8_a_o)begin
            $display("[FAILED] tb.pwm_ch8_a_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch8_a_o = 1");
        if(!tb.pwm_ch8_b_o) begin
            $display("[FAILED] tb.pwm_ch8_b_o = 0");
            tb.error = tb.error + 1;
        end else $display("[PASS ] tb.pwm_ch8_b_o = 1");
       
        #100;
        $display("-----------------------------------------------");
        $display("TEST RESULT: %s",   (tb.error != 0) ? "FAILED" : "PASSED");
        $display("-----------------------------------------------");
        $display("");

    end
endtask