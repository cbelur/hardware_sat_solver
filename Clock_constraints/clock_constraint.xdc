set_property IOSTANDARD LVCMOS18 [get_ports clock]
set_property PACKAGE_PIN Y9 [get_ports clock]
create_clock -period 5.510 -name clock -waveform {0.000 2.755} [get_ports clock]





set_property MARK_DEBUG false [get_nets {F_reg[clauses][1][lits][0][num]__0[1]}]
set_property MARK_DEBUG false [get_nets {F_reg[clauses][1][lits][0][num]__0[0]}]
