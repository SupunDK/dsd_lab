# Create a 50 MHz clock constraint
create_clock -name sys_clk -period 20.000 -waveform {0.000 10.000} [get_ports clk]