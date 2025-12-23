class dff_item extends uvm_sequence_item;
  //  `uvm_object_utils(dff_item)

   rand bit rst;
   rand bit data_in;
    
   bit data_out; 

     `uvm_object_utils_begin(dff_item)
      // Quan trọng: Phải dùng UVM_DEFAULT hoặc UVM_ALL_ON để bật tính năng compare
      `uvm_field_int(data_in, UVM_DEFAULT)
      `uvm_field_int(data_out, UVM_DEFAULT)
  `uvm_object_utils_end
   function new (string name = "dff_item");
     super.new(name);
   endfunction

 endclass
