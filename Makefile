# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# Makefile

# defaults #simulador a usar icarus, #lenguaje verilog
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

#VERILOG_SOURCES += $(PWD)/my_design_gcd1.sv

#Test the fsm:
VERILOG_SOURCES += $(PWD)/gcd_top.sv

# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = gcd_top

# MODULE is the basename of the Python test file
MODULE = test_gcd_top

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
