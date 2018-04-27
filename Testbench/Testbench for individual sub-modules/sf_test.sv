`timescale 1ns / 1ps

import common::*;

module sf_test();
logic clock, reset, wr_en, pop; 
formula din, dout, front;
logic full, empty;

Stack_formula test1(clock, reset, wr_en, pop, din, full, empty, dout, front);

always
begin
clock=1'b1; #50; clock=1'b0; #50;
end

initial
begin
reset=1'b1; wr_en=1'b1; pop=1'b0; din='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
            {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b010,1'b0},{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b011},
            {{{3'b011,1'b0},zero_lit,zero_lit,zero_lit,zero_lit},3'b001}},4'b1010};
#70;
reset=1'b0; din='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
            {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b010,1'b0},{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b011},
            {{{3'b011,1'b0},zero_lit,zero_lit,zero_lit,zero_lit},3'b001}},4'b1010}; //push some formula
#100;
din=zero_formula; //push 0
#100;
din='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
            {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b010,1'b0},{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b011},
            {{{3'b011,1'b0},zero_lit,zero_lit,zero_lit,zero_lit},3'b001}},4'b1010}; //push some formula
#100;
din=zero_formula; //push 0
#100;
din='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
            {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b010,1'b0},{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b011},
            {{{3'b011,1'b0},zero_lit,zero_lit,zero_lit,zero_lit},3'b001}},4'b1010}; //push some formula
#100;
wr_en=1'b0; pop=1'b1; //pop all and do nothing for 400ns
#900;
wr_en=1'b1; pop=1'b0; din='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
            {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b010,1'b0},{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b011},
            {{{3'b011,1'b0},zero_lit,zero_lit,zero_lit,zero_lit},3'b001}},4'b1010}; //push some formula
#100;
din=zero_formula; //push 0
#100;
din='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
            {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b010,1'b0},{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b011},
            {{{3'b011,1'b0},zero_lit,zero_lit,zero_lit,zero_lit},3'b001}},4'b1010}; //push some formula
#100;
wr_en=1'b0; pop=1'b1; //pop
#100;
wr_en=1'b1; pop=1'b0; din=zero_formula; //push 0
#100;
wr_en=1'b0; pop=1'b1; //pop
#100;
wr_en=1'b1; pop=1'b0; din='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
            {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b010,1'b0},{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b011},
            {{{3'b011,1'b0},zero_lit,zero_lit,zero_lit,zero_lit},3'b001}},4'b1010}; //push some formula
#100;
wr_en=1'b0; pop=1'b1; //pop



end
endmodule