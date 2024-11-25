# Verilator creates a obj_dir,
# LANGUAGE
LDH         = sv
# MODULES
RTL_PATH    = rtl/
TOP_MODULE  = mod_main
INCLUDES    = $(RTL_PATH)/include
# Add the extra modules here
MODULES    +=
SRC_FILES   = $(addsuffix .$(LDH), $(TOP_MODULE) $(MODULES))
VSRC        = $(addprefix $(RTL_PATH), $(SRC_FILES))
#MODULES    +=
# TEST BENCH
EXT         = cpp
TEST_BENCH  = tb_$(TOP_MODULE)
#SOME FLAGS FOR TRACE WAVES
TRACE       = --trace --x-assign unique --x-initial unique
TRACE      += --trace-structs --structs-packed --trace-threads 4
TRACE      += --no-trace-top --trace-max-array "64"
# RTLVIEWER
# QUARTUS TOOLS
QSRC        = $(addprefix --source=, $(SRC_FILES))
QUARTUS_MAP = /opt/intelFPGA/23.1/quartus/bin/quartus_map
QUARTUS_FIT = /opt/intelFPGA/23.1/quartus/bin/quartus_fit
QUARTUS_ASM = /opt/intelFPGA/23.1/quartus/bin/quartus_asm
QUARTUS_STA = /opt/intelFPGA/23.1/quartus/bin/quartus_sta
QUARTUS_EDA = /opt/intelFPGA/23.1/quartus/bin/quartus_eda
QUARTUS_NPP = /opt/intelFPGA/23.1/quartus/bin/quartus_npp
QNUI        = /opt/intelFPGA/23.1/quartus/bin/qnui
QFILES_OPT  = --read_settings_files=on --write_settings_files=off

all: lint verilating

lint : $(VSRC)
	@echo
	@echo "### CHECKING ERRORS ###"
	verilator -Wall --lint-only --hierarchical $^ --top-module $(TOP_MODULE) -y $(INCLUDES)

verilating : $(VSRC)
	@echo
	@echo "### VERILATING ###"
	verilator -Wall $(TRACE) -cc --hierarchical $^ --top-module $(TOP_MODULE) -y $(INCLUDES) --exe tb_sim/*.$(EXT)
	@touch .stamp.verilate

build : .stamp.verilate
	@echo
	@echo "### BUILDING SIM ###"
	intercept-build make -j `nproc` -C obj_dir -f V$(TOP_MODULE).mk V$(TOP_MODULE)

tb_sim/waveform.vcd : ./obj_dir/V$(TOP_MODULE)
	@echo
	@echo "### SIMULATING ###"
	$^ +verilator+rand+reset+0

sim : tb_sim/waveform.vcd
	@echo
	@echo "### WAVES ###"
	gtkwave $^ -a gtkwave_setup.gtkw

run : build sim

ys : rtl.ys
	@echo "### SIMPLE RTL ###"
	yosys $^

synth :
	@echo
	@echo "#### ANALYSIS & SYNTHESIS ####"
	$(QUARTUS_MAP) $(QFILES_OPT) $(TOP_MODULE) -c $(TOP_MODULE)

fit:
	@echo
	@echo "#### FITTER (PLACE & ROUTE) ####"
	$(QUARTUS_FIT) $(QFILES_OPT) $(TOP_MODULE) -c $(TOP_MODULE)

qasm :
	@echo
	@echo "#### ASSEMBLER (GENERATE PROGRAMMING FILES) ####"
	$(QUARTUS_ASM) $(QFILES_OPT) $(TOP_MODULE) -c $(TOP_MODULE)

qsta:
	@echo
	@echo "#### TIMING ANALYSIS ####"
	$(QUARTUS_STA) $(TOP_MODULE) -c $(TOP_MODULE)
	# $(QUARTUS_STA) $(TOP_MODULE) -c $(TOP_MODULE)

qeda:
	@echo
	@echo "#### EDA NETLIST WRITER ####"
	$(QUARTUS_EDA) $(QFILES_OPT) $(TOP_MODULE) -c $(TOP_MODULE)

net :
	@echo
	@echo "#### GENERATE NETLIST ####"
	$(QUARTUS_NPP) $(TOP_MODULE) --netlist_type=sgate

view :
	@echo
	@echo "#### OPEN RTL VIEWER ####"
	$(QNUI) $(TOP_MODULE)

sum_sa :
	@echo
	@echo "#### SUMMARY ####"
	cat output_files/$(TOP_MODULE).map.summary
	@echo

sum_fit :
	@echo
	@echo "#### OPEN RTL VIEWER ####"
	cat output_files/$(TOP_MODULE).fit.summary

qrtl : synth sum_sa view

qfull :  synth fit qasm qsta qeda sum_fit view

help:
	@echo "### HELP ###"
	@echo "make       -> Check for errors in the codes, and start the "verilating" process as well as look for errors in the test bench."
	@echo "make run   -> Creates the executable, runs the simulation and displays the generated waves in GTKWave."
	@echo "make synth -> Synthesis and analysis with Intel® tools."
	@echo "make fit   -> Place & Route with Intel® tools."
	@echo "make qasm  -> Generate Programming Fileswith Intel® tools."
	@echo "make qsta  -> Timing analysys with Intel® tools."
	@echo "make qeda  -> Write EDA netlist with Intel® tools."
	@echo "make net   -> Generate Netlist with Intel® tools."
	@echo "make view  -> Open RTLViewer by Intel® to view the schematic diagram."
	@echo "make qrtl  -> Do Analysis and Synthesis and open the RTLViewer with Intel tools."
	@echo "make qfull -> Full compilation & analysis with Intel® tools"
	@echo "make ys    -> Create simple RTL deagram with Yosys tool."
	@echo "make clean -> Clean the project."
	@echo "make help  -> Show a short description of the commands "

clean:
	@echo "### CLEAN ###"
	rm -rf obj_dir/
	rm -rf db/
	rm -rf incremental_db/
	rm -rf output_files/
	rm -rf simulation/
	rm -rf .cache/
	rm -rf .stamp.*
	rm -rf *.plist
	rm -rf tb_sim/waveform.vcd
	rm -rf compile_commands.json
	rm -rf mod_main.sdc
