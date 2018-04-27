set_property IOSTANDARD LVCMOS18 [get_ports clock]
set_property PACKAGE_PIN Y9 [get_ports clock]
create_clock -period 5.510 -name clock -waveform {0.000 2.755} [get_ports clock]