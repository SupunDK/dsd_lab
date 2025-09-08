# Create a 200 MHz clock constraint
create_clock -name sys_clk -period 5.000 -waveform {0.000 2.500} [get_ports clk]