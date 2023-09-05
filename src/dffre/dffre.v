module dffre(d,en,r,clk,q);
parameter n = 1;//n=1为d触发器，n>1为n为d寄存器
input [n-1:0]d;
input en,r,clk;
output [n-1:0]q;
reg [n-1:0]q;
always @ (posedge clk)begin
    if(r)begin
        q = {n{1'b0}};//复位置零
    end
    else if(en)
        q = d;
    else 
        q = q;
end
endmodule
