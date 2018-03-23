`timescale 1ns / 1ps

import common::*;

module decide_branch (input clock, reset, find, 
					  input formula formula_in, 
					  output ended,
					  output lit lit_out);

formula formula_s = zero_formula;
lit lit_s = zero_lit;
logic [width_cluasearray:0] iterator = 0;
logic computing = 0;
logic finished = 0;

assign lit_out = lit_s;

always_ff @(posedge clock or posedge reset)
begin

	if (reset == 1'b1)
	begin
		
		formula_s <= zero_formula;
		lit_s <= zero_lit;
		iterator <= 1'b0;
		computing <= 1'b0;
		finished <= 1'b0;
		ended <= 1'b0;
		
	end

	else
	begin
		
		ended <= 0;
		
		if (formula_s.clauses[iterator].len == 0)
		begin
			iterator <= iterator + 1;
		end
		
		else
		begin
			lit_s.num <= formula_s.clauses[iterator].lits[0].num;
			lit_s <= ~(formula_s.clauses[iterator].lits[0].val);
			computing <= 1'b0;
			ended <= 1'b1;
		end
	end

end


endmodule