package dff_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "../seq/dff_item.sv"

  `include "./dff_driver.sv"
  `include "./dff_monitor.sv"
    `include "./dff_golden.sv"
  `include "./dff_agent.sv"

  `include "./dff_scoreboard.sv"
  `include "./dff_coverage.sv"
  `include "./dff_env.sv"

  `include "../seq/dff_seq.sv"
  `include "../tests/base_test.sv"
  `include "../tests/dff_test.sv"
endpackage
