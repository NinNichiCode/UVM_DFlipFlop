`timescale 1ns/1ps

interface dff_if ();
 logic clk;
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

endinterface
