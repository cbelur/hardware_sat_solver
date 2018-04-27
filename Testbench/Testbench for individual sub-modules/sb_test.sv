`timescale 1ns / 1ps

import common::*;

module sb_test();
logic clock, reset, wr_en, pop, din;
logic dout, front, full, empty;

Stack_bool test1(clock, reset, wr_en, pop, din, dout, front, full, empty);

always
begin
clock=1'b1; #50; clock=1'b0; #50;
end

initial
begin
reset=1'b1; wr_en=1'b1; pop=1'b0; din=1'b1;
#70;
reset=1'b0; din=1'b1; //push 1
#100;
din=1'b0; //push 0
#100;
din=1'b1; //push 1
#100;
din=1'b0; //push 0
#100;
din=1'b1; //push 1
#100;
wr_en=1'b0; pop=1'b1; //pop all and do nothing for 400ns
#900;
wr_en=1'b1; pop=1'b0; din=1'b1; //push 1
#100;
din=1'b0; //push 0
#100;
din=1'b1; //push 1
#100;
wr_en=1'b0; pop=1'b1; //pop
#100;
wr_en=1'b1; pop=1'b0; din=1'b1; //push 1
#100;
wr_en=1'b0; pop=1'b1; //pop
#100;
wr_en=1'b1; pop=1'b0; din=1'b1; //push 1
#100;
wr_en=1'b0; pop=1'b1; //pop



end
endmodule