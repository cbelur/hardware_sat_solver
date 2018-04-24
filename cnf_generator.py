

import re
import math

string_input = raw_input("Enter the CNF separated with brackets, and ' for complement")

bracket_stack = []

count = 0
literal_set = {}
print string_input

unique_characters = "".join(set(string_input))
characters_wo_special = re.sub('[\'\(\)+]','',unique_characters)

character_list=list(characters_wo_special)
character_list.sort()


number_of_literals = len(characters_wo_special)
significant_digits = int(math.ceil(math.log(number_of_literals)/math.log(2) + 1))

significant_digits = '{0:0' + str(significant_digits) + 'b}'

map = {}
i=1;
for c in character_list:
	if c not in map:
		map[c]=significant_digits.format(i)
		i = i + 1





for i in string_input:
    if (i == '('):
        count = count + 1
		
no_of_clauses = '{0:0b}'.format(count)

j=0;
input_list = list(string_input)
output_string = "{"
for i in range(0,len(input_list)):
	if input_list[i] == "(":
		output_string = output_string + "{{"
	if input_list[i] == ")":
		no_set = '{0:0b}'.format(j)
		while(j<len(character_list)):
			output_string = output_string + "zero_lit" + ","
			j=j+1
		if output_string[len(output_string)-1]==",":
			output_string = output_string[:-1]
		j=0;
		output_string = output_string + "}" + ","
		output_string = output_string + no_set + "}" + ","
	if input_list[i].isalpha():
		sign = "1"
		if input_list[i+1] == "'":
			sign = "0"
		output_string = output_string + "{" + map[input_list[i]] + "," + sign + "}" + ","
		j = j+1;
		
output_string = output_string + no_of_clauses + "};" 
print output_string	
