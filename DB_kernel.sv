`timescale 1ns / 1ps

import common::*;

module DB_kernel(input clock, reset, find,
                 input formula in_formula,
                 output ended,
                 output formula out_formula,
                 output sat, unsat, propagating,
                 output lit out_lit

    );
formula s_in_formula, s_out_formula;
lit s_out_lit, C;
logic s_sat, s_unsat, s_finding, s_temp_found, s_ended, s_propagating;

typedef enum logic[3:0] {UC_b, UC_r, UC_e, PL_b, PL_r, PL_e, PROP_b, PROP_r, PROP_e, IDLE} state;
state present_state, called_from_state;

lit UC_lit_found;
logic UC_find, UC_ended, UC_found;
lit PL_lit_found;
logic PL_find, PL_ended, PL_found;
logic PropL_find, PropL_ended, PropL_empty_clause, PropL_empty_formula;
lit PropL_in_lit;
formula PropL_out_formula;

Unit_Clause unitclause(.clock(clock), .reset(reset), .find(UC_find), .in_formula(s_in_formula), .ended(UC_ended), .found(UC_found), .lit_found(UC_lit_found));
Pure_literal pureliteral(.clock(clock), .reset(reset), .find(PL_find), .in_formula(s_in_formula), .ended(PL_ended), .found(PL_found), .lit_found(PL_lit_found));
Propagate_literal propagateliteral_dbk(.clock(clock), .reset(reset), .find(PropL_find), .in_formula(s_in_formula), .in_lit(PropL_in_lit), .ended(PropL_ended), .empty_clause(PropL_empty_clause), .empty_formula(PropL_empty_formula), .out_formula(PropL_out_formula));

assign ended = s_ended;
assign out_formula = s_out_formula;
assign sat = s_sat;
assign unsat = s_unsat;
assign propagating = s_propagating;
assign out_lit = s_out_lit;

always_ff@(posedge clock or posedge reset)
if (reset)
    begin
    s_ended <= 1'b0;
    s_sat <= 1'b0;
    s_unsat <= 1'b0;
    s_out_formula <= zero_formula;
    s_propagating <= 1'b0;
    s_out_lit <= zero_lit;
    s_in_formula <= zero_formula;
    s_finding<= 1'b0;
    present_state <= IDLE;
    called_from_state <= IDLE;
    UC_find <= 1'b0;
    PL_find <= 1'b0;
    PropL_find <= 1'b0;
    PropL_in_lit <= zero_lit;
    end
else if (clock)
    begin
    s_ended <= 1'b0;
    UC_find <= 1'b0;
    PL_find <= 1'b0;
    PropL_find <= 1'b0;
    if (find == 1 & s_finding == 0)
        begin
        s_in_formula <= in_formula;
        s_finding <= 1'b1;
        s_ended <= 1'b0;
        present_state <= UC_b;
        s_sat <= 1'b0;
        s_unsat <= 1'b0;
        s_out_formula <= zero_formula;
        s_propagating <= 1'b0;
        s_out_lit <= zero_lit;
        end
    else if (s_finding == 1)
        begin
        s_ended <= 1'b0;
        s_propagating <= 1'b0;
        case (present_state)
            UC_b:
                begin
                if (s_in_formula == zero_formula)
                    begin
                    s_ended <= 1'b1;
                    s_sat <= 1'b1;
                    s_unsat <= 1'b0;
                    s_propagating <= 1'b0;
                    s_out_formula <= s_in_formula;
                    present_state <= IDLE;
                    s_finding <= 1'b0;
                    end
                else
                    begin
                    UC_find <= 1'b1;
                    present_state <= UC_r;
                    end
                end
            UC_r:
                begin
                if (UC_ended == 1)
                    begin
                    C <= UC_lit_found;
                    s_temp_found <= UC_found;
                    present_state <= UC_e;
                    end
                end
            UC_e:
                begin
                if (s_temp_found == 1)
                    begin
                    called_from_state <= UC_b;
                    present_state <= PROP_b;
                    end
                else
                    present_state <= PL_b;
                end
            PROP_b:
                begin
                PropL_find <= 1'b1;
                s_propagating <= 1'b1;
                s_out_lit <= C;
                PropL_in_lit <= C;
                present_state <= PROP_r;
                end
            PROP_r:
                begin
                if (PropL_ended == 1)
                    begin
                    s_sat <= PropL_empty_formula;
                    s_unsat <= PropL_empty_clause;
                    s_in_formula <= PropL_out_formula;
                    present_state <= PROP_e;
                    end
                end
            PROP_e:
                begin
                if (s_sat == 1)
                    begin
                    s_ended <= 1'b1;
                    s_sat <= 1'b1;
                    s_unsat <= 1'b0;
                    s_propagating <= 1'b0;
                    s_out_formula <= s_in_formula;
                    present_state <= IDLE;
                    s_finding <= 1'b0;
                    end
                else if (s_unsat == 1)
                    begin
                    s_ended <= 1'b1;
                    s_sat <= 1'b0;
                    s_unsat <= 1'b1;
                    s_propagating <= 1'b0;
                    s_out_formula <= s_in_formula;
                    present_state <= IDLE;
                    s_finding <= 1'b0;
                    end
                else
                    present_state <= called_from_state;
                end
            PL_b:
                begin
                PL_find <= 1'b1;
                present_state <= PL_r;
                end
            PL_r:
                begin
                if (PL_ended == 1)
                    begin
                    C <= PL_lit_found;
                    s_temp_found <= PL_found;
                    present_state <= PL_e;
                    end
                end
            PL_e:
                begin
                if (s_temp_found == 1)
                    begin
                    called_from_state <= PL_b;
                    present_state <= PROP_b;
                    end
                else
                    begin
                    s_ended <= 1'b1;
                    s_sat <= 1'b0;
                    s_unsat <= 1'b0;
                    s_propagating <= 1'b0;
                    s_out_formula <= s_in_formula;
                    present_state <= IDLE;
                    s_finding <= 1'b0;
                    end
                end
            IDLE:
                begin
                present_state <= IDLE;
                s_finding <= 1'b0;
                end
            endcase
        end
    end


endmodule
