`timescale 1ns/1ns

module tb;
    `include "../tb/reg_task.v"
    `include "./test_case.v"
    // Parameters
    parameter WIDTH = 16;

    // Signals
    reg clk;
    reg rst_n;
    reg wr_en;
    reg rd_en;
    reg [7:0] addr;
    reg [15:0] wdata;
    wire [15:0] rdata;

    // Outputs from DUT
    wire              pwm_ch1_a_o, pwm_ch1_b_o;
    wire              pwm_ch2_a_o, pwm_ch2_b_o;
    wire              pwm_ch3_a_o, pwm_ch3_b_o;
    wire              pwm_ch4_a_o, pwm_ch4_b_o;

    // DUT instance
    pwm_top #(.WIDTH(WIDTH)) uut (
        .clk_psc_i(clk),
        .rst_n_i(rst_n),
        .wr_en_i(wr_en),
        .rd_en_i(rd_en),
        .wdata_i(wdata),
        .rdata_o(rdata),
        .addr_i(addr),

        .pwm_ch1_a_o     (pwm_ch1_a_o),
        .pwm_ch1_b_o     (pwm_ch1_b_o),
        .pwm_ch2_a_o     (pwm_ch2_a_o),
        .pwm_ch2_b_o     (pwm_ch2_b_o),
        .pwm_ch3_a_o     (pwm_ch3_a_o),
        .pwm_ch3_b_o     (pwm_ch3_b_o),
        .pwm_ch4_a_o     (pwm_ch4_a_o),
        .pwm_ch4_b_o     (pwm_ch4_b_o)
    );

    // Dump waveform ra file VCD
    initial begin
    `ifdef WAVE
        $display("=== DUMP NORMAL VCD ===");
        $dumpfile("dump.vcd");
        $dumpvars(0);
    `elsif DEC
        $display("=== DUMP DEC VCD ===");
        $dumpfile("dump_dec.vcd");
        // $dumpvars(0,tb.clk,tb.uut.overflow,tb.PWM_CH1,tb.PWM_CH2,tb.PWM_CH3,tb.PWM_CH4);
        $dumpvars(0,tb.clk,tb.uut.overflow,tb.PWM_CH1,tb.uut.OC1,tb.uut.OC1N);
        // $dumpvars(0,tb.clk,tb.uut.overflow,tb.PWM_CH1);
    `else
        $display("=== RUN DEFAULT CASE ===");
    `endif
    end

    // Clock generation
    initial clk = 0;
    always #1 clk = ~clk; // 100 MHz

    // Test sequence
    initial begin
        // Initialize
        wr_en = 0;
        rd_en = 0;
        addr  = 0;
        wdata = 0;
        rst_n = 0;
        #2;
        rst_n = 1;
        #2;

        // write_reg(8'd3, 16'd1);                  // on
        // write_reg(8'd4, 16'd6);                  // off

        test_case();

        #50;
        $finish;
    end

endmodule
