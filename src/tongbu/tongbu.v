module tongbu(in,clk,out);
input in,clk;
output out;
wire q0,q1;
assign out = q0&&~q1;//与门实现输出一个时钟周期长度的信号
dffre #(.n(1)) d1(.d(in),.q(q0),.en(1),.r(0),.clk(clk));
dffre #(.n(1)) d2(.d(q0),.clk(clk),.en(1),.r(0),.q(q1));
endmodule//同步化电路