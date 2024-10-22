# create_clock -period 0.02 [get_ports {i_clk}] -waveform { 0.000 10.000 }
# derive_pll_clocks -create_base_clocks
# derive_clock_uncertaint

#
#  Design Timing Constraints Definitions
#
set_time_format -unit ns -decimal_places 3
# #############################################################################
#  Create Input reference clocks (Minimun period is 10ns)
create_clock [get_ports {i_clk}] -period 10.000 -waveform { 0.000 5.000 }
# #############################################################################
#  Now that we have created the custom clocks which will be base clocks,
#  derive_pll_clock is used to calculate all remaining clocks for PLLs
derive_pll_clocks -create_base_clocks
derive_clock_uncertainty
