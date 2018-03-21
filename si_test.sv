`timescale 1ns / 1ps

import common::*;

module si_test();
logic clock, reset, wr_en, pop; 
lit din, dout, front;
logic full, empty;

Stack_integer test1(clock, reset, wr_en, pop, din, full, empty, dout, front);

always
begin
clock=1'b1; #50; clock=1'b0; #50;
end

initial
begin
reset=1'b1; wr_en=1'b1; pop=1'b0; din='{3'b001,1'b1};
#70;
reset=1'b0; din='{3'b001,1'b1}; //push some lit
#100;
din=zero_lit; //push 0
#100;
din='{3'b001,1'b1}; //push some lit
#100;
din=zero_lit; //push 0
#100;
din='{3'b001,1'b1}; //push some lit
#100;
wr_en=1'b0; pop=1'b1; //pop all and do nothing for 400ns
#900;
wr_en=1'b1; pop=1'b0; din='{3'b001,1'b1}; //push some lit
#100;
din=zero_lit; //push 0
#100;
din='{3'b001,1'b1}; //push some lit
#100;
wr_en=1'b0; pop=1'b1; //pop
#100;
wr_en=1'b1; pop=1'b0; din=zero_lit; //push 0
#100;
wr_en=1'b0; pop=1'b1; //pop
#100;
wr_en=1'b1; pop=1'b0; din='{3'b001,1'b1}; //push some formula
#100;
wr_en=1'b0; pop=1'b1; //pop

end
endmodule