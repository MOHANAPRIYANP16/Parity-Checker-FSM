`timescale 1ns / 1ps

module top_module(
            input clk_in,  
            input reset,
            input data_in,     
            input valid,       
            input mode,   
            output parity_ok,
            output [3:0] counter
    );
    
    wire clk;
    clockdivider clk_div(.clk(clk),.clk_in(clk_in),.reset(reset));
    parity parok(.clk(clk),.reset(reset),.valid(valid),.mode(mode),.data_in(data_in),.parity_ok(parity_ok),.counter(counter));
    
endmodule
