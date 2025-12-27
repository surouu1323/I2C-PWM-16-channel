task test_case();
    reg [15:0] data;
    integer i;
    reg [15:0] rdata;
    begin
        tb.error = 0;

        $display("");
        $display("===============================================");
        $display("==                 PWM OC CHECK              ==");
        $display("===============================================");


        $display("------------------- PWM CORE 1 ----------------");
        $display("");
        $display("------------- oc_sel = 0, oc_pol = 0 ----------");
        

        i2c_write (8'd13,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b00,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b00,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });


        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_a_o) $display("[PASS ] tb.pwm_ch1_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_a_o not = 0");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_b_o) $display("[PASS ] tb.pwm_ch1_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_b_o not = 0");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("------------- oc_sel = 0, oc_pol = 1 ----------");

        i2c_write (8'd13,{8'b0,
            1'b1,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b1,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b00,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b00,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });


        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch1_a_o) $display("[PASS ] tb.pwm_ch1_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch1_a_o not = 1");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch1_b_o) $display("[PASS ] tb.pwm_ch1_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch1_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- dtg_sel = 0, oc_sel = 10, oc_pol = 0 --------");

        i2c_write (8'd13,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b10,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b10,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd1 , 0);
        i2c_write (8'd2 , 2);
        i2c_write (8'd10, 0);
        i2c_write (8'd11, 3);
        i2c_write (0, 16'hf);


        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_a_o) $display("[PASS ] tb.pwm_ch1_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_a_o not = 0");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_b_o) $display("[PASS ] tb.pwm_ch1_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_b_o not = 0");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("-------- dtg_sel = 1, oc_sel = 10, oc_pol = 0 --------");

        i2c_write (8'd13,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b10,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b10,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b1,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd1 , 0);
        i2c_write (8'd2 , 2);
        i2c_write (8'd10, 0);
        i2c_write (8'd11, 3);
        i2c_write (0, 16'hf);


        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch1_a_o) $display("[PASS ] tb.pwm_ch1_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch1_a_o not = 1");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch1_b_o) $display("[PASS ] tb.pwm_ch1_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch1_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- dtg_sel = 0, oc_sel = 11, oc_pol = 0 --------");
        tb.rst_n = 0; #10 tb.rst_n=1;
        i2c_write (8'd13,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b11,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b11,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd1 , 0);
        i2c_write (8'd2 , 6);
        i2c_write (8'd10, 2);
        i2c_write (8'd12, 0);
        i2c_write (0, 16'hf);

        @(posedge tb.pwm_ch1_a_o);
        #1 if(tb.pwm_ch1_a_o) $display("[PASS ] tb.pwm_ch1_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch1_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.pwm_ch1_b_o);
        #1 if(tb.pwm_ch1_b_o) $display("[PASS ] tb.pwm_ch1_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch1_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- dtg_sel = 255, oc_sel = 11, oc_pol = 0 --------");
        tb.rst_n = 0; #10 tb.rst_n=1;
        i2c_write (8'd13,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b11,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b11,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd1 , 0);
        i2c_write (8'd2 , 1024);
        i2c_write (8'd10, 512);
        i2c_write (8'd12, 255);
        i2c_write (0, 16'hf);

        @(posedge tb.pwm_ch1_a_o);
        #1 if(tb.pwm_ch1_a_o) $display("[PASS ] tb.pwm_ch1_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch1_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.pwm_ch1_b_o);
        #1 if(tb.pwm_ch1_b_o) $display("[PASS ] tb.pwm_ch1_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch1_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- oc_mode = 1, oc_sel = 01, oc_pol = 0 --------");

        i2c_write (8'd13,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b01,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b01,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b1        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd1 , 0);
        i2c_write (8'd2 , 2);
        i2c_write (8'd10, 0);
        i2c_write (8'd11, 3);
        i2c_write (8'd12, 0);
        i2c_write (0, 16'hf);

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch1_a_o) $display("[PASS ] tb.pwm_ch1_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch1_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch1_b_o) $display("[PASS ] tb.pwm_ch1_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch1_b_o not = 0");
            tb.error = tb.error + 1;
        end



        $display("------------------- PWM CORE 2 ----------------");
        $display("");
        $display("------------- oc_sel = 0, oc_pol = 0 ----------");
        

        i2c_write (8'd21,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b00,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b00,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });


        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_a_o) $display("[PASS ] tb.pwm_ch3_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_a_o not = 0");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_b_o) $display("[PASS ] tb.pwm_ch3_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_b_o not = 0");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("------------- oc_sel = 0, oc_pol = 1 ----------");

        i2c_write (8'd21,{8'b0,
            1'b1,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b1,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b00,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b00,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });


        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch3_a_o) $display("[PASS ] tb.pwm_ch3_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch3_a_o not = 1");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch3_b_o) $display("[PASS ] tb.pwm_ch3_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch3_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- dtg_sel = 0, oc_sel = 10, oc_pol = 0 --------");

        i2c_write (8'd21,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b10,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b10,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd3 , 0);
        i2c_write (8'd4 , 2);
        i2c_write (8'd18, 0);
        i2c_write (8'd19, 3);
        i2c_write (0, 16'hf);


        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_a_o) $display("[PASS ] tb.pwm_ch3_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_a_o not = 0");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_b_o) $display("[PASS ] tb.pwm_ch3_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_b_o not = 0");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("-------- dtg_sel = 1, oc_sel = 10, oc_pol = 0 --------");

        i2c_write (8'd21,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b10,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b10,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b1,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd3 , 0);
        i2c_write (8'd4 , 2);
        i2c_write (8'd18, 0);
        i2c_write (8'd19, 3);
        i2c_write (0, 16'hf);


        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch3_a_o) $display("[PASS ] tb.pwm_ch3_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch3_a_o not = 1");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch3_b_o) $display("[PASS ] tb.pwm_ch3_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch3_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- dtg_sel = 0, oc_sel = 11, oc_pol = 0 --------");
        tb.rst_n = 0; #10 tb.rst_n=1;
        i2c_write (8'd21,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b11,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b11,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd3 , 0);
        i2c_write (8'd4 , 6);
        i2c_write (8'd18, 2);
        i2c_write (8'd20, 0);
        i2c_write (0, 16'hf);

        @(posedge tb.pwm_ch3_a_o);
        #1 if(tb.pwm_ch3_a_o) $display("[PASS ] tb.pwm_ch3_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch3_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.pwm_ch3_b_o);
        #1 if(tb.pwm_ch3_b_o) $display("[PASS ] tb.pwm_ch3_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch3_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- dtg_sel = 255, oc_sel = 11, oc_pol = 0 --------");
        tb.rst_n = 0; #10 tb.rst_n=1;
        i2c_write (8'd21,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b11,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b11,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd3 , 0);
        i2c_write (8'd4 , 1024);
        i2c_write (8'd18, 512);
        i2c_write (8'd20, 255);
        i2c_write (0, 16'hf);

        @(posedge tb.pwm_ch3_a_o);
        #1 if(tb.pwm_ch3_a_o) $display("[PASS ] tb.pwm_ch3_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch3_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.pwm_ch3_b_o);
        #1 if(tb.pwm_ch3_b_o) $display("[PASS ] tb.pwm_ch3_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch3_b_o not = 1");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("-------- oc_mode = 1, oc_sel = 01, oc_pol = 0 --------");

        i2c_write (8'd21,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b01,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b01,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b1        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd3 , 0);
        i2c_write (8'd4 , 2);
        i2c_write (8'd18, 0);
        i2c_write (8'd19, 3);
        i2c_write (8'd20, 0);
        i2c_write (0, 16'hf);

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch3_a_o) $display("[PASS ] tb.pwm_ch3_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch3_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch3_b_o) $display("[PASS ] tb.pwm_ch3_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch3_b_o not = 0");
            tb.error = tb.error + 1;
        end


        $display("------------------- PWM CORE 3 ----------------");
        $display("");
        $display("------------- oc_sel = 0, oc_pol = 0 ----------");
        

        i2c_write (8'd29,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b00,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b00,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });


        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_a_o) $display("[PASS ] tb.pwm_ch5_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_a_o not = 0");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_b_o) $display("[PASS ] tb.pwm_ch5_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_b_o not = 0");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("------------- oc_sel = 0, oc_pol = 1 ----------");

        i2c_write (8'd29,{8'b0,
            1'b1,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b1,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b00,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b00,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });


        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch5_a_o) $display("[PASS ] tb.pwm_ch5_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch5_a_o not = 1");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch5_b_o) $display("[PASS ] tb.pwm_ch5_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch5_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- dtg_sel = 0, oc_sel = 10, oc_pol = 0 --------");

        i2c_write (8'd29,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b10,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b10,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd5 , 0);
        i2c_write (8'd6 , 2);
        i2c_write (8'd26, 0);
        i2c_write (8'd27, 3);
        i2c_write (0, 16'hf);


        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_a_o) $display("[PASS ] tb.pwm_ch5_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_a_o not = 0");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_b_o) $display("[PASS ] tb.pwm_ch5_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_b_o not = 0");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("-------- dtg_sel = 1, oc_sel = 10, oc_pol = 0 --------");

        i2c_write (8'd29,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b10,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b10,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b1,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd5 , 0);
        i2c_write (8'd6 , 2);
        i2c_write (8'd26, 0);
        i2c_write (8'd27, 3);
        i2c_write (0, 16'hf);


        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch5_a_o) $display("[PASS ] tb.pwm_ch5_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch5_a_o not = 1");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch5_b_o) $display("[PASS ] tb.pwm_ch5_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch5_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- dtg_sel = 0, oc_sel = 11, oc_pol = 0 --------");
        tb.rst_n = 0; #10 tb.rst_n=1;
        i2c_write (8'd29,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b11,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b11,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd5 , 0);
        i2c_write (8'd6 , 6);
        i2c_write (8'd26, 2);
        i2c_write (8'd28, 0);
        i2c_write (0, 16'hf);

        @(posedge tb.pwm_ch5_a_o);
        #1 if(tb.pwm_ch5_a_o) $display("[PASS ] tb.pwm_ch5_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch5_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.pwm_ch5_b_o);
        #1 if(tb.pwm_ch5_b_o) $display("[PASS ] tb.pwm_ch5_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch5_b_o not = 1");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("-------- dtg_sel = 255, oc_sel = 11, oc_pol = 0 --------");
        tb.rst_n = 0; #10 tb.rst_n=1;
        i2c_write (8'd29,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b11,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b11,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd5 , 0);
        i2c_write (8'd6 , 1024);
        i2c_write (8'd26, 512);
        i2c_write (8'd28, 255);
        i2c_write (0, 16'hf);

        @(posedge tb.pwm_ch5_a_o);
        #1 if(tb.pwm_ch5_a_o) $display("[PASS ] tb.pwm_ch5_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch5_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.pwm_ch5_b_o);
        #1 if(tb.pwm_ch5_b_o) $display("[PASS ] tb.pwm_ch5_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch5_b_o not = 1");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("-------- oc_mode = 1, oc_sel = 01, oc_pol = 0 --------");

        i2c_write (8'd29,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b01,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b01,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b1        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd5 , 0);
        i2c_write (8'd6 , 2);
        i2c_write (8'd26, 0);
        i2c_write (8'd27, 3);
        i2c_write (8'd28, 0);
        i2c_write (0, 16'hf);

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch5_a_o) $display("[PASS ] tb.pwm_ch5_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch5_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch5_b_o) $display("[PASS ] tb.pwm_ch5_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch5_b_o not = 0");
            tb.error = tb.error + 1;
        end


        $display("------------------- PWM CORE 4 ----------------");
        $display("");
        $display("------------- oc_sel = 0, oc_pol = 0 ----------");
        

        i2c_write (8'd37,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b00,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b00,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });


        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_a_o) $display("[PASS ] tb.pwm_ch7_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_a_o not = 0");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_b_o) $display("[PASS ] tb.pwm_ch7_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_b_o not = 0");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("------------- oc_sel = 0, oc_pol = 1 ----------");

        i2c_write (8'd37,{8'b0,
            1'b1,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b1,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b00,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b00,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });


        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch7_a_o) $display("[PASS ] tb.pwm_ch7_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch7_a_o not = 1");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch7_b_o) $display("[PASS ] tb.pwm_ch7_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch7_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- dtg_sel = 0, oc_sel = 10, oc_pol = 0 --------");

        i2c_write (8'd37,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b10,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b10,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd7 , 0);
        i2c_write (8'd8 , 2);
        i2c_write (8'd34, 0);
        i2c_write (8'd35, 3);
        i2c_write (0, 16'hf);


        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_a_o) $display("[PASS ] tb.pwm_ch7_a_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_a_o not = 0");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_b_o) $display("[PASS ] tb.pwm_ch7_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_b_o not = 0");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("-------- dtg_sel = 1, oc_sel = 10, oc_pol = 0 --------");

        i2c_write (8'd37,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b10,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b10,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b1,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd7 , 0);
        i2c_write (8'd8 , 2);
        i2c_write (8'd34, 0);
        i2c_write (8'd35, 3);
        i2c_write (0, 16'hf);


        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch7_a_o) $display("[PASS ] tb.pwm_ch7_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch7_a_o not = 1");
            tb.error = tb.error + 1;
        end

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch7_b_o) $display("[PASS ] tb.pwm_ch7_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch7_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- dtg_sel = 0, oc_sel = 11, oc_pol = 0 --------");
        tb.rst_n = 0; #10 tb.rst_n=1;
        i2c_write (8'd37,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b11,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b11,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd7 , 0);
        i2c_write (8'd8 , 6);
        i2c_write (8'd34, 2);
        i2c_write (8'd36, 0);
        i2c_write (0, 16'hf);

        @(posedge tb.pwm_ch7_a_o);
        #1 if(tb.pwm_ch7_a_o) $display("[PASS ] tb.pwm_ch7_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch7_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.pwm_ch7_b_o);
        #1 if(tb.pwm_ch7_b_o) $display("[PASS ] tb.pwm_ch7_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch7_b_o not = 1");
            tb.error = tb.error + 1;
        end

        $display("");
        $display("-------- dtg_sel = 255, oc_sel = 11, oc_pol = 0 --------");
        tb.rst_n = 0; #10 tb.rst_n=1;
        i2c_write (8'd37,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b11,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b11,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b0        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd7 , 0);
        i2c_write (8'd8 , 1024);
        i2c_write (8'd34, 512);
        i2c_write (8'd36, 255);
        i2c_write (0, 16'hf);

        @(posedge tb.pwm_ch7_a_o);
        #1 if(tb.pwm_ch7_a_o) $display("[PASS ] tb.pwm_ch7_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch7_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.pwm_ch7_b_o);
       #1 if(tb.pwm_ch7_b_o) $display("[PASS ] tb.pwm_ch7_b_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch7_b_o not = 1");
            tb.error = tb.error + 1;
        end


        $display("");
        $display("-------- oc_mode = 1, oc_sel = 01, oc_pol = 0 --------");

        i2c_write (8'd37,{8'b0,
            1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
            1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

            2'b01,       // oc_comp_sel_i
            // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

            2'b01,       // oc_main_sel_i
            // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

            1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
            1'b1        // oc_mode_i (0: independent, 1: dual)
        });

        i2c_write (0, 0);
        i2c_write (8'd7 , 0);
        i2c_write (8'd8 , 2);
        i2c_write (8'd34, 0);
        i2c_write (8'd35, 3);
        i2c_write (8'd36, 0);
        i2c_write (0, 16'hf);

        @(posedge tb.clk_pwm);
        #1 if(tb.pwm_ch7_a_o) $display("[PASS ] tb.pwm_ch7_a_o = 1");
        else begin
            $display("[FAILED] tb.pwm_ch7_a_o not = 1");
            tb.error = tb.error + 1;
        end
    
        @(posedge tb.clk_pwm);
        #1 if(!tb.pwm_ch7_b_o) $display("[PASS ] tb.pwm_ch7_b_o = 0");
        else begin
            $display("[FAILED] tb.pwm_ch7_b_o not = 0");
            tb.error = tb.error + 1;
        end




        #100;
        $display("-----------------------------------------------");
        $display("TEST RESULT: %s",   (tb.error != 0) ? "FAILED" : "PASSED");
        $display("-----------------------------------------------");
        $display("");

        // $display("test_case_1");
        // if(tb.error != 0 )  $display("Test_result FAILED");
        // else                $display("Test_result PASSED");
    end
endtask