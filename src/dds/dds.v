module dds(k,clk,reset,sampling_pulse,sample,new_sample_ready);
input [21:0]k;//相位增量
input clk,reset,sampling_pulse;
output [15:0]sample;//正弦信号
output new_sample_ready;
wire [21:0]raw_addr;//地址处理输入
wire [21:0]s;//加法器输出
fulladder_n #(.n(22))addr1(.a(k),.b(raw_addr),.ci(0),.s(s),.co());
dffre #(.n(22))dffre1(.d(s),.clk(clk),.en(sampling_pulse),.r(reset),.q(raw_addr));
wire [9:0]rom_addr;//ROM地址
assign rom_addr[9:0] = raw_addr[20]?((raw_addr[20:10]==1024)?1023:(~raw_addr[19:10]+1)):raw_addr[19:10];//地址处理
wire [15:0]raw_data;//ROM输出
sine_rom sine_rom1(.clk(clk),.addr(rom_addr),.dout(raw_data));
wire area;//正弦区域
dffre #(.n(1))dffre2(.d(raw_addr[21]),.en(1),.r(0),.clk(clk),.q(area));
wire [15:0]data;//正弦样品data
assign data[15:0] = area?(~raw_data[15:0]+1):raw_data[15:0];//数据处理
dffre #(.n(16))dffre3(.d(data),.clk(clk),.en(sampling_pulse),.r(0),.q(sample));
dffre #(.n(1))dffre4(.d(sampling_pulse),.clk(clk),.en(1),.r(0),.q(new_sample_ready));
endmodule

