
import math
import re

string_input = raw_input("Enter the CNF separated with brackets, and ' for complement")
input_list = list(string_input)

unique_characters = "".join(set(string_input))
characters_wo_special = re.sub('[\'\(\)+]','',unique_characters)

character_list=list(characters_wo_special)
character_list.sort()
number_of_literals = len(characters_wo_special)

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
		print "i <= " + str(number_of_literals) + "'b" + str(pos_clause).zfill(number_of_literals) + "; #100;" + "\n"
		print "i <= " + str(number_of_literals) + "'b" + str(neg_clause).zfill(number_of_literals) + "; #100;" + "\n"

print ("load <= 1'b0; \n")

