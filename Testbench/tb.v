`timescale 1ns/1ps

module tb();

    reg clk;
    reg reset;
    reg data_in;
    reg valid;
    reg mode;
    wire parity_ok;
    wire [3:0] counter;
    
    parity u1 (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .valid(valid),
        .mode(mode),
        .parity_ok(parity_ok),
        .counter(counter)
        
    );

    initial begin
        clk = 0;
        forever #5 clk  = ~clk;
    end
    initial begin
        
        reset = 1;
        valid = 0;
        mode = 0;        
        data_in = 0;
        #10;
        reset = 0;
        valid = 1;

        data_in = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 0; #10;
        data_in = 0; #10;   
        data_in = 1; #10;
        
      #10 $finish;

    end
    initial begin
        $dumpfile("parity.vcd");
        $dumpvars(0, tb);
    end
    initial begin
                $monitor("time =%0t ,clk%b ,reset = %b,mode = %b,valid = %b, data_in =%b,counter = %d,parity_ok =%b", $time, clk, reset,mode,valid, data_in, counter, parity_ok);
    end

endmodule
