
LIB = work_Dff

TB_DIR = ../tb
UVC_DIR = ../uvc
RTL_DIR = ../

INCDIRS = +incdir+$(UVC_DIR)/env +incdir+$(UVC_DIR)/seq	+incdir+$(UVC_DIR)/tests

TESTS = dff_test

all: compile regress summary

compile: 
	vlib $(LIB)
	vmap work $(LIB)
	vlog -work work -sv $(TB_DIR)/dff_if.sv  $(RTL_DIR)/dff.v
	vlog -work work -sv $(UVC_DIR)/env/dff_pkg.sv
	vlog -work work -sv $(TB_DIR)/top.sv 
regress:
	@mkdir -p logs
	@for t in $(TESTS); do \
	vsim -c top +UVM_TESTNAME=$$t -l logs/$$t.log -do "run -all; quit -f"; \
	done

summary:
	@echo "PASS"
	@grep -l "TEST PASSED" logs/*.log | sed "s#.*/##"
	@echo ""
	@echo "FAIL"
	@grep -L "TEST PASSED" logs/*.log | sed "s#.*/##"
	@echo ""

clean:
	rm -rf $(LIB) transcript logs *.log modelsim.ini

.PHONY: all compile regress summary clean

	



