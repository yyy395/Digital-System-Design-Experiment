`timescale 1ns/1ps
module tongbu_tb;
reg clk;
reg in;
wire out;
tongbu tongbu1(.clk(clk),.in(in),.out(out));
//clock
always #50 clk=~clk;
initial
begin
    // Initialize Inputs
    clk = 0;
    in = 0;
    
    #(51) in=0;
    #(50) in=1;
    #(50) in=0;
    #(200)
    repeat(10)begin
        #(50*3) in=1;
        #(50) in=0;
    end
    #(100) $stop;
end
endmodule