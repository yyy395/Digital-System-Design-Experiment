module music_player #(parameter sim = 0)(clk,reset,play_pause,next,NewFrame,sample,play,song);
input clk,reset,play_pause,next,NewFrame;
output [15:0]sample;
output play;//高电平表示播放
output [1:0]song;
wire song_done;
wire reset_play;
wire play;
mcu mcu1(.clk(clk),.next(next),.play_pause(play_pause),.reset(reset),.song(song),.play(play),.reset_play(reset_play),.song_done(song_done));//主控制器
wire [5:0]duration;
wire [5:0]note;
wire new_note;
wire note_done;
//乐曲读取
song_reader song_reader1(.song(song),.play(play),.reset(reset_play),.note_done(note_done),.clk(clk),.song_done(song_done),.duration(duration),.note(note),.new_note(new_note));
wire beat;
wire ready;
//音符播放
note_player note_player1(.clk(clk),.reset(reset_play),.beat(beat),.play_enable(play),.note_to_load(note),.duration_to_load(duration),.load_new_note(new_note),.note_done(note_done),.sample(sample),.sampling_pulse(ready),.sample_ready());
//同步化电路
tongbu tongbu1(.clk(clk),.in(NewFrame),.out(ready));
//节拍基准产生器
counter_n #(.n(sim?64:1000),.counter_bits(sim?6:10))counter_n1(.clk(clk),.en(ready),.r(0),.q(),.co(beat));
endmodule
