`timescale 1ns / 1ps

import common::*;

module read_store(input clock, reset, load,
                  input[number_literal-1:0] i,
                  output formula formula_res, 
                  output logic ended);
                  
formula temp_formula;
typedef logic[0:2*number_clauses-1][0:number_literal-1] mem_type;
mem_type bit_vec;
logic[$clog2(2*number_clauses)-1:0] noofcycles;
logic[width_clausearray:0] noofclauses;
logic prev_load;
logic prev_load1;
logic[width_clausearray:0] oiterator;
logic[width_litarray:0] iiterator;
logic[width_litarray:0] row_iterator;
logic computing;
logic finished;

always_ff@(posedge clock or posedge reset)
if(reset)
    begin
    temp_formula <= zero_formula;
    bit_vec <= 1'b0;
    noofcycles <= 1'b0;
    prev_load <= 1'b0;
    prev_load1 <= 1'b0;
    noofclauses <= 1'b0;
    oiterator <= 1'b0;
    iiterator <= 1'b0;
    row_iterator <= 1'b0;
    computing <= 1'b0;
    finished <= 1'b0;
    end
else if (clock)
    begin
    prev_load <= load;
    prev_load1 <= prev_load;
    ended <= 1'b0;
    if (load == 1'b1 & computing == 1'b0)
        begin
        bit_vec[noofcycles] <= i;
        noofcycles <= noofcycles+1;
        ended <= 1'b0;
        end
    else if (load == 1'b0 & prev_load == 1'b1)
        ended <= 1'b0;
    else if (load == 1'b0 & prev_load == 1'b0 & prev_load1 == 1'b1 & computing == 1'b0)
        begin
        computing <= 1'b1;
        noofclauses <= noofcycles/2;
        temp_formula.len <= noofcycles/2;
        ended <= 1'b0;
        end
    else if (computing == 1'b1)
        begin
        if (oiterator < noofclauses)
            begin
            if (iiterator < number_literal)
                begin
                if (bit_vec[2*oiterator][iiterator] == 1'b1 & bit_vec[2*oiterator+1][iiterator] == 1'b0)
                    begin
                    temp_formula.clauses[oiterator].lits[row_iterator].num <= iiterator + 1;
                    temp_formula.clauses[oiterator].lits[row_iterator].val <= 1'b1;
                    row_iterator <= row_iterator + 1;
                    end
                else if (bit_vec[2*oiterator][iiterator] == 1'b0 & bit_vec[2*oiterator+1][iiterator] == 1'b1)
                    begin
                    temp_formula.clauses[oiterator].lits[row_iterator].num <= iiterator + 1;
                    temp_formula.clauses[oiterator].lits[row_iterator].val <= 1'b0;
                    row_iterator <= row_iterator + 1;
                    end
                iiterator <= iiterator + 1;
                end
            else
                begin
                if (row_iterator == 1'b0)
                    begin
                    temp_formula.len <= temp_formula.len - 1;
                    end
                iiterator <= 1'b0;
                temp_formula.clauses[oiterator].len <= row_iterator;
                row_iterator <= 1'b0;
                oiterator <= oiterator + 1;                
                end  
            end
        else
            begin
            computing <= 1'b0;
            finished <= 1'b1;
            end
        ended <= 1'b0;
        end
    else if (finished == 1'b1)
        begin
        formula_res <= temp_formula;
        ended <= 1'b1;
        end
    end
endmodule
