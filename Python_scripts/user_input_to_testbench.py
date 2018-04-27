
import math
import re

string_input = raw_input("Enter the CNF separated with brackets, and ' for complement")
input_list = list(string_input)

unique_characters = "".join(set(string_input))
characters_wo_special = re.sub('[\'\(\)+]','',unique_characters)

character_list=list(characters_wo_special)
character_list.sort()
number_of_literals = len(characters_wo_special)


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



pos_clause = 0
neg_clause = 0

map = {}
i = number_of_literals - 1

for c in character_list:
	if c not in map:
		map[c]=10**i 
		i = i - 1

j = 0

for i in xrange(0,len(input_list)):
	if (input_list[i] == "(" ):
		j = i
		pos_clause = 0
		neg_clause = 0
		while (input_list[j] != ")" ):
			if input_list[j].isalpha():
				if input_list[j+1] != "'":
					pos_clause = pos_clause + map[input_list[j]]
				if input_list[j+1] == "'":
					neg_clause = neg_clause + map[input_list[j]]
					
			j = j+1
		#print "i <= " + str(number_of_literals) + "'b" + str(pos_clause).zfill(number_of_literals) + "; #100;" #+ "\n"
		write_file.write("i <= " + str(number_of_literals) + "'b" + str(pos_clause).zfill(number_of_literals) + "; #100; \n")
		#print  #+ "\n"
		write_file.write("i <= " + str(number_of_literals) + "'b" + str(neg_clause).zfill(number_of_literals) + "; #100; \n")

write_file.write("load <= 1'b0; \n")
write_file.write("end\n")
write_file.write("endmodule\n")
write_file.close()

