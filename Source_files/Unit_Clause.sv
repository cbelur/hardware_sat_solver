`timescale 1ns / 1ps
import common::*;

module Unit_Clause(input clock, reset, find,
           input formula in_formula,
           output ended, found, 
           output lit lit_found);
           

formula s_in_formula;
logic s_ended;
logic s_found;
lit s_lit_found;
logic s_finding;
logic[width_clausearray:0] i;

assign ended = s_ended;
assign found = s_found;
assign lit_found = s_lit_found;

always_ff@(posedge clock or posedge reset)
if (reset)
    begin
    s_ended <= 1'b0;
    s_found <= 1'b0;
    s_in_formula <= zero_formula;
    s_lit_found<= zero_lit;
    s_finding <= 1'b0;
    i <= 1'b0;
    end

else if (clock)
    begin
	s_ended <= 1'b0;
	if (find==1'b1 & s_finding==1'b0)
	   begin
		s_in_formula <= in_formula;
		s_finding <= 1'b1;
		s_ended <= 1'b0;
		i <= 1'b0;
	   end
	else if (s_finding == 1'b1)
        begin
		if((i < s_in_formula.len) & (i < number_clauses))
		    begin 
			if (s_in_formula.clauses[i].len == 1'b1)
				begin
				s_finding <= 1'b0;
				s_found <= 1'b1;
				s_ended <= 1'b1;
				s_lit_found <= s_in_formula.clauses[i].lits[0];
				end
			else
			    begin
				s_ended <= 1'b0;
			    end
		    end
		else
		    begin
			s_finding <= 1'b0;
			s_ended <= 1'b1;
			s_found <= 1'b0; 
		    end
		i <= i+1;     
        end
       
    end
endmodule
