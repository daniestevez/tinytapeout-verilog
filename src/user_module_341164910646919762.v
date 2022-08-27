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

   wire [7:0]        io_out_gold;

   gold_code_module_341164910646919762 gold_code_generator
     (.clk(clk), .loadn(io_in[4]), .b_load({io_in[7:5], io_in[3:1]}),
      .io_out(io_out_gold));

   wire [7:0]        io_out_fibonacci;

   fibonacci_module_341164910646919762 #(.DIGITS(4)) fibonacci_inst
     (.clk(clk), .clk_scan(io_in[1]), .rstn(io_in[2]), .scan_en(io_in[3]),
      .io_out(io_out_fibonacci));

   user_module_mux_341164910646919762 mux_inst
     (.sel(io_in[7]), .a(io_out_gold), .b(io_out_fibonacci),
      .out(io_out));
endmodule // user_module_341164910646919762

module user_module_mux_341164910646919762
  (
   input wire sel,
   input wire [7:0] a,
   input wire [7:0] b,
   output wire [7:0] out
   );

   sky130_fd_sc_hd__mux2_1 mux2_inst [7:0]
     (.A0(a), .A1(b), .S(sel), .X(out),
      .VPWR(1'b1), .VGND(1'b0));
endmodule // user_module_mux_341164910646919762

module gold_code_module_341164910646919762
  (
   input wire clk,
   input wire loadn,
   input wire [5:0] b_load,
   output wire [7:0] io_out
   );

   wire         gold;
   assign io_out[7] = gold;
   wire [2:0]   a_lsbs;
   assign {io_out[5], io_out[0], io_out[1]} = a_lsbs;
   wire [2:0]   b_lsbs;
   assign {io_out[4], io_out[3], io_out[2]} = b_lsbs;
   wire         load_indicator;
   assign io_out[6] = load_indicator;

   wire [14:0]   a;

   sky130_fd_sc_hd__dfstp_1 a_set_ff
     (.CLK(clk), .D(a[0] ^ a[1]), .SET_B(loadn),
      .Q(a[14]),
      .VPWR(1'b1), .VGND(1'b0));

   sky130_fd_sc_hd__dfrtp_1 a_rst_ff [13:0]
     (.CLK(clk), .D(a[14:1]), .RESET_B(loadn),
      .Q(a[13:0]),
      .VPWR(1'b1), .VGND(1'b0));

   wire [14:0]   b;

   sky130_fd_sc_hd__dfrtp_1 b_msb_ff
     (.CLK(clk), .D(b[0] ^ b[1] ^ b[3] ^ b[12]),
      .RESET_B(loadn),
      .Q(b[14]),
      .VPWR(1'b1), .VGND(1'b0));

   sky130_fd_sc_hd__dfstp_1 b_msb2_ff [13:0]
     (.CLK(clk), .D(b[14]), .SET_B(loadn),
      .Q(b[13]),
      .VPWR(1'b1), .VGND(1'b0));

   sky130_fd_sc_hd__dfrtp_1 b_middle_ff [6:0]
     (.CLK(clk), .D(b[13:7]),
      .RESET_B(loadn),
      .Q(b[12:6]),
      .VPWR(1'b1), .VGND(1'b0));

   sky130_fd_sc_hd__sdfxtp_1 b_load_ff [5:0]
     (.CLK(clk), .D(b_load), .SCD(b[6:1]),
      .SCE(loadn),
      .Q(b[5:0]),
      .VPWR(1'b1), .VGND(1'b0));

   assign gold = a[0] ^ b[0];
   assign a_lsbs = a[2:0];
   assign b_lsbs = b[2:0];
   assign load_indicator = ~loadn;
endmodule // gold_code_module_341164910646919762

