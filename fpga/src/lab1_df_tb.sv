// Daniel Fajardo
// dfajardo@g.hmc.edu
// 09/09/2024
//
// testbench for top level module
`timescale 1ns/1ns
`default_nettype none
`define N_TV 8
module lab1_df_tb();
    logic clk;
    logic mcu_blink_in;
    logic [3:0] s;
    logic mcu_echo_led;
    logic [6:0] seg;
    logic [2:0] led;

    top dut(.clk(clk),.mcu_blink_in(mcu_blink_in),.s(s),.mcu_echo_led(mcu_echo_led),.seg(seg),.led(led));

	always begin
        clk = 1; #5;
        clk = 0; #5;
        end

    initial begin
        mcu_blink_in = 0;
        s = 4'b0000; #100;
        s = 4'b0001; #100;
        s = 4'b0000; #100;
        s = 4'b1011; #100;
    end


endmodule
