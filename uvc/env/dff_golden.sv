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
             transaction.data_out = prev_din;
       
       // Cập nhật Input nhịp này vào biến nhớ để dùng cho nhịp sau
       prev_din = transaction.data_in;
       
endfunction

    virtual task run_phase(uvm_phase phase);
       forever begin
           @(posedge vif.clk);
              transaction = dff_item::type_id::create("transaction",this);
                transaction.data_in = vif.din;
                predict();
                item_golden_port.write(transaction);
       end
    endtask
endclass
