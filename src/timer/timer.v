module timer(r,en,done,q,clk);
parameter counter_bits=4;
input r,en,clk;
output done;
input [counter_bits-1:0]q;//计时长度
reg [counter_bits-1:0]p;
assign done = en&&(p==(q-1));
always @ (posedge clk)begin
    if(r)
        p = 0;
   else if(en)
   begin
       if(p==(q-1))
       p=0;
       else
       p=p+1;
   end
end
endmodule
