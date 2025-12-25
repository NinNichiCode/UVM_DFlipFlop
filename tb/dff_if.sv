`timescale 1ns/1ps

interface dff_if (input logic clk); 
  logic rst;
  logic din;
  logic dout;

  clocking drv_cb @(posedge clk);
     default input #1step output #1ns;
     input  rst;
     output din;
  endclocking

  clocking mon_cb @(posedge clk);
     default input #1step output #1ns;
     input rst;
     input din;
     input dout;
  endclocking

  //---------------------------------------------------------
  // SVA 
  //---------------------------------------------------------
  property p_reset;
    @(posedge clk) rst |=> (dout == 0);
  endproperty

  property p_data_transfer;
    @(posedge clk) disable iff (rst) 
    (!rst) |=> (dout == $past(din));
  endproperty

  ASSERT_RESET: assert property (p_reset) 
                else $error("SVA Error: Reset failed! dout is not 0");

  ASSERT_DATA:  assert property (p_data_transfer) 
                else $error("SVA Error: Data transfer failed! dout != din");


  COVER_RESET: cover property (p_reset);
  COVER_DATA:  cover property (p_data_transfer);

endinterface