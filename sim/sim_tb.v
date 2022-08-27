`default_nettype none

`timescale 1ms/1us

module sim_tb;
   reg clk = 1'b0;
   reg [6:0] switches = 7'b0;

   initial begin
      $dumpfile("sim.vcd");
      $dumpvars(0, sim_tb);
      #100000 $finish;
   end

   always begin
      clk = 1'b1;
      #1;
      clk = 1'b0;
      #1;
   end

   initial begin
      switches[0] = 1'b1;
      #20;
      switches[0] = 1'b0;
   end

   user_module_341164910646919762 dut
     (
      .io_in({switches, clk}),
      .io_out()
      );
endmodule
