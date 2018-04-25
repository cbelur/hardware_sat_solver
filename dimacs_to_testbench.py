

import math 
import re

file_name = "C:\Users\Harshavardhan\Desktop\dimacs.cnf"

pos_clause = 0
neg_clause = 0

with open(file_name) as f:
	for line in f:
		line = line.strip()
		if line:
			if (line.split()[0] == 'p'):
				no_of_literals = int(line.split()[2])
f.close()

write_file = open(r"C:\Users\Harshavardhan\Desktop\top_test.sv", "w+")

write_file.write("`timescale 1ns / 1ps \n")
write_file.write("import common::*;\n")
write_file.write("module top_test();\n")
write_file.write("logic clock, reset, load;\n")
write_file.write("logic[number_literal-1:0] i;\n")
write_file.write("logic ended, sat;\n")
write_file.write("logic[number_literal-1:0] model;\n")
write_file.write("top test1(clock, reset, load, i, ended, sat, model);\n")
write_file.write("always\n")
write_file.write("begin\n")
write_file.write("clock=1'b1; #50; clock=1'b0; #50;\n")
write_file.write("end\n")
write_file.write("initial\n")
write_file.write("begin\n")
write_file.write("reset=1'b1; load <= 1'b0;\n")
write_file.write("#60;\n")
write_file.write("reset=1'b0; load <= 1'b1;)\n")
write_file.write("\n")
write_file.write("\n")
write_file.write("\n")
write_file.write("\n")
write_file.write("\n")


with open(file_name) as f:
	for line in f:
		line = line.strip()
		if line:
			split_line = line.split()
			if ((split_line[0] != 'p') and (split_line[0] != 'c')):
				#print line.split()
				pos_clause = 0
				neg_clause = 0
				for x in xrange(len(split_line)):
					#print split_line
					if (int(split_line[x]) > 0):
						pos_clause = pos_clause + 10**(no_of_literals - int(split_line[x]))
						#print pos_clause
					elif (int(split_line[x]) < 0):
						#print neg_clause
						neg_clause = neg_clause + 10**(no_of_literals - int(abs(int(split_line[x]))))
				write_file.write("i <= " + str(no_of_literals) + "'b" + str(pos_clause).zfill(no_of_literals) + "; #100; \n")
				write_file.write("i <= " + str(no_of_literals) + "'b" + str(neg_clause).zfill(no_of_literals) + "; #100; \n")

write_file.write("load <= 1'b0; \n")
write_file.write("end\n")
write_file.write("endmodule\n")
write_file.close()
				
f.close()
