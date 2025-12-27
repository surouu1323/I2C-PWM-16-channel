//=====================================================================
// Module: pwm_prescaler
// Description: PWM prescaler counter that divides input clock to
//              generate CK_CNT (clock enable) signal.
// Author: [Your Name]
// Standard: ARM / Intel / Xilinx Vivado HDL Naming Convention
//=====================================================================
module pwm_prescaler #(
    parameter integer WIDTH = 16
)(
    // Clock & Reset
    input  wire                 clk_psc_i,       // Input prescaler clock
    input  wire                 rst_n_i,         // Active-low reset

    // Control inputs
    input  wire                 cen_i,           // Counter enable
    input  wire [WIDTH-1:0] psc_preload_i,   // Prescaler preload value
    input  wire                 update_event_i,

    // Outputs
    output reg                  ck_cnt_o        // Clock enable pulse
    
);

    //-----------------------------------------------------------------
    // Internal registers
    //-----------------------------------------------------------------
    reg [WIDTH-1:0] psc_counter_reg;
    reg [WIDTH-1:0] psc_shadow_reg;
    // reg                  uev_o;            // Update event flag

    //-----------------------------------------------------------------
    // Shadow register and UEV (update event)
    //-----------------------------------------------------------------
    // Khi bộ đếm đạt giá trị preload => phát update event (UEV)
    // Dùng synchronous logic chuẩn (chỉ 1 clock edge)
    // always @(posedge clk_psc_i or negedge rst_n_i) begin
    //     if (!rst_n_i) begin
    //         psc_shadow_reg <= {WIDTH{1'b0}};
    //         // uev_o          <= 1'b0;
    //     end else begin
    //         if (psc_counter_reg >= psc_shadow_reg || cen_i == 0) begin
    //             psc_shadow_reg <= psc_preload_i;
    //             // uev_o          <= 1'b1;
    //         end else begin
    //             // uev_o          <= 1'b0;
    //         end
    //     end
    // end

    always @(posedge clk_psc_i or negedge rst_n_i) begin
        if (!rst_n_i)                   psc_shadow_reg <= {WIDTH{1'b0}};
        else if( update_event_i)        psc_shadow_reg <= psc_preload_i; // Reload shadow when counter disabled or overflow occurred
        else                            psc_shadow_reg <= psc_shadow_reg;
    end

    //-----------------------------------------------------------------
    // Main prescaler counter
    //-----------------------------------------------------------------
    // Tạo xung CK_CNT mỗi khi đếm đủ PSC preload
    always @(posedge clk_psc_i or negedge rst_n_i) begin
        if (!rst_n_i) begin
            psc_counter_reg <= {WIDTH{1'b0}};
            ck_cnt_o        <= 1'b0;
        end else if (!cen_i) begin
            // Disable counter when not enabled
            psc_counter_reg <= {WIDTH{1'b0}};
            ck_cnt_o        <= 1'b0;
        end else if (psc_preload_i == {WIDTH{1'b0}}) begin
            // Nếu preload = 0 => chia = 1 (luôn cho phép)
            ck_cnt_o        <= 1'b1;
            psc_counter_reg <= {WIDTH{1'b0}};
        end else begin
            if (psc_counter_reg >= psc_shadow_reg) begin
                psc_counter_reg <= {WIDTH{1'b0}};
                ck_cnt_o        <= 1'b1;
            end else begin
                psc_counter_reg <= psc_counter_reg + 1'b1;
                ck_cnt_o        <= 1'b0;
            end
        end
    end

endmodule
