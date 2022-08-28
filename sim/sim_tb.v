`default_nettype none

`timescale 1ns/100ps

module sim_tb;
   reg clk = 1'b1;
   reg rstn = 1'b0;
   reg mux_sel = 1'b0;
   reg load_gold_n = 1'b0;

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
      load_gold_n = 1'b0;
      #500;
      load_gold_n = 1'b1;
   end

   user_module_341164910646919762 dut
     (
      .io_in({4'b0, load_gold_n, rstn, mux_sel, clk}),
      .io_out()
      );
endmodule
