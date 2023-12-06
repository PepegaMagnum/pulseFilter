# Makefile

SIM ?= ghdl
TOPLEVEL_LANG ?= vhdl

PWD = $(shell pwd)

VHDL_SOURCES += $(PWD)/../src/pulseFilterTypes.vhd
VHDL_SOURCES += $(PWD)/../src/pulse_filterComponents.vhd
VHDL_SOURCES += $(PWD)/../src/filterController.vhd
VHDL_SOURCES += $(PWD)/../src/pulseCyclesCounter.vhd
VHDL_SOURCES += $(PWD)/../src/pulseTransmitter.vhd
VHDL_SOURCES += $(PWD)/../src/pulse_filter.vhd

TOPLEVEL = pulse_filter
MODULE = pulse_filter_tests

include $(shell cocotb-config --makefiles)/Makefile.sim