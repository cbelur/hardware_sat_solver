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

begin
ended <= s_ended;
found <= s_found;
lit_found <= s_lit_found;

process(clock,reset)
begin
if reset='1' then
	s_ended <= '0';
	s_found <= '0';
elsif rising_edge(clock) then
	s_ended <= '0';
	if find='1' and s_finding='0' then
		s_in_formula <= in_formula;
		s_finding <= '1';
		s_ended <= '0';
		i <= 0;
	elsif s_finding = '1' then

		--for i in 0 to NUMBER_CLAUSES-1 loop
		--	exit when ((i = s_in_formula.len)or(_finished='1'));
		--	if (s_in_formula.clauses(i)).len = 1 then
		--		_found <= '1';
		--		_finished <= '1';
		--		s_lit_found <= (s_in_formula.clauses(i)).lits[0];
		--	end if ;
		--end loop ;
		--s_ended <= '1';

		if((i < s_in_formula.len) and (i < NUMBER_CLAUSES)) then
			if s_in_formula.clauses(i).len = 1 then
				s_finding <= '0';
				s_found <= '1';
				s_ended <= '1';
				s_lit_found <= s_in_formula.clauses(i).lits(0);
			else
				s_ended <= '0';
			end if;
		else
			s_finding <= '0';
			s_ended <= '1';
			s_found <= '0'; 
		end if;
		i <= i+1;
	end if;
end if;

end process ;

endmodule
