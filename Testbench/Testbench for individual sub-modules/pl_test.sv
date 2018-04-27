`timescale 1ns / 1ps

import common::*;

module pl_test();
logic clock, reset, find;
lit in_lit;
formula in_formula;
formula out_formula;
logic ended, empty_clause, empty_formula;

Propagate_literal test1(clock, reset, find, in_lit, in_formula, ended, empty_clause, empty_formula, out_formula);

always
begin
clock=1'b1; #50; clock=1'b0; #50;
end

initial
begin
reset=1'b1; find=1'b0; in_lit='{3'b001,1'b1}; in_formula='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
            {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},zero_lit,zero_lit,zero_lit,zero_lit},3'b001},
            {{{3'b010,1'b1},zero_lit,zero_lit,zero_lit,zero_lit},3'b001},
            {{{3'b011,1'b1},zero_lit,zero_lit,zero_lit,zero_lit},3'b001},
            {{{3'b100,1'b1},zero_lit,zero_lit,zero_lit,zero_lit},3'b001},
            {{{3'b010,1'b0},{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b011},
            {{{3'b011,1'b0},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010}},4'b1010};
#160;
reset=1'b0; find=1'b0;
#100;
reset=1'b0; find=1'b1; 

            
/* in_formula='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},zero_lit},3'b011},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b100,1'b1},zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit},3'b010},
            {{{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b010}},3'b100}; */   
            
/* in_formula='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
                        {{{3'b001,1'b1},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
                        {{{3'b001,1'b1},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
                        {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000}},4'b0100};*/
            
end
endmodule
