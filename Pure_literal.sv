`timescale 1ns / 1ps

import common::*;

module Pure_literal(input clock, reset,
                  input formula in_formula,
                  input find,
                  output ended, found,
                  output lit lit_found);

formula s_in_formula;
logic s_ended;
logic s_found;
lit s_lit_found;
logic s_finding;
logic [0:number_literal-1] s_val_set, s_val, s_is_pure;
logic [width_clausearray:0] oiterator;
logic [width_litarray:0] iiterator, piterator;


assign ended = s_ended;
assign found = s_found;
assign lit_found = s_lit_found;


always_ff@(posedge clock or posedge reset)
if (reset)
    begin
    s_in_formula <= zero_formula;
    s_ended <= 1'b0;
    s_found <= 1'b0;
    s_lit_found <= zero_lit;
    s_finding <= 1'b0;
    s_val_set <= 1'b0;
    s_val <= 1'b0;
    s_is_pure <= 1'b0;
    oiterator <= 1'b0;
    iiterator <= 1'b0;
    piterator <= 1'b0;
    end
else if (clock)
    begin
    s_ended <= 1'b0;
    if (find == 1'b1 & s_finding == 1'b0)
        begin
        s_in_formula <= in_formula;
        s_finding <= 1'b1;
        s_ended <= 1'b0;
        oiterator <= 1'b0;
        iiterator <= 1'b0;
        piterator <= 1'b0;
        s_val_set <= 1'b0;
        s_val <= 1'b0;
        s_is_pure <= '{number_literal{1}};
        end
    else if (s_finding == 1)
        begin
        if (oiterator < s_in_formula.len)
            begin
            if (iiterator < s_in_formula.clauses[oiterator].len)
                begin
                if (s_is_pure[s_in_formula.clauses[oiterator].lits[iiterator].num-1] == 1)
                    begin
                    if (s_val_set[s_in_formula.clauses[oiterator].lits[iiterator].num-1] == 1)
                        begin
                        if (s_val[s_in_formula.clauses[oiterator].lits[iiterator].num-1] != s_in_formula.clauses[oiterator].lits[iiterator].val)
                            begin
                            s_is_pure[s_in_formula.clauses[oiterator].lits[iiterator].num-1] <= 1'b0;
                            end
                        end
                    else
                        begin
                        s_val[s_in_formula.clauses[oiterator].lits[iiterator].num-1] <= s_in_formula.clauses[oiterator].lits[iiterator].val;
                        s_val_set[s_in_formula.clauses[oiterator].lits[iiterator].num-1] <= 1'b1;
                        end
                    end
                iiterator <= iiterator + 1;
                end
            else
                begin
                iiterator <= 1'b0;
                oiterator <= oiterator + 1;                
                end    
            end
        else
            begin
            if (piterator < number_literal)
                begin
                if (s_is_pure[piterator] == 0 | s_val_set[piterator] == 0)
                    begin
                    piterator <= piterator + 1;
                    end
                else
                    begin
                    s_lit_found.num <= piterator + 1;
                    s_lit_found.val<= s_val[piterator];
                    s_finding <= 1'b0;
                    s_found <= 1'b1;
                    s_ended <= 1'b1;
                    end
                end
            else
                begin
                s_finding <= 1'b0;
                s_found <= 1'b0;
                s_ended <= 1'b1;
                end
            end
        end        
    end
endmodule