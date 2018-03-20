`timescale 1ns / 1ps

import common::*;

module uc_test();
logic clock, reset, find;
formula in_formula;
logic ended, found;
lit lit_found;

Unit_Clause test1(clock, reset, find, in_formula, ended, found, lit_found);

always
begin
clock=1'b1; #50; clock=1'b0; #50;
end

initial
begin
reset=1'b1; find=1'b1;
in_formula='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
            {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b010,1'b0},{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b011},
            {{{3'b011,1'b0},zero_lit,zero_lit,zero_lit,zero_lit},3'b001}},4'b1010};
#160;
reset=1'b0; find=1'b1;
#100;
reset=1'b0; find=1'b1; 



end
endmodule