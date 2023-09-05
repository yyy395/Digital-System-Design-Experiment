module counter_n(r,en,co,q,clk);
parameter n = 2;
parameter counter_bits=1;
input r,en,clk;
output co;
output [counter_bits-1:0]q;
reg [counter_bits-1:0]q=0;
assign co=(q==(n-1))&& en;//进位输出
always @ (posedge clk)begin
    if(r==1)
        q <= 0;//复位
   else if(en)
   begin
       if(q==(n-1))
       q=0;//同步清零
       else
       q=q+1;
   end
end
endmodule
