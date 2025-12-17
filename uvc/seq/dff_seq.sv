class dff_seq extends uvm_sequence#(dff_item);
   `uvm_object_utils(dff_seq);

   function new (string name = "dff_seq");
     super.new(name);
   endfunction

   virtual task body();
      dff_item req;

      repeat(30) begin
        `uvm_do(req); 
      end

   endtask

 endclass
