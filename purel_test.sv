`timescale 1ns / 1ps

import common::*;

module purel_test();
logic clock, reset, find;
lit lit_found;
formula in_formula;
logic ended, found;

Pure_literal test1(clock, reset, in_formula, find, ended, found, lit_found);

always
begin
clock=1'b1; #50; clock=1'b0; #50;
end

initial
begin
reset=1'b1; find=1'b0; in_formula='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b011,1'b1},{3'b100,1'b1},{3'b101,1'b1}},3'b101},
            {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
            {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
            {{{3'b001,1'b1},zero_lit,zero_lit,zero_lit,zero_lit},3'b001},
            {{{3'b010,1'b1},zero_lit,zero_lit,zero_lit,zero_lit},3'b001},
            {{{3'b011,1'b1},zero_lit,zero_lit,zero_lit,zero_lit},3'b001},
            {{{3'b100,1'b1},zero_lit,zero_lit,zero_lit,zero_lit},3'b001},
            {{{3'b010,1'b0},{3'b011,1'b0},{3'b100,1'b1},zero_lit,zero_lit},3'b011},
            {{{3'b011,1'b0},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010}},4'b1010};
            
/*reset=1'b1; find=1'b0; in_formula='{{{{{3'b001,1'b1},{3'b010,1'b1},{3'b101,1'b1},zero_lit,zero_lit},3'b011},
                        {{{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit,zero_lit},3'b010},
                        {{{3'b001,1'b0},{3'b010,1'b0},{3'b101,1'b0},zero_lit,zero_lit},3'b011},
                        {{{3'b001,1'b1},{3'b010,1'b1},zero_lit,zero_lit,zero_lit},3'b010},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000},
                        {{zero_lit,zero_lit,zero_lit,zero_lit,zero_lit},3'b000}},4'b0100};*/
   
#70;
reset=1'b0; find=1'b1;
end
endmodule
