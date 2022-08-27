/* Custom verilog based on the template automatically generated from
/* https://wokwi.com/projects/341164910646919762 */

`ifdef SIM
`define UNIT_DELAY #1
`define FUNCTIONAL
`define USE_POWER_PINS
`include "libs.ref/sky130_fd_sc_hd/verilog/primitives.v"
`include "libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
`endif

`default_nettype none

module user_module_341164910646919762
  (
   input [7:0]  io_in,
   output [7:0] io_out
   );
   wire         clk = io_in[0];
   wire         rstn = io_in[1];

   wire         neg;
   wire         q;
   assign io_out[1] = q;
   assign io_out[0] = neg;
   assign io_out[7:2] = 6'b0;

   sky130_fd_sc_hd__dfrbp_1 ff
     (.CLK(clk), .D(neg), .RESET_B(rstn),
      .Q(q), .Q_N(neg),
      .VPWR(1'b1),
      .VGND(1'b0));
endmodule
