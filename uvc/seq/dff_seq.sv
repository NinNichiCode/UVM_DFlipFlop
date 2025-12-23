class dff_seq extends uvm_sequence#(dff_item);
   `uvm_object_utils(dff_seq);

   function new (string name = "dff_seq");
     super.new(name);
   endfunction

   virtual task body();
      dff_item req;
      
      repeat(10) begin
      dff_item req;
         `uvm_do_with(req, {
		data_in inside {1'b0, 1'b1};
	});
     end

      repeat(300) begin
      dff_item req;
        `uvm_do(req); 
      end


   endtask

 endclass
