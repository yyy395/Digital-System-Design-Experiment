module mcu(clk,reset,play_pause,next,play,reset_play,song_done,song);
input clk;//100MHz时钟信号
input reset,play_pause,next;
input song_done;//一个周期宽度的高电平脉冲，表示乐曲播放结束
output play,reset_play;
output [1:0]song;//当前播放乐曲的序号
wire nextsong;//下一首播放
mcu_c mcu_c1(.clk(clk),.reset(reset),.play_pause(play_pause),.next(next),.play(play),.reset_play(reset_play),.song_done(song_done),.nextsong(nextsong));//控制器
counter_n #(.n(4),.counter_bits(2))counter_n1(.en(nextsong),.r(reset),.clk(clk),.q(song),.co());//二位二进制计数器
endmodule