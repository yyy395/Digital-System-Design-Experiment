module fulladder_n(a,b,s,ci,co);
parameter n=1;
input [n-1:0]a;
input [n-1:0]b;
output [n-1:0]s;
input ci;
output co;
reg [n-1:0]s;
reg co;
always @(*)
begin
    {co,s}=a+b;
end
endmodule