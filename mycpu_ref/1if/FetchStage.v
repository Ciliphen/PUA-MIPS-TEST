module FetchStage(
  input         clock,
  input         reset,
  input         io_memory_ex,
  input  [31:0] io_memory_ex_pc,
  input         io_memory_flush,
  input  [31:0] io_memory_flush_pc,
  input         io_decoder_branch,
  input  [31:0] io_decoder_target,
  input         io_execute_branch,
  input  [31:0] io_execute_target,
  input         io_instBuffer_full,
  input         io_iCache_inst_valid_0,
  input         io_iCache_inst_valid_1,
  output [31:0] io_iCache_pc,
  output [31:0] io_iCache_pc_next
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pc; // @[FetchStage.scala 32:19]
  wire [31:0] _io_iCache_pc_next_T_1 = pc + 32'h8; // @[FetchStage.scala 44:38]
  wire [31:0] _io_iCache_pc_next_T_3 = pc + 32'h4; // @[FetchStage.scala 45:38]
  wire [31:0] _io_iCache_pc_next_T_4 = io_iCache_inst_valid_0 ? _io_iCache_pc_next_T_3 : pc; // @[Mux.scala 101:16]
  wire [31:0] _io_iCache_pc_next_T_5 = io_iCache_inst_valid_1 ? _io_iCache_pc_next_T_1 : _io_iCache_pc_next_T_4; // @[Mux.scala 101:16]
  wire [31:0] _io_iCache_pc_next_T_6 = io_instBuffer_full ? pc : _io_iCache_pc_next_T_5; // @[Mux.scala 101:16]
  wire [31:0] _io_iCache_pc_next_T_7 = io_decoder_branch ? io_decoder_target : _io_iCache_pc_next_T_6; // @[Mux.scala 101:16]
  wire [31:0] _io_iCache_pc_next_T_8 = io_execute_branch ? io_execute_target : _io_iCache_pc_next_T_7; // @[Mux.scala 101:16]
  wire [31:0] _io_iCache_pc_next_T_9 = io_memory_flush ? io_memory_flush_pc : _io_iCache_pc_next_T_8; // @[Mux.scala 101:16]
  assign io_iCache_pc = pc; // @[FetchStage.scala 33:16]
  assign io_iCache_pc_next = io_memory_ex ? io_memory_ex_pc : _io_iCache_pc_next_T_9; // @[Mux.scala 101:16]
  always @(posedge clock) begin
    if (reset) begin // @[FetchStage.scala 32:19]
      pc <= 32'hbfc00000; // @[FetchStage.scala 32:19]
    end else begin
      pc <= io_iCache_pc_next; // @[FetchStage.scala 32:19]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pc = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
