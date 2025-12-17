class dff_driver extends uvm_driver#(dff_item);
  `uvm_component_utils(dff_driver)

  function new (string name = "dff_driver", uvm_component parent = null);
     super.new(name, parent);
  endfunction

  dff_item transaction;
  virtual dff_if vif;

  virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
    //  transaction = dff_item::type_id::create("transaction", this);
     
     if(!uvm_config_db#(virtual dff_if)::get(this,"","vif", vif))
	`uvm_fatal("DRV", "Cannot access interface")
  endfunction

  virtual task run_phase(uvm_phase phase);
     forever begin
       seq_item_port.get_next_item(transaction);
       @(posedge vif.clk);
        
    	 vif.din <= transaction.data_in;

       seq_item_port.item_done();
     end
  endtask
endclass

