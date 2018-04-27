`timescale 1ns / 1ps

import common::*;

module dbk_test();
logic clock, reset, find;
formula in_formula, out_formula;
logic ended, sat, unsat, propagating;
lit out_lit;

DB_kernel test1(clock, reset, find, in_formula, ended, out_formula, sat, unsat, propagating, out_lit);

always
begin
clock=1'b1; #50; clock=1'b0; #50;
end

initial
begin
reset=1'b1; find=1'b0;
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
#60;
reset=1'b0; find=1'b1; in_formula='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
            {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b010,1'b0},{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b011},
            {{{3'b011,1'b0},zero_lit,zero_lit,zero_lit,zero_lit},3'b001}},4'b1010};
#500;find=1'b0;

end
endmodule