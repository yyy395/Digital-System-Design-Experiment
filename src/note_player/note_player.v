module note_player(clk,reset,play_enable,note_to_load,duration_to_load,load_new_note,note_done,sampling_pulse,beat,sample,sample_ready);
input clk;//系统时钟信号，外接sys_clk
input reset,play_enable,load_new_note,sampling_pulse;
input beat;//定时基准信号，频率为48Hz脉冲，一个时钟周期宽度的高电平脉冲
input [5:0]note_to_load;
input [5:0]duration_to_load;
output note_done,sample_ready;
output [15:0]sample;
wire r;
assign r=~play_enable||reset;
wire timer_clear;//清零信号
wire timer_done;//定时结束标志
//控制器
note_player_c note_player_c1(.clk(clk),.reset(reset),.play_enable(play_enable),.load_new_note(load_new_note),.note_done(note_done),.timer_clear(timer_clear),.timer_done(timer_done),.load(load));
wire [5:0]q;
//d触发器
dffre #(.n(6)) d1(.r(r),.en(load),.d(note_to_load),.clk(clk),.q(q));
wire [19:0]dout;
//FreqROM
frequency_rom frequency_rom1(.clk(clk),.addr(q),.dout(dout));
//DDS
dds dds1(.clk(clk),.sampling_pulse(sampling_pulse),.k({2'b00,dout}),.reset(r),.sample(sample),.new_sample_ready(sample_ready));
//音符节拍定时器
timer #(.counter_bits(6)) timer1(.clk(clk),.r(timer_clear),.en(beat),.q(duration_to_load),.done(timer_done));
endmodule