module fibonacci_module_341164910646919762
  #(
    parameter DIGITS = 4
    )
   (
    input wire        clk,
    input wire        clk_scan,
    input wire        rstn,
    input wire        scan_en,
    output wire [7:0] io_out
    );

   localparam         WIDTH = 4 * DIGITS;
   wire [WIDTH-1:0]   fibonacci;

   fibonacci_341164910646919762 #(.WIDTH(WIDTH)) fib
     (.clk(clk), .rstn(rstn),
      .value(fibonacci));

   wire [3:0]         digit;

   digit_scan_341164910646919762 #(.DIGITS(DIGITS)) digit_scan
     (.clk(clk_scan), .scan_en(scan_en), .in(fibonacci),
      .out(digit));

   seven_segment_341164910646919762 seven_segment_encoder
     (.digit(digit), .dot(1'b0), .seven_segment(io_out));
endmodule // fibonacci_module_341164910646919762

module fibonacci_341164910646919762
  #(
    parameter WIDTH = 16
    )
   (
    input wire         clk,
    input wire         rstn,
    output wire [WIDTH-1:0] value
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

module digit_scan_341164910646919762
  #(
    parameter DIGITS = 4
    )
   (
    input wire                clk,
    input wire                scan_en,
    input wire [4*DIGITS-1:0] in,
    output wire [3:0]         out
    );

   wire [4*DIGITS-1:0]        q;
   assign out = q[3:0];
   wire [4*DIGITS-1:0]        scd;
   assign scd = {4'b0, q[4*DIGITS-1:4]};

   genvar                     i;
   generate for (i = 0; i < 4 * DIGITS; i = i + 1) begin
      sky130_fd_sc_hd__sdfxtp_1 scan_ff
                     (.D(in[i]), .SCD(scd[i]), .SCE(scan_en),
                      .CLK(clk), .Q(q[i]),
                      .VPWR(1'b1), .VGND(1'b0));
   end
   endgenerate
endmodule // digit_scan_341164910646919762

module seven_segment_341164910646919762
  (
   input wire [3:0]  digit,
   input wire        dot,
   output wire [7:0] seven_segment
   );

   reg               up, mid, down, left_up,
                     left_down, right_up, right_down;
   assign seven_segment = {dot, mid, left_up, left_down,
                           down, right_down, right_up, up};

   always @(*) begin
      up = 1'b0;
      mid = 1'b0;
      down = 1'b0;
      left_up = 1'b0;
      left_down = 1'b0;
      right_up = 1'b0;
      right_down = 1'b0;
      case (digit)
        4'h0: begin
           up = 1'b1;
           down = 1'b1;
           left_up = 1'b1;
           left_down = 1'b1;
           right_up = 1'b1;
           right_down = 1'b1;
        end
        4'h1: begin
           right_up = 1'b1;
           right_down = 1'b1;
        end
        4'h2: begin
           up = 1'b1;
           mid = 1'b1;
           down = 1'b1;
           right_up = 1'b1;
           left_down = 1'b1;
        end
        4'h3: begin
           up = 1'b1;
           mid = 1'b1;
           down = 1'b1;
           right_up = 1'b1;
           right_down = 1'b1;
        end
        4'h4: begin
           left_up = 1'b1;
           right_up = 1'b1;
           mid = 1'b1;
           right_down = 1'b1;
        end
        4'h5: begin
           up = 1'b1;
           mid = 1'b1;
           down = 1'b1;
           left_up = 1'b1;
           right_down = 1'b1;
        end
        4'h6: begin
           up = 1'b1;
           mid = 1'b1;
           down = 1'b1;
           left_up = 1'b1;
           left_down = 1'b1;
           right_down = 1'b1;
        end
        4'h7: begin
           up = 1'b1;
           right_up = 1'b1;
           right_down = 1'b1;
        end
        4'h8: begin
           up = 1'b1;
           mid = 1'b1;
           down = 1'b1;
           left_up = 1'b1;
           left_down = 1'b1;
           right_up = 1'b1;
           right_down = 1'b1;
        end
        4'h9: begin
           up = 1'b1;
           mid = 1'b1;
           left_up = 1'b1;
           right_up = 1'b1;
           right_down = 1'b1;
        end
        4'ha: begin
           up = 1'b1;
           mid = 1'b1;
           left_up = 1'b1;
           left_down = 1'b1;
           right_up = 1'b1;
           right_down = 1'b1;
        end
        4'hb: begin
           mid = 1'b1;
           down = 1'b1;
           left_up = 1'b1;
           left_down = 1'b1;
           right_down = 1'b1;
        end
        4'hc: begin
           up = 1'b1;
           down = 1'b1;
           left_up = 1'b1;
           left_down = 1'b1;
        end
        4'hd: begin
           mid = 1'b1;
           down = 1'b1;
           left_down = 1'b1;
           right_up = 1'b1;
           right_down = 1'b1;
        end
        4'he: begin
           up = 1'b1;
           mid = 1'b1;
           down = 1'b1;
           left_up = 1'b1;
           left_down = 1'b1;
        end
        4'hf: begin
           up = 1'b1;
           mid = 1'b1;
           left_up = 1'b1;
           left_down = 1'b1;
        end
      endcase // case (digit)
   end // always @ (*)
endmodule // seven_segment_341164910646919762
