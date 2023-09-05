module song_reader_c(clk,reset,play,note_done,new_note);
input clk,reset,play,note_done;
output new_note;
parameter RESET=0,NEW_NOTE=1,WAIT=2,NEXT_NOTE=3;//状态编码
reg [1:0]state,nextstate;
reg new_note;
//D寄存器
always @(posedge clk)begin
    if(reset)
        state=RESET;
    else
        state=nextstate;
end
//下一状态和输出电路
always @(*)begin
    new_note=0;
    case(state)
        RESET:begin
            new_note=0;//默认值为0
            if(play)
                nextstate=NEW_NOTE;
            else
                nextstate=RESET;
        end
        NEW_NOTE:begin
            new_note=1;
            nextstate=WAIT;
        end
        WAIT:begin
            new_note=0;
            if(play)
                if(note_done)
                    nextstate=NEXT_NOTE;
                else
                    nextstate=WAIT;
            else
                nextstate=RESET;
        end
        NEXT_NOTE:begin
            new_note=0;
            nextstate=NEW_NOTE;
        end
        default:nextstate=RESET;
    endcase
end
endmodule