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
   input wire [7:0]  io_in,
   output wire [7:0] io_out
   );
   wire              clk = io_in[0];
   wire              rstn = io_in[1];

   wire [15:0]       fibonacci;
   assign io_out = fibonacci[15:8];

   fibonacci_341164910646919762 fib
     (.clk(clk), .rstn(rstn),
      .value(fibonacci));
endmodule // user_module_341164910646919762

module fibonacci_341164910646919762
  (
   input wire         clk,
   input wire         rstn,
   output wire [15:0] value
   );

   reg [15:0]    a;
   assign value = a;
   reg [15:0]    b;

   always @(posedge clk or negedge rstn) begin
      a <= b;
      b <= a + b;

      if (!rstn) begin
         a <= 1'b0;
         b <= 1'b1;
      end
   end
endmodule // fibonacci_341164910646919762
