task test_case();
    write_reg(8'd1, 16'd0); // prescaler_div
    write_reg(8'd2, 16'd9); //arr = 9
    write_reg(8'd3, 16'd1); // start = 2
    write_reg(8'd4, 16'd7); // end = 7

    write_reg(8'd6,{8'b0,
        1'b0,        // oc_comp_pol_i(1: invert; 0: non-invert)
        1'b0,        // oc_main_pol_i (1: invert; 0: non-invert)

        2'b01,       // oc_comp_sel_i
        // 00: out=0 ; 01: oc_ref_b ; 10: dtg_input; 11:oc_comp_dt

        2'b01,       // oc_main_sel_i
        // 00: out=0 ; 01: oc_ref_a ; 10: dtg_input; 11:oc_main_dt

        1'b0,        // dtg_src_sel_i (0: oc_ref_ch_a, 1: oc_ref_ch_b)
        1'b0        // oc_mode_i (0: independent, 1: dual)
    });


    write_reg(8'd0, 16'd1); //en =1
    #20;
endtask