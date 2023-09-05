module mcu_c(clk,reset,play_pause,next,play,reset_play,song_done,nextsong);
input clk,reset,play_pause,next,song_done;
output play,reset_play,nextsong;
parameter RESET=0,PAUSE=1,PLAY=2,NEXT=3;//状态编码
reg [1:0]state,nextstate;
reg play;
reg reset_play;
reg nextsong;
//D寄存器
always @(posedge clk)begin
    if(reset)
        state=RESET;
    else
        state=nextstate;
end
//下一状态和输出电路
always @(*)begin
    play=0;nextsong=0;reset_play=0;//默认值为0
    case(state)
        RESET:begin 
            play=0;
            nextsong=0;
            reset_play=1;
            nextstate=PAUSE;
        end
        PAUSE:begin
            play=0;
            nextsong=0;
            reset_play=0;
            if(play_pause)
                nextstate=PLAY;
            else begin
                if(next)
                    nextstate=NEXT;
                else
                    nextstate=PAUSE;
            end
        end
        PLAY:begin
            play=1;
            nextsong=0;
            reset_play=0;
            if(play_pause)
                nextstate=PAUSE;
            else begin
                if(next)
                    nextstate=NEXT;
                else begin
                    if(song_done)
                        nextstate=RESET;
                    else
                        nextstate=PLAY;
                end
            end
        end
        NEXT:begin
            play=0;
            nextsong=1;
            reset_play=1;
            nextstate=PLAY;
        end
        default:nextstate=RESET;
    endcase
end
endmodule