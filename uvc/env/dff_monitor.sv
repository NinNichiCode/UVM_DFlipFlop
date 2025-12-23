class dff_monitor extends uvm_monitor;
  `uvm_component_utils(dff_monitor);

  uvm_analysis_port#(dff_item) item_send_port;
  
  function new (string name = "dff_monitor", uvm_component parent = null);
    super.new(name, parent);
    item_send_port = new("item_send_port", this);
  endfunction

  dff_item transaction;
  virtual dff_if vif;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    transaction = dff_item::type_id::create("transaction");
    if (!uvm_config_db#(virtual dff_if)::get(this, "", "vif", vif))
	 `uvm_fatal("MON", "cannot access interface");
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin 
      
      repeat(1) @(posedge vif.mon_cb);
       transaction.rst = vif.mon_cb.rst;
 
       transaction.data_in = vif.mon_cb.din;
       
      transaction.data_out = vif.mon_cb.dout;
       item_send_port.write(transaction);
    end
  endtask

 endclass

