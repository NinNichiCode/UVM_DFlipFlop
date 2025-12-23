`uvm_analysis_imp_decl(_dut)
`uvm_analysis_imp_decl(_golden)

class dff_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(dff_scoreboard)
  
  dff_item dut_q[$]; 
  dff_item golden_q[$];
  int pass;
  int fail;

  uvm_analysis_imp_dut#(dff_item, dff_scoreboard) item_dut_imp;
  uvm_analysis_imp_golden#(dff_item, dff_scoreboard) item_golden_imp;

  function new (string name = "dff_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_dut_imp = new("item_dut_imp", this);
    item_golden_imp = new("item_golden_imp", this);
  endfunction

  // virtual function void write(dff_item transaction);
  //    if( transaction.data_in == transaction.data_out)
  //      `uvm_info("SCO", $sformatf(" Pass , din = %0h , dout = %0h", transaction.data_in, transaction.data_out), UVM_LOW)
  //     else 
  //       `uvm_error("SCO", $sformatf(" Fail, din = %0h , dout = %0h", transaction.data_in, transaction.data_out))
  //  endfunction

  function void write_dut(dff_item trans);
     dut_q.push_back(trans);
     compare_if_ready();
  endfunction


  function void write_golden(dff_item trans);
     golden_q.push_back(trans);
     compare_if_ready();
  endfunction


  function void compare_if_ready();
      dff_item tr, golden_tr;
      if(dut_q.size() > 0 && golden_q.size >0) begin
	  tr = dut_q.pop_front();
	  golden_tr = golden_q.pop_front();

        if(tr.compare(golden_tr)) begin
          `uvm_info("SCO", $sformatf(" Pass , din = %0h , dout = %0h | golden_din = %0h, golden_dout = %0h", tr.data_in, tr.data_out, golden_tr.data_in, golden_tr.data_out), UVM_LOW)
            pass++;
	 end else begin 
           `uvm_error("SCO", $sformatf(" Fail, din = %0h , dout = %0h | golden_din = %0h, golden_dout = %0h", tr.data_in, tr.data_out, golden_tr.data_in, golden_tr.data_out))
           fail++;
         end
       end
    endfunction

    function void report_phase(uvm_phase phase);
       super.report_phase(phase);
         $display("======================================================================");
	 `uvm_info("SCO_report", $sformatf("pass = %0d, fail = %0d", pass, fail), UVM_NONE)
         $display("======================================================================");
    endfunction


  endclass

