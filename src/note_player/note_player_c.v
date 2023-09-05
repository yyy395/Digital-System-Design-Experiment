module note_player_c(clk,reset,play_enable,load_new_note,timer_clear,timer_done,note_done,load);
input clk,reset,play_enable,load_new_note,timer_done;
output note_done,timer_clear,load;
parameter RESET=0,WAIT=1,DONE=2,LOAD=3;//状态编码
reg [1:0]state,nextstate;
reg timer_clear;
reg load;
reg note_done;
//D寄存器
always @(posedge clk)begin
    if(reset)
        state=RESET;
    else
        state=nextstate;
end
//下一状态和输出电路
always @(*)begin
    timer_clear=0;load=0;note_done=0;//默认值为0
    case(state)
        RESET:begin
            timer_clear=1;
            load=0;
            note_done=0;
            nextstate=WAIT;
        end
        WAIT:begin
            timer_clear=0;
            load=0;
            note_done=0;
            if(play_enable)begin
                if(timer_done)begin
                    nextstate=DONE;
                end
                else
                begin
                    if(load_new_note)
                        nextstate=LOAD;
                    else
                        nextstate=WAIT;
                end
                    
            end
            else
                nextstate=RESET;
        end
        DONE:begin
            timer_clear=1;
            load=0;
            note_done=1;
            nextstate=WAIT;
        end
        LOAD:begin
            timer_clear=1;
            load=1;
            note_done=0;
            nextstate=WAIT;
        end
    endcase
end
endmodule
            
