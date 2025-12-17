class dff_agent extends uvm_agent;
  `uvm_component_utils(dff_agent)
   
   function new (string name = "dff_agent", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   dff_driver driver;
   dff_monitor monitor;
   dff_golden golden_model;
   uvm_sequencer#(dff_item) seqr;

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      driver = dff_driver::type_id::create("driver", this);
      monitor = dff_monitor::type_id::create("monitor", this);
      golden_model = dff_golden::type_id::create("golden_model", this);
      seqr = uvm_sequencer#(dff_item)::type_id::create("seqr", this);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      driver.seq_item_port.connect(seqr.seq_item_export);
   endfunction

   endclass


