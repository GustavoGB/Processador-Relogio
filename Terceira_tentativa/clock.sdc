set_input_delay -clock clk -max 3 [all_inputs]

set_input_delay -clock clk -min 2 [all_inputs]The Synopsys Design Constraint (SDC) format provides a simple and easy method to constrain the simplest to the most complex designs. The following example provides the simplest SDC file content that constrains all clock (ports and pins), input I/O paths, and output I/O paths for a design. You can use the SDC file below as a template for any design. However, each design should contain a customized SDC file that individually constrains all clocks, input ports, and output ports.

# Constrain clock port clk with a 10-ns requirement

create_clock -period 10 [get_ports clk]

# Automatically apply a generate clock on the output of phase-locked loops (PLLs)
# This command can be safely left in the SDC even if no PLLs exist in the design

derive_pll_clocks

# Constrain the input I/O path

set_input_delay -clock clk -max 3 [all_inputs]

set_input_delay -clock clk -min 2 [all_inputs]

# Constrain the output I/O path

set_output_delay -clock clk -max 3 [all_inputs]

set_output_delay -clock clk -min 2 [all_inputs]