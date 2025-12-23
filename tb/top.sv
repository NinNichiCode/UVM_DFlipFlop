`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;
import dff_pkg::*;

module top;
   logic clk, rst;

   initial begin
      clk = 0;
      forever #5 clk = ~clk;
    end

    initial begin
       
       rst = 0;
       #10;
       rst = 1;
       #60;
       rst = 0;
    end

  dff_if vif();

   assign vif.clk = clk;
   assign vif.rst = rst;

    dff dut (.clk(vif.clk), .rst(vif.rst), .din(vif.din), .dout(vif.dout));

    initial begin
       uvm_config_db#(virtual dff_if)::set(null, "*", "vif", vif);
       run_test();
    end

endmodule

