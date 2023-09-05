module song_reader(clk,reset,play,song,note_done,song_done,note,duration,new_note);
input clk,reset;
input play;//高电平要求播放
input note_done;//表示一个音符播放结束并索取新音符
input [1:0]song;
output song_done;
output new_note;//新的音符需播放
output [5:0]note;//音符标记
output [5:0]duration;//音符的持续时间
//控制器
song_reader_c song_reader_c1(.clk(clk),.reset(reset),.note_done(note_done),.play(play),.new_note(new_note));
wire [4:0]q;//音符地址后五位
wire co;//32个音符播放完毕
//地址计数器
counter_n #(.n(32),.counter_bits(5)) counter_n1(.clk(clk),.r(reset),.en(note_done),.q(q),.co(co));
//乐曲选择
song_rom song_rom1(.clk(clk),.addr({song,q}),.dout({note,duration}));
wire [5:0]duration;
//结束判断
over over1(.clk(clk),.co(co),.duration(duration),.song_done(song_done));
endmodule