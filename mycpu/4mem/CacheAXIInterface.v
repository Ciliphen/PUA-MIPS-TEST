// module CacheAXIInterface(
//   input         clock,
//   input         reset,
//   output        io_icache_ar_ready,
//   input         io_icache_ar_valid,
//   input  [31:0] io_icache_ar_bits_addr,
//   input  [7:0]  io_icache_ar_bits_len,
//   input  [2:0]  io_icache_ar_bits_size,
//   input         io_icache_r_ready,
//   output        io_icache_r_valid,
//   output [31:0] io_icache_r_bits_data,
//   output        io_icache_r_bits_last,
//   output        io_dcache_ar_ready,
//   input         io_dcache_ar_valid,
//   input  [31:0] io_dcache_ar_bits_addr,
//   input  [7:0]  io_dcache_ar_bits_len,
//   input  [2:0]  io_dcache_ar_bits_size,
//   input         io_dcache_r_ready,
//   output        io_dcache_r_valid,
//   output [31:0] io_dcache_r_bits_data,
//   output        io_dcache_r_bits_last,
//   output        io_dcache_aw_ready,
//   input         io_dcache_aw_valid,
//   input  [31:0] io_dcache_aw_bits_addr,
//   input  [7:0]  io_dcache_aw_bits_len,
//   input  [2:0]  io_dcache_aw_bits_size,
//   output        io_dcache_w_ready,
//   input         io_dcache_w_valid,
//   input  [31:0] io_dcache_w_bits_data,
//   input  [3:0]  io_dcache_w_bits_strb,
//   input         io_dcache_w_bits_last,
//   input         io_dcache_b_ready,
//   output        io_dcache_b_valid,
//   input         io_axi_ar_ready,
//   output        io_axi_ar_valid,
//   output [3:0]  io_axi_ar_bits_id,
//   output [31:0] io_axi_ar_bits_addr,
//   output [7:0]  io_axi_ar_bits_len,
//   output [2:0]  io_axi_ar_bits_size,
//   output [1:0]  io_axi_ar_bits_burst,
//   output [1:0]  io_axi_ar_bits_lock,
//   output [3:0]  io_axi_ar_bits_cache,
//   output [2:0]  io_axi_ar_bits_prot,
//   output        io_axi_r_ready,
//   input         io_axi_r_valid,
//   input  [3:0]  io_axi_r_bits_id,
//   input  [31:0] io_axi_r_bits_data,
//   input  [1:0]  io_axi_r_bits_resp,
//   input         io_axi_r_bits_last,
//   input         io_axi_aw_ready,
//   output        io_axi_aw_valid,
//   output [3:0]  io_axi_aw_bits_id,
//   output [31:0] io_axi_aw_bits_addr,
//   output [7:0]  io_axi_aw_bits_len,
//   output [2:0]  io_axi_aw_bits_size,
//   output [1:0]  io_axi_aw_bits_burst,
//   output [1:0]  io_axi_aw_bits_lock,
//   output [3:0]  io_axi_aw_bits_cache,
//   output [2:0]  io_axi_aw_bits_prot,
//   input         io_axi_w_ready,
//   output        io_axi_w_valid,
//   output [3:0]  io_axi_w_bits_id,
//   output [31:0] io_axi_w_bits_data,
//   output [3:0]  io_axi_w_bits_strb,
//   output        io_axi_w_bits_last,
//   output        io_axi_b_ready,
//   input         io_axi_b_valid,
//   input  [3:0]  io_axi_b_bits_id,
//   input  [1:0]  io_axi_b_bits_resp
// );
// `ifdef RANDOMIZE_REG_INIT
//   reg [31:0] _RAND_0;
//   reg [31:0] _RAND_1;
// `endif // RANDOMIZE_REG_INIT
//   reg  ar_sel_lock; // @[CacheAXIInterface.scala 15:32]
//   reg  ar_sel_lock_val; // @[CacheAXIInterface.scala 16:32]
//   wire  ar_sel = ar_sel_lock ? ar_sel_lock_val : ~io_icache_ar_valid & io_dcache_ar_valid; // @[CacheAXIInterface.scala 26:16]
//   wire  r_sel = io_axi_r_bits_id[0]; // @[CacheAXIInterface.scala 27:31]
//   wire  _io_icache_r_bits_data_T = ~r_sel; // @[CacheAXIInterface.scala 45:32]
//   assign io_icache_ar_ready = io_axi_ar_ready & ~ar_sel; // @[CacheAXIInterface.scala 44:44]
//   assign io_icache_r_valid = _io_icache_r_bits_data_T & io_axi_r_valid; // @[CacheAXIInterface.scala 47:31]
//   assign io_icache_r_bits_data = ~r_sel ? io_axi_r_bits_data : 32'h0; // @[CacheAXIInterface.scala 45:31]
//   assign io_icache_r_bits_last = _io_icache_r_bits_data_T & io_axi_r_bits_last; // @[CacheAXIInterface.scala 46:31]
//   assign io_dcache_ar_ready = io_axi_ar_ready & ar_sel; // @[CacheAXIInterface.scala 32:44]
//   assign io_dcache_r_valid = r_sel & io_axi_r_valid; // @[CacheAXIInterface.scala 35:31]
//   assign io_dcache_r_bits_data = r_sel ? io_axi_r_bits_data : 32'h0; // @[CacheAXIInterface.scala 33:31]
//   assign io_dcache_r_bits_last = r_sel & io_axi_r_bits_last; // @[CacheAXIInterface.scala 34:31]
//   assign io_dcache_aw_ready = io_axi_aw_ready; // @[CacheAXIInterface.scala 37:22]
//   assign io_dcache_w_ready = io_axi_w_ready; // @[CacheAXIInterface.scala 38:22]
//   assign io_dcache_b_valid = io_axi_b_valid; // @[CacheAXIInterface.scala 39:22]
//   assign io_axi_ar_valid = ar_sel ? io_dcache_ar_valid : io_icache_ar_valid; // @[CacheAXIInterface.scala 60:30]
//   assign io_axi_ar_bits_id = {{3'd0}, ar_sel}; // @[CacheAXIInterface.scala 52:24]
//   assign io_axi_ar_bits_addr = ar_sel ? io_dcache_ar_bits_addr : io_icache_ar_bits_addr; // @[CacheAXIInterface.scala 53:30]
//   assign io_axi_ar_bits_len = ar_sel ? io_dcache_ar_bits_len : io_icache_ar_bits_len; // @[CacheAXIInterface.scala 54:30]
//   assign io_axi_ar_bits_size = ar_sel ? io_dcache_ar_bits_size : io_icache_ar_bits_size; // @[CacheAXIInterface.scala 55:30]
//   assign io_axi_ar_bits_burst = 2'h1; // @[CacheAXIInterface.scala 56:24]
//   assign io_axi_ar_bits_lock = 2'h0; // @[CacheAXIInterface.scala 57:24]
//   assign io_axi_ar_bits_cache = 4'h0; // @[CacheAXIInterface.scala 58:24]
//   assign io_axi_ar_bits_prot = 3'h0; // @[CacheAXIInterface.scala 59:24]
//   assign io_axi_r_ready = _io_icache_r_bits_data_T ? io_icache_r_ready : io_dcache_r_ready; // @[CacheAXIInterface.scala 62:30]
//   assign io_axi_aw_valid = io_dcache_aw_valid; // @[CacheAXIInterface.scala 72:24]
//   assign io_axi_aw_bits_id = 4'h0; // @[CacheAXIInterface.scala 64:24]
//   assign io_axi_aw_bits_addr = io_dcache_aw_bits_addr; // @[CacheAXIInterface.scala 65:24]
//   assign io_axi_aw_bits_len = io_dcache_aw_bits_len; // @[CacheAXIInterface.scala 66:24]
//   assign io_axi_aw_bits_size = io_dcache_aw_bits_size; // @[CacheAXIInterface.scala 67:24]
//   assign io_axi_aw_bits_burst = 2'h1; // @[CacheAXIInterface.scala 68:24]
//   assign io_axi_aw_bits_lock = 2'h0; // @[CacheAXIInterface.scala 69:24]
//   assign io_axi_aw_bits_cache = 4'h0; // @[CacheAXIInterface.scala 70:24]
//   assign io_axi_aw_bits_prot = 3'h0; // @[CacheAXIInterface.scala 71:24]
//   assign io_axi_w_valid = io_dcache_w_valid; // @[CacheAXIInterface.scala 78:22]
//   assign io_axi_w_bits_id = 4'h0; // @[CacheAXIInterface.scala 74:22]
//   assign io_axi_w_bits_data = io_dcache_w_bits_data; // @[CacheAXIInterface.scala 75:22]
//   assign io_axi_w_bits_strb = io_dcache_w_bits_strb; // @[CacheAXIInterface.scala 76:22]
//   assign io_axi_w_bits_last = io_dcache_w_bits_last; // @[CacheAXIInterface.scala 77:22]
//   assign io_axi_b_ready = io_dcache_b_ready; // @[CacheAXIInterface.scala 80:18]
//   always @(posedge clock) begin
//     if (reset) begin // @[CacheAXIInterface.scala 15:32]
//       ar_sel_lock <= 1'h0; // @[CacheAXIInterface.scala 15:32]
//     end else if (io_axi_ar_valid) begin // @[CacheAXIInterface.scala 17:25]
//       if (io_axi_ar_ready) begin // @[CacheAXIInterface.scala 18:27]
//         ar_sel_lock <= 1'h0; // @[CacheAXIInterface.scala 19:19]
//       end else begin
//         ar_sel_lock <= 1'h1; // @[CacheAXIInterface.scala 21:23]
//       end
//     end
//     if (reset) begin // @[CacheAXIInterface.scala 16:32]
//       ar_sel_lock_val <= 1'h0; // @[CacheAXIInterface.scala 16:32]
//     end else if (io_axi_ar_valid) begin // @[CacheAXIInterface.scala 17:25]
//       if (!(io_axi_ar_ready)) begin // @[CacheAXIInterface.scala 18:27]
//         if (!(ar_sel_lock)) begin // @[CacheAXIInterface.scala 26:16]
//           ar_sel_lock_val <= ~io_icache_ar_valid & io_dcache_ar_valid;
//         end
//       end
//     end
//   end
// // Register and memory initialization
// `ifdef RANDOMIZE_GARBAGE_ASSIGN
// `define RANDOMIZE
// `endif
// `ifdef RANDOMIZE_INVALID_ASSIGN
// `define RANDOMIZE
// `endif
// `ifdef RANDOMIZE_REG_INIT
// `define RANDOMIZE
// `endif
// `ifdef RANDOMIZE_MEM_INIT
// `define RANDOMIZE
// `endif
// `ifndef RANDOM
// `define RANDOM $random
// `endif
// `ifdef RANDOMIZE_MEM_INIT
//   integer initvar;
// `endif
// `ifndef SYNTHESIS
// `ifdef FIRRTL_BEFORE_INITIAL
// `FIRRTL_BEFORE_INITIAL
// `endif
// initial begin
//   `ifdef RANDOMIZE
//     `ifdef INIT_RANDOM
//       `INIT_RANDOM
//     `endif
//     `ifndef VERILATOR
//       `ifdef RANDOMIZE_DELAY
//         #`RANDOMIZE_DELAY begin end
//       `else
//         #0.002 begin end
//       `endif
//     `endif
// `ifdef RANDOMIZE_REG_INIT
//   _RAND_0 = {1{`RANDOM}};
//   ar_sel_lock = _RAND_0[0:0];
//   _RAND_1 = {1{`RANDOM}};
//   ar_sel_lock_val = _RAND_1[0:0];
// `endif // RANDOMIZE_REG_INIT
//   `endif // RANDOMIZE
// end // initial
// `ifdef FIRRTL_AFTER_INITIAL
// `FIRRTL_AFTER_INITIAL
// `endif
// `endif // SYNTHESIS
// endmodule
