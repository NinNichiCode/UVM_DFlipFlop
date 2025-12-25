
LIB = work_Dff

TB_DIR = ../tb
UVC_DIR = ../uvc
RTL_DIR = ../

INCDIRS = +incdir+$(UVC_DIR)/env +incdir+$(UVC_DIR)/seq	+incdir+$(UVC_DIR)/tests

TESTS = dff_test

all: compile regress coverage summary

compile: 
	vlib $(LIB)
	vmap work $(LIB)
	vlog -work work -sv -cover bcetf $(TB_DIR)/dff_if.sv  $(RTL_DIR)/dff.v
	vlog -work work -sv -cover bcetf $(UVC_DIR)/env/dff_pkg.sv
	vlog -work work -sv -cover bcetf $(TB_DIR)/top.sv 
regress:
	@mkdir -p logs
	@mkdir -p cov
	@for t in $(TESTS); do \
	vsim -c -coverage top +UVM_TESTNAME=$$t -voptargs="+acc" -assertdebug -l logs/$$t.log \
	-do "coverage save -onexit cov/$$t.ucdb; run -all; quit"; \
	done

coverage:
	@echo "Generate coverage report..."
	vcover report -html cov/dff_test.ucdb -htmldir cov/html
	vcover report -detail -file cov/coverage.txt cov/dff_test.ucdb

summary:
	@echo "PASS"
	@grep -l "TEST PASSED" logs/*.log | sed "s#.*/##"
	@echo ""
	@echo "FAIL"
	@grep -L "TEST PASSED" logs/*.log | sed "s#.*/##"
	@echo ""

clean:
	rm -rf $(LIB) transcript logs *.log cov modelsim.ini

.PHONY: all compile regress coverage summary clean

	



