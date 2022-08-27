`default_nettype none

`timescale 1ns/100ps

module sim_tb;
   reg clk = 1'b1;
   reg clk_scan = 1'b1;
   reg rstn = 1'b0;
   reg scan_en = 1'b0;
   reg mux_sel = 1'b0;
   reg load_gold = 1'b1;

   initial begin
      $dumpfile("sim.vcd");
      $dumpvars(0, sim_tb);
      #100000 $finish;
   end

   always begin
      clk = 1'b1;
      #50;
      clk = 1'b0;
      #50;
   end

   always begin
      scan_en = 1'b0;
      #10;
      scan_en = 1'b1;
      #90;
   end

   always begin
      clk_scan = 1'b1;
      #5;
      clk_scan = 1'b0;
      #5;
   end

   always begin
      mux_sel = 1'b0;
      #1;
      mux_sel = 1'b1;
      #1;
   end

   initial begin
      rstn = 1'b0;
      #500;
      rstn = 1'b1;
   end

   initial begin
      load_gold = 1'b1;
      #500;
      load_gold = 1'b0;
   end

   user_module_341164910646919762 dut
     (
      .io_in({mux_sel, 2'b0, load_gold, scan_en, rstn, clk_scan, clk}),
      .io_out()
      );
endmodule
