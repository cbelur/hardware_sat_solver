`timescale 1ns / 1ps

import common::*;

module Stack_bool(input clock, reset, wr_en, pop, din,
                  output dout, front, full, empty);
                  
typedef logic[bool_stack_size-1:0] mem_type;
mem_type data;
logic[width_bool_stack_size:0] curr_size;

logic data_in, data_out, full_signal, empty_signal, front_signal;

assign data_in = din;
assign dout = data_out;
assign full = full_signal;
assign empty = empty_signal;
assign front = front_signal;
always_ff@(posedge clock or posedge reset)
if (reset)
    begin
    data <= 1'b0;
    curr_size <= 1'b0;
    data_out <= 1'b0;
    empty_signal <= 1'b1;
    full_signal <= 1'b0;
    front_signal <= 1'b0;
    end
else if (clock)
    begin
    //PUSH
    if (wr_en == 1'b1 & full_signal == 1'b0)
        begin
        data[curr_size] <= data_in;
        curr_size <= curr_size+1;
        front_signal <= data_in;
        empty_signal <= 1'b0;
        if (curr_size+1 >= bool_stack_size)
            begin
            full_signal <= 1'b1;
            end
        else
            begin
            full_signal <= 1'b0;
            end
        end
    //POP
     else if (pop == 1'b1 & empty_signal == 1'b0)
        begin
        if (curr_size > 1'b0)
            begin
            curr_size <= curr_size-1;
            data_out <= data[curr_size-1];
            end
        front_signal <= data[curr_size-2];
        full_signal <= 1'b0;
        if (curr_size == 1'b0)
            begin
            empty_signal <= 1'b1;
            end
        else
            begin
            empty_signal <= 1'b0;
            end
        end
    end
endmodule
