# Đặt tên module
set module tb.uut

# Danh sách tín hiệu trong module đó
set sig_list [list \
    $module.clk_psc_i \
    \
    $module.rst_n_i \
    $module.u_pwm_core.cnt_val_w \
    \
    $module.pwm_ch1_a_o \
    $module.pwm_ch1_b_o \
]

# Thêm các tín hiệu vào waveform
gtkwave::addSignalsFromList $sig_list


# Đặt tất cả tín hiệu sang định dạng thập phân
gtkwave::/Edit/Highlight_All
gtkwave::/Edit/Data_Format/Decimal