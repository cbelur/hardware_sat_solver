`timescale 1ns / 1ps

import common::*;

module Propagate_literal(input clock, reset, find, 
                        input lit in_lit, 
                        input formula in_formula, 
                        output ended, empty_clause, empty_formula, 
                        output formula out_formula);

typedef enum logic[2:0] {IDLE, BEGIN_OUTER, BEGIN_INNER, RUN_INNER, END_INNER, END_OUTER, DONE} state;

formula s_in_formula;
lit s_in_lit;
logic s_ended;
logic s_empty_clause;
logic s_empty_formula;
formula s_out_formula;
logic s_finding;
logic[width_clausearray:0] i; 
logic[width_litarray:0] j;
state present_state;
formula final_formula;
clause temp_clause;
logic[width_clausearray:0] num_clauses;
logic[width_litarray:0] num_lits;

assign ended = s_ended;
assign empty_clause = s_empty_clause;
assign empty_formula = s_empty_formula;
assign out_formula = s_out_formula;

always_ff@(posedge clock or posedge reset)
if (reset)
    begin
    s_in_formula <= zero_formula;
    s_in_lit <= zero_lit;
    s_ended <= 1'b0;
    s_empty_clause <= 1'b0;
    s_empty_formula <= 1'b0;
    s_out_formula <= zero_formula;
    s_finding <= 1'b0;
    i <= 1'b0;
    j <= 1'b0;
    present_state <= IDLE;
    final_formula <= zero_formula;
    temp_clause <= zero_clause;
    num_clauses <= 1'b0;
    num_lits <= 1'b0;
    end
else if (clock)
    begin
    s_ended <= 1'b0;
    if (find == 1'b1 & s_finding == 1'b0)
        begin
        s_in_formula <= in_formula;
        s_in_lit <= in_lit;
        s_finding <= 1'b1;
        s_ended <= 1'b0;
        present_state <= BEGIN_OUTER;
        end
    else if (s_finding == 1'b1)
        begin
        s_ended <= 1'b0;
        case (present_state)
            BEGIN_OUTER:
                begin
                final_formula <= zero_formula;
                num_clauses <= 1'b0;
                i <= 1'b0;
                present_state <= BEGIN_INNER;
                end
            BEGIN_INNER:
                begin
                if (i >= s_in_formula.len)
                    present_state <= END_OUTER;
                else
                    begin
                    temp_clause <= zero_clause;
                    num_lits <= 1'b0;
                    j <= 1'b0;
                    present_state <= RUN_INNER;
                    end
                end
            RUN_INNER:
                begin
                if (j >= s_in_formula.clauses[i].len)
                    present_state <= END_INNER;                    
                else
                    begin
                    if (s_in_formula.clauses[i].lits[j].num == s_in_lit.num)
                        begin
                        if (s_in_formula.clauses[i].lits[j].val == s_in_lit.val)
                            begin
                            i <= i+1;
                            present_state <= BEGIN_INNER;
                            end
                        else
                            begin
                            j <= j+1;
                            present_state <= RUN_INNER;
                            end
                        end
                    else if (s_in_formula.clauses[i].lits[j].num == 0)
                        begin
                        j <= j+1;
                        present_state <= RUN_INNER;
                        end
                    else
                        begin
                        temp_clause.lits[num_lits] <= s_in_formula.clauses[i].lits[j];
                        temp_clause.len <= num_lits + 1;
                        num_lits <= num_lits + 1;
                        j <= j+1;
                        present_state <= RUN_INNER;
                        end
                    end    
                end
            END_INNER:
                begin
                if (num_lits == 0)
                    begin
                    s_ended <= 1'b1;
                    s_finding <= 1'b0;
                    s_empty_clause <= 1'b1;
                    s_empty_formula <= 1'b0;
                    s_out_formula <= final_formula;
                    present_state <= DONE;
                    end
                else
                    begin
                    final_formula.clauses[num_clauses] <= temp_clause;
                    final_formula.len <= num_clauses+1;
                    num_clauses <= num_clauses+1;
                    i <= i+1;
                    present_state <= BEGIN_INNER;
                    end
                end
            END_OUTER:
                begin
                s_ended <= 1'b1;
                s_finding <= 1'b0;
                s_empty_clause <= 1'b0;
                s_out_formula <= final_formula;
                present_state <= DONE;
                if (num_clauses == 0)
                    s_empty_formula <= 1'b1;
                else
                    s_empty_formula <= 1'b0;    
                end
            DONE: present_state <= IDLE;
            default:
                begin
                s_ended <= 1'b1;
                s_finding <= 1'b0;
                s_empty_clause <= 1'b0;
                s_empty_formula <= 1'b0;
                s_out_formula <= zero_formula;
                present_state <= IDLE;
                end
        endcase
        end             
    end
endmodule