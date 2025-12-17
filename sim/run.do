
if {[file isdirectory work]} {
    vdel -all
}
vlib work

echo "--- Compiling RTL ---"
vlog -sv ../tb/dff_if.sv ../dff.v


echo "--- Compiling UVC Package ---"
# Thêm đường dẫn tìm file include
vlog -sv +incdir+../uvc/env +incdir+../uvc/seq +incdir+../uvc/tests ../uvc/env/dff_pkg.sv

echo "--- Compiling Tests Package ---"
# Thêm đường dẫn tìm file include 


echo "--- Compiling Top Module ---"
vlog -sv ../tb/top.sv

echo "--- Compilation successful! ---"

echo "--- Starting Simulation ---"
# Simulation: ---------------------------------------------------------

vsim top +UVM_TESTNAME=dff_test


# Coverage report: ----------------------------------------------------
# Coverage save ucdb file:
# coverage save -onexit -assert -directive -cvg -codeAll directed_test.ucdb

# Coverage reports with html and text files:
# vcover report -html directed_test.ucdb -htmldir covhtmlreport
# vcover report -file cov_report.txt directed_test.ucdb

add wave -r /*

run -all

