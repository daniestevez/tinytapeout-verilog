/* Custom verilog based on the template automatically generated from
/* https://wokwi.com/projects/341164910646919762 */

`default_nettype none

module user_module_341164910646919762(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2;
  wire net3 = 1'b0;
  wire net4 = 1'b1;
  wire net5 = 1'b1;
  wire net6;

  assign io_out[0] = net2;

  dff_cell flipflop1 (
    .d (net6),
    .clk (net1),
    .q (net2),
    .notq (net6)
  );
endmodule
