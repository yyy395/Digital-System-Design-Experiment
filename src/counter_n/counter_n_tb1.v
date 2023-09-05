`timescale 1ns/1ps
module counter_n_tb1;
reg clk;
reg en;
reg r;
wire co;
wire [3:0]q;
counter_n #(.n(14),.counter_bits(4))i1(.clk(clk),.r(r),.en(en),.q(q),.co(co));
always #50 clk=~clk;
initial
begin
    clk = 0;
    r = 0;
    en = 0;
    #(51)r=1;
    #(100)r=0;en=1;
    #(800)
    repeat(20)begin
        #(100*3)en=1;
        # 100 en=0;
    end
    # 100 $stop;
end
endmodule