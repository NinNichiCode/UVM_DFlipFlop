
//`include "uvm_macros.svh"
//import uvm_pkg::*;
//import dff_pkg::*;

class dff_test extends base_test;
  `uvm_component_utils(dff_test)

  function new(string name = "dff_test", uvm_component parent = null);
     super.new(name, parent);
  endfunction


  virtual task run_test_seq();
     dff_seq seq;
     seq = dff_seq::type_id::create("seq");

     seq.start(env.agent.seqr);
  endtask

endclass
