// `timescale 1ns/1ns

module tb;
    `include "../tb/i2c_task.v"
    `include "./run_test.v"


    // Signals
    reg clk_pwm,clk_i2c_slave, clk;
    reg rst_n;
    reg scl_en;
    reg scl;
    reg sda_drive;   // master điều khiển SDA
    wire sda;        // SDA line (pull-up)
    reg ack_respone;
    
    // Pull-up giả lập bus
    pullup(sda);
    
    integer error;

    reg [7:0] SLAVE_ADD ;
    reg [2:0] address_set_pin;

    // Outputs from DUT
    wire              pwm_ch1_a_o, pwm_ch1_b_o;
    wire              pwm_ch2_a_o, pwm_ch2_b_o;
    wire              pwm_ch3_a_o, pwm_ch3_b_o;
    wire              pwm_ch4_a_o, pwm_ch4_b_o;
    wire              pwm_ch5_a_o, pwm_ch5_b_o;
    wire              pwm_ch6_a_o, pwm_ch6_b_o;
    wire              pwm_ch7_a_o, pwm_ch7_b_o;
    wire              pwm_ch8_a_o, pwm_ch8_b_o;

    // DUT instance
    top uut (
        .clk_pwm(clk_pwm),
        .clk_i2c(clk_i2c_slave),
        .rst_n(rst_n),
        .SCL_bus(scl),
        .capture(),
        .SDA_bus(sda),
        .address_set_pin(address_set_pin),

        .pwm_ch1_a_o     (pwm_ch1_a_o),
        .pwm_ch1_b_o     (pwm_ch1_b_o),
        .pwm_ch2_a_o     (pwm_ch2_a_o),
        .pwm_ch2_b_o     (pwm_ch2_b_o),
        .pwm_ch3_a_o     (pwm_ch3_a_o),
        .pwm_ch3_b_o     (pwm_ch3_b_o),
        .pwm_ch4_a_o     (pwm_ch4_a_o),
        .pwm_ch4_b_o     (pwm_ch4_b_o),
        .pwm_ch5_a_o     (pwm_ch5_a_o),
        .pwm_ch5_b_o     (pwm_ch5_b_o),
        .pwm_ch6_a_o     (pwm_ch6_a_o),
        .pwm_ch6_b_o     (pwm_ch6_b_o),
        .pwm_ch7_a_o     (pwm_ch7_a_o),
        .pwm_ch7_b_o     (pwm_ch7_b_o),
        .pwm_ch8_a_o     (pwm_ch8_a_o),
        .pwm_ch8_b_o     (pwm_ch8_b_o)
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
        $dumpvars(0,
            tb.sda,
            tb.scl,
        );
    `endif
    end

    // Kết nối SDA: master có thể drive low hoặc nhả ra
    assign sda = (sda_drive) ? 1'bz : 1'b0;

    // Clock 100 MHz
    initial begin
        clk_pwm = 0;
        forever #5 clk_pwm = ~clk_pwm;  // 100 MHz
    end

    // Clock 24 MHz
    initial begin
        clk_i2c_slave = 0;
        forever #(20.833) clk_i2c_slave = ~clk_i2c_slave;  // 24 MHz
    end

    // Clock nội bộ để generate SCL: 1Mhz
    initial begin
        clk = 0;
        forever #(500) clk = ~clk;  // 1Mhz (500 ns period)
    end

    always @(posedge clk) begin
        if (!scl_en)
            scl <= 1'b1;        // giữ high khi enable
        else
            scl <= ~scl;    // tạo xung khi disable
    end

    // Test sequence
    initial begin
        // Initialize
        SLAVE_ADD = 7'h50;
        address_set_pin = 3'd0;
        scl = 1;
        scl_en = 0;
        sda_drive = 1'b1;
        ack_respone = 0;
        error = 0;
        rst_n = 0;
        #2;
        rst_n = 1;
        #10;

        $display("run test");
        test_case();
        $finish;
    end

endmodule
