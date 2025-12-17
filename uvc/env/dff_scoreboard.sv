class dff_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(dff_scoreboard)
  
  dff_item tr, golden_tr;
  uvm_tlm_analysis_fifo#(dff_item) item_got_imp;
  uvm_tlm_analysis_fifo#(dff_item) item_golden_imp;

  function new (string name = "dff_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_got_imp = new("item_got_imp", this);
    item_golden_imp = new("item_golden_imp", this);
  endfunction

  // virtual function void write(dff_item transaction);
  //    if( transaction.data_in == transaction.data_out)
  //      `uvm_info("SCO", $sformatf(" Pass , din = %0h , dout = %0h", transaction.data_in, transaction.data_out), UVM_LOW)
  //     else 
  //       `uvm_error("SCO", $sformatf(" Fail, din = %0h , dout = %0h", transaction.data_in, transaction.data_out))
  //  endfunction

  virtual task run_phase(uvm_phase phase);
     forever begin
        item_got_imp.get(tr);
        item_golden_imp.get(golden_tr);
        
        if(tr.compare(golden_tr))
          `uvm_info("SCO", $sformatf(" Pass , din = %0h , dout = %0h | golden_din = %0h, golden_dout = %0h", tr.data_in, tr.data_out, golden_tr.data_in, golden_tr.data_out), UVM_LOW)
         else 
           `uvm_error("SCO", $sformatf(" Fail, din = %0h , dout = %0h | golden_din = %0h, golden_dout = %0h", tr.data_in, tr.data_out, golden_tr.data_in, golden_tr.data_out))
     end
  endtask
endclass

