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

   wire [15:0]   sum;
   adder_341164910646919762 #(.WIDTH(16)) adder
     (.a(a), .b(b), .sum(sum));

   always @(posedge clk or negedge rstn) begin
      a <= b;
      b <= sum;

      if (!rstn) begin
         a <= 1'b0;
         b <= 1'b1;
      end
   end
endmodule // fibonacci_341164910646919762

module adder_341164910646919762
  #(
    parameter WIDTH = 16
    )
   (
    input wire [WIDTH-1:0] a,
    input wire [WIDTH-1:0] b,
    output wire [WIDTH-1:0] sum
    );

   wire [WIDTH-1:0]         cout;

   sky130_fd_sc_hd__ha_1 add_first
     (.A(a[0]), .B(b[0]), .COUT(cout[0]), .SUM(sum[0]),
      .VPWR(1'b1), .VGND(1'b0));

   genvar                   i;
   generate for (i = 1; i < WIDTH; i = i + 1) begin
      sky130_fd_sc_hd__fa_1 add_rest
                     (.A(a[i]), .B(b[i]), .CIN(cout[i-1]),
                      .COUT(cout[i]), .SUM(sum[i]),
                      .VPWR(1'b1), .VGND(1'b0));
   end
   endgenerate
endmodule // adder_341164910646919762
