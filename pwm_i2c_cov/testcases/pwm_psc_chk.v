task test_case();
    reg [15:0] data;
    integer i;
    reg [15:0] rdata;
    begin
        tb.error = 0;

        $display("");
        $display("===============================================");
        $display("==             PWM PRESCALER CHECK           ==");
        $display("===============================================");


        $display("------------------- PWM CORE 1 ----------------");
        $display("");
        $display("--------- clock divided by 1 (PSC = 0) --------");
        
        i2c_write (8'd1 , 0);
        i2c_write (8'd2 , 9);
        i2c_write (8'd10, 1);
        i2c_write (8'd11, 4);
        i2c_write (8'd13,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b01,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b01,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });
        i2c_write (0, 16'h1);

        @(posedge tb.pwm_ch1_a_o);
        repeat (1) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_a_o) $display("[PASS ] tb.pwm_ch1_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch1_b_o);
        repeat (4) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_b_o) $display("[PASS ] tb.pwm_ch1_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);

        $display("");
        $display("--------- clock divided by 2 (PSC = 1) --------");
        
        i2c_write (8'd1 , 1);
        i2c_write (0, 16'h1);

        @(posedge tb.pwm_ch1_a_o);
        repeat (2) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_a_o) $display("[PASS ] tb.pwm_ch1_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch1_b_o);
        repeat (8) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_b_o) $display("[PASS ] tb.pwm_ch1_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);


        $display("");
        $display("--------- clock divided by 4 (PSC = 3) --------");
        
        i2c_write (8'd1 , 3);
        i2c_write (0, 16'h1);

        @(posedge tb.pwm_ch1_a_o);
        repeat (4) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_a_o) $display("[PASS ] tb.pwm_ch1_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch1_b_o);
        repeat (16) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_b_o) $display("[PASS ] tb.pwm_ch1_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);


        $display("");
        $display("------ clock divided by 65536 (PSC = 65535) ------");
        
        i2c_write (8'd1 , 65535);
        i2c_write (0, 16'h1);

        @(posedge tb.pwm_ch1_a_o);
        repeat (65536) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_a_o) $display("[PASS ] tb.pwm_ch1_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch1_b_o);
        repeat (262144) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_b_o) $display("[PASS ] tb.pwm_ch1_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);
        
        tb.rst_n = 0;
        #10 tb.rst_n = 1;


        $display("");
        $display("------------------- PWM CORE 2 ----------------");
        $display("");
        $display("--------- clock divided by 1 (PSC = 0) --------");
        
        i2c_write (8'd3, 0);
        i2c_write (8'd4 , 9);
        i2c_write (8'd18, 1);
        i2c_write (8'd19, 4);
        i2c_write (8'd21,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b01,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b01,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });
        i2c_write (8'd0 , {{12{1'b0}},4'b0010});

        @(posedge tb.pwm_ch3_a_o);
        repeat (1) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_a_o) $display("[PASS ] tb.pwm_ch3_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch3_b_o);
        repeat (4) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_b_o) $display("[PASS ] tb.pwm_ch3_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);


        $display("");
        $display("--------- clock divided by 2 (PSC = 1) --------");
        
        i2c_write (8'd3, 1);
        i2c_write (8'd0 , {{12{1'b0}},4'b0010});

        @(posedge tb.pwm_ch3_a_o);
        repeat (2) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_a_o) $display("[PASS ] tb.pwm_ch3_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch3_b_o);
        repeat (8) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_b_o) $display("[PASS ] tb.pwm_ch3_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);


        $display("");
        $display("--------- clock divided by 4 (PSC = 3) --------");
        
        i2c_write (8'd3, 3);
        i2c_write (8'd0 , {{12{1'b0}},4'b0010});

        @(posedge tb.pwm_ch3_a_o);
        repeat (4) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_a_o) $display("[PASS ] tb.pwm_ch3_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch3_b_o);
        repeat (16) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_b_o) $display("[PASS ] tb.pwm_ch3_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);


        $display("");
        $display("------ clock divided by 65536 (PSC = 65535) ------");
        
        i2c_write (8'd3, 65535);
        i2c_write (8'd0 , {{12{1'b0}},4'b0010});

        @(posedge tb.pwm_ch3_a_o);
        repeat (65536) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_a_o) $display("[PASS ] tb.pwm_ch3_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch3_b_o);
        repeat (262144) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_b_o) $display("[PASS ] tb.pwm_ch3_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);

        $display("");
        $display("------------------- PWM CORE 3 ----------------");
        $display("");
        $display("--------- clock divided by 1 (PSC = 0) --------");
        
        i2c_write (8'd5, 0);
        i2c_write (8'd6 , 9);
        i2c_write (8'd26, 1);
        i2c_write (8'd27, 4);
        i2c_write (8'd29,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b01,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b01,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });
        i2c_write (8'd0 , {{12{1'b0}},4'b0100});

        @(posedge tb.pwm_ch5_a_o);
        repeat (1) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_a_o) $display("[PASS ] tb.pwm_ch5_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch5_b_o);
        repeat (4) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_b_o) $display("[PASS ] tb.pwm_ch5_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);


        $display("");
        $display("--------- clock divided by 2 (PSC = 1) --------");
        
        i2c_write (8'd5, 1);
        i2c_write (8'd0 , {{12{1'b0}},4'b0100});

        @(posedge tb.pwm_ch5_a_o);
        repeat (2) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_a_o) $display("[PASS ] tb.pwm_ch5_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch5_b_o);
        repeat (8) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_b_o) $display("[PASS ] tb.pwm_ch5_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);


        $display("");
        $display("--------- clock divided by 4 (PSC = 3) --------");
        
        i2c_write (8'd5, 3);
        i2c_write (8'd0 , {{12{1'b0}},4'b0100});

        @(posedge tb.pwm_ch5_a_o);
        repeat (4) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_a_o) $display("[PASS ] tb.pwm_ch5_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch5_b_o);
        repeat (16) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_b_o) $display("[PASS ] tb.pwm_ch5_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);


        $display("");
        $display("------ clock divided by 65536 (PSC = 65535) ------");
        
        i2c_write (8'd5, 65535);
        i2c_write (8'd0 , {{12{1'b0}},4'b0100});

        @(posedge tb.pwm_ch5_a_o);
        repeat (65536) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_a_o) $display("[PASS ] tb.pwm_ch5_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch5_b_o);
        repeat (262144) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_b_o) $display("[PASS ] tb.pwm_ch5_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);

        $display("");
        $display("------------------- PWM CORE 4 ----------------");
        $display("");
        $display("--------- clock divided by 1 (PSC = 0) --------");
        
        i2c_write (8'd7, 0);
        i2c_write (8'd8 , 9);
        i2c_write (8'd34, 1);
        i2c_write (8'd35, 4);
        i2c_write (8'd37,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b01,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b01,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });
        i2c_write (8'd0 , {{12{1'b0}},4'b1000});

        @(posedge tb.pwm_ch7_a_o);
        repeat (1) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_a_o) $display("[PASS ] tb.pwm_ch7_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch7_b_o);
        repeat (4) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_b_o) $display("[PASS ] tb.pwm_ch7_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);


        $display("");
        $display("--------- clock divided by 2 (PSC = 1) --------");
        
        i2c_write (8'd7, 1);
        i2c_write (8'd0 , {{12{1'b0}},4'b1000});

        @(posedge tb.pwm_ch7_a_o);
        repeat (2) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_a_o) $display("[PASS ] tb.pwm_ch7_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch7_b_o);
        repeat (8) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_b_o) $display("[PASS ] tb.pwm_ch7_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);


        $display("");
        $display("--------- clock divided by 4 (PSC = 3) --------");
        
        i2c_write (8'd7, 3);
        i2c_write (8'd0 , {{12{1'b0}},4'b1000});

        @(posedge tb.pwm_ch7_a_o);
        repeat (4) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_a_o) $display("[PASS ] tb.pwm_ch7_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch7_b_o);
        repeat (16) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_b_o) $display("[PASS ] tb.pwm_ch7_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);


        $display("");
        $display("------ clock divided by 65536 (PSC = 65535) ------");
        
        i2c_write (8'd7, 65535);
        i2c_write (8'd0 , {{12{1'b0}},4'b1000});

        @(posedge tb.pwm_ch7_a_o);
        repeat (65536) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_a_o) $display("[PASS ] tb.pwm_ch7_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_a_o not = 0");
            tb.error = 1;
        end

        @(posedge tb.pwm_ch7_b_o);
        repeat (262144) @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_b_o) $display("[PASS ] tb.pwm_ch7_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_b_o not = 0");
            tb.error = 1;
        end

        i2c_write(0, 16'h0);





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