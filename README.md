# hardware_sat_solver

A sat solver for the ECE 659 course, meant to be synthesized on an FPGA.

Steps to use our design to check for SAT

1) Convert a dimacs file to testbench using the Python script "dimacs_to_testbench.py" or convert a user input file (eg. (a+b')(a+b+c)(a'+b+c')) to testbench using the Python script "user_input_to_testbench.py"

2) Set the generated testbench file and the source file "top.sv" as top module.

3) In common.sv file change the "number_clauses" and "number_literal" to be more than or equal to number of clauses and number of literals in the input. (When we say literals, we actually mean variable.)

4) Run simulation to check for SAT. Check for the "ended" and "sat" variable.

5) Synthesize and implement the design. If running it on Xilinx Vivado use the clock constraint file "clock_constraint.xdc". Change the clock period as required in the file.

Source files         Testbench
propagateliteral.sv  pl_test.sv
Unit_Clause          uc_test.sv
Pure_literal.sv      purel_test.sv
DB_kernel.sv         dbk_test.sv
decide_branch.sv     db_test.sv
Stack_bool.sv        sb_test.sv
Stack_formula.sv     sf_test.sv
Stack_integer.sv     si_test.sv
read_store.sv        rs_test.sv
common.sv            N/A
top.sv               top_test.sv or testbench_30_lit
                     (or any file generated from the script)