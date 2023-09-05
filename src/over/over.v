module over(co,clk,duration,song_done);
input co,clk;
input [5:0]duration;
output song_done;
wire q;
assign song_done=((co==1)||(duration==0))&&~q;//通过或门输出一个时钟周期的信号
//d触发器
dffre #(.n(1)) d1(.clk(clk),.en(1),.r(0),.d((co==1)||(duration==0)),.q(q));
endmodule//脉宽变换电路