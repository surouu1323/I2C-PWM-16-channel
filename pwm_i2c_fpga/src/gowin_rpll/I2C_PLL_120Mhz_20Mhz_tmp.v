//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9.03 Education (64-bit)
//Part Number: GW2AR-LV18QN88C8/I7
//Device: GW2AR-18
//Device Version: C
//Created Time: Tue Nov 18 17:49:39 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    I2C_PLL_120Mhz_20Mhz your_instance_name(
        .clkout(clkout), //output clkout
        .clkoutd(clkoutd), //output clkoutd
        .reset(reset), //input reset
        .clkin(clkin) //input clkin
    );

//--------Copy end-------------------
