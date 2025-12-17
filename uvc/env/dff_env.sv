class dff_env extends uvm_env;
  `uvm_component_utils(dff_env)

  function new (string name="dff_env", uvm_component parent = null);
     super.new(name, parent);
  endfunction

  dff_agent agent;
  dff_scoreboard scoreboard;

  virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     agent = dff_agent::type_id::create("agent", this);
     scoreboard = dff_scoreboard::type_id::create("scoreboard", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     agent.monitor.item_send_port.connect(scoreboard.item_got_imp.analysis_export);
     agent.golden_model.item_golden_port.connect(scoreboard.item_golden_imp.analysis_export);
  endfunction
endclass




