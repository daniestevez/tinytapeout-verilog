/* Custom verilog based on the template automatically generated from
/* https://wokwi.com/projects/341164910646919762 */

`default_nettype none

module user_module_341164910646919762
  (
   input [7:0]  io_in,
   output [7:0] io_out
   );
   wire         clk = io_in[0];
   wire         load = io_in[1];
   wire         gold;
   assign io_out[7] = gold;
   wire [2:0]   a_lsbs;
   assign {io_out[5], io_out[0], io_out[1]} = a_lsbs;
   wire [2:0]   b_lsbs;
   assign {io_out[4], io_out[3], io_out[2]} = b_lsbs;
   wire         load_indicator;
   assign io_out[6] = load_indicator;
   wire [5:0]   b_load = io_in[7:2];

   reg [14:0]   a;
   reg [14:0]   b;

   always @(posedge clk) begin
      a <= {a[0] ^ a[1], a[14:1]};
      b <= {b[0] ^ b[1] ^ b[3] ^ b[12], b[14:1]};

      if (load) begin
         a <= {1'b1, 14'b0};
         b <= {1'b0, 1'b1, 7'b0, b_load};
      end
   end

   assign gold = a[0] ^ b[0];
   assign a_lsbs = a[2:0];
   assign b_lsbs = b[2:0];
   assign load_indicator = load;
endmodule
