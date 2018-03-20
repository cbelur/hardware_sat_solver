package common;
`timescale 1ns / 1ps
parameter number_clauses = 10;
parameter number_literal = 5;
parameter width_litarray = $clog2(number_literal+1)-1;
parameter width_clausearray = $clog2(number_clauses+1)-1;
parameter lit_range_st = 0;
parameter lit_range_end = number_literal;
parameter bool_stack_size = number_literal;
parameter formula_stack_size = number_literal;
parameter width_bool_stack_size = $clog2(bool_stack_size)-1;

typedef struct packed {
     logic[width_litarray:0] num;
     logic val;
   } lit;

typedef lit[0:number_literal-1] lit_array;

typedef struct packed {
     lit_array lits;
     logic[width_litarray:0] len;
   } clause;

typedef clause[0:number_clauses-1] clause_array;

typedef struct packed {
     clause_array clauses;
     logic[width_clausearray:0] len;
   } formula;

typedef formula[0:formula_stack_size] formula_array;

const lit zero_lit = '{num:1'b0, val:1'b0};
const lit_array zero_lit_array = '{number_literal{zero_lit}};
const clause zero_clause = '{lits:zero_lit_array,len:1'b0};
const clause_array zero_clause_array = '{number_clauses{zero_clause}};
const formula zero_formula = '{clauses:zero_clause_array,len:1'b0};
const formula_array zero_formula_array = '{number_literal+1{zero_formula}};
endpackage : common