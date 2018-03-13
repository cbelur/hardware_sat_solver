timescale 1ns / 1ps
import common::*;

module unitClause (clock, reset, find, in_formula, ended, found, lit_found);

input clock, reset, find;
input formula in_formula;
output ended, found;
output lit lit_found;

formula s_in_formula = ZERO_FORMULA;
logic s_ended = '0';
logic s_found = '0';
lit s_lit_found = ZERO_LIT;
logic s_finding = '0';
int i = 0;


assign ended = s_ended;
assign found = s_found;
assign lit_found = s_lit_found;

always_ff @(posedge clock or posedge reset)
begin
	
if reset
	begin
		s_ended <= 0;
		s_found <= 0;
	end
	
	
else if (clock)
	begin
		s_ended <= 0;

		if ((find == 1) and (s_finding == 0))
			begin
				s_in_formula <= in_formula;
				s_finding <= 1;
				s_ended <= 0;
				i <= 0;
			end
		else if (s_finding == 1)
			begin
				for (i; i < NUMBER_CLAUSES; i++)
					begin
						if ((i == s_in_formula.len) or (_finished == 1))
							break;
						if ((s_in_formula.clauses(i)).len == 1)
							begin
								_found <= 1;
								_finished <= 1;
								s_lit_found <= (s_in_formula.clauses(i)).lits[0];
							end
					end
				s_ended <= 1;

				if ((i < s_in_formula.len) and (i < NUMBER_CLAUSES))
					begin
						if (s_in_formula.clauses(i).len = 1)
							begin
								s_finding <= 0;
								s_found <= 1;
								s_ended <= 1;
								s_lit_found <= s_in_formula.clauses(i).lits(0);
							end
						else
							s_ended <= 0;

					end
				else
					begin
						s_finding <= 0;
						s_ended <= 0;
						s_found <= 0; 
					end

				i <= i+1;
			end
	end

							
endmodule
