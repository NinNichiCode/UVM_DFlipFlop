class dff_golden extends uvm_monitor;
    `uvm_component_utils(dff_golden)

    virtual dff_if vif;
    dff_item transaction;
    uvm_analysis_port#(dff_item) item_golden_port;
 bit prev_din;
   function new(string name = "dff_golden", uvm_component parent = null);
      super.new(name, parent);
      item_golden_port = new("item_golden_port", this);
       prev_din = 0;
   endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dff_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "cannot get vif")
    endfunction


    function void predict();
    //    transaction.data_out = transaction.data_in;
         if(transaction.rst) begin
		transaction.data_out = 1'b0;
	 end else begin
        transaction.data_out = prev_din;
       
        prev_din = transaction.data_in;
       end
       
endfunction

    virtual task run_phase(uvm_phase phase);
       forever begin
           @(posedge vif.mon_cb);
              transaction = dff_item::type_id::create("transaction",this);
                transaction.rst = vif.mon_cb.rst;
	        transaction.data_in = vif.mon_cb.din;
                predict();
                item_golden_port.write(transaction);
       end
    endtask
endclass
