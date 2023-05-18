module PreFetchStage(
  input         clock,
  input         reset,
  input         io_fromFetchStage_valid,
  input         io_fromFetchStage_allowin,
  input         io_fromFetchStage_inst_unable,
  input         io_fromDecoder_br_leaving_ds,
  input         io_fromDecoder_branch_stall,
  input         io_fromDecoder_branch_flag,
  input  [31:0] io_fromDecoder_branch_target_address,
  input         io_fromInstMemory_addr_ok,
  input  [31:0] io_fromInstMemory_rdata,
  input         io_fromInstMemory_data_ok,
  input         io_fromInstMMU_tlb_refill,
  input         io_fromInstMMU_tlb_invalid,
  input         io_fromCtrl_after_ex,
  input         io_fromCtrl_do_flush,
  input  [31:0] io_fromCtrl_flush_pc,
  input         io_fromCtrl_block,
  output        io_fetchStage_valid,
  output        io_fetchStage_inst_ok,
  output [31:0] io_fetchStage_inst,
  output [31:0] io_fetchStage_pc,
  output        io_fetchStage_tlb_refill,
  output        io_fetchStage_ex,
  output [31:0] io_fetchStage_badvaddr,
  output [4:0]  io_fetchStage_excode,
  output        io_instMemory_req,
  output        io_instMemory_waiting,
  output [31:0] io_instMMU_vaddr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg  pfs_valid; // @[PreFetchStage.scala 31:32]
  reg  br_taken_r; // @[PreFetchStage.scala 46:30]
  reg [31:0] br_target_r; // @[PreFetchStage.scala 47:30]
  reg  bd_done_r; // @[PreFetchStage.scala 48:30]
  wire  br_taken = br_taken_r | io_fromDecoder_branch_flag; // @[PreFetchStage.scala 119:27]
  wire  _pfs_ex_T = io_fromInstMMU_tlb_refill | io_fromInstMMU_tlb_invalid; // @[PreFetchStage.scala 163:38]
  wire  bd_done = bd_done_r | io_fromFetchStage_valid; // @[PreFetchStage.scala 121:26]
  wire [31:0] br_target = br_taken_r ? br_target_r : io_fromDecoder_branch_target_address; // @[PreFetchStage.scala 120:19]
  reg [31:0] seq_pc; // @[PreFetchStage.scala 56:23]
  wire [31:0] pc = br_taken & bd_done ? br_target : seq_pc; // @[PreFetchStage.scala 57:19]
  wire  addr_error = pc[1:0] != 2'h0; // @[PreFetchStage.scala 162:30]
  wire  pfs_ex = pfs_valid & (io_fromInstMMU_tlb_refill | io_fromInstMMU_tlb_invalid | addr_error); // @[PreFetchStage.scala 163:23]
  wire  _inst_sram_req_T = ~pfs_ex; // @[PreFetchStage.scala 132:5]
  wire  _inst_sram_req_T_1 = pfs_valid & _inst_sram_req_T; // @[PreFetchStage.scala 131:30]
  reg  addr_ok_r; // @[PreFetchStage.scala 67:34]
  wire  _inst_sram_req_T_2 = ~addr_ok_r; // @[PreFetchStage.scala 133:5]
  wire  _inst_sram_req_T_3 = _inst_sram_req_T_1 & _inst_sram_req_T_2; // @[PreFetchStage.scala 132:13]
  wire  _inst_sram_req_T_5 = ~(bd_done & io_fromDecoder_branch_stall); // @[PreFetchStage.scala 134:5]
  wire  _inst_sram_req_T_6 = _inst_sram_req_T_3 & _inst_sram_req_T_5; // @[PreFetchStage.scala 133:16]
  wire  _inst_sram_req_T_7 = ~io_fromCtrl_do_flush; // @[PreFetchStage.scala 135:5]
  wire  inst_sram_req = _inst_sram_req_T_6 & _inst_sram_req_T_7; // @[PreFetchStage.scala 134:28]
  wire  _addr_ok_T = inst_sram_req & io_fromInstMemory_addr_ok; // @[PreFetchStage.scala 149:29]
  wire  addr_ok = inst_sram_req & io_fromInstMemory_addr_ok | addr_ok_r; // @[PreFetchStage.scala 149:59]
  wire  pfs_ready_go = addr_ok | pfs_ex & ~io_fromCtrl_block; // @[PreFetchStage.scala 86:30]
  wire  pfs_to_fs_valid = pfs_valid & pfs_ready_go & _inst_sram_req_T_7; // @[PreFetchStage.scala 87:48]
  wire  _target_leaving_pfs_T_1 = br_taken & pfs_to_fs_valid & io_fromFetchStage_allowin; // @[PreFetchStage.scala 53:56]
  wire  target_leaving_pfs = br_taken & pfs_to_fs_valid & io_fromFetchStage_allowin & bd_done; // @[PreFetchStage.scala 53:70]
  wire  bd_leaving_pfs = _target_leaving_pfs_T_1 & ~bd_done; // @[PreFetchStage.scala 54:70]
  reg [31:0] inst_buff; // @[PreFetchStage.scala 62:34]
  reg  inst_buff_valid; // @[PreFetchStage.scala 63:34]
  wire  to_pfs_valid = ~reset & _inst_sram_req_T & ~io_fromCtrl_after_ex; // @[PreFetchStage.scala 84:47]
  wire  _pfs_allowin_T_1 = pfs_ready_go & io_fromFetchStage_allowin; // @[PreFetchStage.scala 85:49]
  wire  pfs_allowin = ~pfs_valid | pfs_ready_go & io_fromFetchStage_allowin; // @[PreFetchStage.scala 85:33]
  wire  _GEN_0 = pfs_allowin ? to_pfs_valid : pfs_valid; // @[PreFetchStage.scala 91:27 92:15 31:32]
  wire  _GEN_1 = io_fromCtrl_do_flush | _GEN_0; // @[PreFetchStage.scala 89:18 90:15]
  wire  _T = target_leaving_pfs | io_fromCtrl_do_flush; // @[PreFetchStage.scala 103:27]
  wire  _GEN_6 = bd_leaving_pfs | bd_done_r; // @[PreFetchStage.scala 115:30 116:15 48:30]
  wire [31:0] _seq_pc_T_1 = pc + 32'h4; // @[PreFetchStage.scala 127:18]
  wire  inst_sram_data_ok = io_fromInstMemory_data_ok & io_fromFetchStage_inst_unable; // @[PreFetchStage.scala 139:50]
  wire  _inst_ok_T = addr_ok & inst_sram_data_ok; // @[PreFetchStage.scala 159:42]
  wire  inst_ok = inst_buff_valid | addr_ok & inst_sram_data_ok; // @[PreFetchStage.scala 159:30]
  wire  _T_4 = ~io_fromFetchStage_allowin; // @[PreFetchStage.scala 143:60]
  wire  _GEN_11 = io_fromFetchStage_allowin ? 1'h0 : addr_ok_r; // @[PreFetchStage.scala 145:26 146:15 67:34]
  wire  _GEN_12 = _addr_ok_T & ~io_fromFetchStage_allowin | _GEN_11; // @[PreFetchStage.scala 143:73 144:15]
  wire  _GEN_14 = _inst_ok_T & _T_4 | inst_buff_valid; // @[PreFetchStage.scala 154:59 155:21 63:34]
  wire [4:0] _pfs_excode_T_1 = _pfs_ex_T ? 5'h2 : 5'h1f; // @[Mux.scala 101:16]
  assign io_fetchStage_valid = pfs_valid & pfs_ready_go & _inst_sram_req_T_7; // @[PreFetchStage.scala 87:48]
  assign io_fetchStage_inst_ok = inst_buff_valid | addr_ok & inst_sram_data_ok; // @[PreFetchStage.scala 159:30]
  assign io_fetchStage_inst = inst_buff_valid ? inst_buff : io_fromInstMemory_rdata; // @[PreFetchStage.scala 160:17]
  assign io_fetchStage_pc = br_taken & bd_done ? br_target : seq_pc; // @[PreFetchStage.scala 57:19]
  assign io_fetchStage_tlb_refill = io_fromInstMMU_tlb_refill; // @[PreFetchStage.scala 75:28]
  assign io_fetchStage_ex = pfs_valid & (io_fromInstMMU_tlb_refill | io_fromInstMMU_tlb_invalid | addr_error); // @[PreFetchStage.scala 163:23]
  assign io_fetchStage_badvaddr = br_taken & bd_done ? br_target : seq_pc; // @[PreFetchStage.scala 57:19]
  assign io_fetchStage_excode = addr_error ? 5'h4 : _pfs_excode_T_1; // @[Mux.scala 101:16]
  assign io_instMemory_req = _inst_sram_req_T_6 & _inst_sram_req_T_7; // @[PreFetchStage.scala 134:28]
  assign io_instMemory_waiting = addr_ok & ~inst_ok; // @[PreFetchStage.scala 137:29]
  assign io_instMMU_vaddr = br_taken & bd_done ? br_target : seq_pc; // @[PreFetchStage.scala 57:19]
  always @(posedge clock) begin
    if (reset) begin // @[PreFetchStage.scala 31:32]
      pfs_valid <= 1'h0; // @[PreFetchStage.scala 31:32]
    end else begin
      pfs_valid <= _GEN_1;
    end
    if (reset) begin // @[PreFetchStage.scala 46:30]
      br_taken_r <= 1'h0; // @[PreFetchStage.scala 46:30]
    end else if (target_leaving_pfs | io_fromCtrl_do_flush) begin // @[PreFetchStage.scala 103:40]
      br_taken_r <= 1'h0; // @[PreFetchStage.scala 104:17]
    end else if (io_fromDecoder_br_leaving_ds) begin // @[PreFetchStage.scala 106:29]
      br_taken_r <= io_fromDecoder_branch_flag; // @[PreFetchStage.scala 107:17]
    end
    if (reset) begin // @[PreFetchStage.scala 47:30]
      br_target_r <= 32'h0; // @[PreFetchStage.scala 47:30]
    end else if (target_leaving_pfs | io_fromCtrl_do_flush) begin // @[PreFetchStage.scala 103:40]
      br_target_r <= 32'h0; // @[PreFetchStage.scala 105:17]
    end else if (io_fromDecoder_br_leaving_ds) begin // @[PreFetchStage.scala 106:29]
      br_target_r <= io_fromDecoder_branch_target_address; // @[PreFetchStage.scala 108:17]
    end
    if (reset) begin // @[PreFetchStage.scala 48:30]
      bd_done_r <= 1'h0; // @[PreFetchStage.scala 48:30]
    end else if (_T) begin // @[PreFetchStage.scala 111:40]
      bd_done_r <= 1'h0; // @[PreFetchStage.scala 112:15]
    end else if (io_fromDecoder_br_leaving_ds) begin // @[PreFetchStage.scala 113:29]
      bd_done_r <= io_fromFetchStage_valid | pfs_to_fs_valid & io_fromFetchStage_allowin; // @[PreFetchStage.scala 114:15]
    end else begin
      bd_done_r <= _GEN_6;
    end
    if (reset) begin // @[PreFetchStage.scala 56:23]
      seq_pc <= 32'hbfc00000; // @[PreFetchStage.scala 56:23]
    end else if (io_fromCtrl_do_flush) begin // @[PreFetchStage.scala 124:18]
      seq_pc <= io_fromCtrl_flush_pc; // @[PreFetchStage.scala 125:12]
    end else if (_pfs_allowin_T_1) begin // @[PreFetchStage.scala 126:42]
      seq_pc <= _seq_pc_T_1; // @[PreFetchStage.scala 127:12]
    end
    if (reset) begin // @[PreFetchStage.scala 67:34]
      addr_ok_r <= 1'h0; // @[PreFetchStage.scala 67:34]
    end else if (io_fromCtrl_do_flush) begin // @[PreFetchStage.scala 141:18]
      addr_ok_r <= 1'h0; // @[PreFetchStage.scala 142:15]
    end else begin
      addr_ok_r <= _GEN_12;
    end
    if (reset) begin // @[PreFetchStage.scala 62:34]
      inst_buff <= 32'h0; // @[PreFetchStage.scala 62:34]
    end else if (io_fromFetchStage_allowin | io_fromCtrl_do_flush) begin // @[PreFetchStage.scala 151:32]
      inst_buff <= 32'h0; // @[PreFetchStage.scala 153:21]
    end else if (_inst_ok_T & _T_4) begin // @[PreFetchStage.scala 154:59]
      inst_buff <= io_fromInstMemory_rdata; // @[PreFetchStage.scala 156:21]
    end
    if (reset) begin // @[PreFetchStage.scala 63:34]
      inst_buff_valid <= 1'h0; // @[PreFetchStage.scala 63:34]
    end else if (io_fromFetchStage_allowin | io_fromCtrl_do_flush) begin // @[PreFetchStage.scala 151:32]
      inst_buff_valid <= 1'h0; // @[PreFetchStage.scala 152:21]
    end else begin
      inst_buff_valid <= _GEN_14;
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
  pfs_valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  br_taken_r = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  br_target_r = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  bd_done_r = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  seq_pc = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  addr_ok_r = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  inst_buff = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  inst_buff_valid = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FetchStage(
  input         clock,
  input         reset,
  input         io_fromPreFetchStage_valid,
  input         io_fromPreFetchStage_inst_ok,
  input  [31:0] io_fromPreFetchStage_inst,
  input  [31:0] io_fromPreFetchStage_pc,
  input         io_fromPreFetchStage_tlb_refill,
  input         io_fromPreFetchStage_ex,
  input  [31:0] io_fromPreFetchStage_badvaddr,
  input  [4:0]  io_fromPreFetchStage_excode,
  input         io_fromInstMemory_data_ok,
  input  [31:0] io_fromInstMemory_rdata,
  input         io_fromDecoder_allowin,
  input         io_fromCtrl_do_flush,
  output        io_ctrl_ex,
  output        io_preFetchStage_valid,
  output        io_preFetchStage_allowin,
  output        io_preFetchStage_inst_unable,
  output        io_decoderStage_valid,
  output        io_decoderStage_tlb_refill,
  output [4:0]  io_decoderStage_excode,
  output        io_decoderStage_ex,
  output [31:0] io_decoderStage_badvaddr,
  output [31:0] io_decoderStage_inst,
  output [31:0] io_decoderStage_pc,
  output        io_instMemory_waiting
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  reg  fs_valid; // @[FetchStage.scala 21:35]
  reg  pfs_to_fs_inst_ok; // @[FetchStage.scala 25:35]
  reg [31:0] pfs_to_fs_inst; // @[FetchStage.scala 26:35]
  reg [31:0] pc; // @[FetchStage.scala 27:35]
  reg [31:0] inst_buff; // @[FetchStage.scala 28:35]
  reg  inst_buff_valid; // @[FetchStage.scala 29:35]
  reg  fs_tlb_refill; // @[FetchStage.scala 30:35]
  reg  pfs_to_fs_ex; // @[FetchStage.scala 31:35]
  reg [31:0] pfs_to_fs_badvaddr; // @[FetchStage.scala 32:35]
  reg [4:0] pfs_to_fs_excode; // @[FetchStage.scala 33:35]
  wire  _io_preFetchStage_inst_unable_T = ~fs_valid; // @[FetchStage.scala 47:35]
  wire  inst_ok = pfs_to_fs_inst_ok | inst_buff_valid | fs_valid & io_fromInstMemory_data_ok; // @[FetchStage.scala 93:51]
  wire  ex = fs_valid & pfs_to_fs_ex; // @[FetchStage.scala 103:24]
  wire  ready_go = inst_ok | ex; // @[FetchStage.scala 62:29]
  wire  allowin = _io_preFetchStage_inst_unable_T | ready_go & io_fromDecoder_allowin; // @[FetchStage.scala 63:31]
  wire  _GEN_9 = io_fromDecoder_allowin ? 1'h0 : inst_buff_valid; // @[FetchStage.scala 88:38 89:21 29:35]
  wire  _GEN_11 = ~inst_buff_valid & fs_valid & io_fromInstMemory_data_ok & ~io_fromDecoder_allowin | _GEN_9; // @[FetchStage.scala 85:100 86:21]
  wire [31:0] _inst_temp_T = inst_buff_valid ? inst_buff : io_fromInstMemory_rdata; // @[Mux.scala 101:16]
  wire [31:0] inst_temp = pfs_to_fs_inst_ok ? pfs_to_fs_inst : _inst_temp_T; // @[Mux.scala 101:16]
  assign io_ctrl_ex = fs_valid & pfs_to_fs_ex; // @[FetchStage.scala 103:24]
  assign io_preFetchStage_valid = fs_valid; // @[FetchStage.scala 45:32]
  assign io_preFetchStage_allowin = _io_preFetchStage_inst_unable_T | ready_go & io_fromDecoder_allowin; // @[FetchStage.scala 63:31]
  assign io_preFetchStage_inst_unable = ~fs_valid | inst_buff_valid | pfs_to_fs_inst_ok; // @[FetchStage.scala 47:64]
  assign io_decoderStage_valid = fs_valid & ready_go & ~io_fromCtrl_do_flush; // @[FetchStage.scala 64:42]
  assign io_decoderStage_tlb_refill = fs_tlb_refill; // @[FetchStage.scala 55:30]
  assign io_decoderStage_excode = pfs_to_fs_excode; // @[FetchStage.scala 105:12 43:22]
  assign io_decoderStage_ex = fs_valid & pfs_to_fs_ex; // @[FetchStage.scala 103:24]
  assign io_decoderStage_badvaddr = pfs_to_fs_badvaddr; // @[FetchStage.scala 104:12 42:22]
  assign io_decoderStage_inst = ~ex ? inst_temp : 32'h0; // @[FetchStage.scala 101:14]
  assign io_decoderStage_pc = pc; // @[FetchStage.scala 50:30]
  assign io_instMemory_waiting = fs_valid & ~inst_ok; // @[FetchStage.scala 57:37]
  always @(posedge clock) begin
    if (reset) begin // @[FetchStage.scala 21:35]
      fs_valid <= 1'h0; // @[FetchStage.scala 21:35]
    end else if (io_fromCtrl_do_flush) begin // @[FetchStage.scala 66:18]
      fs_valid <= 1'h0; // @[FetchStage.scala 67:14]
    end else if (allowin) begin // @[FetchStage.scala 68:23]
      fs_valid <= io_fromPreFetchStage_valid; // @[FetchStage.scala 69:14]
    end
    if (reset) begin // @[FetchStage.scala 25:35]
      pfs_to_fs_inst_ok <= 1'h0; // @[FetchStage.scala 25:35]
    end else if (io_fromPreFetchStage_valid & allowin) begin // @[FetchStage.scala 72:47]
      pfs_to_fs_inst_ok <= io_fromPreFetchStage_inst_ok; // @[FetchStage.scala 73:24]
    end
    if (reset) begin // @[FetchStage.scala 26:35]
      pfs_to_fs_inst <= 32'h0; // @[FetchStage.scala 26:35]
    end else if (io_fromPreFetchStage_valid & allowin) begin // @[FetchStage.scala 72:47]
      pfs_to_fs_inst <= io_fromPreFetchStage_inst; // @[FetchStage.scala 74:24]
    end
    if (reset) begin // @[FetchStage.scala 27:35]
      pc <= 32'h0; // @[FetchStage.scala 27:35]
    end else if (io_fromPreFetchStage_valid & allowin) begin // @[FetchStage.scala 72:47]
      pc <= io_fromPreFetchStage_pc; // @[FetchStage.scala 75:24]
    end
    if (reset) begin // @[FetchStage.scala 28:35]
      inst_buff <= 32'h0; // @[FetchStage.scala 28:35]
    end else if (io_fromCtrl_do_flush) begin // @[FetchStage.scala 82:18]
      inst_buff <= 32'h0; // @[FetchStage.scala 84:21]
    end else if (~inst_buff_valid & fs_valid & io_fromInstMemory_data_ok & ~io_fromDecoder_allowin) begin // @[FetchStage.scala 85:100]
      inst_buff <= io_fromInstMemory_rdata; // @[FetchStage.scala 87:21]
    end else if (io_fromDecoder_allowin) begin // @[FetchStage.scala 88:38]
      inst_buff <= 32'h0; // @[FetchStage.scala 90:21]
    end
    if (reset) begin // @[FetchStage.scala 29:35]
      inst_buff_valid <= 1'h0; // @[FetchStage.scala 29:35]
    end else if (io_fromCtrl_do_flush) begin // @[FetchStage.scala 82:18]
      inst_buff_valid <= 1'h0; // @[FetchStage.scala 83:21]
    end else begin
      inst_buff_valid <= _GEN_11;
    end
    if (reset) begin // @[FetchStage.scala 30:35]
      fs_tlb_refill <= 1'h0; // @[FetchStage.scala 30:35]
    end else if (io_fromPreFetchStage_valid & allowin) begin // @[FetchStage.scala 72:47]
      fs_tlb_refill <= io_fromPreFetchStage_tlb_refill; // @[FetchStage.scala 76:24]
    end
    if (reset) begin // @[FetchStage.scala 31:35]
      pfs_to_fs_ex <= 1'h0; // @[FetchStage.scala 31:35]
    end else if (io_fromPreFetchStage_valid & allowin) begin // @[FetchStage.scala 72:47]
      pfs_to_fs_ex <= io_fromPreFetchStage_ex; // @[FetchStage.scala 77:24]
    end
    if (reset) begin // @[FetchStage.scala 32:35]
      pfs_to_fs_badvaddr <= 32'h0; // @[FetchStage.scala 32:35]
    end else if (io_fromPreFetchStage_valid & allowin) begin // @[FetchStage.scala 72:47]
      pfs_to_fs_badvaddr <= io_fromPreFetchStage_badvaddr; // @[FetchStage.scala 78:24]
    end
    if (reset) begin // @[FetchStage.scala 33:35]
      pfs_to_fs_excode <= 5'h0; // @[FetchStage.scala 33:35]
    end else if (io_fromPreFetchStage_valid & allowin) begin // @[FetchStage.scala 72:47]
      pfs_to_fs_excode <= io_fromPreFetchStage_excode; // @[FetchStage.scala 79:24]
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
  fs_valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  pfs_to_fs_inst_ok = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  pfs_to_fs_inst = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  pc = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  inst_buff = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  inst_buff_valid = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  fs_tlb_refill = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  pfs_to_fs_ex = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  pfs_to_fs_badvaddr = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  pfs_to_fs_excode = _RAND_9[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DecoderStage(
  input         clock,
  input         reset,
  input         io_fromFetchStage_valid,
  input         io_fromFetchStage_tlb_refill,
  input  [4:0]  io_fromFetchStage_excode,
  input         io_fromFetchStage_ex,
  input  [31:0] io_fromFetchStage_badvaddr,
  input  [31:0] io_fromFetchStage_inst,
  input  [31:0] io_fromFetchStage_pc,
  input         io_fromDecoder_allowin,
  input         io_fromCtrl_do_flush,
  output        io_decoder_do_flush,
  output        io_decoder_valid,
  output        io_decoder_tlb_refill,
  output [4:0]  io_decoder_excode,
  output        io_decoder_ex,
  output [31:0] io_decoder_badvaddr,
  output [31:0] io_decoder_inst,
  output [31:0] io_decoder_pc
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pc; // @[DecoderStage.scala 15:27]
  reg [31:0] inst; // @[DecoderStage.scala 16:27]
  reg  ex; // @[DecoderStage.scala 17:27]
  reg [31:0] badvaddr; // @[DecoderStage.scala 18:27]
  reg  valid; // @[DecoderStage.scala 19:27]
  reg  tlb_refill; // @[DecoderStage.scala 20:27]
  reg [4:0] excode; // @[DecoderStage.scala 21:27]
  assign io_decoder_do_flush = io_fromCtrl_do_flush; // @[DecoderStage.scala 25:23]
  assign io_decoder_valid = valid; // @[DecoderStage.scala 28:25]
  assign io_decoder_tlb_refill = tlb_refill; // @[DecoderStage.scala 34:25]
  assign io_decoder_excode = excode; // @[DecoderStage.scala 33:25]
  assign io_decoder_ex = ex; // @[DecoderStage.scala 31:25]
  assign io_decoder_badvaddr = badvaddr; // @[DecoderStage.scala 32:25]
  assign io_decoder_inst = inst; // @[DecoderStage.scala 30:25]
  assign io_decoder_pc = pc; // @[DecoderStage.scala 29:25]
  always @(posedge clock) begin
    if (reset) begin // @[DecoderStage.scala 15:27]
      pc <= 32'h0; // @[DecoderStage.scala 15:27]
    end else if (io_fromFetchStage_valid & io_fromDecoder_allowin) begin // @[DecoderStage.scala 42:59]
      pc <= io_fromFetchStage_pc; // @[DecoderStage.scala 43:16]
    end
    if (reset) begin // @[DecoderStage.scala 16:27]
      inst <= 32'h0; // @[DecoderStage.scala 16:27]
    end else if (io_fromFetchStage_valid & io_fromDecoder_allowin) begin // @[DecoderStage.scala 42:59]
      inst <= io_fromFetchStage_inst; // @[DecoderStage.scala 44:16]
    end
    if (reset) begin // @[DecoderStage.scala 17:27]
      ex <= 1'h0; // @[DecoderStage.scala 17:27]
    end else if (io_fromFetchStage_valid & io_fromDecoder_allowin) begin // @[DecoderStage.scala 42:59]
      ex <= io_fromFetchStage_ex; // @[DecoderStage.scala 45:16]
    end
    if (reset) begin // @[DecoderStage.scala 18:27]
      badvaddr <= 32'h0; // @[DecoderStage.scala 18:27]
    end else if (io_fromFetchStage_valid & io_fromDecoder_allowin) begin // @[DecoderStage.scala 42:59]
      badvaddr <= io_fromFetchStage_badvaddr; // @[DecoderStage.scala 46:16]
    end
    if (reset) begin // @[DecoderStage.scala 19:27]
      valid <= 1'h0; // @[DecoderStage.scala 19:27]
    end else if (io_fromCtrl_do_flush) begin // @[DecoderStage.scala 36:30]
      valid <= 1'h0; // @[DecoderStage.scala 37:11]
    end else if (io_fromDecoder_allowin) begin // @[DecoderStage.scala 38:38]
      valid <= io_fromFetchStage_valid; // @[DecoderStage.scala 39:11]
    end
    if (reset) begin // @[DecoderStage.scala 20:27]
      tlb_refill <= 1'h0; // @[DecoderStage.scala 20:27]
    end else if (io_fromFetchStage_valid & io_fromDecoder_allowin) begin // @[DecoderStage.scala 42:59]
      tlb_refill <= io_fromFetchStage_tlb_refill; // @[DecoderStage.scala 48:16]
    end
    if (reset) begin // @[DecoderStage.scala 21:27]
      excode <= 5'h0; // @[DecoderStage.scala 21:27]
    end else if (io_fromFetchStage_valid & io_fromDecoder_allowin) begin // @[DecoderStage.scala 42:59]
      excode <= io_fromFetchStage_excode; // @[DecoderStage.scala 47:16]
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
  _RAND_1 = {1{`RANDOM}};
  inst = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  ex = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  badvaddr = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  valid = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  tlb_refill = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  excode = _RAND_6[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Decoder(
  input         clock,
  input         reset,
  input         io_fromDecoderStage_do_flush,
  input         io_fromDecoderStage_valid,
  input         io_fromDecoderStage_tlb_refill,
  input  [4:0]  io_fromDecoderStage_excode,
  input         io_fromDecoderStage_ex,
  input  [31:0] io_fromDecoderStage_badvaddr,
  input  [31:0] io_fromDecoderStage_inst,
  input  [31:0] io_fromDecoderStage_pc,
  input  [4:0]  io_fromExecute_reg_waddr,
  input  [31:0] io_fromExecute_reg_wdata,
  input  [3:0]  io_fromExecute_reg_wen,
  input         io_fromExecute_allowin,
  input         io_fromExecute_blk_valid,
  input         io_fromExecute_inst_is_mfc0,
  input         io_fromExecute_es_fwd_valid,
  input  [31:0] io_fromRegfile_reg1_data,
  input  [31:0] io_fromRegfile_reg2_data,
  input  [4:0]  io_fromMemory_reg_waddr,
  input  [31:0] io_fromMemory_reg_wdata,
  input  [3:0]  io_fromMemory_reg_wen,
  input         io_fromMemory_inst_is_mfc0,
  input         io_fromMemory_ms_fwd_valid,
  input         io_fromMemory_blk_valid,
  input         io_fromWriteBackStage_inst_is_mfc0,
  input  [4:0]  io_fromWriteBackStage_reg_waddr,
  input  [31:0] io_fromWriteBackStage_cp0_cause,
  input  [31:0] io_fromWriteBackStage_cp0_status,
  output        io_preFetchStage_br_leaving_ds,
  output        io_preFetchStage_branch_stall,
  output        io_preFetchStage_branch_flag,
  output [31:0] io_preFetchStage_branch_target_address,
  output        io_fetchStage_allowin,
  output        io_decoderStage_allowin,
  output [6:0]  io_executeStage_aluop,
  output [2:0]  io_executeStage_alusel,
  output [31:0] io_executeStage_inst,
  output [31:0] io_executeStage_link_addr,
  output [31:0] io_executeStage_reg1,
  output [31:0] io_executeStage_reg2,
  output [4:0]  io_executeStage_reg_waddr,
  output [3:0]  io_executeStage_reg_wen,
  output [31:0] io_executeStage_pc,
  output        io_executeStage_valid,
  output        io_executeStage_ex,
  output        io_executeStage_bd,
  output [31:0] io_executeStage_badvaddr,
  output [7:0]  io_executeStage_cp0_addr,
  output [4:0]  io_executeStage_excode,
  output        io_executeStage_overflow_inst,
  output        io_executeStage_tlb_refill,
  output        io_executeStage_after_tlb,
  output        io_executeStage_mem_re,
  output        io_executeStage_mem_we,
  output [4:0]  io_regfile_reg1_raddr,
  output [4:0]  io_regfile_reg2_raddr,
  output        io_ctrl_ex
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  bd; // @[Decoder.scala 74:39]
  wire  _signals_T_1 = 32'h0 == io_fromDecoderStage_inst; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_2 = io_fromDecoderStage_inst & 32'hfc0007ff; // @[Lookup.scala 31:38]
  wire  _signals_T_3 = 32'h25 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_5 = 32'h24 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_7 = 32'h26 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_9 = 32'h27 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_11 = 32'h4 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_13 = 32'h6 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_15 = 32'h7 == _signals_T_2; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_16 = io_fromDecoderStage_inst & 32'hffe0003f; // @[Lookup.scala 31:38]
  wire  _signals_T_17 = 32'h0 == _signals_T_16; // @[Lookup.scala 31:38]
  wire  _signals_T_19 = 32'h2 == _signals_T_16; // @[Lookup.scala 31:38]
  wire  _signals_T_21 = 32'h3 == _signals_T_16; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_22 = io_fromDecoderStage_inst & 32'hfc000000; // @[Lookup.scala 31:38]
  wire  _signals_T_23 = 32'h34000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_25 = 32'h30000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_27 = 32'h38000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_28 = io_fromDecoderStage_inst & 32'hffe00000; // @[Lookup.scala 31:38]
  wire  _signals_T_29 = 32'h3c000000 == _signals_T_28; // @[Lookup.scala 31:38]
  wire  _signals_T_31 = 32'hb == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_33 = 32'ha == _signals_T_2; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_34 = io_fromDecoderStage_inst & 32'hffff07ff; // @[Lookup.scala 31:38]
  wire  _signals_T_35 = 32'h10 == _signals_T_34; // @[Lookup.scala 31:38]
  wire  _signals_T_37 = 32'h12 == _signals_T_34; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_38 = io_fromDecoderStage_inst & 32'hfc1fffff; // @[Lookup.scala 31:38]
  wire  _signals_T_39 = 32'h11 == _signals_T_38; // @[Lookup.scala 31:38]
  wire  _signals_T_41 = 32'h13 == _signals_T_38; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_42 = io_fromDecoderStage_inst & 32'hffe007f8; // @[Lookup.scala 31:38]
  wire  _signals_T_43 = 32'h40000000 == _signals_T_42; // @[Lookup.scala 31:38]
  wire  _signals_T_45 = 32'h40800000 == _signals_T_42; // @[Lookup.scala 31:38]
  wire  _signals_T_47 = 32'h2a == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_49 = 32'h2b == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_51 = 32'h28000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_53 = 32'h2c000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_54 = io_fromDecoderStage_inst & 32'hfc00003f; // @[Lookup.scala 31:38]
  wire  _signals_T_55 = 32'h34 == _signals_T_54; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_56 = io_fromDecoderStage_inst & 32'hfc1f0000; // @[Lookup.scala 31:38]
  wire  _signals_T_57 = 32'h40c0000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_59 = 32'h30 == _signals_T_54; // @[Lookup.scala 31:38]
  wire  _signals_T_61 = 32'h4080000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_63 = 32'h4090000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_65 = 32'h31 == _signals_T_54; // @[Lookup.scala 31:38]
  wire  _signals_T_67 = 32'h32 == _signals_T_54; // @[Lookup.scala 31:38]
  wire  _signals_T_69 = 32'h40a0000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_71 = 32'h33 == _signals_T_54; // @[Lookup.scala 31:38]
  wire  _signals_T_73 = 32'h40b0000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_75 = 32'h36 == _signals_T_54; // @[Lookup.scala 31:38]
  wire  _signals_T_77 = 32'h40e0000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_79 = 32'h20 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_81 = 32'h21 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_83 = 32'h22 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_85 = 32'h23 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_87 = 32'h70000002 == _signals_T_2; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_88 = io_fromDecoderStage_inst & 32'hfc00ffff; // @[Lookup.scala 31:38]
  wire  _signals_T_89 = 32'h18 == _signals_T_88; // @[Lookup.scala 31:38]
  wire  _signals_T_91 = 32'h19 == _signals_T_88; // @[Lookup.scala 31:38]
  wire  _signals_T_93 = 32'h70000000 == _signals_T_88; // @[Lookup.scala 31:38]
  wire  _signals_T_95 = 32'h70000001 == _signals_T_88; // @[Lookup.scala 31:38]
  wire  _signals_T_97 = 32'h70000004 == _signals_T_88; // @[Lookup.scala 31:38]
  wire  _signals_T_99 = 32'h70000005 == _signals_T_88; // @[Lookup.scala 31:38]
  wire  _signals_T_101 = 32'h1a == _signals_T_88; // @[Lookup.scala 31:38]
  wire  _signals_T_103 = 32'h1b == _signals_T_88; // @[Lookup.scala 31:38]
  wire  _signals_T_105 = 32'h70000021 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_107 = 32'h70000020 == _signals_T_2; // @[Lookup.scala 31:38]
  wire  _signals_T_109 = 32'h20000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_111 = 32'h24000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_113 = 32'h8000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_115 = 32'hc000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_116 = io_fromDecoderStage_inst & 32'hfc1ff83f; // @[Lookup.scala 31:38]
  wire  _signals_T_117 = 32'h8 == _signals_T_116; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_118 = io_fromDecoderStage_inst & 32'hfc1f003f; // @[Lookup.scala 31:38]
  wire  _signals_T_119 = 32'h9 == _signals_T_118; // @[Lookup.scala 31:38]
  wire  _signals_T_121 = 32'h10000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_123 = 32'h14000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_125 = 32'h1c000000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_127 = 32'h18000000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_129 = 32'h4010000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_131 = 32'h4110000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_133 = 32'h4000000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_135 = 32'h4100000 == _signals_T_56; // @[Lookup.scala 31:38]
  wire  _signals_T_137 = 32'h42000008 == io_fromDecoderStage_inst; // @[Lookup.scala 31:38]
  wire  _signals_T_139 = 32'h42000001 == io_fromDecoderStage_inst; // @[Lookup.scala 31:38]
  wire  _signals_T_141 = 32'h42000002 == io_fromDecoderStage_inst; // @[Lookup.scala 31:38]
  wire  _signals_T_143 = 32'hc == _signals_T_54; // @[Lookup.scala 31:38]
  wire  _signals_T_145 = 32'hd == _signals_T_54; // @[Lookup.scala 31:38]
  wire  _signals_T_147 = 32'h42000018 == io_fromDecoderStage_inst; // @[Lookup.scala 31:38]
  wire  _signals_T_149 = 32'h80000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_151 = 32'h90000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_153 = 32'h84000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_155 = 32'h94000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_157 = 32'h8c000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_159 = 32'ha0000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_161 = 32'ha4000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_163 = 32'hac000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_165 = 32'h88000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_167 = 32'h98000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_169 = 32'ha8000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_171 = 32'hb8000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_173 = 32'hc0000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_175 = 32'he0000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire [31:0] _signals_T_176 = io_fromDecoderStage_inst & 32'hfffff83f; // @[Lookup.scala 31:38]
  wire  _signals_T_177 = 32'hf == _signals_T_176; // @[Lookup.scala 31:38]
  wire  _signals_T_179 = 32'hcc000000 == _signals_T_22; // @[Lookup.scala 31:38]
  wire  _signals_T_181 = 32'h4c00000f == _signals_T_2; // @[Lookup.scala 31:38]
  wire [6:0] _signals_T_545 = _signals_T_175 ? 7'h39 : 7'h0; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_546 = _signals_T_173 ? 7'h34 : _signals_T_545; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_547 = _signals_T_171 ? 7'h3d : _signals_T_546; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_548 = _signals_T_169 ? 7'h3c : _signals_T_547; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_549 = _signals_T_167 ? 7'h37 : _signals_T_548; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_550 = _signals_T_165 ? 7'h36 : _signals_T_549; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_551 = _signals_T_163 ? 7'h3b : _signals_T_550; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_552 = _signals_T_161 ? 7'h3a : _signals_T_551; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_553 = _signals_T_159 ? 7'h38 : _signals_T_552; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_554 = _signals_T_157 ? 7'h35 : _signals_T_553; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_555 = _signals_T_155 ? 7'h33 : _signals_T_554; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_556 = _signals_T_153 ? 7'h32 : _signals_T_555; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_557 = _signals_T_151 ? 7'h31 : _signals_T_556; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_558 = _signals_T_149 ? 7'h30 : _signals_T_557; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_559 = _signals_T_147 ? 7'h46 : _signals_T_558; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_560 = _signals_T_145 ? 7'h45 : _signals_T_559; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_561 = _signals_T_143 ? 7'h44 : _signals_T_560; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_562 = _signals_T_141 ? 7'h4a : _signals_T_561; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_563 = _signals_T_139 ? 7'h49 : _signals_T_562; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_564 = _signals_T_137 ? 7'h48 : _signals_T_563; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_565 = _signals_T_135 ? 7'h2e : _signals_T_564; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_566 = _signals_T_133 ? 7'h2d : _signals_T_565; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_567 = _signals_T_131 ? 7'h2a : _signals_T_566; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_568 = _signals_T_129 ? 7'h29 : _signals_T_567; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_569 = _signals_T_127 ? 7'h2c : _signals_T_568; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_570 = _signals_T_125 ? 7'h2b : _signals_T_569; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_571 = _signals_T_123 ? 7'h2f : _signals_T_570; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_572 = _signals_T_121 ? 7'h28 : _signals_T_571; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_573 = _signals_T_119 ? 7'h26 : _signals_T_572; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_574 = _signals_T_117 ? 7'h27 : _signals_T_573; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_575 = _signals_T_115 ? 7'h25 : _signals_T_574; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_576 = _signals_T_113 ? 7'h24 : _signals_T_575; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_577 = _signals_T_111 ? 7'h16 : _signals_T_576; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_578 = _signals_T_109 ? 7'h15 : _signals_T_577; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_579 = _signals_T_107 ? 7'h19 : _signals_T_578; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_580 = _signals_T_105 ? 7'h1a : _signals_T_579; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_581 = _signals_T_103 ? 7'h23 : _signals_T_580; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_582 = _signals_T_101 ? 7'h22 : _signals_T_581; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_583 = _signals_T_99 ? 7'h21 : _signals_T_582; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_584 = _signals_T_97 ? 7'h20 : _signals_T_583; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_585 = _signals_T_95 ? 7'h1f : _signals_T_584; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_586 = _signals_T_93 ? 7'h1e : _signals_T_585; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_587 = _signals_T_91 ? 7'h1c : _signals_T_586; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_588 = _signals_T_89 ? 7'h1b : _signals_T_587; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_589 = _signals_T_87 ? 7'h1d : _signals_T_588; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_590 = _signals_T_85 ? 7'h18 : _signals_T_589; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_591 = _signals_T_83 ? 7'h17 : _signals_T_590; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_592 = _signals_T_81 ? 7'h16 : _signals_T_591; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_593 = _signals_T_79 ? 7'h15 : _signals_T_592; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_594 = _signals_T_77 ? 7'h43 : _signals_T_593; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_595 = _signals_T_75 ? 7'h43 : _signals_T_594; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_596 = _signals_T_73 ? 7'h42 : _signals_T_595; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_597 = _signals_T_71 ? 7'h42 : _signals_T_596; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_598 = _signals_T_69 ? 7'h41 : _signals_T_597; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_599 = _signals_T_67 ? 7'h41 : _signals_T_598; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_600 = _signals_T_65 ? 7'h40 : _signals_T_599; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_601 = _signals_T_63 ? 7'h40 : _signals_T_600; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_602 = _signals_T_61 ? 7'h3f : _signals_T_601; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_603 = _signals_T_59 ? 7'h3f : _signals_T_602; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_604 = _signals_T_57 ? 7'h3e : _signals_T_603; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_605 = _signals_T_55 ? 7'h3e : _signals_T_604; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_606 = _signals_T_53 ? 7'h14 : _signals_T_605; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_607 = _signals_T_51 ? 7'h13 : _signals_T_606; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_608 = _signals_T_49 ? 7'h14 : _signals_T_607; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_609 = _signals_T_47 ? 7'h13 : _signals_T_608; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_610 = _signals_T_45 ? 7'h12 : _signals_T_609; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_611 = _signals_T_43 ? 7'h11 : _signals_T_610; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_612 = _signals_T_41 ? 7'h10 : _signals_T_611; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_613 = _signals_T_39 ? 7'he : _signals_T_612; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_614 = _signals_T_37 ? 7'hf : _signals_T_613; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_615 = _signals_T_35 ? 7'hd : _signals_T_614; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_616 = _signals_T_33 ? 7'hb : _signals_T_615; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_617 = _signals_T_31 ? 7'hc : _signals_T_616; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_618 = _signals_T_29 ? 7'h2 : _signals_T_617; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_619 = _signals_T_27 ? 7'h3 : _signals_T_618; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_620 = _signals_T_25 ? 7'h1 : _signals_T_619; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_621 = _signals_T_23 ? 7'h2 : _signals_T_620; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_622 = _signals_T_21 ? 7'h9 : _signals_T_621; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_623 = _signals_T_19 ? 7'h7 : _signals_T_622; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_624 = _signals_T_17 ? 7'h5 : _signals_T_623; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_625 = _signals_T_15 ? 7'h9 : _signals_T_624; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_626 = _signals_T_13 ? 7'h7 : _signals_T_625; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_627 = _signals_T_11 ? 7'h5 : _signals_T_626; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_628 = _signals_T_9 ? 7'h4 : _signals_T_627; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_629 = _signals_T_7 ? 7'h3 : _signals_T_628; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_630 = _signals_T_5 ? 7'h1 : _signals_T_629; // @[Lookup.scala 34:39]
  wire [6:0] _signals_T_631 = _signals_T_3 ? 7'h2 : _signals_T_630; // @[Lookup.scala 34:39]
  wire [6:0] csOpType = _signals_T_1 ? 7'h0 : _signals_T_631; // @[Lookup.scala 34:39]
  wire  ds_is_branch = (csOpType == 7'h27 | csOpType == 7'h26 | csOpType == 7'h24 | csOpType == 7'h25 | csOpType == 7'h28
     | csOpType == 7'h2f | csOpType == 7'h2b | csOpType == 7'h29 | csOpType == 7'h2a | csOpType == 7'h2d | csOpType == 7'h2e
     | csOpType == 7'h2c) & io_fromDecoderStage_valid; // @[Decoder.scala 77:324]
  wire [7:0] cp0_addr = {io_fromDecoderStage_inst[15:11],io_fromDecoderStage_inst[2:0]}; // @[Cat.scala 33:92]
  reg  after_tlb; // @[Decoder.scala 79:26]
  wire  _signals_T_289 = _signals_T_147 ? 1'h0 : _signals_T_149 | (_signals_T_151 | (_signals_T_153 | (_signals_T_155 |
    (_signals_T_157 | (_signals_T_159 | (_signals_T_161 | (_signals_T_163 | (_signals_T_165 | (_signals_T_167 | (
    _signals_T_169 | (_signals_T_171 | (_signals_T_173 | _signals_T_175)))))))))))); // @[Lookup.scala 34:39]
  wire  _signals_T_290 = _signals_T_145 ? 1'h0 : _signals_T_289; // @[Lookup.scala 34:39]
  wire  _signals_T_291 = _signals_T_143 ? 1'h0 : _signals_T_290; // @[Lookup.scala 34:39]
  wire  _signals_T_292 = _signals_T_141 ? 1'h0 : _signals_T_291; // @[Lookup.scala 34:39]
  wire  _signals_T_293 = _signals_T_139 ? 1'h0 : _signals_T_292; // @[Lookup.scala 34:39]
  wire  _signals_T_294 = _signals_T_137 ? 1'h0 : _signals_T_293; // @[Lookup.scala 34:39]
  wire  _signals_T_305 = _signals_T_115 ? 1'h0 : _signals_T_117 | (_signals_T_119 | (_signals_T_121 | (_signals_T_123 |
    (_signals_T_125 | (_signals_T_127 | (_signals_T_129 | (_signals_T_131 | (_signals_T_133 | (_signals_T_135 |
    _signals_T_294))))))))); // @[Lookup.scala 34:39]
  wire  _signals_T_306 = _signals_T_113 ? 1'h0 : _signals_T_305; // @[Lookup.scala 34:39]
  wire  _signals_T_336 = _signals_T_53 | (_signals_T_55 | (_signals_T_57 | (_signals_T_59 | (_signals_T_61 | (
    _signals_T_63 | (_signals_T_65 | (_signals_T_67 | (_signals_T_69 | (_signals_T_71 | (_signals_T_73 | (_signals_T_75
     | (_signals_T_77 | (_signals_T_79 | (_signals_T_81 | (_signals_T_83 | (_signals_T_85 | (_signals_T_87 | (
    _signals_T_89 | (_signals_T_91 | (_signals_T_93 | (_signals_T_95 | (_signals_T_97 | (_signals_T_99 | (_signals_T_101
     | (_signals_T_103 | (_signals_T_105 | (_signals_T_107 | (_signals_T_109 | (_signals_T_111 | _signals_T_306)))))))))
    )))))))))))))))))))); // @[Lookup.scala 34:39]
  wire  _signals_T_340 = _signals_T_45 ? 1'h0 : _signals_T_47 | (_signals_T_49 | (_signals_T_51 | _signals_T_336)); // @[Lookup.scala 34:39]
  wire  _signals_T_341 = _signals_T_43 ? 1'h0 : _signals_T_340; // @[Lookup.scala 34:39]
  wire  _signals_T_344 = _signals_T_37 ? 1'h0 : _signals_T_39 | (_signals_T_41 | _signals_T_341); // @[Lookup.scala 34:39]
  wire  _signals_T_345 = _signals_T_35 ? 1'h0 : _signals_T_344; // @[Lookup.scala 34:39]
  wire  _signals_T_352 = _signals_T_21 ? 1'h0 : _signals_T_23 | (_signals_T_25 | (_signals_T_27 | (_signals_T_29 | (
    _signals_T_31 | (_signals_T_33 | _signals_T_345))))); // @[Lookup.scala 34:39]
  wire  _signals_T_353 = _signals_T_19 ? 1'h0 : _signals_T_352; // @[Lookup.scala 34:39]
  wire  _signals_T_354 = _signals_T_17 ? 1'h0 : _signals_T_353; // @[Lookup.scala 34:39]
  wire  op1_type = _signals_T_1 ? 1'h0 : _signals_T_3 | (_signals_T_5 | (_signals_T_7 | (_signals_T_9 | (_signals_T_11
     | (_signals_T_13 | (_signals_T_15 | _signals_T_354)))))); // @[Lookup.scala 34:39]
  wire [4:0] rs = io_fromDecoderStage_inst[25:21]; // @[Decoder.scala 152:16]
  wire  _T_37 = io_fromExecute_reg_waddr == rs; // @[Decoder.scala 439:68]
  wire  _T_42 = io_fromMemory_reg_waddr == rs; // @[Decoder.scala 441:74]
  wire [2:0] _signals_T_847 = _signals_T_111 ? 3'h1 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_848 = _signals_T_109 ? 3'h1 : _signals_T_847; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_849 = _signals_T_107 ? 3'h0 : _signals_T_848; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_850 = _signals_T_105 ? 3'h0 : _signals_T_849; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_851 = _signals_T_103 ? 3'h0 : _signals_T_850; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_852 = _signals_T_101 ? 3'h0 : _signals_T_851; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_853 = _signals_T_99 ? 3'h0 : _signals_T_852; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_854 = _signals_T_97 ? 3'h0 : _signals_T_853; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_855 = _signals_T_95 ? 3'h0 : _signals_T_854; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_856 = _signals_T_93 ? 3'h0 : _signals_T_855; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_857 = _signals_T_91 ? 3'h0 : _signals_T_856; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_858 = _signals_T_89 ? 3'h0 : _signals_T_857; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_859 = _signals_T_87 ? 3'h0 : _signals_T_858; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_860 = _signals_T_85 ? 3'h0 : _signals_T_859; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_861 = _signals_T_83 ? 3'h0 : _signals_T_860; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_862 = _signals_T_81 ? 3'h0 : _signals_T_861; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_863 = _signals_T_79 ? 3'h0 : _signals_T_862; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_864 = _signals_T_77 ? 3'h1 : _signals_T_863; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_865 = _signals_T_75 ? 3'h0 : _signals_T_864; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_866 = _signals_T_73 ? 3'h1 : _signals_T_865; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_867 = _signals_T_71 ? 3'h0 : _signals_T_866; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_868 = _signals_T_69 ? 3'h1 : _signals_T_867; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_869 = _signals_T_67 ? 3'h0 : _signals_T_868; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_870 = _signals_T_65 ? 3'h0 : _signals_T_869; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_871 = _signals_T_63 ? 3'h1 : _signals_T_870; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_872 = _signals_T_61 ? 3'h1 : _signals_T_871; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_873 = _signals_T_59 ? 3'h0 : _signals_T_872; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_874 = _signals_T_57 ? 3'h1 : _signals_T_873; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_875 = _signals_T_55 ? 3'h0 : _signals_T_874; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_876 = _signals_T_53 ? 3'h1 : _signals_T_875; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_877 = _signals_T_51 ? 3'h1 : _signals_T_876; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_878 = _signals_T_49 ? 3'h0 : _signals_T_877; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_879 = _signals_T_47 ? 3'h0 : _signals_T_878; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_880 = _signals_T_45 ? 3'h0 : _signals_T_879; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_881 = _signals_T_43 ? 3'h0 : _signals_T_880; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_882 = _signals_T_41 ? 3'h0 : _signals_T_881; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_883 = _signals_T_39 ? 3'h0 : _signals_T_882; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_884 = _signals_T_37 ? 3'h0 : _signals_T_883; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_885 = _signals_T_35 ? 3'h0 : _signals_T_884; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_886 = _signals_T_33 ? 3'h0 : _signals_T_885; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_887 = _signals_T_31 ? 3'h0 : _signals_T_886; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_888 = _signals_T_29 ? 3'h3 : _signals_T_887; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_889 = _signals_T_27 ? 3'h2 : _signals_T_888; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_890 = _signals_T_25 ? 3'h2 : _signals_T_889; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_891 = _signals_T_23 ? 3'h2 : _signals_T_890; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_892 = _signals_T_21 ? 3'h4 : _signals_T_891; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_893 = _signals_T_19 ? 3'h4 : _signals_T_892; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_894 = _signals_T_17 ? 3'h4 : _signals_T_893; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_895 = _signals_T_15 ? 3'h0 : _signals_T_894; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_896 = _signals_T_13 ? 3'h0 : _signals_T_895; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_897 = _signals_T_11 ? 3'h0 : _signals_T_896; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_898 = _signals_T_9 ? 3'h0 : _signals_T_897; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_899 = _signals_T_7 ? 3'h0 : _signals_T_898; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_900 = _signals_T_5 ? 3'h0 : _signals_T_899; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_901 = _signals_T_3 ? 3'h0 : _signals_T_900; // @[Lookup.scala 34:39]
  wire [2:0] immType = _signals_T_1 ? 3'h0 : _signals_T_901; // @[Lookup.scala 34:39]
  wire [15:0] imm16 = io_fromDecoderStage_inst[15:0]; // @[Decoder.scala 153:16]
  wire [31:0] _imm_T_9 = {imm16,16'h0}; // @[Cat.scala 33:92]
  wire [31:0] _imm_T_7 = {16'h0,imm16}; // @[Cat.scala 33:92]
  wire [15:0] _imm_T_4 = imm16[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _imm_T_5 = {_imm_T_4,imm16}; // @[Cat.scala 33:92]
  wire [4:0] sa = io_fromDecoderStage_inst[10:6]; // @[Decoder.scala 151:16]
  wire [31:0] _imm_T_1 = {27'h0,sa}; // @[Cat.scala 33:92]
  wire [31:0] _imm_T_11 = 3'h1 == immType ? _imm_T_5 : _imm_T_1; // @[Mux.scala 81:58]
  wire [31:0] _imm_T_13 = 3'h2 == immType ? _imm_T_7 : _imm_T_11; // @[Mux.scala 81:58]
  wire [31:0] imm = 3'h3 == immType ? _imm_T_9 : _imm_T_13; // @[Mux.scala 81:58]
  wire [7:0] _GEN_14 = ~op1_type ? imm[31:24] : 8'h0; // @[Decoder.scala 445:27 446:21 448:21]
  wire [7:0] _GEN_15 = op1_type ? io_fromRegfile_reg1_data[31:24] : _GEN_14; // @[Decoder.scala 443:26 444:21]
  wire [7:0] _GEN_16 = op1_type & io_fromMemory_ms_fwd_valid & io_fromMemory_reg_wen[3] & io_fromMemory_reg_waddr == rs
     ? io_fromMemory_reg_wdata[31:24] : _GEN_15; // @[Decoder.scala 441:90 442:21]
  wire [7:0] reg1_value_3 = op1_type & io_fromExecute_es_fwd_valid & io_fromExecute_reg_wen[3] &
    io_fromExecute_reg_waddr == rs ? io_fromExecute_reg_wdata[31:24] : _GEN_16; // @[Decoder.scala 439:84 440:21]
  wire [7:0] _GEN_10 = ~op1_type ? imm[23:16] : 8'h0; // @[Decoder.scala 445:27 446:21 448:21]
  wire [7:0] _GEN_11 = op1_type ? io_fromRegfile_reg1_data[23:16] : _GEN_10; // @[Decoder.scala 443:26 444:21]
  wire [7:0] _GEN_12 = op1_type & io_fromMemory_ms_fwd_valid & io_fromMemory_reg_wen[2] & io_fromMemory_reg_waddr == rs
     ? io_fromMemory_reg_wdata[23:16] : _GEN_11; // @[Decoder.scala 441:90 442:21]
  wire [7:0] reg1_value_2 = op1_type & io_fromExecute_es_fwd_valid & io_fromExecute_reg_wen[2] &
    io_fromExecute_reg_waddr == rs ? io_fromExecute_reg_wdata[23:16] : _GEN_12; // @[Decoder.scala 439:84 440:21]
  wire [15:0] reg1_hi = {reg1_value_3,reg1_value_2}; // @[Decoder.scala 437:22]
  wire [7:0] _GEN_6 = ~op1_type ? imm[15:8] : 8'h0; // @[Decoder.scala 445:27 446:21 448:21]
  wire [7:0] _GEN_7 = op1_type ? io_fromRegfile_reg1_data[15:8] : _GEN_6; // @[Decoder.scala 443:26 444:21]
  wire [7:0] _GEN_8 = op1_type & io_fromMemory_ms_fwd_valid & io_fromMemory_reg_wen[1] & io_fromMemory_reg_waddr == rs
     ? io_fromMemory_reg_wdata[15:8] : _GEN_7; // @[Decoder.scala 441:90 442:21]
  wire [7:0] reg1_value_1 = op1_type & io_fromExecute_es_fwd_valid & io_fromExecute_reg_wen[1] &
    io_fromExecute_reg_waddr == rs ? io_fromExecute_reg_wdata[15:8] : _GEN_8; // @[Decoder.scala 439:84 440:21]
  wire [7:0] _GEN_2 = ~op1_type ? imm[7:0] : 8'h0; // @[Decoder.scala 445:27 446:21 448:21]
  wire [7:0] _GEN_3 = op1_type ? io_fromRegfile_reg1_data[7:0] : _GEN_2; // @[Decoder.scala 443:26 444:21]
  wire [7:0] _GEN_4 = op1_type & io_fromMemory_ms_fwd_valid & io_fromMemory_reg_wen[0] & io_fromMemory_reg_waddr == rs
     ? io_fromMemory_reg_wdata[7:0] : _GEN_3; // @[Decoder.scala 441:90 442:21]
  wire [7:0] reg1_value_0 = op1_type & io_fromExecute_es_fwd_valid & io_fromExecute_reg_wen[0] &
    io_fromExecute_reg_waddr == rs ? io_fromExecute_reg_wdata[7:0] : _GEN_4; // @[Decoder.scala 439:84 440:21]
  wire [15:0] reg1_lo = {reg1_value_1,reg1_value_0}; // @[Decoder.scala 437:22]
  wire [31:0] reg1 = {reg1_value_3,reg1_value_2,reg1_value_1,reg1_value_0}; // @[Decoder.scala 437:22]
  wire  _branch_flag_temp_T_13 = ~reg1[31]; // @[Decoder.scala 400:27]
  wire  _branch_flag_temp_T_15 = ~reg1[31] & reg1 != 32'h0; // @[Decoder.scala 400:37]
  wire  _branch_flag_temp_T_16 = ~(~reg1[31] & reg1 != 32'h0); // @[Decoder.scala 400:25]
  wire  _signals_T_366 = _signals_T_173 ? 1'h0 : _signals_T_175 | _signals_T_177; // @[Lookup.scala 34:39]
  wire  _signals_T_374 = _signals_T_157 ? 1'h0 : _signals_T_159 | (_signals_T_161 | (_signals_T_163 | (_signals_T_165 |
    (_signals_T_167 | (_signals_T_169 | (_signals_T_171 | _signals_T_366)))))); // @[Lookup.scala 34:39]
  wire  _signals_T_375 = _signals_T_155 ? 1'h0 : _signals_T_374; // @[Lookup.scala 34:39]
  wire  _signals_T_376 = _signals_T_153 ? 1'h0 : _signals_T_375; // @[Lookup.scala 34:39]
  wire  _signals_T_377 = _signals_T_151 ? 1'h0 : _signals_T_376; // @[Lookup.scala 34:39]
  wire  _signals_T_378 = _signals_T_149 ? 1'h0 : _signals_T_377; // @[Lookup.scala 34:39]
  wire  _signals_T_379 = _signals_T_147 ? 1'h0 : _signals_T_378; // @[Lookup.scala 34:39]
  wire  _signals_T_380 = _signals_T_145 ? 1'h0 : _signals_T_379; // @[Lookup.scala 34:39]
  wire  _signals_T_381 = _signals_T_143 ? 1'h0 : _signals_T_380; // @[Lookup.scala 34:39]
  wire  _signals_T_382 = _signals_T_141 ? 1'h0 : _signals_T_381; // @[Lookup.scala 34:39]
  wire  _signals_T_383 = _signals_T_139 ? 1'h0 : _signals_T_382; // @[Lookup.scala 34:39]
  wire  _signals_T_384 = _signals_T_137 ? 1'h0 : _signals_T_383; // @[Lookup.scala 34:39]
  wire  _signals_T_385 = _signals_T_135 ? 1'h0 : _signals_T_384; // @[Lookup.scala 34:39]
  wire  _signals_T_386 = _signals_T_133 ? 1'h0 : _signals_T_385; // @[Lookup.scala 34:39]
  wire  _signals_T_387 = _signals_T_131 ? 1'h0 : _signals_T_386; // @[Lookup.scala 34:39]
  wire  _signals_T_388 = _signals_T_129 ? 1'h0 : _signals_T_387; // @[Lookup.scala 34:39]
  wire  _signals_T_389 = _signals_T_127 ? 1'h0 : _signals_T_388; // @[Lookup.scala 34:39]
  wire  _signals_T_390 = _signals_T_125 ? 1'h0 : _signals_T_389; // @[Lookup.scala 34:39]
  wire  _signals_T_393 = _signals_T_119 ? 1'h0 : _signals_T_121 | (_signals_T_123 | _signals_T_390); // @[Lookup.scala 34:39]
  wire  _signals_T_394 = _signals_T_117 ? 1'h0 : _signals_T_393; // @[Lookup.scala 34:39]
  wire  _signals_T_395 = _signals_T_115 ? 1'h0 : _signals_T_394; // @[Lookup.scala 34:39]
  wire  _signals_T_396 = _signals_T_113 ? 1'h0 : _signals_T_395; // @[Lookup.scala 34:39]
  wire  _signals_T_397 = _signals_T_111 ? 1'h0 : _signals_T_396; // @[Lookup.scala 34:39]
  wire  _signals_T_398 = _signals_T_109 ? 1'h0 : _signals_T_397; // @[Lookup.scala 34:39]
  wire  _signals_T_399 = _signals_T_107 ? 1'h0 : _signals_T_398; // @[Lookup.scala 34:39]
  wire  _signals_T_400 = _signals_T_105 ? 1'h0 : _signals_T_399; // @[Lookup.scala 34:39]
  wire  _signals_T_414 = _signals_T_77 ? 1'h0 : _signals_T_79 | (_signals_T_81 | (_signals_T_83 | (_signals_T_85 | (
    _signals_T_87 | (_signals_T_89 | (_signals_T_91 | (_signals_T_93 | (_signals_T_95 | (_signals_T_97 | (_signals_T_99
     | (_signals_T_101 | (_signals_T_103 | _signals_T_400)))))))))))); // @[Lookup.scala 34:39]
  wire  _signals_T_416 = _signals_T_73 ? 1'h0 : _signals_T_75 | _signals_T_414; // @[Lookup.scala 34:39]
  wire  _signals_T_418 = _signals_T_69 ? 1'h0 : _signals_T_71 | _signals_T_416; // @[Lookup.scala 34:39]
  wire  _signals_T_421 = _signals_T_63 ? 1'h0 : _signals_T_65 | (_signals_T_67 | _signals_T_418); // @[Lookup.scala 34:39]
  wire  _signals_T_422 = _signals_T_61 ? 1'h0 : _signals_T_421; // @[Lookup.scala 34:39]
  wire  _signals_T_424 = _signals_T_57 ? 1'h0 : _signals_T_59 | _signals_T_422; // @[Lookup.scala 34:39]
  wire  _signals_T_426 = _signals_T_53 ? 1'h0 : _signals_T_55 | _signals_T_424; // @[Lookup.scala 34:39]
  wire  _signals_T_427 = _signals_T_51 ? 1'h0 : _signals_T_426; // @[Lookup.scala 34:39]
  wire  _signals_T_431 = _signals_T_43 ? 1'h0 : _signals_T_45 | (_signals_T_47 | (_signals_T_49 | _signals_T_427)); // @[Lookup.scala 34:39]
  wire  _signals_T_432 = _signals_T_41 ? 1'h0 : _signals_T_431; // @[Lookup.scala 34:39]
  wire  _signals_T_433 = _signals_T_39 ? 1'h0 : _signals_T_432; // @[Lookup.scala 34:39]
  wire  _signals_T_434 = _signals_T_37 ? 1'h0 : _signals_T_433; // @[Lookup.scala 34:39]
  wire  _signals_T_435 = _signals_T_35 ? 1'h0 : _signals_T_434; // @[Lookup.scala 34:39]
  wire  _signals_T_438 = _signals_T_29 ? 1'h0 : _signals_T_31 | (_signals_T_33 | _signals_T_435); // @[Lookup.scala 34:39]
  wire  _signals_T_439 = _signals_T_27 ? 1'h0 : _signals_T_438; // @[Lookup.scala 34:39]
  wire  _signals_T_440 = _signals_T_25 ? 1'h0 : _signals_T_439; // @[Lookup.scala 34:39]
  wire  _signals_T_441 = _signals_T_23 ? 1'h0 : _signals_T_440; // @[Lookup.scala 34:39]
  wire  op2_type = _signals_T_1 ? 1'h0 : _signals_T_3 | (_signals_T_5 | (_signals_T_7 | (_signals_T_9 | (_signals_T_11
     | (_signals_T_13 | (_signals_T_15 | (_signals_T_17 | (_signals_T_19 | (_signals_T_21 | _signals_T_441))))))))); // @[Lookup.scala 34:39]
  wire [4:0] rt = io_fromDecoderStage_inst[20:16]; // @[Decoder.scala 149:16]
  wire  _T_81 = io_fromExecute_reg_waddr == rt; // @[Decoder.scala 455:65]
  wire  _T_82 = op2_type & io_fromExecute_es_fwd_valid & io_fromExecute_reg_wen[3] & io_fromExecute_reg_waddr == rt; // @[Decoder.scala 455:49]
  wire  _T_86 = io_fromMemory_reg_waddr == rt; // @[Decoder.scala 459:65]
  wire  _T_87 = op2_type & io_fromMemory_ms_fwd_valid & io_fromMemory_reg_wen[3] & io_fromMemory_reg_waddr == rt; // @[Decoder.scala 459:49]
  wire [7:0] _GEN_30 = ~op2_type ? imm[31:24] : 8'h0; // @[Decoder.scala 464:27 465:21 467:21]
  wire [7:0] _GEN_31 = op2_type ? io_fromRegfile_reg2_data[31:24] : _GEN_30; // @[Decoder.scala 462:26 463:21]
  wire [7:0] _GEN_32 = _T_87 ? io_fromMemory_reg_wdata[31:24] : _GEN_31; // @[Decoder.scala 460:7 461:21]
  wire [7:0] reg2_value_3 = _T_82 ? io_fromExecute_reg_wdata[31:24] : _GEN_32; // @[Decoder.scala 456:7 457:21]
  wire  _T_71 = op2_type & io_fromExecute_es_fwd_valid & io_fromExecute_reg_wen[2] & io_fromExecute_reg_waddr == rt; // @[Decoder.scala 455:49]
  wire  _T_76 = op2_type & io_fromMemory_ms_fwd_valid & io_fromMemory_reg_wen[2] & io_fromMemory_reg_waddr == rt; // @[Decoder.scala 459:49]
  wire [7:0] _GEN_26 = ~op2_type ? imm[23:16] : 8'h0; // @[Decoder.scala 464:27 465:21 467:21]
  wire [7:0] _GEN_27 = op2_type ? io_fromRegfile_reg2_data[23:16] : _GEN_26; // @[Decoder.scala 462:26 463:21]
  wire [7:0] _GEN_28 = _T_76 ? io_fromMemory_reg_wdata[23:16] : _GEN_27; // @[Decoder.scala 460:7 461:21]
  wire [7:0] reg2_value_2 = _T_71 ? io_fromExecute_reg_wdata[23:16] : _GEN_28; // @[Decoder.scala 456:7 457:21]
  wire [15:0] reg2_hi = {reg2_value_3,reg2_value_2}; // @[Decoder.scala 452:22]
  wire  _T_60 = op2_type & io_fromExecute_es_fwd_valid & io_fromExecute_reg_wen[1] & io_fromExecute_reg_waddr == rt; // @[Decoder.scala 455:49]
  wire  _T_65 = op2_type & io_fromMemory_ms_fwd_valid & io_fromMemory_reg_wen[1] & io_fromMemory_reg_waddr == rt; // @[Decoder.scala 459:49]
  wire [7:0] _GEN_22 = ~op2_type ? imm[15:8] : 8'h0; // @[Decoder.scala 464:27 465:21 467:21]
  wire [7:0] _GEN_23 = op2_type ? io_fromRegfile_reg2_data[15:8] : _GEN_22; // @[Decoder.scala 462:26 463:21]
  wire [7:0] _GEN_24 = _T_65 ? io_fromMemory_reg_wdata[15:8] : _GEN_23; // @[Decoder.scala 460:7 461:21]
  wire [7:0] reg2_value_1 = _T_60 ? io_fromExecute_reg_wdata[15:8] : _GEN_24; // @[Decoder.scala 456:7 457:21]
  wire  _T_49 = op2_type & io_fromExecute_es_fwd_valid & io_fromExecute_reg_wen[0] & io_fromExecute_reg_waddr == rt; // @[Decoder.scala 455:49]
  wire  _T_54 = op2_type & io_fromMemory_ms_fwd_valid & io_fromMemory_reg_wen[0] & io_fromMemory_reg_waddr == rt; // @[Decoder.scala 459:49]
  wire [7:0] _GEN_18 = ~op2_type ? imm[7:0] : 8'h0; // @[Decoder.scala 464:27 465:21 467:21]
  wire [7:0] _GEN_19 = op2_type ? io_fromRegfile_reg2_data[7:0] : _GEN_18; // @[Decoder.scala 462:26 463:21]
  wire [7:0] _GEN_20 = _T_54 ? io_fromMemory_reg_wdata[7:0] : _GEN_19; // @[Decoder.scala 460:7 461:21]
  wire [7:0] reg2_value_0 = _T_49 ? io_fromExecute_reg_wdata[7:0] : _GEN_20; // @[Decoder.scala 456:7 457:21]
  wire [15:0] reg2_lo = {reg2_value_1,reg2_value_0}; // @[Decoder.scala 452:22]
  wire [31:0] reg2 = {reg2_value_3,reg2_value_2,reg2_value_1,reg2_value_0}; // @[Decoder.scala 452:22]
  wire  _branch_flag_temp_T_1 = reg1 != reg2; // @[Decoder.scala 394:30]
  wire  _branch_flag_temp_T = reg1 == reg2; // @[Decoder.scala 393:30]
  wire  _branch_flag_temp_T_26 = 7'h28 == csOpType ? _branch_flag_temp_T : 7'h25 == csOpType | (7'h24 == csOpType | (7'h26
     == csOpType | 7'h27 == csOpType)); // @[Mux.scala 81:58]
  wire  _branch_flag_temp_T_28 = 7'h2f == csOpType ? _branch_flag_temp_T_1 : _branch_flag_temp_T_26; // @[Mux.scala 81:58]
  wire  _branch_flag_temp_T_30 = 7'h2b == csOpType ? _branch_flag_temp_T_15 : _branch_flag_temp_T_28; // @[Mux.scala 81:58]
  wire  _branch_flag_temp_T_32 = 7'h29 == csOpType ? _branch_flag_temp_T_13 : _branch_flag_temp_T_30; // @[Mux.scala 81:58]
  wire  _branch_flag_temp_T_34 = 7'h2a == csOpType ? _branch_flag_temp_T_13 : _branch_flag_temp_T_32; // @[Mux.scala 81:58]
  wire  _branch_flag_temp_T_36 = 7'h2d == csOpType ? reg1[31] : _branch_flag_temp_T_34; // @[Mux.scala 81:58]
  wire  _branch_flag_temp_T_38 = 7'h2e == csOpType ? reg1[31] : _branch_flag_temp_T_36; // @[Mux.scala 81:58]
  wire  branch_flag_temp = 7'h2c == csOpType ? _branch_flag_temp_T_16 : _branch_flag_temp_T_38; // @[Mux.scala 81:58]
  wire  branch_flag = io_fromDecoderStage_valid & branch_flag_temp; // @[Decoder.scala 404:27]
  wire  _mfc0_block_T_2 = _T_37 | _T_81; // @[Decoder.scala 162:82]
  wire  _mfc0_block_T_6 = _T_42 | _T_86; // @[Decoder.scala 163:68]
  wire  _mfc0_block_T_7 = io_fromMemory_inst_is_mfc0 & (_T_42 | _T_86); // @[Decoder.scala 163:33]
  wire  _mfc0_block_T_8 = io_fromExecute_inst_is_mfc0 & (_T_37 | _T_81) | _mfc0_block_T_7; // @[Decoder.scala 162:119]
  wire  _mfc0_block_T_12 = io_fromWriteBackStage_inst_is_mfc0 & (io_fromWriteBackStage_reg_waddr == rs |
    io_fromWriteBackStage_reg_waddr == rt); // @[Decoder.scala 164:41]
  wire  mfc0_block = _mfc0_block_T_8 | _mfc0_block_T_12; // @[Decoder.scala 163:104]
  wire  _ready_go_T_3 = io_fromExecute_blk_valid & _mfc0_block_T_2; // @[Decoder.scala 167:7]
  wire  _ready_go_T_4 = mfc0_block | _ready_go_T_3; // @[Decoder.scala 166:5]
  wire  _ready_go_T_8 = io_fromMemory_blk_valid & _mfc0_block_T_6; // @[Decoder.scala 169:7]
  wire  _ready_go_T_9 = _ready_go_T_4 | _ready_go_T_8; // @[Decoder.scala 168:5]
  wire  ready_go = ~_ready_go_T_9; // @[Decoder.scala 165:15]
  wire  ds_to_es_valid = io_fromDecoderStage_valid & ready_go & ~io_fromDecoderStage_do_flush; // @[Decoder.scala 171:42]
  wire [31:0] pc_plus_4 = io_fromDecoderStage_pc + 32'h4; // @[Decoder.scala 173:28]
  wire [31:0] pc_plus_8 = io_fromDecoderStage_pc + 32'h8; // @[Decoder.scala 174:28]
  wire [13:0] _imm_sll2_signedext_T_2 = imm16[15] ? 14'h3fff : 14'h0; // @[Bitwise.scala 77:12]
  wire [31:0] imm_sll2_signedext = {_imm_sll2_signedext_T_2,imm16,2'h0}; // @[Cat.scala 33:92]
  wire [31:0] BTarget = pc_plus_4 + imm_sll2_signedext; // @[Decoder.scala 177:27]
  wire [31:0] JTarget = {pc_plus_4[31:28],io_fromDecoderStage_inst[25:0],2'h0}; // @[Cat.scala 33:92]
  wire  _signals_T_182 = _signals_T_181 ? 1'h0 : 1'h1; // @[Lookup.scala 34:39]
  wire  _signals_T_183 = _signals_T_179 ? 1'h0 : _signals_T_182; // @[Lookup.scala 34:39]
  wire  _signals_T_184 = _signals_T_177 ? 1'h0 : _signals_T_183; // @[Lookup.scala 34:39]
  wire  _signals_T_185 = _signals_T_175 ? 1'h0 : _signals_T_184; // @[Lookup.scala 34:39]
  wire  _signals_T_186 = _signals_T_173 ? 1'h0 : _signals_T_185; // @[Lookup.scala 34:39]
  wire  _signals_T_187 = _signals_T_171 ? 1'h0 : _signals_T_186; // @[Lookup.scala 34:39]
  wire  _signals_T_188 = _signals_T_169 ? 1'h0 : _signals_T_187; // @[Lookup.scala 34:39]
  wire  _signals_T_189 = _signals_T_167 ? 1'h0 : _signals_T_188; // @[Lookup.scala 34:39]
  wire  _signals_T_190 = _signals_T_165 ? 1'h0 : _signals_T_189; // @[Lookup.scala 34:39]
  wire  _signals_T_191 = _signals_T_163 ? 1'h0 : _signals_T_190; // @[Lookup.scala 34:39]
  wire  _signals_T_192 = _signals_T_161 ? 1'h0 : _signals_T_191; // @[Lookup.scala 34:39]
  wire  _signals_T_193 = _signals_T_159 ? 1'h0 : _signals_T_192; // @[Lookup.scala 34:39]
  wire  _signals_T_194 = _signals_T_157 ? 1'h0 : _signals_T_193; // @[Lookup.scala 34:39]
  wire  _signals_T_195 = _signals_T_155 ? 1'h0 : _signals_T_194; // @[Lookup.scala 34:39]
  wire  _signals_T_196 = _signals_T_153 ? 1'h0 : _signals_T_195; // @[Lookup.scala 34:39]
  wire  _signals_T_197 = _signals_T_151 ? 1'h0 : _signals_T_196; // @[Lookup.scala 34:39]
  wire  _signals_T_198 = _signals_T_149 ? 1'h0 : _signals_T_197; // @[Lookup.scala 34:39]
  wire  _signals_T_199 = _signals_T_147 ? 1'h0 : _signals_T_198; // @[Lookup.scala 34:39]
  wire  _signals_T_200 = _signals_T_145 ? 1'h0 : _signals_T_199; // @[Lookup.scala 34:39]
  wire  _signals_T_201 = _signals_T_143 ? 1'h0 : _signals_T_200; // @[Lookup.scala 34:39]
  wire  _signals_T_202 = _signals_T_141 ? 1'h0 : _signals_T_201; // @[Lookup.scala 34:39]
  wire  _signals_T_203 = _signals_T_139 ? 1'h0 : _signals_T_202; // @[Lookup.scala 34:39]
  wire  _signals_T_204 = _signals_T_137 ? 1'h0 : _signals_T_203; // @[Lookup.scala 34:39]
  wire  _signals_T_205 = _signals_T_135 ? 1'h0 : _signals_T_204; // @[Lookup.scala 34:39]
  wire  _signals_T_206 = _signals_T_133 ? 1'h0 : _signals_T_205; // @[Lookup.scala 34:39]
  wire  _signals_T_207 = _signals_T_131 ? 1'h0 : _signals_T_206; // @[Lookup.scala 34:39]
  wire  _signals_T_208 = _signals_T_129 ? 1'h0 : _signals_T_207; // @[Lookup.scala 34:39]
  wire  _signals_T_209 = _signals_T_127 ? 1'h0 : _signals_T_208; // @[Lookup.scala 34:39]
  wire  _signals_T_210 = _signals_T_125 ? 1'h0 : _signals_T_209; // @[Lookup.scala 34:39]
  wire  _signals_T_211 = _signals_T_123 ? 1'h0 : _signals_T_210; // @[Lookup.scala 34:39]
  wire  _signals_T_212 = _signals_T_121 ? 1'h0 : _signals_T_211; // @[Lookup.scala 34:39]
  wire  _signals_T_213 = _signals_T_119 ? 1'h0 : _signals_T_212; // @[Lookup.scala 34:39]
  wire  _signals_T_214 = _signals_T_117 ? 1'h0 : _signals_T_213; // @[Lookup.scala 34:39]
  wire  _signals_T_215 = _signals_T_115 ? 1'h0 : _signals_T_214; // @[Lookup.scala 34:39]
  wire  _signals_T_216 = _signals_T_113 ? 1'h0 : _signals_T_215; // @[Lookup.scala 34:39]
  wire  _signals_T_217 = _signals_T_111 ? 1'h0 : _signals_T_216; // @[Lookup.scala 34:39]
  wire  _signals_T_218 = _signals_T_109 ? 1'h0 : _signals_T_217; // @[Lookup.scala 34:39]
  wire  _signals_T_219 = _signals_T_107 ? 1'h0 : _signals_T_218; // @[Lookup.scala 34:39]
  wire  _signals_T_220 = _signals_T_105 ? 1'h0 : _signals_T_219; // @[Lookup.scala 34:39]
  wire  _signals_T_221 = _signals_T_103 ? 1'h0 : _signals_T_220; // @[Lookup.scala 34:39]
  wire  _signals_T_222 = _signals_T_101 ? 1'h0 : _signals_T_221; // @[Lookup.scala 34:39]
  wire  _signals_T_223 = _signals_T_99 ? 1'h0 : _signals_T_222; // @[Lookup.scala 34:39]
  wire  _signals_T_224 = _signals_T_97 ? 1'h0 : _signals_T_223; // @[Lookup.scala 34:39]
  wire  _signals_T_225 = _signals_T_95 ? 1'h0 : _signals_T_224; // @[Lookup.scala 34:39]
  wire  _signals_T_226 = _signals_T_93 ? 1'h0 : _signals_T_225; // @[Lookup.scala 34:39]
  wire  _signals_T_227 = _signals_T_91 ? 1'h0 : _signals_T_226; // @[Lookup.scala 34:39]
  wire  _signals_T_228 = _signals_T_89 ? 1'h0 : _signals_T_227; // @[Lookup.scala 34:39]
  wire  _signals_T_229 = _signals_T_87 ? 1'h0 : _signals_T_228; // @[Lookup.scala 34:39]
  wire  _signals_T_230 = _signals_T_85 ? 1'h0 : _signals_T_229; // @[Lookup.scala 34:39]
  wire  _signals_T_231 = _signals_T_83 ? 1'h0 : _signals_T_230; // @[Lookup.scala 34:39]
  wire  _signals_T_232 = _signals_T_81 ? 1'h0 : _signals_T_231; // @[Lookup.scala 34:39]
  wire  _signals_T_233 = _signals_T_79 ? 1'h0 : _signals_T_232; // @[Lookup.scala 34:39]
  wire  _signals_T_234 = _signals_T_77 ? 1'h0 : _signals_T_233; // @[Lookup.scala 34:39]
  wire  _signals_T_235 = _signals_T_75 ? 1'h0 : _signals_T_234; // @[Lookup.scala 34:39]
  wire  _signals_T_236 = _signals_T_73 ? 1'h0 : _signals_T_235; // @[Lookup.scala 34:39]
  wire  _signals_T_237 = _signals_T_71 ? 1'h0 : _signals_T_236; // @[Lookup.scala 34:39]
  wire  _signals_T_238 = _signals_T_69 ? 1'h0 : _signals_T_237; // @[Lookup.scala 34:39]
  wire  _signals_T_239 = _signals_T_67 ? 1'h0 : _signals_T_238; // @[Lookup.scala 34:39]
  wire  _signals_T_240 = _signals_T_65 ? 1'h0 : _signals_T_239; // @[Lookup.scala 34:39]
  wire  _signals_T_241 = _signals_T_63 ? 1'h0 : _signals_T_240; // @[Lookup.scala 34:39]
  wire  _signals_T_242 = _signals_T_61 ? 1'h0 : _signals_T_241; // @[Lookup.scala 34:39]
  wire  _signals_T_243 = _signals_T_59 ? 1'h0 : _signals_T_242; // @[Lookup.scala 34:39]
  wire  _signals_T_244 = _signals_T_57 ? 1'h0 : _signals_T_243; // @[Lookup.scala 34:39]
  wire  _signals_T_245 = _signals_T_55 ? 1'h0 : _signals_T_244; // @[Lookup.scala 34:39]
  wire  _signals_T_246 = _signals_T_53 ? 1'h0 : _signals_T_245; // @[Lookup.scala 34:39]
  wire  _signals_T_247 = _signals_T_51 ? 1'h0 : _signals_T_246; // @[Lookup.scala 34:39]
  wire  _signals_T_248 = _signals_T_49 ? 1'h0 : _signals_T_247; // @[Lookup.scala 34:39]
  wire  _signals_T_249 = _signals_T_47 ? 1'h0 : _signals_T_248; // @[Lookup.scala 34:39]
  wire  _signals_T_250 = _signals_T_45 ? 1'h0 : _signals_T_249; // @[Lookup.scala 34:39]
  wire  _signals_T_251 = _signals_T_43 ? 1'h0 : _signals_T_250; // @[Lookup.scala 34:39]
  wire  _signals_T_252 = _signals_T_41 ? 1'h0 : _signals_T_251; // @[Lookup.scala 34:39]
  wire  _signals_T_253 = _signals_T_39 ? 1'h0 : _signals_T_252; // @[Lookup.scala 34:39]
  wire  _signals_T_254 = _signals_T_37 ? 1'h0 : _signals_T_253; // @[Lookup.scala 34:39]
  wire  _signals_T_255 = _signals_T_35 ? 1'h0 : _signals_T_254; // @[Lookup.scala 34:39]
  wire  _signals_T_256 = _signals_T_33 ? 1'h0 : _signals_T_255; // @[Lookup.scala 34:39]
  wire  _signals_T_257 = _signals_T_31 ? 1'h0 : _signals_T_256; // @[Lookup.scala 34:39]
  wire  _signals_T_258 = _signals_T_29 ? 1'h0 : _signals_T_257; // @[Lookup.scala 34:39]
  wire  _signals_T_259 = _signals_T_27 ? 1'h0 : _signals_T_258; // @[Lookup.scala 34:39]
  wire  _signals_T_260 = _signals_T_25 ? 1'h0 : _signals_T_259; // @[Lookup.scala 34:39]
  wire  _signals_T_261 = _signals_T_23 ? 1'h0 : _signals_T_260; // @[Lookup.scala 34:39]
  wire  _signals_T_262 = _signals_T_21 ? 1'h0 : _signals_T_261; // @[Lookup.scala 34:39]
  wire  _signals_T_263 = _signals_T_19 ? 1'h0 : _signals_T_262; // @[Lookup.scala 34:39]
  wire  _signals_T_264 = _signals_T_17 ? 1'h0 : _signals_T_263; // @[Lookup.scala 34:39]
  wire  _signals_T_265 = _signals_T_15 ? 1'h0 : _signals_T_264; // @[Lookup.scala 34:39]
  wire  _signals_T_266 = _signals_T_13 ? 1'h0 : _signals_T_265; // @[Lookup.scala 34:39]
  wire  _signals_T_267 = _signals_T_11 ? 1'h0 : _signals_T_266; // @[Lookup.scala 34:39]
  wire  _signals_T_268 = _signals_T_9 ? 1'h0 : _signals_T_267; // @[Lookup.scala 34:39]
  wire  _signals_T_269 = _signals_T_7 ? 1'h0 : _signals_T_268; // @[Lookup.scala 34:39]
  wire  _signals_T_270 = _signals_T_5 ? 1'h0 : _signals_T_269; // @[Lookup.scala 34:39]
  wire  _signals_T_271 = _signals_T_3 ? 1'h0 : _signals_T_270; // @[Lookup.scala 34:39]
  wire  csinst_valid = _signals_T_1 ? 1'h0 : _signals_T_271; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_455 = _signals_T_175 ? 3'h7 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_456 = _signals_T_173 ? 3'h7 : _signals_T_455; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_457 = _signals_T_171 ? 3'h7 : _signals_T_456; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_458 = _signals_T_169 ? 3'h7 : _signals_T_457; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_459 = _signals_T_167 ? 3'h7 : _signals_T_458; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_460 = _signals_T_165 ? 3'h7 : _signals_T_459; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_461 = _signals_T_163 ? 3'h7 : _signals_T_460; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_462 = _signals_T_161 ? 3'h7 : _signals_T_461; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_463 = _signals_T_159 ? 3'h7 : _signals_T_462; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_464 = _signals_T_157 ? 3'h7 : _signals_T_463; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_465 = _signals_T_155 ? 3'h7 : _signals_T_464; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_466 = _signals_T_153 ? 3'h7 : _signals_T_465; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_467 = _signals_T_151 ? 3'h7 : _signals_T_466; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_468 = _signals_T_149 ? 3'h7 : _signals_T_467; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_469 = _signals_T_147 ? 3'h0 : _signals_T_468; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_470 = _signals_T_145 ? 3'h0 : _signals_T_469; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_471 = _signals_T_143 ? 3'h0 : _signals_T_470; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_472 = _signals_T_141 ? 3'h0 : _signals_T_471; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_473 = _signals_T_139 ? 3'h0 : _signals_T_472; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_474 = _signals_T_137 ? 3'h0 : _signals_T_473; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_475 = _signals_T_135 ? 3'h6 : _signals_T_474; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_476 = _signals_T_133 ? 3'h6 : _signals_T_475; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_477 = _signals_T_131 ? 3'h6 : _signals_T_476; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_478 = _signals_T_129 ? 3'h6 : _signals_T_477; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_479 = _signals_T_127 ? 3'h6 : _signals_T_478; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_480 = _signals_T_125 ? 3'h6 : _signals_T_479; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_481 = _signals_T_123 ? 3'h6 : _signals_T_480; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_482 = _signals_T_121 ? 3'h6 : _signals_T_481; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_483 = _signals_T_119 ? 3'h6 : _signals_T_482; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_484 = _signals_T_117 ? 3'h6 : _signals_T_483; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_485 = _signals_T_115 ? 3'h6 : _signals_T_484; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_486 = _signals_T_113 ? 3'h6 : _signals_T_485; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_487 = _signals_T_111 ? 3'h1 : _signals_T_486; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_488 = _signals_T_109 ? 3'h1 : _signals_T_487; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_489 = _signals_T_107 ? 3'h1 : _signals_T_488; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_490 = _signals_T_105 ? 3'h1 : _signals_T_489; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_491 = _signals_T_103 ? 3'h0 : _signals_T_490; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_492 = _signals_T_101 ? 3'h0 : _signals_T_491; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_493 = _signals_T_99 ? 3'h5 : _signals_T_492; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_494 = _signals_T_97 ? 3'h5 : _signals_T_493; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_495 = _signals_T_95 ? 3'h5 : _signals_T_494; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_496 = _signals_T_93 ? 3'h5 : _signals_T_495; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_497 = _signals_T_91 ? 3'h0 : _signals_T_496; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_498 = _signals_T_89 ? 3'h0 : _signals_T_497; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_499 = _signals_T_87 ? 3'h5 : _signals_T_498; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_500 = _signals_T_85 ? 3'h1 : _signals_T_499; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_501 = _signals_T_83 ? 3'h1 : _signals_T_500; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_502 = _signals_T_81 ? 3'h1 : _signals_T_501; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_503 = _signals_T_79 ? 3'h1 : _signals_T_502; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_504 = _signals_T_77 ? 3'h0 : _signals_T_503; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_505 = _signals_T_75 ? 3'h0 : _signals_T_504; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_506 = _signals_T_73 ? 3'h0 : _signals_T_505; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_507 = _signals_T_71 ? 3'h0 : _signals_T_506; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_508 = _signals_T_69 ? 3'h0 : _signals_T_507; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_509 = _signals_T_67 ? 3'h0 : _signals_T_508; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_510 = _signals_T_65 ? 3'h0 : _signals_T_509; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_511 = _signals_T_63 ? 3'h0 : _signals_T_510; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_512 = _signals_T_61 ? 3'h0 : _signals_T_511; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_513 = _signals_T_59 ? 3'h0 : _signals_T_512; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_514 = _signals_T_57 ? 3'h0 : _signals_T_513; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_515 = _signals_T_55 ? 3'h0 : _signals_T_514; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_516 = _signals_T_53 ? 3'h1 : _signals_T_515; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_517 = _signals_T_51 ? 3'h1 : _signals_T_516; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_518 = _signals_T_49 ? 3'h1 : _signals_T_517; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_519 = _signals_T_47 ? 3'h1 : _signals_T_518; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_520 = _signals_T_45 ? 3'h0 : _signals_T_519; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_521 = _signals_T_43 ? 3'h3 : _signals_T_520; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_522 = _signals_T_41 ? 3'h0 : _signals_T_521; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_523 = _signals_T_39 ? 3'h0 : _signals_T_522; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_524 = _signals_T_37 ? 3'h3 : _signals_T_523; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_525 = _signals_T_35 ? 3'h3 : _signals_T_524; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_526 = _signals_T_33 ? 3'h3 : _signals_T_525; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_527 = _signals_T_31 ? 3'h3 : _signals_T_526; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_528 = _signals_T_29 ? 3'h1 : _signals_T_527; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_529 = _signals_T_27 ? 3'h1 : _signals_T_528; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_530 = _signals_T_25 ? 3'h1 : _signals_T_529; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_531 = _signals_T_23 ? 3'h1 : _signals_T_530; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_532 = _signals_T_21 ? 3'h1 : _signals_T_531; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_533 = _signals_T_19 ? 3'h1 : _signals_T_532; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_534 = _signals_T_17 ? 3'h1 : _signals_T_533; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_535 = _signals_T_15 ? 3'h1 : _signals_T_534; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_536 = _signals_T_13 ? 3'h1 : _signals_T_535; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_537 = _signals_T_11 ? 3'h1 : _signals_T_536; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_538 = _signals_T_9 ? 3'h1 : _signals_T_537; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_539 = _signals_T_7 ? 3'h1 : _signals_T_538; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_540 = _signals_T_5 ? 3'h1 : _signals_T_539; // @[Lookup.scala 34:39]
  wire [2:0] _signals_T_541 = _signals_T_3 ? 3'h1 : _signals_T_540; // @[Lookup.scala 34:39]
  wire [2:0] csInstType = _signals_T_1 ? 3'h0 : _signals_T_541; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_633 = _signals_T_179 ? 4'hf : 4'h0; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_634 = _signals_T_177 ? 4'h0 : _signals_T_633; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_635 = _signals_T_175 ? 4'h0 : _signals_T_634; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_636 = _signals_T_173 ? 4'hf : _signals_T_635; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_637 = _signals_T_171 ? 4'h0 : _signals_T_636; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_638 = _signals_T_169 ? 4'h0 : _signals_T_637; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_639 = _signals_T_167 ? 4'hf : _signals_T_638; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_640 = _signals_T_165 ? 4'hf : _signals_T_639; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_641 = _signals_T_163 ? 4'h0 : _signals_T_640; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_642 = _signals_T_161 ? 4'h0 : _signals_T_641; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_643 = _signals_T_159 ? 4'h0 : _signals_T_642; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_644 = _signals_T_157 ? 4'hf : _signals_T_643; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_645 = _signals_T_155 ? 4'hf : _signals_T_644; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_646 = _signals_T_153 ? 4'hf : _signals_T_645; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_647 = _signals_T_151 ? 4'hf : _signals_T_646; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_648 = _signals_T_149 ? 4'hf : _signals_T_647; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_649 = _signals_T_147 ? 4'h0 : _signals_T_648; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_650 = _signals_T_145 ? 4'h0 : _signals_T_649; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_651 = _signals_T_143 ? 4'h0 : _signals_T_650; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_652 = _signals_T_141 ? 4'h0 : _signals_T_651; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_653 = _signals_T_139 ? 4'h0 : _signals_T_652; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_654 = _signals_T_137 ? 4'h0 : _signals_T_653; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_655 = _signals_T_135 ? 4'hf : _signals_T_654; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_656 = _signals_T_133 ? 4'h0 : _signals_T_655; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_657 = _signals_T_131 ? 4'hf : _signals_T_656; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_658 = _signals_T_129 ? 4'h0 : _signals_T_657; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_659 = _signals_T_127 ? 4'h0 : _signals_T_658; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_660 = _signals_T_125 ? 4'h0 : _signals_T_659; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_661 = _signals_T_123 ? 4'h0 : _signals_T_660; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_662 = _signals_T_121 ? 4'h0 : _signals_T_661; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_663 = _signals_T_119 ? 4'hf : _signals_T_662; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_664 = _signals_T_117 ? 4'h0 : _signals_T_663; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_665 = _signals_T_115 ? 4'hf : _signals_T_664; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_666 = _signals_T_113 ? 4'h0 : _signals_T_665; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_667 = _signals_T_111 ? 4'hf : _signals_T_666; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_668 = _signals_T_109 ? 4'hf : _signals_T_667; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_669 = _signals_T_107 ? 4'hf : _signals_T_668; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_670 = _signals_T_105 ? 4'hf : _signals_T_669; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_671 = _signals_T_103 ? 4'h0 : _signals_T_670; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_672 = _signals_T_101 ? 4'h0 : _signals_T_671; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_673 = _signals_T_99 ? 4'h0 : _signals_T_672; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_674 = _signals_T_97 ? 4'h0 : _signals_T_673; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_675 = _signals_T_95 ? 4'h0 : _signals_T_674; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_676 = _signals_T_93 ? 4'h0 : _signals_T_675; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_677 = _signals_T_91 ? 4'h0 : _signals_T_676; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_678 = _signals_T_89 ? 4'h0 : _signals_T_677; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_679 = _signals_T_87 ? 4'hf : _signals_T_678; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_680 = _signals_T_85 ? 4'hf : _signals_T_679; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_681 = _signals_T_83 ? 4'hf : _signals_T_680; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_682 = _signals_T_81 ? 4'hf : _signals_T_681; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_683 = _signals_T_79 ? 4'hf : _signals_T_682; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_684 = _signals_T_77 ? 4'h0 : _signals_T_683; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_685 = _signals_T_75 ? 4'h0 : _signals_T_684; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_686 = _signals_T_73 ? 4'h0 : _signals_T_685; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_687 = _signals_T_71 ? 4'h0 : _signals_T_686; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_688 = _signals_T_69 ? 4'h0 : _signals_T_687; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_689 = _signals_T_67 ? 4'h0 : _signals_T_688; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_690 = _signals_T_65 ? 4'h0 : _signals_T_689; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_691 = _signals_T_63 ? 4'h0 : _signals_T_690; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_692 = _signals_T_61 ? 4'h0 : _signals_T_691; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_693 = _signals_T_59 ? 4'h0 : _signals_T_692; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_694 = _signals_T_57 ? 4'h0 : _signals_T_693; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_695 = _signals_T_55 ? 4'h0 : _signals_T_694; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_696 = _signals_T_53 ? 4'hf : _signals_T_695; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_697 = _signals_T_51 ? 4'hf : _signals_T_696; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_698 = _signals_T_49 ? 4'hf : _signals_T_697; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_699 = _signals_T_47 ? 4'hf : _signals_T_698; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_700 = _signals_T_45 ? 4'h0 : _signals_T_699; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_701 = _signals_T_43 ? 4'hf : _signals_T_700; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_702 = _signals_T_41 ? 4'h0 : _signals_T_701; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_703 = _signals_T_39 ? 4'h0 : _signals_T_702; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_704 = _signals_T_37 ? 4'hf : _signals_T_703; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_705 = _signals_T_35 ? 4'hf : _signals_T_704; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_706 = _signals_T_33 ? 4'hf : _signals_T_705; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_707 = _signals_T_31 ? 4'hf : _signals_T_706; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_708 = _signals_T_29 ? 4'hf : _signals_T_707; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_709 = _signals_T_27 ? 4'hf : _signals_T_708; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_710 = _signals_T_25 ? 4'hf : _signals_T_709; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_711 = _signals_T_23 ? 4'hf : _signals_T_710; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_712 = _signals_T_21 ? 4'hf : _signals_T_711; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_713 = _signals_T_19 ? 4'hf : _signals_T_712; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_714 = _signals_T_17 ? 4'hf : _signals_T_713; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_715 = _signals_T_15 ? 4'hf : _signals_T_714; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_716 = _signals_T_13 ? 4'hf : _signals_T_715; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_717 = _signals_T_11 ? 4'hf : _signals_T_716; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_718 = _signals_T_9 ? 4'hf : _signals_T_717; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_719 = _signals_T_7 ? 4'hf : _signals_T_718; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_720 = _signals_T_5 ? 4'hf : _signals_T_719; // @[Lookup.scala 34:39]
  wire [3:0] _signals_T_721 = _signals_T_3 ? 4'hf : _signals_T_720; // @[Lookup.scala 34:39]
  wire [3:0] csWReg = _signals_T_1 ? 4'h0 : _signals_T_721; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_725 = _signals_T_175 ? 2'h1 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_726 = _signals_T_173 ? 2'h1 : _signals_T_725; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_727 = _signals_T_171 ? 2'h0 : _signals_T_726; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_728 = _signals_T_169 ? 2'h0 : _signals_T_727; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_729 = _signals_T_167 ? 2'h1 : _signals_T_728; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_730 = _signals_T_165 ? 2'h1 : _signals_T_729; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_731 = _signals_T_163 ? 2'h0 : _signals_T_730; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_732 = _signals_T_161 ? 2'h0 : _signals_T_731; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_733 = _signals_T_159 ? 2'h0 : _signals_T_732; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_734 = _signals_T_157 ? 2'h1 : _signals_T_733; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_735 = _signals_T_155 ? 2'h1 : _signals_T_734; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_736 = _signals_T_153 ? 2'h1 : _signals_T_735; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_737 = _signals_T_151 ? 2'h1 : _signals_T_736; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_738 = _signals_T_149 ? 2'h1 : _signals_T_737; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_739 = _signals_T_147 ? 2'h0 : _signals_T_738; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_740 = _signals_T_145 ? 2'h0 : _signals_T_739; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_741 = _signals_T_143 ? 2'h0 : _signals_T_740; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_742 = _signals_T_141 ? 2'h0 : _signals_T_741; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_743 = _signals_T_139 ? 2'h0 : _signals_T_742; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_744 = _signals_T_137 ? 2'h0 : _signals_T_743; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_745 = _signals_T_135 ? 2'h2 : _signals_T_744; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_746 = _signals_T_133 ? 2'h0 : _signals_T_745; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_747 = _signals_T_131 ? 2'h2 : _signals_T_746; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_748 = _signals_T_129 ? 2'h0 : _signals_T_747; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_749 = _signals_T_127 ? 2'h0 : _signals_T_748; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_750 = _signals_T_125 ? 2'h0 : _signals_T_749; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_751 = _signals_T_123 ? 2'h0 : _signals_T_750; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_752 = _signals_T_121 ? 2'h0 : _signals_T_751; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_753 = _signals_T_119 ? 2'h0 : _signals_T_752; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_754 = _signals_T_117 ? 2'h0 : _signals_T_753; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_755 = _signals_T_115 ? 2'h2 : _signals_T_754; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_756 = _signals_T_113 ? 2'h0 : _signals_T_755; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_757 = _signals_T_111 ? 2'h1 : _signals_T_756; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_758 = _signals_T_109 ? 2'h1 : _signals_T_757; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_759 = _signals_T_107 ? 2'h0 : _signals_T_758; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_760 = _signals_T_105 ? 2'h0 : _signals_T_759; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_761 = _signals_T_103 ? 2'h0 : _signals_T_760; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_762 = _signals_T_101 ? 2'h0 : _signals_T_761; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_763 = _signals_T_99 ? 2'h0 : _signals_T_762; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_764 = _signals_T_97 ? 2'h0 : _signals_T_763; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_765 = _signals_T_95 ? 2'h0 : _signals_T_764; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_766 = _signals_T_93 ? 2'h0 : _signals_T_765; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_767 = _signals_T_91 ? 2'h0 : _signals_T_766; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_768 = _signals_T_89 ? 2'h0 : _signals_T_767; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_769 = _signals_T_87 ? 2'h0 : _signals_T_768; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_770 = _signals_T_85 ? 2'h0 : _signals_T_769; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_771 = _signals_T_83 ? 2'h0 : _signals_T_770; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_772 = _signals_T_81 ? 2'h0 : _signals_T_771; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_773 = _signals_T_79 ? 2'h0 : _signals_T_772; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_774 = _signals_T_77 ? 2'h0 : _signals_T_773; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_775 = _signals_T_75 ? 2'h0 : _signals_T_774; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_776 = _signals_T_73 ? 2'h0 : _signals_T_775; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_777 = _signals_T_71 ? 2'h0 : _signals_T_776; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_778 = _signals_T_69 ? 2'h0 : _signals_T_777; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_779 = _signals_T_67 ? 2'h0 : _signals_T_778; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_780 = _signals_T_65 ? 2'h0 : _signals_T_779; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_781 = _signals_T_63 ? 2'h0 : _signals_T_780; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_782 = _signals_T_61 ? 2'h0 : _signals_T_781; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_783 = _signals_T_59 ? 2'h0 : _signals_T_782; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_784 = _signals_T_57 ? 2'h0 : _signals_T_783; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_785 = _signals_T_55 ? 2'h0 : _signals_T_784; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_786 = _signals_T_53 ? 2'h1 : _signals_T_785; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_787 = _signals_T_51 ? 2'h1 : _signals_T_786; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_788 = _signals_T_49 ? 2'h0 : _signals_T_787; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_789 = _signals_T_47 ? 2'h0 : _signals_T_788; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_790 = _signals_T_45 ? 2'h0 : _signals_T_789; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_791 = _signals_T_43 ? 2'h1 : _signals_T_790; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_792 = _signals_T_41 ? 2'h0 : _signals_T_791; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_793 = _signals_T_39 ? 2'h0 : _signals_T_792; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_794 = _signals_T_37 ? 2'h0 : _signals_T_793; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_795 = _signals_T_35 ? 2'h0 : _signals_T_794; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_796 = _signals_T_33 ? 2'h0 : _signals_T_795; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_797 = _signals_T_31 ? 2'h0 : _signals_T_796; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_798 = _signals_T_29 ? 2'h1 : _signals_T_797; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_799 = _signals_T_27 ? 2'h1 : _signals_T_798; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_800 = _signals_T_25 ? 2'h1 : _signals_T_799; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_801 = _signals_T_23 ? 2'h1 : _signals_T_800; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_802 = _signals_T_21 ? 2'h0 : _signals_T_801; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_803 = _signals_T_19 ? 2'h0 : _signals_T_802; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_804 = _signals_T_17 ? 2'h0 : _signals_T_803; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_805 = _signals_T_15 ? 2'h0 : _signals_T_804; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_806 = _signals_T_13 ? 2'h0 : _signals_T_805; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_807 = _signals_T_11 ? 2'h0 : _signals_T_806; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_808 = _signals_T_9 ? 2'h0 : _signals_T_807; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_809 = _signals_T_7 ? 2'h0 : _signals_T_808; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_810 = _signals_T_5 ? 2'h0 : _signals_T_809; // @[Lookup.scala 34:39]
  wire [1:0] _signals_T_811 = _signals_T_3 ? 2'h0 : _signals_T_810; // @[Lookup.scala 34:39]
  wire [1:0] signals_6 = _signals_T_1 ? 2'h0 : _signals_T_811; // @[Lookup.scala 34:39]
  wire  _mem_re_T = csInstType == 3'h7; // @[Decoder.scala 330:24]
  wire [4:0] _reg_waddr_T_1 = 2'h0 == signals_6 ? io_fromDecoderStage_inst[15:11] : 5'h1f; // @[Mux.scala 81:58]
  wire [3:0] _reg_wen_T_1 = reg2 != 32'h0 ? 4'h1 : 4'h0; // @[Decoder.scala 360:12]
  wire [15:0] _reg_wen_T_3 = {_reg_wen_T_1,_reg_wen_T_1,_reg_wen_T_1,_reg_wen_T_1}; // @[Cat.scala 33:92]
  wire [3:0] _reg_wen_T_5 = reg2 == 32'h0 ? 4'h1 : 4'h0; // @[Decoder.scala 364:12]
  wire [15:0] _reg_wen_T_7 = {_reg_wen_T_5,_reg_wen_T_5,_reg_wen_T_5,_reg_wen_T_5}; // @[Cat.scala 33:92]
  wire [15:0] _reg_wen_T_9 = 7'hc == csOpType ? _reg_wen_T_3 : {{12'd0}, csWReg}; // @[Mux.scala 81:58]
  wire [15:0] _reg_wen_T_11 = 7'hb == csOpType ? _reg_wen_T_7 : _reg_wen_T_9; // @[Mux.scala 81:58]
  wire [31:0] _link_addr_T_3 = 7'h26 == csOpType ? pc_plus_8 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _link_addr_T_5 = 7'h24 == csOpType ? 32'h0 : _link_addr_T_3; // @[Mux.scala 81:58]
  wire [31:0] _link_addr_T_7 = 7'h25 == csOpType ? pc_plus_8 : _link_addr_T_5; // @[Mux.scala 81:58]
  wire [31:0] _link_addr_T_9 = 7'h2a == csOpType ? pc_plus_8 : _link_addr_T_7; // @[Mux.scala 81:58]
  wire [31:0] _branch_target_address_T_1 = 7'h27 == csOpType ? reg1 : BTarget; // @[Mux.scala 81:58]
  wire [31:0] _branch_target_address_T_3 = 7'h26 == csOpType ? reg1 : _branch_target_address_T_1; // @[Mux.scala 81:58]
  wire [31:0] _branch_target_address_T_5 = 7'h24 == csOpType ? JTarget : _branch_target_address_T_3; // @[Mux.scala 81:58]
  wire [7:0] _interrupt_T_2 = io_fromWriteBackStage_cp0_cause[15:8] & io_fromWriteBackStage_cp0_status[15:8]; // @[Decoder.scala 471:38]
  wire  _interrupt_T_5 = io_fromWriteBackStage_cp0_status[1:0] == 2'h1; // @[Decoder.scala 472:23]
  wire  interrupt = _interrupt_T_2 != 8'h0 & _interrupt_T_5; // @[Decoder.scala 471:68]
  wire  _ex_T = csOpType == 7'h44; // @[Decoder.scala 477:15]
  wire  _ex_T_1 = io_fromDecoderStage_ex | _ex_T; // @[Decoder.scala 476:30]
  wire  _ex_T_2 = csOpType == 7'h45; // @[Decoder.scala 478:15]
  wire  _ex_T_3 = _ex_T_1 | _ex_T_2; // @[Decoder.scala 477:34]
  wire  _ex_T_4 = csOpType == 7'h46; // @[Decoder.scala 479:15]
  wire  _ex_T_5 = _ex_T_3 | _ex_T_4; // @[Decoder.scala 478:32]
  wire  _ex_T_7 = _ex_T_5 | csinst_valid; // @[Decoder.scala 479:31]
  wire  _ex_T_8 = _ex_T_7 | interrupt; // @[Decoder.scala 480:37]
  wire  _ex_T_9 = _ex_T_8 | after_tlb; // @[Decoder.scala 481:19]
  wire  inst_is_mtc0_entryhi = csOpType == 7'h12 & cp0_addr == 8'h50; // @[Decoder.scala 485:52]
  wire  affect_tlb = csOpType == 7'h49 | csOpType == 7'h4a | inst_is_mtc0_entryhi; // @[Decoder.scala 487:68]
  wire  _GEN_34 = affect_tlb & io_fromExecute_allowin & ds_to_es_valid | after_tlb; // @[Decoder.scala 491:70 492:15 79:26]
  wire [4:0] _excode_T_3 = _ex_T_2 ? 5'h9 : 5'h1f; // @[Mux.scala 101:16]
  wire [4:0] _excode_T_4 = _ex_T ? 5'h8 : _excode_T_3; // @[Mux.scala 101:16]
  wire [4:0] _excode_T_5 = csinst_valid ? 5'ha : _excode_T_4; // @[Mux.scala 101:16]
  wire [4:0] _excode_T_6 = io_fromDecoderStage_ex ? io_fromDecoderStage_excode : _excode_T_5; // @[Mux.scala 101:16]
  assign io_preFetchStage_br_leaving_ds = branch_flag & ready_go & io_fromExecute_allowin; // @[Decoder.scala 84:69]
  assign io_preFetchStage_branch_stall = ds_is_branch & ~ready_go; // @[Decoder.scala 85:58]
  assign io_preFetchStage_branch_flag = io_fromDecoderStage_valid & branch_flag_temp; // @[Decoder.scala 404:27]
  assign io_preFetchStage_branch_target_address = 7'h25 == csOpType ? JTarget : _branch_target_address_T_5; // @[Mux.scala 81:58]
  assign io_fetchStage_allowin = ~io_fromDecoderStage_valid | ready_go & io_fromExecute_allowin; // @[Decoder.scala 170:31]
  assign io_decoderStage_allowin = ~io_fromDecoderStage_valid | ready_go & io_fromExecute_allowin; // @[Decoder.scala 170:31]
  assign io_executeStage_aluop = _signals_T_1 ? 7'h0 : _signals_T_631; // @[Lookup.scala 34:39]
  assign io_executeStage_alusel = _signals_T_1 ? 3'h0 : _signals_T_541; // @[Lookup.scala 34:39]
  assign io_executeStage_inst = io_fromDecoderStage_inst; // @[Decoder.scala 119:42]
  assign io_executeStage_link_addr = 7'h2e == csOpType ? pc_plus_8 : _link_addr_T_9; // @[Mux.scala 81:58]
  assign io_executeStage_reg1 = {reg1_hi,reg1_lo}; // @[Decoder.scala 437:22]
  assign io_executeStage_reg2 = {reg2_hi,reg2_lo}; // @[Decoder.scala 452:22]
  assign io_executeStage_reg_waddr = 2'h1 == signals_6 ? rt : _reg_waddr_T_1; // @[Mux.scala 81:58]
  assign io_executeStage_reg_wen = _reg_wen_T_11[3:0]; // @[Decoder.scala 354:11 64:36]
  assign io_executeStage_pc = io_fromDecoderStage_pc; // @[Decoder.scala 96:33]
  assign io_executeStage_valid = io_fromDecoderStage_valid & ready_go & ~io_fromDecoderStage_do_flush; // @[Decoder.scala 171:42]
  assign io_executeStage_ex = io_fromDecoderStage_valid & _ex_T_9; // @[Decoder.scala 474:18]
  assign io_executeStage_bd = io_fromDecoderStage_valid & bd; // @[Decoder.scala 98:45]
  assign io_executeStage_badvaddr = io_fromDecoderStage_badvaddr; // @[Decoder.scala 99:33]
  assign io_executeStage_cp0_addr = {io_fromDecoderStage_inst[15:11],io_fromDecoderStage_inst[2:0]}; // @[Cat.scala 33:92]
  assign io_executeStage_excode = interrupt ? 5'h0 : _excode_T_6; // @[Mux.scala 101:16]
  assign io_executeStage_overflow_inst = csOpType == 7'h15 | csOpType == 7'h17; // @[Decoder.scala 506:43]
  assign io_executeStage_tlb_refill = io_fromDecoderStage_tlb_refill; // @[Decoder.scala 103:33]
  assign io_executeStage_after_tlb = after_tlb; // @[Decoder.scala 104:33]
  assign io_executeStage_mem_re = csInstType == 3'h7 & csWReg == 4'hf; // @[Decoder.scala 330:47]
  assign io_executeStage_mem_we = _mem_re_T & csWReg == 4'h0; // @[Decoder.scala 331:47]
  assign io_regfile_reg1_raddr = io_fromDecoderStage_inst[25:21]; // @[Decoder.scala 152:16]
  assign io_regfile_reg2_raddr = io_fromDecoderStage_inst[20:16]; // @[Decoder.scala 149:16]
  assign io_ctrl_ex = io_fromDecoderStage_valid & _ex_T_9; // @[Decoder.scala 474:18]
  always @(posedge clock) begin
    if (reset) begin // @[Decoder.scala 74:39]
      bd <= 1'h0; // @[Decoder.scala 74:39]
    end else if (io_fromDecoderStage_do_flush) begin // @[Decoder.scala 421:18]
      bd <= 1'h0; // @[Decoder.scala 422:8]
    end else if (ds_to_es_valid & io_fromExecute_allowin) begin // @[Decoder.scala 423:56]
      bd <= ds_is_branch; // @[Decoder.scala 424:8]
    end
    if (reset) begin // @[Decoder.scala 79:26]
      after_tlb <= 1'h0; // @[Decoder.scala 79:26]
    end else if (io_fromDecoderStage_do_flush) begin // @[Decoder.scala 489:18]
      after_tlb <= 1'h0; // @[Decoder.scala 490:15]
    end else begin
      after_tlb <= _GEN_34;
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
  bd = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  after_tlb = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ExecuteStage(
  input         clock,
  input         reset,
  input  [6:0]  io_fromDecoder_aluop,
  input  [2:0]  io_fromDecoder_alusel,
  input  [31:0] io_fromDecoder_inst,
  input  [31:0] io_fromDecoder_link_addr,
  input  [31:0] io_fromDecoder_reg1,
  input  [31:0] io_fromDecoder_reg2,
  input  [4:0]  io_fromDecoder_reg_waddr,
  input  [3:0]  io_fromDecoder_reg_wen,
  input  [31:0] io_fromDecoder_pc,
  input         io_fromDecoder_valid,
  input         io_fromDecoder_ex,
  input         io_fromDecoder_bd,
  input  [31:0] io_fromDecoder_badvaddr,
  input  [7:0]  io_fromDecoder_cp0_addr,
  input  [4:0]  io_fromDecoder_excode,
  input         io_fromDecoder_overflow_inst,
  input         io_fromDecoder_tlb_refill,
  input         io_fromDecoder_after_tlb,
  input         io_fromDecoder_mem_re,
  input         io_fromDecoder_mem_we,
  input         io_fromExecute_allowin,
  input         io_fromCtrl_do_flush,
  input         io_fromCtrl_after_ex,
  output        io_execute_do_flush,
  output        io_execute_after_ex,
  output        io_execute_valid,
  output [6:0]  io_execute_aluop,
  output [2:0]  io_execute_alusel,
  output [31:0] io_execute_inst,
  output [31:0] io_execute_link_addr,
  output [31:0] io_execute_reg1,
  output [31:0] io_execute_reg2,
  output [4:0]  io_execute_reg_waddr,
  output [3:0]  io_execute_reg_wen,
  output [31:0] io_execute_pc,
  output        io_execute_bd,
  output [31:0] io_execute_badvaddr,
  output [7:0]  io_execute_cp0_addr,
  output [4:0]  io_execute_excode,
  output        io_execute_overflow_inst,
  output        io_execute_ds_to_es_ex,
  output        io_execute_tlb_refill,
  output        io_execute_after_tlb,
  output        io_execute_mem_re,
  output        io_execute_mem_we
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  reg [6:0] aluop; // @[ExecuteStage.scala 18:35]
  reg [2:0] alusel; // @[ExecuteStage.scala 19:35]
  reg [31:0] inst; // @[ExecuteStage.scala 20:35]
  reg [31:0] link_addr; // @[ExecuteStage.scala 23:35]
  reg [31:0] reg1; // @[ExecuteStage.scala 24:35]
  reg [31:0] reg2; // @[ExecuteStage.scala 25:35]
  reg [4:0] reg_waddr; // @[ExecuteStage.scala 26:35]
  reg [3:0] reg_wen; // @[ExecuteStage.scala 27:35]
  reg [31:0] pc; // @[ExecuteStage.scala 28:35]
  reg  es_valid; // @[ExecuteStage.scala 29:35]
  reg  ex; // @[ExecuteStage.scala 30:35]
  reg  bd; // @[ExecuteStage.scala 31:35]
  reg [31:0] badvaddr; // @[ExecuteStage.scala 32:35]
  reg [7:0] cp0_addr; // @[ExecuteStage.scala 33:35]
  reg [4:0] excode; // @[ExecuteStage.scala 34:35]
  reg  overflow_inst; // @[ExecuteStage.scala 35:35]
  reg  tlb_refill; // @[ExecuteStage.scala 37:35]
  reg  after_tlb; // @[ExecuteStage.scala 38:35]
  reg  mem_re; // @[ExecuteStage.scala 39:35]
  reg  mem_we; // @[ExecuteStage.scala 40:35]
  assign io_execute_do_flush = io_fromCtrl_do_flush; // @[ExecuteStage.scala 44:23]
  assign io_execute_after_ex = io_fromCtrl_after_ex; // @[ExecuteStage.scala 45:23]
  assign io_execute_valid = es_valid; // @[ExecuteStage.scala 47:30]
  assign io_execute_aluop = aluop; // @[ExecuteStage.scala 48:30]
  assign io_execute_alusel = alusel; // @[ExecuteStage.scala 49:30]
  assign io_execute_inst = inst; // @[ExecuteStage.scala 50:30]
  assign io_execute_link_addr = link_addr; // @[ExecuteStage.scala 52:30]
  assign io_execute_reg1 = reg1; // @[ExecuteStage.scala 53:30]
  assign io_execute_reg2 = reg2; // @[ExecuteStage.scala 54:30]
  assign io_execute_reg_waddr = reg_waddr; // @[ExecuteStage.scala 55:30]
  assign io_execute_reg_wen = reg_wen; // @[ExecuteStage.scala 56:30]
  assign io_execute_pc = pc; // @[ExecuteStage.scala 57:30]
  assign io_execute_bd = bd; // @[ExecuteStage.scala 58:30]
  assign io_execute_badvaddr = badvaddr; // @[ExecuteStage.scala 59:30]
  assign io_execute_cp0_addr = cp0_addr; // @[ExecuteStage.scala 60:30]
  assign io_execute_excode = excode; // @[ExecuteStage.scala 61:30]
  assign io_execute_overflow_inst = overflow_inst; // @[ExecuteStage.scala 62:30]
  assign io_execute_ds_to_es_ex = ex; // @[ExecuteStage.scala 64:30]
  assign io_execute_tlb_refill = tlb_refill; // @[ExecuteStage.scala 65:30]
  assign io_execute_after_tlb = after_tlb; // @[ExecuteStage.scala 66:30]
  assign io_execute_mem_re = mem_re; // @[ExecuteStage.scala 67:30]
  assign io_execute_mem_we = mem_we; // @[ExecuteStage.scala 68:30]
  always @(posedge clock) begin
    if (reset) begin // @[ExecuteStage.scala 18:35]
      aluop <= 7'h0; // @[ExecuteStage.scala 18:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      aluop <= io_fromDecoder_aluop; // @[ExecuteStage.scala 80:24]
    end
    if (reset) begin // @[ExecuteStage.scala 19:35]
      alusel <= 3'h0; // @[ExecuteStage.scala 19:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      alusel <= io_fromDecoder_alusel; // @[ExecuteStage.scala 81:24]
    end
    if (reset) begin // @[ExecuteStage.scala 20:35]
      inst <= 32'h0; // @[ExecuteStage.scala 20:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      inst <= io_fromDecoder_inst; // @[ExecuteStage.scala 89:24]
    end
    if (reset) begin // @[ExecuteStage.scala 23:35]
      link_addr <= 32'h0; // @[ExecuteStage.scala 23:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      link_addr <= io_fromDecoder_link_addr; // @[ExecuteStage.scala 86:24]
    end
    if (reset) begin // @[ExecuteStage.scala 24:35]
      reg1 <= 32'h0; // @[ExecuteStage.scala 24:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      reg1 <= io_fromDecoder_reg1; // @[ExecuteStage.scala 82:24]
    end
    if (reset) begin // @[ExecuteStage.scala 25:35]
      reg2 <= 32'h0; // @[ExecuteStage.scala 25:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      reg2 <= io_fromDecoder_reg2; // @[ExecuteStage.scala 83:24]
    end
    if (reset) begin // @[ExecuteStage.scala 26:35]
      reg_waddr <= 5'h0; // @[ExecuteStage.scala 26:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      reg_waddr <= io_fromDecoder_reg_waddr; // @[ExecuteStage.scala 84:24]
    end
    if (reset) begin // @[ExecuteStage.scala 27:35]
      reg_wen <= 4'h0; // @[ExecuteStage.scala 27:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      reg_wen <= io_fromDecoder_reg_wen; // @[ExecuteStage.scala 85:24]
    end
    if (reset) begin // @[ExecuteStage.scala 28:35]
      pc <= 32'h0; // @[ExecuteStage.scala 28:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      pc <= io_fromDecoder_pc; // @[ExecuteStage.scala 90:24]
    end
    if (reset) begin // @[ExecuteStage.scala 29:35]
      es_valid <= 1'h0; // @[ExecuteStage.scala 29:35]
    end else if (io_fromCtrl_do_flush) begin // @[ExecuteStage.scala 73:30]
      es_valid <= 1'h0; // @[ExecuteStage.scala 74:14]
    end else if (io_fromExecute_allowin) begin // @[ExecuteStage.scala 75:38]
      es_valid <= io_fromDecoder_valid; // @[ExecuteStage.scala 76:14]
    end
    if (reset) begin // @[ExecuteStage.scala 30:35]
      ex <= 1'h0; // @[ExecuteStage.scala 30:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      ex <= io_fromDecoder_ex; // @[ExecuteStage.scala 91:24]
    end
    if (reset) begin // @[ExecuteStage.scala 31:35]
      bd <= 1'h0; // @[ExecuteStage.scala 31:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      bd <= io_fromDecoder_bd; // @[ExecuteStage.scala 92:24]
    end
    if (reset) begin // @[ExecuteStage.scala 32:35]
      badvaddr <= 32'h0; // @[ExecuteStage.scala 32:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      badvaddr <= io_fromDecoder_badvaddr; // @[ExecuteStage.scala 93:24]
    end
    if (reset) begin // @[ExecuteStage.scala 33:35]
      cp0_addr <= 8'h0; // @[ExecuteStage.scala 33:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      cp0_addr <= io_fromDecoder_cp0_addr; // @[ExecuteStage.scala 94:24]
    end
    if (reset) begin // @[ExecuteStage.scala 34:35]
      excode <= 5'h0; // @[ExecuteStage.scala 34:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      excode <= io_fromDecoder_excode; // @[ExecuteStage.scala 95:24]
    end
    if (reset) begin // @[ExecuteStage.scala 35:35]
      overflow_inst <= 1'h0; // @[ExecuteStage.scala 35:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      overflow_inst <= io_fromDecoder_overflow_inst; // @[ExecuteStage.scala 96:24]
    end
    if (reset) begin // @[ExecuteStage.scala 37:35]
      tlb_refill <= 1'h0; // @[ExecuteStage.scala 37:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      tlb_refill <= io_fromDecoder_tlb_refill; // @[ExecuteStage.scala 98:24]
    end
    if (reset) begin // @[ExecuteStage.scala 38:35]
      after_tlb <= 1'h0; // @[ExecuteStage.scala 38:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      after_tlb <= io_fromDecoder_after_tlb; // @[ExecuteStage.scala 99:24]
    end
    if (reset) begin // @[ExecuteStage.scala 39:35]
      mem_re <= 1'h0; // @[ExecuteStage.scala 39:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      mem_re <= io_fromDecoder_mem_re; // @[ExecuteStage.scala 100:24]
    end
    if (reset) begin // @[ExecuteStage.scala 40:35]
      mem_we <= 1'h0; // @[ExecuteStage.scala 40:35]
    end else if (io_fromDecoder_valid & io_fromExecute_allowin) begin // @[ExecuteStage.scala 79:56]
      mem_we <= io_fromDecoder_mem_we; // @[ExecuteStage.scala 101:24]
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
  aluop = _RAND_0[6:0];
  _RAND_1 = {1{`RANDOM}};
  alusel = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  inst = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  link_addr = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  reg1 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  reg2 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_waddr = _RAND_6[4:0];
  _RAND_7 = {1{`RANDOM}};
  reg_wen = _RAND_7[3:0];
  _RAND_8 = {1{`RANDOM}};
  pc = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  es_valid = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  ex = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  bd = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  badvaddr = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  cp0_addr = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  excode = _RAND_14[4:0];
  _RAND_15 = {1{`RANDOM}};
  overflow_inst = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  tlb_refill = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  after_tlb = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  mem_re = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  mem_we = _RAND_19[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Execute(
  input         clock,
  input         reset,
  input  [31:0] io_fromAlu_out,
  input         io_fromAlu_ov,
  input  [63:0] io_fromMul_out,
  input  [31:0] io_fromDiv_quotient,
  input  [31:0] io_fromDiv_remainder,
  input  [31:0] io_fromMov_out,
  input         io_fromDataMemory_addr_ok,
  input         io_fromDataMemory_data_ok,
  input         io_fromExecuteStage_do_flush,
  input         io_fromExecuteStage_after_ex,
  input         io_fromExecuteStage_valid,
  input  [6:0]  io_fromExecuteStage_aluop,
  input  [2:0]  io_fromExecuteStage_alusel,
  input  [31:0] io_fromExecuteStage_inst,
  input  [31:0] io_fromExecuteStage_link_addr,
  input  [31:0] io_fromExecuteStage_reg1,
  input  [31:0] io_fromExecuteStage_reg2,
  input  [4:0]  io_fromExecuteStage_reg_waddr,
  input  [3:0]  io_fromExecuteStage_reg_wen,
  input  [31:0] io_fromExecuteStage_pc,
  input         io_fromExecuteStage_bd,
  input  [31:0] io_fromExecuteStage_badvaddr,
  input  [7:0]  io_fromExecuteStage_cp0_addr,
  input  [4:0]  io_fromExecuteStage_excode,
  input         io_fromExecuteStage_overflow_inst,
  input         io_fromExecuteStage_ds_to_es_ex,
  input         io_fromExecuteStage_tlb_refill,
  input         io_fromExecuteStage_after_tlb,
  input         io_fromExecuteStage_mem_re,
  input         io_fromExecuteStage_mem_we,
  input         io_fromMemory_whilo,
  input  [31:0] io_fromMemory_hi,
  input  [31:0] io_fromMemory_lo,
  input         io_fromMemory_allowin,
  input         io_fromMemory_inst_unable,
  input  [31:0] io_fromHILO_hi,
  input  [31:0] io_fromHILO_lo,
  input         io_fromWriteBackStage_whilo,
  input  [31:0] io_fromWriteBackStage_hi,
  input  [31:0] io_fromWriteBackStage_lo,
  input         io_fromDataMMU_tlb_refill,
  input         io_fromDataMMU_tlb_invalid,
  input         io_fromDataMMU_tlb_modified,
  input         io_fromTLB_s1_found,
  input  [3:0]  io_fromTLB_s1_index,
  output [6:0]  io_alu_op,
  output [31:0] io_alu_in1,
  output [31:0] io_alu_in2,
  output [6:0]  io_mul_op,
  output [31:0] io_mul_in1,
  output [31:0] io_mul_in2,
  output [6:0]  io_div_op,
  output [31:0] io_div_divisor,
  output [31:0] io_div_dividend,
  output [6:0]  io_mov_op,
  output [31:0] io_mov_inst,
  output [31:0] io_mov_in,
  output [31:0] io_mov_hi,
  output [31:0] io_mov_lo,
  output [4:0]  io_decoder_reg_waddr,
  output [31:0] io_decoder_reg_wdata,
  output [3:0]  io_decoder_reg_wen,
  output        io_decoder_allowin,
  output        io_decoder_blk_valid,
  output        io_decoder_inst_is_mfc0,
  output        io_decoder_es_fwd_valid,
  output [31:0] io_dataMMU_vaddr,
  output        io_dataMMU_inst_is_tlbp,
  output [6:0]  io_memoryStage_aluop,
  output [31:0] io_memoryStage_hi,
  output [31:0] io_memoryStage_lo,
  output [31:0] io_memoryStage_reg2,
  output [4:0]  io_memoryStage_reg_waddr,
  output [31:0] io_memoryStage_reg_wdata,
  output        io_memoryStage_whilo,
  output [3:0]  io_memoryStage_reg_wen,
  output [31:0] io_memoryStage_pc,
  output        io_memoryStage_valid,
  output [31:0] io_memoryStage_mem_addr,
  output        io_memoryStage_bd,
  output [31:0] io_memoryStage_badvaddr,
  output [7:0]  io_memoryStage_cp0_addr,
  output [4:0]  io_memoryStage_excode,
  output        io_memoryStage_ex,
  output        io_memoryStage_data_ok,
  output        io_memoryStage_wait_mem,
  output        io_memoryStage_res_from_mem,
  output        io_memoryStage_tlb_refill,
  output        io_memoryStage_after_tlb,
  output        io_memoryStage_s1_found,
  output [3:0]  io_memoryStage_s1_index,
  output [6:0]  io_dataMemory_aluop,
  output [1:0]  io_dataMemory_addrLowBit2,
  output        io_dataMemory_req,
  output        io_dataMemory_wr,
  output [1:0]  io_dataMemory_size,
  output [31:0] io_dataMemory_wdata,
  output [3:0]  io_dataMemory_wstrb,
  output        io_dataMemory_waiting,
  output        io_executeStage_allowin,
  output        io_ctrl_ex
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  addr_ok_r; // @[Execute.scala 99:34]
  wire [15:0] _mem_addr_temp_T_3 = io_fromExecuteStage_inst[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _mem_addr_temp_T_4 = {_mem_addr_temp_T_3,io_fromExecuteStage_inst[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] mem_addr_temp = io_fromExecuteStage_reg1 + _mem_addr_temp_T_4; // @[Execute.scala 335:25]
  wire [1:0] addrLowBit2 = mem_addr_temp[1:0]; // @[Execute.scala 102:40]
  wire  _data_sram_req_T_2 = io_fromExecuteStage_mem_we | io_fromExecuteStage_mem_re; // @[Execute.scala 103:61]
  wire  overflow_ex = io_fromExecuteStage_overflow_inst & io_fromAlu_ov; // @[Execute.scala 470:55]
  wire  _load_ex_T = io_fromExecuteStage_aluop == 7'h35; // @[Execute.scala 473:25]
  wire  _load_ex_T_1 = addrLowBit2 != 2'h0; // @[Execute.scala 473:52]
  wire  _load_ex_T_3 = io_fromExecuteStage_aluop == 7'h32; // @[Execute.scala 474:13]
  wire  _load_ex_T_4 = io_fromExecuteStage_aluop == 7'h33; // @[Execute.scala 474:36]
  wire  _load_ex_T_8 = (io_fromExecuteStage_aluop == 7'h32 | io_fromExecuteStage_aluop == 7'h33) & addrLowBit2[0]; // @[Execute.scala 474:52]
  wire  load_ex = io_fromExecuteStage_aluop == 7'h35 & addrLowBit2 != 2'h0 | _load_ex_T_8; // @[Execute.scala 473:62]
  wire  _store_ex_T_6 = io_fromExecuteStage_aluop == 7'h3a & addrLowBit2[0]; // @[Execute.scala 476:26]
  wire  store_ex = io_fromExecuteStage_aluop == 7'h3b & _load_ex_T_1 | _store_ex_T_6; // @[Execute.scala 475:61]
  wire  mem_ex = load_ex | store_ex; // @[Execute.scala 477:24]
  wire  _tlb_load_ex_T = io_fromDataMMU_tlb_refill | io_fromDataMMU_tlb_invalid; // @[Execute.scala 479:44]
  wire  tlb_load_ex = io_fromExecuteStage_mem_re & (io_fromDataMMU_tlb_refill | io_fromDataMMU_tlb_invalid); // @[Execute.scala 479:29]
  wire  tlb_store_ex = io_fromExecuteStage_mem_we & _tlb_load_ex_T; // @[Execute.scala 480:29]
  wire  tlb_mod_ex = io_fromExecuteStage_mem_we & io_fromDataMMU_tlb_modified; // @[Execute.scala 482:27]
  wire  tlb_ex = tlb_load_ex | tlb_store_ex | tlb_mod_ex; // @[Execute.scala 483:48]
  wire  ex = io_fromExecuteStage_valid & (overflow_ex | mem_ex | io_fromExecuteStage_ds_to_es_ex | tlb_ex); // @[Execute.scala 485:18]
  wire  no_store = ex | io_fromExecuteStage_after_ex; // @[Execute.scala 295:18]
  wire  data_sram_req = io_fromExecuteStage_valid & ~addr_ok_r & (io_fromExecuteStage_mem_we |
    io_fromExecuteStage_mem_re) & ~no_store; // @[Execute.scala 103:72]
  reg  data_buff_valid; // @[Execute.scala 110:34]
  wire  _addr_ok_T = data_sram_req & io_fromDataMemory_addr_ok; // @[Execute.scala 111:41]
  wire  addr_ok = data_sram_req & io_fromDataMemory_addr_ok | addr_ok_r; // @[Execute.scala 111:70]
  wire  data_sram_data_ok = io_fromDataMemory_data_ok & io_fromMemory_inst_unable; // @[Execute.scala 112:53]
  wire  _T_1 = 7'h3b == io_fromExecuteStage_aluop; // @[Execute.scala 117:17]
  wire  _T_5 = 7'h3a == io_fromExecuteStage_aluop; // @[Execute.scala 117:17]
  wire  _T_10 = 7'h38 == io_fromExecuteStage_aluop; // @[Execute.scala 117:17]
  wire  _T_14 = 7'h3c == io_fromExecuteStage_aluop; // @[Execute.scala 117:17]
  wire [1:0] _data_sram_size_T_1 = addrLowBit2 == 2'h3 ? 2'h2 : addrLowBit2; // @[Execute.scala 128:28]
  wire  _T_17 = 7'h3d == io_fromExecuteStage_aluop; // @[Execute.scala 117:17]
  wire [1:0] _data_sram_size_T_4 = 2'h3 - addrLowBit2; // @[Execute.scala 131:59]
  wire [1:0] _data_sram_size_T_5 = addrLowBit2 == 2'h0 ? 2'h2 : _data_sram_size_T_4; // @[Execute.scala 131:28]
  wire [1:0] _GEN_0 = 7'h37 == io_fromExecuteStage_aluop | 7'h3d == io_fromExecuteStage_aluop ? _data_sram_size_T_5 : 2'h0
    ; // @[Execute.scala 117:17 131:22]
  wire [1:0] _GEN_1 = 7'h36 == io_fromExecuteStage_aluop | 7'h3c == io_fromExecuteStage_aluop ? _data_sram_size_T_1 :
    _GEN_0; // @[Execute.scala 117:17 128:22]
  wire [1:0] _GEN_2 = 7'h30 == io_fromExecuteStage_aluop | 7'h31 == io_fromExecuteStage_aluop | 7'h38 ==
    io_fromExecuteStage_aluop ? 2'h0 : _GEN_1; // @[Execute.scala 117:17 125:22]
  wire [1:0] _GEN_3 = 7'h32 == io_fromExecuteStage_aluop | 7'h33 == io_fromExecuteStage_aluop | 7'h3a ==
    io_fromExecuteStage_aluop ? 2'h1 : _GEN_2; // @[Execute.scala 117:17 122:22]
  wire  _data_sram_addr_T = io_fromExecuteStage_aluop == 7'h36; // @[Execute.scala 137:12]
  wire  _data_sram_addr_T_2 = io_fromExecuteStage_aluop == 7'h36 | io_fromExecuteStage_aluop == 7'h3c; // @[Execute.scala 137:27]
  wire [31:0] _data_sram_addr_T_4 = {mem_addr_temp[31:2],2'h0}; // @[Cat.scala 33:92]
  wire [1:0] _data_sram_wstrb_T_1 = 2'h1 == addrLowBit2 ? 2'h2 : 2'h1; // @[Mux.scala 81:58]
  wire [2:0] _data_sram_wstrb_T_3 = 2'h2 == addrLowBit2 ? 3'h4 : {{1'd0}, _data_sram_wstrb_T_1}; // @[Mux.scala 81:58]
  wire [3:0] _data_sram_wstrb_T_5 = 2'h3 == addrLowBit2 ? 4'h8 : {{1'd0}, _data_sram_wstrb_T_3}; // @[Mux.scala 81:58]
  wire [1:0] _data_sram_wstrb_T_7 = 2'h0 == addrLowBit2 ? 2'h3 : 2'h0; // @[Mux.scala 81:58]
  wire [3:0] _data_sram_wstrb_T_9 = 2'h2 == addrLowBit2 ? 4'hc : {{2'd0}, _data_sram_wstrb_T_7}; // @[Mux.scala 81:58]
  wire [3:0] _data_sram_wstrb_T_11 = 2'h2 == addrLowBit2 ? 4'h7 : 4'hf; // @[Mux.scala 81:58]
  wire [3:0] _data_sram_wstrb_T_13 = 2'h1 == addrLowBit2 ? 4'h3 : _data_sram_wstrb_T_11; // @[Mux.scala 81:58]
  wire [3:0] _data_sram_wstrb_T_15 = 2'h0 == addrLowBit2 ? 4'h1 : _data_sram_wstrb_T_13; // @[Mux.scala 81:58]
  wire [3:0] _data_sram_wstrb_T_17 = 2'h2 == addrLowBit2 ? 4'hc : 4'h8; // @[Mux.scala 81:58]
  wire [3:0] _data_sram_wstrb_T_19 = 2'h1 == addrLowBit2 ? 4'he : _data_sram_wstrb_T_17; // @[Mux.scala 81:58]
  wire [3:0] _data_sram_wstrb_T_21 = 2'h0 == addrLowBit2 ? 4'hf : _data_sram_wstrb_T_19; // @[Mux.scala 81:58]
  wire [3:0] _data_sram_wstrb_T_23 = _T_10 ? _data_sram_wstrb_T_5 : 4'hf; // @[Mux.scala 81:58]
  wire [3:0] _data_sram_wstrb_T_25 = _T_5 ? _data_sram_wstrb_T_9 : _data_sram_wstrb_T_23; // @[Mux.scala 81:58]
  wire [3:0] _data_sram_wstrb_T_27 = _T_14 ? _data_sram_wstrb_T_15 : _data_sram_wstrb_T_25; // @[Mux.scala 81:58]
  wire [31:0] _data_sram_wdata_T_2 = {io_fromExecuteStage_reg2[7:0],io_fromExecuteStage_reg2[7:0],
    io_fromExecuteStage_reg2[7:0],io_fromExecuteStage_reg2[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _data_sram_wdata_T_4 = {io_fromExecuteStage_reg2[15:0],io_fromExecuteStage_reg2[15:0]}; // @[Cat.scala 33:92]
  wire [15:0] _data_sram_wdata_T_6 = {8'h0,io_fromExecuteStage_reg2[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _data_sram_wdata_T_8 = {16'h0,io_fromExecuteStage_reg2[31:16]}; // @[Cat.scala 33:92]
  wire [47:0] _data_sram_wdata_T_10 = {24'h0,io_fromExecuteStage_reg2[31:8]}; // @[Cat.scala 33:92]
  wire [31:0] _data_sram_wdata_T_12 = 2'h1 == addrLowBit2 ? _data_sram_wdata_T_8 : {{16'd0}, _data_sram_wdata_T_6}; // @[Mux.scala 81:58]
  wire [47:0] _data_sram_wdata_T_14 = 2'h2 == addrLowBit2 ? _data_sram_wdata_T_10 : {{16'd0}, _data_sram_wdata_T_12}; // @[Mux.scala 81:58]
  wire [47:0] _data_sram_wdata_T_16 = 2'h3 == addrLowBit2 ? {{16'd0}, io_fromExecuteStage_reg2} : _data_sram_wdata_T_14; // @[Mux.scala 81:58]
  wire [31:0] _data_sram_wdata_T_18 = {io_fromExecuteStage_reg2[23:0],8'h0}; // @[Cat.scala 33:92]
  wire [31:0] _data_sram_wdata_T_20 = {io_fromExecuteStage_reg2[15:0],16'h0}; // @[Cat.scala 33:92]
  wire [31:0] _data_sram_wdata_T_22 = {io_fromExecuteStage_reg2[7:0],24'h0}; // @[Cat.scala 33:92]
  wire [31:0] _data_sram_wdata_T_24 = 2'h1 == addrLowBit2 ? _data_sram_wdata_T_18 : io_fromExecuteStage_reg2; // @[Mux.scala 81:58]
  wire [31:0] _data_sram_wdata_T_26 = 2'h2 == addrLowBit2 ? _data_sram_wdata_T_20 : _data_sram_wdata_T_24; // @[Mux.scala 81:58]
  wire [31:0] _data_sram_wdata_T_28 = 2'h3 == addrLowBit2 ? _data_sram_wdata_T_22 : _data_sram_wdata_T_26; // @[Mux.scala 81:58]
  wire [31:0] _data_sram_wdata_T_30 = _T_10 ? _data_sram_wdata_T_2 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _data_sram_wdata_T_32 = _T_5 ? _data_sram_wdata_T_4 : _data_sram_wdata_T_30; // @[Mux.scala 81:58]
  wire [31:0] _data_sram_wdata_T_34 = _T_1 ? io_fromExecuteStage_reg2 : _data_sram_wdata_T_32; // @[Mux.scala 81:58]
  wire [47:0] _data_sram_wdata_T_36 = _T_14 ? _data_sram_wdata_T_16 : {{16'd0}, _data_sram_wdata_T_34}; // @[Mux.scala 81:58]
  wire [47:0] _data_sram_wdata_T_38 = _T_17 ? {{16'd0}, _data_sram_wdata_T_28} : _data_sram_wdata_T_36; // @[Mux.scala 81:58]
  wire  _io_memoryStage_wait_mem_T = io_fromExecuteStage_valid & addr_ok; // @[Execute.scala 251:46]
  wire  tlb_refill_ex = (io_fromExecuteStage_mem_re | io_fromExecuteStage_mem_we) & io_fromDataMMU_tlb_refill; // @[Execute.scala 481:39]
  wire  _data_ok_T = addr_ok & data_sram_data_ok; // @[Execute.scala 290:42]
  wire  data_ok = data_buff_valid | addr_ok & data_sram_data_ok; // @[Execute.scala 290:30]
  wire  _T_20 = ~io_fromMemory_allowin; // @[Execute.scala 277:54]
  wire  _GEN_5 = io_fromMemory_allowin ? 1'h0 : addr_ok_r; // @[Execute.scala 279:37 280:15 99:34]
  wire  _GEN_6 = _addr_ok_T & ~io_fromMemory_allowin | _GEN_5; // @[Execute.scala 277:78 278:15]
  wire  _GEN_7 = _data_ok_T & _T_20 | data_buff_valid; // @[Execute.scala 285:70 286:21 110:34]
  wire  _T_30 = io_fromExecuteStage_aluop == 7'h30 | io_fromExecuteStage_aluop == 7'h31 | _load_ex_T_3; // @[Execute.scala 301:49]
  wire  _T_34 = _T_30 | _load_ex_T_4 | _load_ex_T; // @[Execute.scala 302:51]
  wire  _T_38 = _T_34 | io_fromExecuteStage_aluop == 7'h37 | _data_sram_addr_T; // @[Execute.scala 303:51]
  wire  _T_41 = io_fromExecuteStage_aluop == 7'h39; // @[Execute.scala 305:13]
  wire  load_op = _T_38 | io_fromExecuteStage_aluop == 7'h34 | _T_41; // @[Execute.scala 304:51]
  wire  _blk_valid_T_1 = ~io_fromExecuteStage_do_flush; // @[Execute.scala 312:39]
  wire  ready_go = _data_sram_req_T_2 ? addr_ok | ex : 1'h1; // @[Execute.scala 314:24]
  wire [31:0] _GEN_12 = io_fromWriteBackStage_whilo ? io_fromWriteBackStage_hi : io_fromHILO_hi; // @[Execute.scala 371:43 372:8 375:8]
  wire [31:0] _GEN_13 = io_fromWriteBackStage_whilo ? io_fromWriteBackStage_lo : io_fromHILO_lo; // @[Execute.scala 371:43 373:8 376:8]
  wire [31:0] _GEN_14 = io_fromMemory_whilo ? io_fromMemory_hi : _GEN_12; // @[Execute.scala 368:44 369:8]
  wire [31:0] _GEN_15 = io_fromMemory_whilo ? io_fromMemory_lo : _GEN_13; // @[Execute.scala 368:44 370:8]
  wire [31:0] HI = reset ? 32'h0 : _GEN_14; // @[Execute.scala 365:37 366:8]
  wire [31:0] LO = reset ? 32'h0 : _GEN_15; // @[Execute.scala 365:37 367:8]
  wire [31:0] _reg_wdata_T_2 = 3'h0 == io_fromExecuteStage_alusel ? io_fromAlu_out : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_4 = 3'h1 == io_fromExecuteStage_alusel ? io_fromAlu_out : _reg_wdata_T_2; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_6 = 3'h3 == io_fromExecuteStage_alusel ? io_fromMov_out : _reg_wdata_T_4; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_8 = 3'h5 == io_fromExecuteStage_alusel ? io_fromMul_out[31:0] : _reg_wdata_T_6; // @[Mux.scala 81:58]
  wire  _T_74 = io_fromExecuteStage_aluop == 7'h10; // @[Execute.scala 460:20]
  wire [31:0] _GEN_45 = io_fromExecuteStage_aluop == 7'h10 ? HI : 32'h0; // @[Execute.scala 460:37 462:11 466:11]
  wire [31:0] _GEN_46 = io_fromExecuteStage_aluop == 7'h10 ? io_fromExecuteStage_reg1 : 32'h0; // @[Execute.scala 460:37 463:11 467:11]
  wire  _GEN_47 = io_fromExecuteStage_aluop == 7'he | _T_74; // @[Execute.scala 456:37 457:11]
  wire [31:0] _GEN_48 = io_fromExecuteStage_aluop == 7'he ? io_fromExecuteStage_reg1 : _GEN_45; // @[Execute.scala 456:37 458:11]
  wire [31:0] _GEN_49 = io_fromExecuteStage_aluop == 7'he ? LO : _GEN_46; // @[Execute.scala 456:37 459:11]
  wire  _GEN_50 = io_fromExecuteStage_aluop == 7'h22 | io_fromExecuteStage_aluop == 7'h23 | _GEN_47; // @[Execute.scala 452:65 453:11]
  wire [31:0] _GEN_51 = io_fromExecuteStage_aluop == 7'h22 | io_fromExecuteStage_aluop == 7'h23 ? io_fromDiv_remainder
     : _GEN_48; // @[Execute.scala 452:65 454:11]
  wire [31:0] _GEN_52 = io_fromExecuteStage_aluop == 7'h22 | io_fromExecuteStage_aluop == 7'h23 ? io_fromDiv_quotient :
    _GEN_49; // @[Execute.scala 452:65 455:11]
  wire  _GEN_53 = io_fromExecuteStage_aluop == 7'h20 | io_fromExecuteStage_aluop == 7'h21 | _GEN_50; // @[Execute.scala 448:67 449:11]
  wire [31:0] _GEN_54 = io_fromExecuteStage_aluop == 7'h20 | io_fromExecuteStage_aluop == 7'h21 ? 32'h0 : _GEN_51; // @[Execute.scala 448:67 450:11]
  wire [31:0] _GEN_55 = io_fromExecuteStage_aluop == 7'h20 | io_fromExecuteStage_aluop == 7'h21 ? 32'h0 : _GEN_52; // @[Execute.scala 448:67 451:11]
  wire  _GEN_56 = io_fromExecuteStage_aluop == 7'h1e | io_fromExecuteStage_aluop == 7'h1f | _GEN_53; // @[Execute.scala 444:67 445:11]
  wire [31:0] _GEN_57 = io_fromExecuteStage_aluop == 7'h1e | io_fromExecuteStage_aluop == 7'h1f ? 32'h0 : _GEN_54; // @[Execute.scala 444:67 446:11]
  wire [31:0] _GEN_58 = io_fromExecuteStage_aluop == 7'h1e | io_fromExecuteStage_aluop == 7'h1f ? 32'h0 : _GEN_55; // @[Execute.scala 444:67 447:11]
  wire  _GEN_59 = io_fromExecuteStage_aluop == 7'h1b | io_fromExecuteStage_aluop == 7'h1c | _GEN_56; // @[Execute.scala 440:67 441:11]
  wire [31:0] _GEN_60 = io_fromExecuteStage_aluop == 7'h1b | io_fromExecuteStage_aluop == 7'h1c ? io_fromMul_out[63:32]
     : _GEN_57; // @[Execute.scala 440:67 442:11]
  wire [31:0] _GEN_61 = io_fromExecuteStage_aluop == 7'h1b | io_fromExecuteStage_aluop == 7'h1c ? io_fromMul_out[31:0]
     : _GEN_58; // @[Execute.scala 440:67 443:11]
  wire [4:0] _excode_T = tlb_mod_ex ? 5'h1 : io_fromExecuteStage_excode; // @[Mux.scala 101:16]
  wire [4:0] _excode_T_1 = tlb_store_ex ? 5'h3 : _excode_T; // @[Mux.scala 101:16]
  wire [4:0] _excode_T_2 = tlb_load_ex ? 5'h2 : _excode_T_1; // @[Mux.scala 101:16]
  wire [4:0] _excode_T_3 = store_ex ? 5'h5 : _excode_T_2; // @[Mux.scala 101:16]
  wire [4:0] _excode_T_4 = load_ex ? 5'h4 : _excode_T_3; // @[Mux.scala 101:16]
  wire [4:0] _excode_T_5 = overflow_ex ? 5'hc : _excode_T_4; // @[Mux.scala 101:16]
  wire  _badvaddr_T_2 = io_fromExecuteStage_excode == 5'h4 | io_fromExecuteStage_excode == 5'h2; // @[Execute.scala 501:44]
  assign io_alu_op = io_fromExecuteStage_aluop; // @[Execute.scala 340:14]
  assign io_alu_in1 = io_fromExecuteStage_reg1; // @[Execute.scala 341:14]
  assign io_alu_in2 = io_fromExecuteStage_reg2; // @[Execute.scala 342:14]
  assign io_mul_op = io_fromExecuteStage_aluop; // @[Execute.scala 347:14]
  assign io_mul_in1 = io_fromExecuteStage_reg1; // @[Execute.scala 348:14]
  assign io_mul_in2 = io_fromExecuteStage_reg2; // @[Execute.scala 349:14]
  assign io_div_op = io_fromExecuteStage_aluop; // @[Execute.scala 352:19]
  assign io_div_divisor = io_fromExecuteStage_reg1; // @[Execute.scala 353:19]
  assign io_div_dividend = io_fromExecuteStage_reg2; // @[Execute.scala 354:19]
  assign io_mov_op = io_fromExecuteStage_aluop; // @[Execute.scala 358:15]
  assign io_mov_inst = io_fromExecuteStage_inst; // @[Execute.scala 360:15]
  assign io_mov_in = io_fromExecuteStage_reg1; // @[Execute.scala 359:15]
  assign io_mov_hi = reset ? 32'h0 : _GEN_14; // @[Execute.scala 365:37 366:8]
  assign io_mov_lo = reset ? 32'h0 : _GEN_15; // @[Execute.scala 365:37 367:8]
  assign io_decoder_reg_waddr = io_fromExecuteStage_reg_waddr; // @[Execute.scala 228:27]
  assign io_decoder_reg_wdata = 3'h6 == io_fromExecuteStage_alusel ? io_fromExecuteStage_link_addr : _reg_wdata_T_8; // @[Mux.scala 81:58]
  assign io_decoder_reg_wen = io_fromAlu_ov ? 4'h0 : io_fromExecuteStage_reg_wen; // @[Execute.scala 422:17]
  assign io_decoder_allowin = ~io_fromExecuteStage_valid | ready_go & io_fromMemory_allowin; // @[Execute.scala 315:31]
  assign io_decoder_blk_valid = io_fromExecuteStage_valid & load_op & ~io_fromExecuteStage_do_flush; // @[Execute.scala 312:36]
  assign io_decoder_inst_is_mfc0 = io_fromExecuteStage_valid & io_fromExecuteStage_aluop == 7'h11; // @[Execute.scala 233:56]
  assign io_decoder_es_fwd_valid = io_fromExecuteStage_valid; // @[Execute.scala 318:16 91:28]
  assign io_dataMMU_vaddr = _data_sram_addr_T_2 ? _data_sram_addr_T_4 : mem_addr_temp; // @[Execute.scala 136:24]
  assign io_dataMMU_inst_is_tlbp = io_fromExecuteStage_aluop == 7'h48; // @[Execute.scala 273:36]
  assign io_memoryStage_aluop = io_fromExecuteStage_aluop; // @[Execute.scala 244:34]
  assign io_memoryStage_hi = reset ? 32'h0 : _GEN_60; // @[Execute.scala 436:37 438:11]
  assign io_memoryStage_lo = reset ? 32'h0 : _GEN_61; // @[Execute.scala 436:37 439:11]
  assign io_memoryStage_reg2 = io_fromExecuteStage_reg2; // @[Execute.scala 245:34]
  assign io_memoryStage_reg_waddr = io_fromExecuteStage_reg_waddr; // @[Execute.scala 238:34]
  assign io_memoryStage_reg_wdata = 3'h6 == io_fromExecuteStage_alusel ? io_fromExecuteStage_link_addr : _reg_wdata_T_8; // @[Mux.scala 81:58]
  assign io_memoryStage_whilo = reset ? 1'h0 : _GEN_59; // @[Execute.scala 436:37 437:11]
  assign io_memoryStage_reg_wen = io_fromAlu_ov ? 4'h0 : io_fromExecuteStage_reg_wen; // @[Execute.scala 422:17]
  assign io_memoryStage_pc = io_fromExecuteStage_pc; // @[Execute.scala 219:27]
  assign io_memoryStage_valid = io_fromExecuteStage_valid & ready_go & _blk_valid_T_1; // @[Execute.scala 316:42]
  assign io_memoryStage_mem_addr = io_fromExecuteStage_reg1 + _mem_addr_temp_T_4; // @[Execute.scala 335:25]
  assign io_memoryStage_bd = io_fromExecuteStage_bd; // @[Execute.scala 221:27]
  assign io_memoryStage_badvaddr = _badvaddr_T_2 ? io_fromExecuteStage_badvaddr : mem_addr_temp; // @[Execute.scala 500:18]
  assign io_memoryStage_cp0_addr = io_fromExecuteStage_cp0_addr; // @[Execute.scala 223:27]
  assign io_memoryStage_excode = io_fromExecuteStage_ds_to_es_ex ? io_fromExecuteStage_excode : _excode_T_5; // @[Mux.scala 101:16]
  assign io_memoryStage_ex = io_fromExecuteStage_valid & (overflow_ex | mem_ex | io_fromExecuteStage_ds_to_es_ex |
    tlb_ex); // @[Execute.scala 485:18]
  assign io_memoryStage_data_ok = data_buff_valid | addr_ok & data_sram_data_ok; // @[Execute.scala 290:30]
  assign io_memoryStage_wait_mem = io_fromExecuteStage_valid & addr_ok; // @[Execute.scala 251:46]
  assign io_memoryStage_res_from_mem = io_fromExecuteStage_mem_re; // @[Execute.scala 252:34]
  assign io_memoryStage_tlb_refill = io_fromExecuteStage_tlb_refill | tlb_refill_ex; // @[Execute.scala 253:51]
  assign io_memoryStage_after_tlb = io_fromExecuteStage_after_tlb; // @[Execute.scala 254:34]
  assign io_memoryStage_s1_found = io_fromTLB_s1_found; // @[Execute.scala 255:34]
  assign io_memoryStage_s1_index = io_fromTLB_s1_index; // @[Execute.scala 256:34]
  assign io_dataMemory_aluop = io_fromExecuteStage_aluop; // @[Execute.scala 263:29]
  assign io_dataMemory_addrLowBit2 = mem_addr_temp[1:0]; // @[Execute.scala 102:40]
  assign io_dataMemory_req = io_fromExecuteStage_valid & ~addr_ok_r & (io_fromExecuteStage_mem_we |
    io_fromExecuteStage_mem_re) & ~no_store; // @[Execute.scala 103:72]
  assign io_dataMemory_wr = io_fromExecuteStage_mem_we; // @[Execute.scala 266:29]
  assign io_dataMemory_size = 7'h35 == io_fromExecuteStage_aluop | 7'h3b == io_fromExecuteStage_aluop ? 2'h2 : _GEN_3; // @[Execute.scala 117:17 119:22]
  assign io_dataMemory_wdata = _data_sram_wdata_T_38[31:0]; // @[Execute.scala 108:31 189:19]
  assign io_dataMemory_wstrb = _T_17 ? _data_sram_wstrb_T_21 : _data_sram_wstrb_T_27; // @[Mux.scala 81:58]
  assign io_dataMemory_waiting = _io_memoryStage_wait_mem_T & ~data_ok; // @[Execute.scala 270:52]
  assign io_executeStage_allowin = ~io_fromExecuteStage_valid | ready_go & io_fromMemory_allowin; // @[Execute.scala 315:31]
  assign io_ctrl_ex = io_fromExecuteStage_valid & (overflow_ex | mem_ex | io_fromExecuteStage_ds_to_es_ex | tlb_ex); // @[Execute.scala 485:18]
  always @(posedge clock) begin
    if (reset) begin // @[Execute.scala 99:34]
      addr_ok_r <= 1'h0; // @[Execute.scala 99:34]
    end else begin
      addr_ok_r <= _GEN_6;
    end
    if (reset) begin // @[Execute.scala 110:34]
      data_buff_valid <= 1'h0; // @[Execute.scala 110:34]
    end else if (io_fromMemory_allowin | no_store) begin // @[Execute.scala 282:43]
      data_buff_valid <= 1'h0; // @[Execute.scala 283:21]
    end else begin
      data_buff_valid <= _GEN_7;
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
  addr_ok_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  data_buff_valid = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ALU(
  input  [6:0]  io_fromExecute_op,
  input  [31:0] io_fromExecute_in1,
  input  [31:0] io_fromExecute_in2,
  output [31:0] io_execute_out,
  output        io_execute_ov
);
  wire [31:0] sum = io_fromExecute_in1 + io_fromExecute_in2; // @[ALU.scala 18:18]
  wire [31:0] diff = io_fromExecute_in1 - io_fromExecute_in2; // @[ALU.scala 19:18]
  wire  _overflow_T_6 = io_fromExecute_in1[31] == io_fromExecute_in2[31] & (io_fromExecute_in1[31] ^ sum[31]); // @[ALU.scala 24:44]
  wire  _overflow_T_13 = (io_fromExecute_in1[31] ^ io_fromExecute_in2[31]) & (io_fromExecute_in1[31] ^ diff[31]); // @[ALU.scala 25:42]
  wire  lt = $signed(io_fromExecute_in1) < $signed(io_fromExecute_in2); // @[ALU.scala 35:26]
  wire  ltu = io_fromExecute_in1 < io_fromExecute_in2; // @[ALU.scala 36:17]
  wire [31:0] _out_T = io_fromExecute_in1 | io_fromExecute_in2; // @[ALU.scala 42:27]
  wire [31:0] _out_T_1 = io_fromExecute_in1 & io_fromExecute_in2; // @[ALU.scala 43:27]
  wire [31:0] _out_T_3 = ~_out_T; // @[ALU.scala 44:23]
  wire [31:0] _out_T_4 = io_fromExecute_in1 ^ io_fromExecute_in2; // @[ALU.scala 45:27]
  wire [62:0] _GEN_0 = {{31'd0}, io_fromExecute_in2}; // @[ALU.scala 46:27]
  wire [62:0] _out_T_6 = _GEN_0 << io_fromExecute_in1[4:0]; // @[ALU.scala 46:27]
  wire [31:0] _out_T_8 = io_fromExecute_in2 >> io_fromExecute_in1[4:0]; // @[ALU.scala 47:27]
  wire [31:0] _out_T_12 = $signed(io_fromExecute_in2) >>> io_fromExecute_in1[4:0]; // @[ALU.scala 48:49]
  wire [5:0] _out_T_14 = io_fromExecute_in1[31] ? 6'h20 : 6'h1f; // @[ALU.scala 57:12]
  wire [5:0] _out_T_16 = io_fromExecute_in1[30] ? _out_T_14 : 6'h1e; // @[ALU.scala 57:12]
  wire [5:0] _out_T_18 = io_fromExecute_in1[29] ? _out_T_16 : 6'h1d; // @[ALU.scala 57:12]
  wire [5:0] _out_T_20 = io_fromExecute_in1[28] ? _out_T_18 : 6'h1c; // @[ALU.scala 57:12]
  wire [5:0] _out_T_22 = io_fromExecute_in1[27] ? _out_T_20 : 6'h1b; // @[ALU.scala 57:12]
  wire [5:0] _out_T_24 = io_fromExecute_in1[26] ? _out_T_22 : 6'h1a; // @[ALU.scala 57:12]
  wire [5:0] _out_T_26 = io_fromExecute_in1[25] ? _out_T_24 : 6'h19; // @[ALU.scala 57:12]
  wire [5:0] _out_T_28 = io_fromExecute_in1[24] ? _out_T_26 : 6'h18; // @[ALU.scala 57:12]
  wire [5:0] _out_T_30 = io_fromExecute_in1[23] ? _out_T_28 : 6'h17; // @[ALU.scala 57:12]
  wire [5:0] _out_T_32 = io_fromExecute_in1[22] ? _out_T_30 : 6'h16; // @[ALU.scala 57:12]
  wire [5:0] _out_T_34 = io_fromExecute_in1[21] ? _out_T_32 : 6'h15; // @[ALU.scala 57:12]
  wire [5:0] _out_T_36 = io_fromExecute_in1[20] ? _out_T_34 : 6'h14; // @[ALU.scala 57:12]
  wire [5:0] _out_T_38 = io_fromExecute_in1[19] ? _out_T_36 : 6'h13; // @[ALU.scala 57:12]
  wire [5:0] _out_T_40 = io_fromExecute_in1[18] ? _out_T_38 : 6'h12; // @[ALU.scala 57:12]
  wire [5:0] _out_T_42 = io_fromExecute_in1[17] ? _out_T_40 : 6'h11; // @[ALU.scala 57:12]
  wire [5:0] _out_T_44 = io_fromExecute_in1[16] ? _out_T_42 : 6'h10; // @[ALU.scala 57:12]
  wire [5:0] _out_T_46 = io_fromExecute_in1[15] ? _out_T_44 : 6'hf; // @[ALU.scala 57:12]
  wire [5:0] _out_T_48 = io_fromExecute_in1[14] ? _out_T_46 : 6'he; // @[ALU.scala 57:12]
  wire [5:0] _out_T_50 = io_fromExecute_in1[13] ? _out_T_48 : 6'hd; // @[ALU.scala 57:12]
  wire [5:0] _out_T_52 = io_fromExecute_in1[12] ? _out_T_50 : 6'hc; // @[ALU.scala 57:12]
  wire [5:0] _out_T_54 = io_fromExecute_in1[11] ? _out_T_52 : 6'hb; // @[ALU.scala 57:12]
  wire [5:0] _out_T_56 = io_fromExecute_in1[10] ? _out_T_54 : 6'ha; // @[ALU.scala 57:12]
  wire [5:0] _out_T_58 = io_fromExecute_in1[9] ? _out_T_56 : 6'h9; // @[ALU.scala 57:12]
  wire [5:0] _out_T_60 = io_fromExecute_in1[8] ? _out_T_58 : 6'h8; // @[ALU.scala 57:12]
  wire [5:0] _out_T_62 = io_fromExecute_in1[7] ? _out_T_60 : 6'h7; // @[ALU.scala 57:12]
  wire [5:0] _out_T_64 = io_fromExecute_in1[6] ? _out_T_62 : 6'h6; // @[ALU.scala 57:12]
  wire [5:0] _out_T_66 = io_fromExecute_in1[5] ? _out_T_64 : 6'h5; // @[ALU.scala 57:12]
  wire [5:0] _out_T_68 = io_fromExecute_in1[4] ? _out_T_66 : 6'h4; // @[ALU.scala 57:12]
  wire [5:0] _out_T_70 = io_fromExecute_in1[3] ? _out_T_68 : 6'h3; // @[ALU.scala 57:12]
  wire [5:0] _out_T_72 = io_fromExecute_in1[2] ? _out_T_70 : 6'h2; // @[ALU.scala 57:12]
  wire [5:0] _out_T_74 = io_fromExecute_in1[1] ? _out_T_72 : 6'h1; // @[ALU.scala 57:12]
  wire [5:0] _out_T_76 = io_fromExecute_in1[0] ? _out_T_74 : 6'h0; // @[ALU.scala 57:12]
  wire [5:0] _out_T_79 = ~io_fromExecute_in1[31] ? 6'h20 : 6'h1f; // @[ALU.scala 60:12]
  wire [5:0] _out_T_82 = ~io_fromExecute_in1[30] ? _out_T_79 : 6'h1e; // @[ALU.scala 60:12]
  wire [5:0] _out_T_85 = ~io_fromExecute_in1[29] ? _out_T_82 : 6'h1d; // @[ALU.scala 60:12]
  wire [5:0] _out_T_88 = ~io_fromExecute_in1[28] ? _out_T_85 : 6'h1c; // @[ALU.scala 60:12]
  wire [5:0] _out_T_91 = ~io_fromExecute_in1[27] ? _out_T_88 : 6'h1b; // @[ALU.scala 60:12]
  wire [5:0] _out_T_94 = ~io_fromExecute_in1[26] ? _out_T_91 : 6'h1a; // @[ALU.scala 60:12]
  wire [5:0] _out_T_97 = ~io_fromExecute_in1[25] ? _out_T_94 : 6'h19; // @[ALU.scala 60:12]
  wire [5:0] _out_T_100 = ~io_fromExecute_in1[24] ? _out_T_97 : 6'h18; // @[ALU.scala 60:12]
  wire [5:0] _out_T_103 = ~io_fromExecute_in1[23] ? _out_T_100 : 6'h17; // @[ALU.scala 60:12]
  wire [5:0] _out_T_106 = ~io_fromExecute_in1[22] ? _out_T_103 : 6'h16; // @[ALU.scala 60:12]
  wire [5:0] _out_T_109 = ~io_fromExecute_in1[21] ? _out_T_106 : 6'h15; // @[ALU.scala 60:12]
  wire [5:0] _out_T_112 = ~io_fromExecute_in1[20] ? _out_T_109 : 6'h14; // @[ALU.scala 60:12]
  wire [5:0] _out_T_115 = ~io_fromExecute_in1[19] ? _out_T_112 : 6'h13; // @[ALU.scala 60:12]
  wire [5:0] _out_T_118 = ~io_fromExecute_in1[18] ? _out_T_115 : 6'h12; // @[ALU.scala 60:12]
  wire [5:0] _out_T_121 = ~io_fromExecute_in1[17] ? _out_T_118 : 6'h11; // @[ALU.scala 60:12]
  wire [5:0] _out_T_124 = ~io_fromExecute_in1[16] ? _out_T_121 : 6'h10; // @[ALU.scala 60:12]
  wire [5:0] _out_T_127 = ~io_fromExecute_in1[15] ? _out_T_124 : 6'hf; // @[ALU.scala 60:12]
  wire [5:0] _out_T_130 = ~io_fromExecute_in1[14] ? _out_T_127 : 6'he; // @[ALU.scala 60:12]
  wire [5:0] _out_T_133 = ~io_fromExecute_in1[13] ? _out_T_130 : 6'hd; // @[ALU.scala 60:12]
  wire [5:0] _out_T_136 = ~io_fromExecute_in1[12] ? _out_T_133 : 6'hc; // @[ALU.scala 60:12]
  wire [5:0] _out_T_139 = ~io_fromExecute_in1[11] ? _out_T_136 : 6'hb; // @[ALU.scala 60:12]
  wire [5:0] _out_T_142 = ~io_fromExecute_in1[10] ? _out_T_139 : 6'ha; // @[ALU.scala 60:12]
  wire [5:0] _out_T_145 = ~io_fromExecute_in1[9] ? _out_T_142 : 6'h9; // @[ALU.scala 60:12]
  wire [5:0] _out_T_148 = ~io_fromExecute_in1[8] ? _out_T_145 : 6'h8; // @[ALU.scala 60:12]
  wire [5:0] _out_T_151 = ~io_fromExecute_in1[7] ? _out_T_148 : 6'h7; // @[ALU.scala 60:12]
  wire [5:0] _out_T_154 = ~io_fromExecute_in1[6] ? _out_T_151 : 6'h6; // @[ALU.scala 60:12]
  wire [5:0] _out_T_157 = ~io_fromExecute_in1[5] ? _out_T_154 : 6'h5; // @[ALU.scala 60:12]
  wire [5:0] _out_T_160 = ~io_fromExecute_in1[4] ? _out_T_157 : 6'h4; // @[ALU.scala 60:12]
  wire [5:0] _out_T_163 = ~io_fromExecute_in1[3] ? _out_T_160 : 6'h3; // @[ALU.scala 60:12]
  wire [5:0] _out_T_166 = ~io_fromExecute_in1[2] ? _out_T_163 : 6'h2; // @[ALU.scala 60:12]
  wire [5:0] _out_T_169 = ~io_fromExecute_in1[1] ? _out_T_166 : 6'h1; // @[ALU.scala 60:12]
  wire [5:0] _out_T_172 = ~io_fromExecute_in1[0] ? _out_T_169 : 6'h0; // @[ALU.scala 60:12]
  wire [31:0] _out_T_174 = 7'h2 == io_fromExecute_op ? _out_T : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _out_T_176 = 7'h1 == io_fromExecute_op ? _out_T_1 : _out_T_174; // @[Mux.scala 81:58]
  wire [31:0] _out_T_178 = 7'h4 == io_fromExecute_op ? _out_T_3 : _out_T_176; // @[Mux.scala 81:58]
  wire [31:0] _out_T_180 = 7'h3 == io_fromExecute_op ? _out_T_4 : _out_T_178; // @[Mux.scala 81:58]
  wire [62:0] _out_T_182 = 7'h5 == io_fromExecute_op ? _out_T_6 : {{31'd0}, _out_T_180}; // @[Mux.scala 81:58]
  wire [62:0] _out_T_184 = 7'h7 == io_fromExecute_op ? {{31'd0}, _out_T_8} : _out_T_182; // @[Mux.scala 81:58]
  wire [62:0] _out_T_186 = 7'h9 == io_fromExecute_op ? {{31'd0}, _out_T_12} : _out_T_184; // @[Mux.scala 81:58]
  wire [62:0] _out_T_188 = 7'h13 == io_fromExecute_op ? {{62'd0}, lt} : _out_T_186; // @[Mux.scala 81:58]
  wire [62:0] _out_T_190 = 7'h14 == io_fromExecute_op ? {{62'd0}, ltu} : _out_T_188; // @[Mux.scala 81:58]
  wire [62:0] _out_T_192 = 7'h15 == io_fromExecute_op ? {{31'd0}, sum} : _out_T_190; // @[Mux.scala 81:58]
  wire [62:0] _out_T_194 = 7'h16 == io_fromExecute_op ? {{31'd0}, sum} : _out_T_192; // @[Mux.scala 81:58]
  wire [62:0] _out_T_196 = 7'h12 == io_fromExecute_op ? {{31'd0}, sum} : _out_T_194; // @[Mux.scala 81:58]
  wire [62:0] _out_T_198 = 7'h17 == io_fromExecute_op ? {{31'd0}, diff} : _out_T_196; // @[Mux.scala 81:58]
  wire [62:0] _out_T_200 = 7'h18 == io_fromExecute_op ? {{31'd0}, diff} : _out_T_198; // @[Mux.scala 81:58]
  wire [62:0] _out_T_202 = 7'h19 == io_fromExecute_op ? {{57'd0}, _out_T_76} : _out_T_200; // @[Mux.scala 81:58]
  wire [62:0] _out_T_204 = 7'h1a == io_fromExecute_op ? {{57'd0}, _out_T_172} : _out_T_202; // @[Mux.scala 81:58]
  assign io_execute_out = _out_T_204[31:0]; // @[ALU.scala 29:18 38:7]
  assign io_execute_ov = 7'h17 == io_fromExecute_op ? _overflow_T_13 : 7'h15 == io_fromExecute_op & _overflow_T_6; // @[Mux.scala 81:58]
endmodule
module Mul(
  input  [6:0]  io_fromExecute_op,
  input  [31:0] io_fromExecute_in1,
  input  [31:0] io_fromExecute_in2,
  output [63:0] io_execute_out
);
  wire  _io_execute_out_T_6 = io_fromExecute_op == 7'h1b | io_fromExecute_op == 7'h1d | io_fromExecute_op == 7'h1e |
    io_fromExecute_op == 7'h20; // @[Mul.scala 19:68]
  wire [63:0] _io_execute_out_T_10 = $signed(io_fromExecute_in1) * $signed(io_fromExecute_in2); // @[Mul.scala 20:41]
  wire [63:0] _io_execute_out_T_11 = io_fromExecute_in1 * io_fromExecute_in2; // @[Mul.scala 21:9]
  assign io_execute_out = _io_execute_out_T_6 ? _io_execute_out_T_10 : _io_execute_out_T_11; // @[Mul.scala 18:24]
endmodule
module Div(
  input  [6:0]  io_fromExecute_op,
  input  [31:0] io_fromExecute_divisor,
  input  [31:0] io_fromExecute_dividend,
  output [31:0] io_execute_quotient,
  output [31:0] io_execute_remainder
);
  wire [32:0] _quotient_T_3 = $signed(io_fromExecute_divisor) / $signed(io_fromExecute_dividend); // @[Div.scala 28:67]
  wire [31:0] _quotient_T_4 = io_fromExecute_divisor / io_fromExecute_dividend; // @[Div.scala 29:40]
  wire [32:0] _quotient_T_6 = 7'h22 == io_fromExecute_op ? _quotient_T_3 : 33'h0; // @[Mux.scala 81:58]
  wire [32:0] _quotient_T_8 = 7'h23 == io_fromExecute_op ? {{1'd0}, _quotient_T_4} : _quotient_T_6; // @[Mux.scala 81:58]
  wire [31:0] _remainder_T_3 = $signed(io_fromExecute_divisor) % $signed(io_fromExecute_dividend); // @[Div.scala 36:67]
  wire [31:0] _remainder_T_4 = io_fromExecute_divisor % io_fromExecute_dividend; // @[Div.scala 37:40]
  wire [31:0] _remainder_T_6 = 7'h22 == io_fromExecute_op ? _remainder_T_3 : 32'h0; // @[Mux.scala 81:58]
  assign io_execute_quotient = _quotient_T_8[31:0]; // @[Div.scala 19:23 24:12]
  assign io_execute_remainder = 7'h23 == io_fromExecute_op ? _remainder_T_4 : _remainder_T_6; // @[Mux.scala 81:58]
endmodule
module Mov(
  input         io_fromMemory_cp0_wen,
  input         io_fromMemory_cp0_waddr,
  input         io_fromMemory_cp0_wdata,
  input         io_fromWriteBackStage_cp0_wen,
  input         io_fromWriteBackStage_cp0_waddr,
  input         io_fromWriteBackStage_cp0_wdata,
  input  [31:0] io_fromWriteBackStage_cp0_rdata,
  input  [6:0]  io_fromExecute_op,
  input  [31:0] io_fromExecute_inst,
  input  [31:0] io_fromExecute_in,
  input  [31:0] io_fromExecute_hi,
  input  [31:0] io_fromExecute_lo,
  output [31:0] io_execute_out
);
  wire [4:0] _GEN_0 = {{4'd0}, io_fromMemory_cp0_waddr}; // @[Mov.scala 23:31]
  wire  _mem_cp0_T_2 = _GEN_0 == io_fromExecute_inst[15:11]; // @[Mov.scala 23:31]
  wire  mem_cp0 = io_fromMemory_cp0_wen & _mem_cp0_T_2; // @[Mov.scala 22:44]
  wire [4:0] _GEN_1 = {{4'd0}, io_fromWriteBackStage_cp0_waddr}; // @[Mov.scala 26:39]
  wire  _wbs_cp0_T_2 = _GEN_1 == io_fromExecute_inst[15:11]; // @[Mov.scala 26:39]
  wire  wbs_cp0 = io_fromWriteBackStage_cp0_wen & _wbs_cp0_T_2; // @[Mov.scala 25:52]
  wire [31:0] _io_execute_out_T = wbs_cp0 ? {{31'd0}, io_fromWriteBackStage_cp0_wdata} : io_fromWriteBackStage_cp0_rdata
    ; // @[Mux.scala 101:16]
  wire [31:0] _io_execute_out_T_1 = mem_cp0 ? {{31'd0}, io_fromMemory_cp0_wdata} : _io_execute_out_T; // @[Mux.scala 101:16]
  wire [31:0] _io_execute_out_T_3 = 7'hd == io_fromExecute_op ? io_fromExecute_hi : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_execute_out_T_5 = 7'hf == io_fromExecute_op ? io_fromExecute_lo : _io_execute_out_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_execute_out_T_7 = 7'hb == io_fromExecute_op ? io_fromExecute_in : _io_execute_out_T_5; // @[Mux.scala 81:58]
  wire [31:0] _io_execute_out_T_9 = 7'hc == io_fromExecute_op ? io_fromExecute_in : _io_execute_out_T_7; // @[Mux.scala 81:58]
  assign io_execute_out = 7'h11 == io_fromExecute_op ? _io_execute_out_T_1 : _io_execute_out_T_9; // @[Mux.scala 81:58]
endmodule
module InstMemory(
  input         clock,
  input         reset,
  input         io_fromPreFetchStage_req,
  input         io_fromPreFetchStage_waiting,
  input         io_fromFetchStage_waiting,
  input  [31:0] io_fromInstMMU_paddr,
  input         io_fromCtrl_do_flush,
  output        io_preFetchStage_addr_ok,
  output [31:0] io_preFetchStage_rdata,
  output        io_preFetchStage_data_ok,
  output        io_fetchStage_data_ok,
  output [31:0] io_fetchStage_rdata,
  output        io_sramAXITrans_req,
  output [31:0] io_sramAXITrans_addr,
  input         io_sramAXITrans_data_ok,
  input         io_sramAXITrans_addr_ok,
  input  [31:0] io_sramAXITrans_rdata,
  output [1:0]  io_ctrl_inst_sram_discard
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] inst_sram_discard; // @[InstMemory.scala 21:42]
  wire  _io_preFetchStage_data_ok_T_1 = ~(|inst_sram_discard); // @[InstMemory.scala 25:58]
  wire [1:0] _inst_sram_discard_T = {io_fromPreFetchStage_waiting,io_fromFetchStage_waiting}; // @[Cat.scala 33:92]
  wire [1:0] _GEN_0 = inst_sram_discard == 2'h2 ? 2'h0 : inst_sram_discard; // @[InstMemory.scala 46:43 47:25 21:42]
  wire [1:0] _GEN_1 = inst_sram_discard == 2'h1 ? 2'h0 : _GEN_0; // @[InstMemory.scala 44:43 45:25]
  assign io_preFetchStage_addr_ok = io_sramAXITrans_addr_ok; // @[InstMemory.scala 23:28]
  assign io_preFetchStage_rdata = io_sramAXITrans_rdata; // @[InstMemory.scala 24:28]
  assign io_preFetchStage_data_ok = io_sramAXITrans_data_ok & ~(|inst_sram_discard); // @[InstMemory.scala 25:55]
  assign io_fetchStage_data_ok = io_sramAXITrans_data_ok & _io_preFetchStage_data_ok_T_1; // @[InstMemory.scala 28:52]
  assign io_fetchStage_rdata = io_sramAXITrans_rdata; // @[InstMemory.scala 27:25]
  assign io_sramAXITrans_req = io_fromPreFetchStage_req; // @[InstMemory.scala 30:25]
  assign io_sramAXITrans_addr = io_fromInstMMU_paddr; // @[InstMemory.scala 33:25]
  assign io_ctrl_inst_sram_discard = inst_sram_discard; // @[InstMemory.scala 37:29]
  always @(posedge clock) begin
    if (reset) begin // @[InstMemory.scala 21:42]
      inst_sram_discard <= 2'h0; // @[InstMemory.scala 21:42]
    end else if (io_fromCtrl_do_flush) begin // @[InstMemory.scala 39:30]
      inst_sram_discard <= _inst_sram_discard_T; // @[InstMemory.scala 40:23]
    end else if (io_sramAXITrans_data_ok) begin // @[InstMemory.scala 41:39]
      if (inst_sram_discard == 2'h3) begin // @[InstMemory.scala 42:37]
        inst_sram_discard <= 2'h1; // @[InstMemory.scala 43:25]
      end else begin
        inst_sram_discard <= _GEN_1;
      end
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
  inst_sram_discard = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DataMemory(
  input         clock,
  input         reset,
  input  [6:0]  io_fromExecute_aluop,
  input  [1:0]  io_fromExecute_addrLowBit2,
  input         io_fromExecute_req,
  input         io_fromExecute_wr,
  input  [1:0]  io_fromExecute_size,
  input  [31:0] io_fromExecute_wdata,
  input  [3:0]  io_fromExecute_wstrb,
  input         io_fromExecute_waiting,
  input         io_fromMemory_waiting,
  input         io_fromCtrl_do_flush,
  input  [31:0] io_fromDataMMU_paddr,
  output        io_execute_addr_ok,
  output        io_execute_data_ok,
  output        io_memory_data_ok,
  output [31:0] io_memory_rdata,
  output        io_sramAXITrans_req,
  output        io_sramAXITrans_wr,
  output [1:0]  io_sramAXITrans_size,
  output [31:0] io_sramAXITrans_addr,
  output [3:0]  io_sramAXITrans_wstrb,
  output [31:0] io_sramAXITrans_wdata,
  input         io_sramAXITrans_addr_ok,
  input         io_sramAXITrans_data_ok,
  input  [31:0] io_sramAXITrans_rdata,
  output [1:0]  io_ctrl_data_sram_discard
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] _read_mask_T_1 = 2'h1 == io_fromExecute_addrLowBit2 ? 16'hff00 : 16'hff; // @[Mux.scala 81:58]
  wire [23:0] _read_mask_T_3 = 2'h2 == io_fromExecute_addrLowBit2 ? 24'hff0000 : {{8'd0}, _read_mask_T_1}; // @[Mux.scala 81:58]
  wire [31:0] _read_mask_T_5 = 2'h3 == io_fromExecute_addrLowBit2 ? 32'hff000000 : {{8'd0}, _read_mask_T_3}; // @[Mux.scala 81:58]
  wire [31:0] _read_mask_T_13 = 2'h0 == io_fromExecute_addrLowBit2 ? 32'hffff : 32'hffffffff; // @[Mux.scala 81:58]
  wire [31:0] _read_mask_T_15 = 2'h2 == io_fromExecute_addrLowBit2 ? 32'hffff0000 : _read_mask_T_13; // @[Mux.scala 81:58]
  reg [31:0] read_mask_next; // @[DataMemory.scala 76:31]
  reg [1:0] data_sram_discard; // @[DataMemory.scala 78:42]
  wire  _data_sram_data_ok_discard_T_1 = ~(|data_sram_discard); // @[DataMemory.scala 79:46]
  wire [1:0] _data_sram_discard_T = {io_fromExecute_waiting,io_fromMemory_waiting}; // @[Cat.scala 33:92]
  wire [1:0] _GEN_0 = data_sram_discard == 2'h1 | data_sram_discard == 2'h2 ? 2'h0 : data_sram_discard; // @[DataMemory.scala 100:25 78:42 99:72]
  assign io_execute_addr_ok = io_sramAXITrans_addr_ok; // @[DataMemory.scala 90:29]
  assign io_execute_data_ok = _data_sram_data_ok_discard_T_1 & io_sramAXITrans_data_ok; // @[DataMemory.scala 91:55]
  assign io_memory_data_ok = _data_sram_data_ok_discard_T_1 & io_sramAXITrans_data_ok; // @[DataMemory.scala 88:55]
  assign io_memory_rdata = io_sramAXITrans_rdata & read_mask_next; // @[DataMemory.scala 87:38]
  assign io_sramAXITrans_req = io_fromExecute_req; // @[DataMemory.scala 81:29]
  assign io_sramAXITrans_wr = io_fromExecute_wr; // @[DataMemory.scala 82:29]
  assign io_sramAXITrans_size = io_fromExecute_size; // @[DataMemory.scala 83:29]
  assign io_sramAXITrans_addr = io_fromDataMMU_paddr; // @[DataMemory.scala 84:29]
  assign io_sramAXITrans_wstrb = io_fromExecute_wstrb; // @[DataMemory.scala 85:29]
  assign io_sramAXITrans_wdata = io_fromExecute_wdata; // @[DataMemory.scala 86:29]
  assign io_ctrl_data_sram_discard = data_sram_discard; // @[DataMemory.scala 92:29]
  always @(posedge clock) begin
    if (7'h33 == io_fromExecute_aluop) begin // @[Mux.scala 81:58]
      read_mask_next <= _read_mask_T_15;
    end else if (7'h32 == io_fromExecute_aluop) begin // @[Mux.scala 81:58]
      read_mask_next <= _read_mask_T_15;
    end else if (7'h31 == io_fromExecute_aluop) begin // @[Mux.scala 81:58]
      read_mask_next <= _read_mask_T_5;
    end else if (7'h30 == io_fromExecute_aluop) begin // @[Mux.scala 81:58]
      read_mask_next <= _read_mask_T_5;
    end else begin
      read_mask_next <= 32'hffffffff;
    end
    if (reset) begin // @[DataMemory.scala 78:42]
      data_sram_discard <= 2'h0; // @[DataMemory.scala 78:42]
    end else if (io_fromCtrl_do_flush) begin // @[DataMemory.scala 94:30]
      data_sram_discard <= _data_sram_discard_T; // @[DataMemory.scala 95:23]
    end else if (io_sramAXITrans_data_ok) begin // @[DataMemory.scala 96:23]
      if (data_sram_discard == 2'h3) begin // @[DataMemory.scala 97:37]
        data_sram_discard <= 2'h1; // @[DataMemory.scala 98:25]
      end else begin
        data_sram_discard <= _GEN_0;
      end
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
  read_mask_next = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  data_sram_discard = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits,
  output        io_deq_valid,
  output [31:0] io_deq_bits,
  output [2:0]  io_count
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram [0:3]; // @[Decoupled.scala 275:95]
  wire  ram_io_deq_bits_MPORT_en; // @[Decoupled.scala 275:95]
  wire [1:0] ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 275:95]
  wire [31:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 275:95]
  wire [31:0] ram_MPORT_data; // @[Decoupled.scala 275:95]
  wire [1:0] ram_MPORT_addr; // @[Decoupled.scala 275:95]
  wire  ram_MPORT_mask; // @[Decoupled.scala 275:95]
  wire  ram_MPORT_en; // @[Decoupled.scala 275:95]
  reg [1:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [1:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 278:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 279:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 280:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 281:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 52:35]
  wire [1:0] _value_T_1 = enq_ptr_value + 2'h1; // @[Counter.scala 77:24]
  wire [1:0] _value_T_3 = deq_ptr_value + 2'h1; // @[Counter.scala 77:24]
  wire [1:0] ptr_diff = enq_ptr_value - deq_ptr_value; // @[Decoupled.scala 328:32]
  wire [2:0] _io_count_T_1 = maybe_full & ptr_match ? 3'h4 : 3'h0; // @[Decoupled.scala 331:20]
  wire [2:0] _GEN_11 = {{1'd0}, ptr_diff}; // @[Decoupled.scala 331:62]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 275:95]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 305:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 304:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 312:17]
  assign io_count = _io_count_T_1 | _GEN_11; // @[Decoupled.scala 331:62]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 275:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 2'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 288:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 2'h0; // @[Counter.scala 61:40]
    end else if (io_deq_valid) begin // @[Decoupled.scala 292:16]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Decoupled.scala 278:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 278:27]
    end else if (do_enq != io_deq_valid) begin // @[Decoupled.scala 295:27]
      maybe_full <= do_enq; // @[Decoupled.scala 296:16]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    ram[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FifoBuffer(
  input         clock,
  input         reset,
  input         io_wen,
  input  [31:0] io_input,
  output [31:0] io_output,
  output        io_empty,
  output        io_full
);
  wire  queue_clock; // @[SramAXITrans.scala 21:21]
  wire  queue_reset; // @[SramAXITrans.scala 21:21]
  wire  queue_io_enq_ready; // @[SramAXITrans.scala 21:21]
  wire  queue_io_enq_valid; // @[SramAXITrans.scala 21:21]
  wire [31:0] queue_io_enq_bits; // @[SramAXITrans.scala 21:21]
  wire  queue_io_deq_valid; // @[SramAXITrans.scala 21:21]
  wire [31:0] queue_io_deq_bits; // @[SramAXITrans.scala 21:21]
  wire [2:0] queue_io_count; // @[SramAXITrans.scala 21:21]
  Queue queue ( // @[SramAXITrans.scala 21:21]
    .clock(queue_clock),
    .reset(queue_reset),
    .io_enq_ready(queue_io_enq_ready),
    .io_enq_valid(queue_io_enq_valid),
    .io_enq_bits(queue_io_enq_bits),
    .io_deq_valid(queue_io_deq_valid),
    .io_deq_bits(queue_io_deq_bits),
    .io_count(queue_io_count)
  );
  assign io_output = queue_io_deq_bits; // @[SramAXITrans.scala 28:22]
  assign io_empty = queue_io_count == 3'h0; // @[SramAXITrans.scala 29:40]
  assign io_full = ~queue_io_enq_ready; // @[SramAXITrans.scala 25:44]
  assign queue_clock = clock;
  assign queue_reset = reset;
  assign queue_io_enq_valid = io_wen; // @[SramAXITrans.scala 23:22]
  assign queue_io_enq_bits = io_input; // @[SramAXITrans.scala 24:22]
endmodule
module Queue_1(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits,
  output [2:0]  io_count
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram [0:5]; // @[Decoupled.scala 275:95]
  wire  ram_io_deq_bits_MPORT_en; // @[Decoupled.scala 275:95]
  wire [2:0] ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 275:95]
  wire [31:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 275:95]
  wire [31:0] ram_MPORT_data; // @[Decoupled.scala 275:95]
  wire [2:0] ram_MPORT_addr; // @[Decoupled.scala 275:95]
  wire  ram_MPORT_mask; // @[Decoupled.scala 275:95]
  wire  ram_MPORT_en; // @[Decoupled.scala 275:95]
  reg [2:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [2:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 278:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 279:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 280:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 281:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 52:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 52:35]
  wire  wrap = enq_ptr_value == 3'h5; // @[Counter.scala 73:24]
  wire [2:0] _value_T_1 = enq_ptr_value + 3'h1; // @[Counter.scala 77:24]
  wire  wrap_1 = deq_ptr_value == 3'h5; // @[Counter.scala 73:24]
  wire [2:0] _value_T_3 = deq_ptr_value + 3'h1; // @[Counter.scala 77:24]
  wire [2:0] ptr_diff = enq_ptr_value - deq_ptr_value; // @[Decoupled.scala 328:32]
  wire [2:0] _io_count_T = maybe_full ? 3'h6 : 3'h0; // @[Decoupled.scala 335:10]
  wire [2:0] _io_count_T_3 = 3'h6 + ptr_diff; // @[Decoupled.scala 336:57]
  wire [2:0] _io_count_T_4 = deq_ptr_value > enq_ptr_value ? _io_count_T_3 : ptr_diff; // @[Decoupled.scala 336:10]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 275:95]
  `else
  assign ram_io_deq_bits_MPORT_data = ram_io_deq_bits_MPORT_addr >= 3'h6 ? _RAND_1[31:0] :
    ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 275:95]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 305:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 304:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 312:17]
  assign io_count = ptr_match ? _io_count_T : _io_count_T_4; // @[Decoupled.scala 333:20]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 275:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 3'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 288:16]
      if (wrap) begin // @[Counter.scala 87:20]
        enq_ptr_value <= 3'h0; // @[Counter.scala 87:28]
      end else begin
        enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
      end
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 3'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[Decoupled.scala 292:16]
      if (wrap_1) begin // @[Counter.scala 87:20]
        deq_ptr_value <= 3'h0; // @[Counter.scala 87:28]
      end else begin
        deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
      end
    end
    if (reset) begin // @[Decoupled.scala 278:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 278:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 295:27]
      maybe_full <= do_enq; // @[Decoupled.scala 296:16]
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
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 6; initvar = initvar+1)
    ram[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  enq_ptr_value = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  deq_ptr_value = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  maybe_full = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FifoBuffer_1(
  input         clock,
  input         reset,
  input         io_wen,
  input         io_ren,
  input  [31:0] io_input,
  output [31:0] io_output,
  output        io_empty,
  output        io_full
);
  wire  queue_clock; // @[SramAXITrans.scala 21:21]
  wire  queue_reset; // @[SramAXITrans.scala 21:21]
  wire  queue_io_enq_ready; // @[SramAXITrans.scala 21:21]
  wire  queue_io_enq_valid; // @[SramAXITrans.scala 21:21]
  wire [31:0] queue_io_enq_bits; // @[SramAXITrans.scala 21:21]
  wire  queue_io_deq_ready; // @[SramAXITrans.scala 21:21]
  wire  queue_io_deq_valid; // @[SramAXITrans.scala 21:21]
  wire [31:0] queue_io_deq_bits; // @[SramAXITrans.scala 21:21]
  wire [2:0] queue_io_count; // @[SramAXITrans.scala 21:21]
  Queue_1 queue ( // @[SramAXITrans.scala 21:21]
    .clock(queue_clock),
    .reset(queue_reset),
    .io_enq_ready(queue_io_enq_ready),
    .io_enq_valid(queue_io_enq_valid),
    .io_enq_bits(queue_io_enq_bits),
    .io_deq_ready(queue_io_deq_ready),
    .io_deq_valid(queue_io_deq_valid),
    .io_deq_bits(queue_io_deq_bits),
    .io_count(queue_io_count)
  );
  assign io_output = queue_io_deq_bits; // @[SramAXITrans.scala 28:22]
  assign io_empty = queue_io_count == 3'h0; // @[SramAXITrans.scala 29:40]
  assign io_full = ~queue_io_enq_ready; // @[SramAXITrans.scala 25:44]
  assign queue_clock = clock;
  assign queue_reset = reset;
  assign queue_io_enq_valid = io_wen; // @[SramAXITrans.scala 23:22]
  assign queue_io_enq_bits = io_input; // @[SramAXITrans.scala 24:22]
  assign queue_io_deq_ready = io_ren; // @[SramAXITrans.scala 27:22]
endmodule
module FifoCount(
  input   clock,
  input   reset,
  input   io_wen,
  input   io_ren,
  output  io_empty,
  output  io_full
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] count; // @[SramAXITrans.scala 40:22]
  wire  do_read = io_ren & ~io_empty; // @[SramAXITrans.scala 42:25]
  wire  do_write = io_wen & ~io_full; // @[SramAXITrans.scala 43:25]
  wire [2:0] _count_T_1 = count - 3'h1; // @[SramAXITrans.scala 49:20]
  wire [2:0] _count_T_3 = count + 3'h1; // @[SramAXITrans.scala 51:20]
  assign io_empty = count == 3'h0; // @[SramAXITrans.scala 45:21]
  assign io_full = count == 3'h5; // @[SramAXITrans.scala 46:21]
  always @(posedge clock) begin
    if (reset) begin // @[SramAXITrans.scala 40:22]
      count <= 3'h0; // @[SramAXITrans.scala 40:22]
    end else if (do_read & ~do_write) begin // @[SramAXITrans.scala 48:30]
      count <= _count_T_1; // @[SramAXITrans.scala 49:11]
    end else if (do_write & ~do_read) begin // @[SramAXITrans.scala 50:36]
      count <= _count_T_3; // @[SramAXITrans.scala 51:11]
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
  count = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FifoBufferValid(
  input         clock,
  input         reset,
  input         io_wen,
  input         io_ren,
  output        io_empty,
  output        io_full,
  output        io_related_1,
  input  [32:0] io_input,
  output [32:0] io_output,
  input  [31:0] io_related_data_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  reg [32:0] buff_0; // @[SramAXITrans.scala 74:30]
  reg [32:0] buff_1; // @[SramAXITrans.scala 74:30]
  reg [32:0] buff_2; // @[SramAXITrans.scala 74:30]
  reg [32:0] buff_3; // @[SramAXITrans.scala 74:30]
  reg [32:0] buff_4; // @[SramAXITrans.scala 74:30]
  reg [32:0] buff_5; // @[SramAXITrans.scala 74:30]
  reg  valid_0; // @[SramAXITrans.scala 75:30]
  reg  valid_1; // @[SramAXITrans.scala 75:30]
  reg  valid_2; // @[SramAXITrans.scala 75:30]
  reg  valid_3; // @[SramAXITrans.scala 75:30]
  reg  valid_4; // @[SramAXITrans.scala 75:30]
  reg  valid_5; // @[SramAXITrans.scala 75:30]
  reg [2:0] head; // @[SramAXITrans.scala 79:22]
  reg [2:0] tail; // @[SramAXITrans.scala 80:22]
  reg [3:0] count; // @[SramAXITrans.scala 81:22]
  wire  do_read = io_ren & ~io_empty; // @[SramAXITrans.scala 83:25]
  wire  do_write = io_wen & ~io_full; // @[SramAXITrans.scala 84:25]
  wire  related_vec_1_0 = valid_0 & io_related_data_1 == buff_0[31:0]; // @[SramAXITrans.scala 122:34]
  wire  related_vec_1_1 = valid_1 & io_related_data_1 == buff_1[31:0]; // @[SramAXITrans.scala 122:34]
  wire  related_vec_1_2 = valid_2 & io_related_data_1 == buff_2[31:0]; // @[SramAXITrans.scala 122:34]
  wire  related_vec_1_3 = valid_3 & io_related_data_1 == buff_3[31:0]; // @[SramAXITrans.scala 122:34]
  wire  related_vec_1_4 = valid_4 & io_related_data_1 == buff_4[31:0]; // @[SramAXITrans.scala 122:34]
  wire  related_vec_1_5 = valid_5 & io_related_data_1 == buff_5[31:0]; // @[SramAXITrans.scala 122:34]
  wire [32:0] _GEN_1 = 3'h1 == tail ? buff_1 : buff_0; // @[SramAXITrans.scala 90:{13,13}]
  wire [32:0] _GEN_2 = 3'h2 == tail ? buff_2 : _GEN_1; // @[SramAXITrans.scala 90:{13,13}]
  wire [32:0] _GEN_3 = 3'h3 == tail ? buff_3 : _GEN_2; // @[SramAXITrans.scala 90:{13,13}]
  wire [32:0] _GEN_4 = 3'h4 == tail ? buff_4 : _GEN_3; // @[SramAXITrans.scala 90:{13,13}]
  wire [3:0] _count_T_1 = count - 4'h1; // @[SramAXITrans.scala 93:20]
  wire [3:0] _count_T_3 = count + 4'h1; // @[SramAXITrans.scala 95:20]
  wire  _T_4 = head == 3'h5; // @[SramAXITrans.scala 99:15]
  wire [2:0] _head_T_1 = head + 3'h1; // @[SramAXITrans.scala 102:20]
  wire  _T_5 = tail == 3'h5; // @[SramAXITrans.scala 107:15]
  wire [2:0] _tail_T_1 = tail + 3'h1; // @[SramAXITrans.scala 110:20]
  wire  _GEN_13 = do_write & head == 3'h0 | valid_0; // @[SramAXITrans.scala 118:42 120:16 75:30]
  wire  _GEN_17 = do_write & head == 3'h1 | valid_1; // @[SramAXITrans.scala 118:42 120:16 75:30]
  wire  _GEN_21 = do_write & head == 3'h2 | valid_2; // @[SramAXITrans.scala 118:42 120:16 75:30]
  wire  _GEN_25 = do_write & head == 3'h3 | valid_3; // @[SramAXITrans.scala 118:42 120:16 75:30]
  wire  _GEN_29 = do_write & head == 3'h4 | valid_4; // @[SramAXITrans.scala 118:42 120:16 75:30]
  wire  _GEN_33 = do_write & _T_4 | valid_5; // @[SramAXITrans.scala 118:42 120:16 75:30]
  assign io_empty = count == 4'h0; // @[SramAXITrans.scala 86:25]
  assign io_full = count == 4'h5; // @[SramAXITrans.scala 87:25]
  assign io_related_1 = related_vec_1_0 | related_vec_1_1 | related_vec_1_2 | related_vec_1_3 | related_vec_1_4 |
    related_vec_1_5; // @[SramAXITrans.scala 88:42]
  assign io_output = 3'h5 == tail ? buff_5 : _GEN_4; // @[SramAXITrans.scala 90:{13,13}]
  always @(posedge clock) begin
    if (reset) begin // @[SramAXITrans.scala 74:30]
      buff_0 <= 33'h0; // @[SramAXITrans.scala 74:30]
    end else if (do_read & tail == 3'h0) begin // @[SramAXITrans.scala 115:35]
      buff_0 <= 33'h0; // @[SramAXITrans.scala 116:16]
    end else if (do_write & head == 3'h0) begin // @[SramAXITrans.scala 118:42]
      buff_0 <= io_input; // @[SramAXITrans.scala 119:16]
    end
    if (reset) begin // @[SramAXITrans.scala 74:30]
      buff_1 <= 33'h0; // @[SramAXITrans.scala 74:30]
    end else if (do_read & tail == 3'h1) begin // @[SramAXITrans.scala 115:35]
      buff_1 <= 33'h0; // @[SramAXITrans.scala 116:16]
    end else if (do_write & head == 3'h1) begin // @[SramAXITrans.scala 118:42]
      buff_1 <= io_input; // @[SramAXITrans.scala 119:16]
    end
    if (reset) begin // @[SramAXITrans.scala 74:30]
      buff_2 <= 33'h0; // @[SramAXITrans.scala 74:30]
    end else if (do_read & tail == 3'h2) begin // @[SramAXITrans.scala 115:35]
      buff_2 <= 33'h0; // @[SramAXITrans.scala 116:16]
    end else if (do_write & head == 3'h2) begin // @[SramAXITrans.scala 118:42]
      buff_2 <= io_input; // @[SramAXITrans.scala 119:16]
    end
    if (reset) begin // @[SramAXITrans.scala 74:30]
      buff_3 <= 33'h0; // @[SramAXITrans.scala 74:30]
    end else if (do_read & tail == 3'h3) begin // @[SramAXITrans.scala 115:35]
      buff_3 <= 33'h0; // @[SramAXITrans.scala 116:16]
    end else if (do_write & head == 3'h3) begin // @[SramAXITrans.scala 118:42]
      buff_3 <= io_input; // @[SramAXITrans.scala 119:16]
    end
    if (reset) begin // @[SramAXITrans.scala 74:30]
      buff_4 <= 33'h0; // @[SramAXITrans.scala 74:30]
    end else if (do_read & tail == 3'h4) begin // @[SramAXITrans.scala 115:35]
      buff_4 <= 33'h0; // @[SramAXITrans.scala 116:16]
    end else if (do_write & head == 3'h4) begin // @[SramAXITrans.scala 118:42]
      buff_4 <= io_input; // @[SramAXITrans.scala 119:16]
    end
    if (reset) begin // @[SramAXITrans.scala 74:30]
      buff_5 <= 33'h0; // @[SramAXITrans.scala 74:30]
    end else if (do_read & _T_5) begin // @[SramAXITrans.scala 115:35]
      buff_5 <= 33'h0; // @[SramAXITrans.scala 116:16]
    end else if (do_write & _T_4) begin // @[SramAXITrans.scala 118:42]
      buff_5 <= io_input; // @[SramAXITrans.scala 119:16]
    end
    if (reset) begin // @[SramAXITrans.scala 75:30]
      valid_0 <= 1'h0; // @[SramAXITrans.scala 75:30]
    end else if (do_read & tail == 3'h0) begin // @[SramAXITrans.scala 115:35]
      valid_0 <= 1'h0; // @[SramAXITrans.scala 117:16]
    end else begin
      valid_0 <= _GEN_13;
    end
    if (reset) begin // @[SramAXITrans.scala 75:30]
      valid_1 <= 1'h0; // @[SramAXITrans.scala 75:30]
    end else if (do_read & tail == 3'h1) begin // @[SramAXITrans.scala 115:35]
      valid_1 <= 1'h0; // @[SramAXITrans.scala 117:16]
    end else begin
      valid_1 <= _GEN_17;
    end
    if (reset) begin // @[SramAXITrans.scala 75:30]
      valid_2 <= 1'h0; // @[SramAXITrans.scala 75:30]
    end else if (do_read & tail == 3'h2) begin // @[SramAXITrans.scala 115:35]
      valid_2 <= 1'h0; // @[SramAXITrans.scala 117:16]
    end else begin
      valid_2 <= _GEN_21;
    end
    if (reset) begin // @[SramAXITrans.scala 75:30]
      valid_3 <= 1'h0; // @[SramAXITrans.scala 75:30]
    end else if (do_read & tail == 3'h3) begin // @[SramAXITrans.scala 115:35]
      valid_3 <= 1'h0; // @[SramAXITrans.scala 117:16]
    end else begin
      valid_3 <= _GEN_25;
    end
    if (reset) begin // @[SramAXITrans.scala 75:30]
      valid_4 <= 1'h0; // @[SramAXITrans.scala 75:30]
    end else if (do_read & tail == 3'h4) begin // @[SramAXITrans.scala 115:35]
      valid_4 <= 1'h0; // @[SramAXITrans.scala 117:16]
    end else begin
      valid_4 <= _GEN_29;
    end
    if (reset) begin // @[SramAXITrans.scala 75:30]
      valid_5 <= 1'h0; // @[SramAXITrans.scala 75:30]
    end else if (do_read & _T_5) begin // @[SramAXITrans.scala 115:35]
      valid_5 <= 1'h0; // @[SramAXITrans.scala 117:16]
    end else begin
      valid_5 <= _GEN_33;
    end
    if (reset) begin // @[SramAXITrans.scala 79:22]
      head <= 3'h0; // @[SramAXITrans.scala 79:22]
    end else if (do_write) begin // @[SramAXITrans.scala 98:18]
      if (head == 3'h5) begin // @[SramAXITrans.scala 99:39]
        head <= 3'h0; // @[SramAXITrans.scala 100:12]
      end else begin
        head <= _head_T_1; // @[SramAXITrans.scala 102:12]
      end
    end
    if (reset) begin // @[SramAXITrans.scala 80:22]
      tail <= 3'h0; // @[SramAXITrans.scala 80:22]
    end else if (do_read) begin // @[SramAXITrans.scala 106:17]
      if (tail == 3'h5) begin // @[SramAXITrans.scala 107:39]
        tail <= 3'h0; // @[SramAXITrans.scala 108:12]
      end else begin
        tail <= _tail_T_1; // @[SramAXITrans.scala 110:12]
      end
    end
    if (reset) begin // @[SramAXITrans.scala 81:22]
      count <= 4'h0; // @[SramAXITrans.scala 81:22]
    end else if (do_read & ~do_write) begin // @[SramAXITrans.scala 92:30]
      count <= _count_T_1; // @[SramAXITrans.scala 93:11]
    end else if (do_write & ~do_read) begin // @[SramAXITrans.scala 94:36]
      count <= _count_T_3; // @[SramAXITrans.scala 95:11]
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
  _RAND_0 = {2{`RANDOM}};
  buff_0 = _RAND_0[32:0];
  _RAND_1 = {2{`RANDOM}};
  buff_1 = _RAND_1[32:0];
  _RAND_2 = {2{`RANDOM}};
  buff_2 = _RAND_2[32:0];
  _RAND_3 = {2{`RANDOM}};
  buff_3 = _RAND_3[32:0];
  _RAND_4 = {2{`RANDOM}};
  buff_4 = _RAND_4[32:0];
  _RAND_5 = {2{`RANDOM}};
  buff_5 = _RAND_5[32:0];
  _RAND_6 = {1{`RANDOM}};
  valid_0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  valid_1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  valid_2 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  valid_3 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  valid_4 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  valid_5 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  head = _RAND_12[2:0];
  _RAND_13 = {1{`RANDOM}};
  tail = _RAND_13[2:0];
  _RAND_14 = {1{`RANDOM}};
  count = _RAND_14[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SramAXITrans(
  input         clock,
  input         reset,
  input         io_instMemory_req,
  input  [31:0] io_instMemory_addr,
  output        io_instMemory_data_ok,
  output        io_instMemory_addr_ok,
  output [31:0] io_instMemory_rdata,
  input         io_dataMemory_req,
  input         io_dataMemory_wr,
  input  [1:0]  io_dataMemory_size,
  input  [31:0] io_dataMemory_addr,
  input  [3:0]  io_dataMemory_wstrb,
  input  [31:0] io_dataMemory_wdata,
  output        io_dataMemory_addr_ok,
  output        io_dataMemory_data_ok,
  output [31:0] io_dataMemory_rdata,
  output [3:0]  io_axi_arid,
  output [31:0] io_axi_araddr,
  output [2:0]  io_axi_arsize,
  output        io_axi_arvalid,
  input         io_axi_arready,
  input  [3:0]  io_axi_rid,
  input  [31:0] io_axi_rdata,
  input         io_axi_rvalid,
  output        io_axi_rready,
  output [31:0] io_axi_awaddr,
  output [2:0]  io_axi_awsize,
  output        io_axi_awvalid,
  input         io_axi_awready,
  output [31:0] io_axi_wdata,
  output [3:0]  io_axi_wstrb,
  output        io_axi_wvalid,
  input         io_axi_wready,
  input         io_axi_bvalid,
  output        io_axi_bready
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  wire  read_inst_resp_buff_clock; // @[SramAXITrans.scala 200:35]
  wire  read_inst_resp_buff_reset; // @[SramAXITrans.scala 200:35]
  wire  read_inst_resp_buff_io_wen; // @[SramAXITrans.scala 200:35]
  wire [31:0] read_inst_resp_buff_io_input; // @[SramAXITrans.scala 200:35]
  wire [31:0] read_inst_resp_buff_io_output; // @[SramAXITrans.scala 200:35]
  wire  read_inst_resp_buff_io_empty; // @[SramAXITrans.scala 200:35]
  wire  read_inst_resp_buff_io_full; // @[SramAXITrans.scala 200:35]
  wire  read_data_resp_buff_clock; // @[SramAXITrans.scala 216:35]
  wire  read_data_resp_buff_reset; // @[SramAXITrans.scala 216:35]
  wire  read_data_resp_buff_io_wen; // @[SramAXITrans.scala 216:35]
  wire  read_data_resp_buff_io_ren; // @[SramAXITrans.scala 216:35]
  wire [31:0] read_data_resp_buff_io_input; // @[SramAXITrans.scala 216:35]
  wire [31:0] read_data_resp_buff_io_output; // @[SramAXITrans.scala 216:35]
  wire  read_data_resp_buff_io_empty; // @[SramAXITrans.scala 216:35]
  wire  read_data_resp_buff_io_full; // @[SramAXITrans.scala 216:35]
  wire  write_data_resp_count_clock; // @[SramAXITrans.scala 238:37]
  wire  write_data_resp_count_reset; // @[SramAXITrans.scala 238:37]
  wire  write_data_resp_count_io_wen; // @[SramAXITrans.scala 238:37]
  wire  write_data_resp_count_io_ren; // @[SramAXITrans.scala 238:37]
  wire  write_data_resp_count_io_empty; // @[SramAXITrans.scala 238:37]
  wire  write_data_resp_count_io_full; // @[SramAXITrans.scala 238:37]
  wire  data_req_record_clock; // @[SramAXITrans.scala 265:31]
  wire  data_req_record_reset; // @[SramAXITrans.scala 265:31]
  wire  data_req_record_io_wen; // @[SramAXITrans.scala 265:31]
  wire  data_req_record_io_ren; // @[SramAXITrans.scala 265:31]
  wire  data_req_record_io_empty; // @[SramAXITrans.scala 265:31]
  wire  data_req_record_io_full; // @[SramAXITrans.scala 265:31]
  wire  data_req_record_io_related_1; // @[SramAXITrans.scala 265:31]
  wire [32:0] data_req_record_io_input; // @[SramAXITrans.scala 265:31]
  wire [32:0] data_req_record_io_output; // @[SramAXITrans.scala 265:31]
  wire [31:0] data_req_record_io_related_data_1; // @[SramAXITrans.scala 265:31]
  reg  axi_ar_busy; // @[SramAXITrans.scala 159:28]
  reg [3:0] axi_ar_id; // @[SramAXITrans.scala 160:28]
  reg [31:0] axi_ar_addr; // @[SramAXITrans.scala 161:28]
  reg [2:0] axi_ar_size; // @[SramAXITrans.scala 162:28]
  reg  axi_aw_busy; // @[SramAXITrans.scala 170:28]
  reg [31:0] axi_aw_addr; // @[SramAXITrans.scala 171:28]
  reg [2:0] axi_aw_size; // @[SramAXITrans.scala 172:28]
  reg  axi_w_busy; // @[SramAXITrans.scala 173:28]
  reg [31:0] axi_w_data; // @[SramAXITrans.scala 174:28]
  reg [3:0] axi_w_strb; // @[SramAXITrans.scala 175:28]
  wire  _T = ~axi_ar_busy; // @[SramAXITrans.scala 280:8]
  wire  data_req_record_related_1 = data_req_record_io_related_1; // @[SramAXITrans.scala 261:39 270:32]
  wire  _data_read_valid_T_2 = ~data_req_record_related_1; // @[SramAXITrans.scala 386:70]
  wire  data_read_valid = io_dataMemory_req & ~io_dataMemory_wr & ~data_req_record_related_1; // @[SramAXITrans.scala 386:67]
  wire  read_req_valid = io_instMemory_req | data_read_valid; // @[SramAXITrans.scala 340:37]
  wire  _GEN_0 = axi_ar_busy & io_axi_arvalid & io_axi_arready ? 1'h0 : axi_ar_busy; // @[SramAXITrans.scala 285:63 286:17 159:28]
  wire  _GEN_4 = ~axi_ar_busy & read_req_valid | _GEN_0; // @[SramAXITrans.scala 280:40 281:17]
  wire [1:0] _read_req_size_T = data_read_valid ? io_dataMemory_size : 2'h2; // @[SramAXITrans.scala 343:24]
  wire [2:0] read_req_size = {{1'd0}, _read_req_size_T}; // @[SramAXITrans.scala 187:28 343:18]
  wire  _axi_r_data_ok_T = io_axi_rvalid & io_axi_rready; // @[SramAXITrans.scala 298:34]
  wire  read_inst_resp_full = read_inst_resp_buff_io_full; // @[SramAXITrans.scala 196:35 204:31]
  wire  read_data_resp_full = read_data_resp_buff_io_full; // @[SramAXITrans.scala 212:35 220:31]
  wire  _T_4 = ~axi_aw_busy; // @[SramAXITrans.scala 305:8]
  wire  _T_5 = ~axi_w_busy; // @[SramAXITrans.scala 305:24]
  wire  data_write_valid = io_dataMemory_req & io_dataMemory_wr & _data_read_valid_T_2; // @[SramAXITrans.scala 387:66]
  wire  _T_7 = ~axi_aw_busy & ~axi_w_busy & data_write_valid; // @[SramAXITrans.scala 305:36]
  wire  _GEN_8 = axi_aw_busy & io_axi_awvalid & io_axi_awready ? 1'h0 : axi_aw_busy; // @[SramAXITrans.scala 309:63 310:17 170:28]
  wire  _GEN_11 = ~axi_aw_busy & ~axi_w_busy & data_write_valid | _GEN_8; // @[SramAXITrans.scala 305:56 306:17]
  wire [2:0] write_req_size = {{1'd0}, io_dataMemory_size}; // @[SramAXITrans.scala 227:31 363:19]
  wire  _GEN_14 = axi_w_busy & io_axi_wvalid & io_axi_wready ? 1'h0 : axi_w_busy; // @[SramAXITrans.scala 319:60 320:16 173:28]
  wire  _GEN_17 = _T_7 | _GEN_14; // @[SramAXITrans.scala 315:56 316:16]
  wire  write_data_resp_full = write_data_resp_count_io_full; // @[SramAXITrans.scala 236:35 242:33]
  wire  read_req_sel_inst = ~data_read_valid & io_instMemory_req; // @[SramAXITrans.scala 337:41]
  wire  read_data_req_ok = data_read_valid & _T; // @[SramAXITrans.scala 346:41]
  wire  write_data_req_ok = data_write_valid & _T_4 & _T_5; // @[SramAXITrans.scala 368:57]
  wire  read_inst_resp_empty = read_inst_resp_buff_io_empty; // @[SramAXITrans.scala 195:35 203:32]
  wire  data_req_record_empty = data_req_record_io_empty; // @[SramAXITrans.scala 259:39 268:28]
  wire  _data_read_ready_T = ~data_req_record_empty; // @[SramAXITrans.scala 397:26]
  wire [32:0] data_req_record_output = data_req_record_io_output; // @[SramAXITrans.scala 263:39 272:29]
  wire  data_read_ready = ~data_req_record_empty & ~data_req_record_output[32]; // @[SramAXITrans.scala 397:49]
  wire  data_write_ready = _data_read_ready_T & data_req_record_output[32]; // @[SramAXITrans.scala 398:49]
  wire  read_data_resp_empty = read_data_resp_buff_io_empty; // @[SramAXITrans.scala 211:35 219:32]
  wire  write_data_resp_empty = write_data_resp_count_io_empty; // @[SramAXITrans.scala 235:35 241:34]
  FifoBuffer read_inst_resp_buff ( // @[SramAXITrans.scala 200:35]
    .clock(read_inst_resp_buff_clock),
    .reset(read_inst_resp_buff_reset),
    .io_wen(read_inst_resp_buff_io_wen),
    .io_input(read_inst_resp_buff_io_input),
    .io_output(read_inst_resp_buff_io_output),
    .io_empty(read_inst_resp_buff_io_empty),
    .io_full(read_inst_resp_buff_io_full)
  );
  FifoBuffer_1 read_data_resp_buff ( // @[SramAXITrans.scala 216:35]
    .clock(read_data_resp_buff_clock),
    .reset(read_data_resp_buff_reset),
    .io_wen(read_data_resp_buff_io_wen),
    .io_ren(read_data_resp_buff_io_ren),
    .io_input(read_data_resp_buff_io_input),
    .io_output(read_data_resp_buff_io_output),
    .io_empty(read_data_resp_buff_io_empty),
    .io_full(read_data_resp_buff_io_full)
  );
  FifoCount write_data_resp_count ( // @[SramAXITrans.scala 238:37]
    .clock(write_data_resp_count_clock),
    .reset(write_data_resp_count_reset),
    .io_wen(write_data_resp_count_io_wen),
    .io_ren(write_data_resp_count_io_ren),
    .io_empty(write_data_resp_count_io_empty),
    .io_full(write_data_resp_count_io_full)
  );
  FifoBufferValid data_req_record ( // @[SramAXITrans.scala 265:31]
    .clock(data_req_record_clock),
    .reset(data_req_record_reset),
    .io_wen(data_req_record_io_wen),
    .io_ren(data_req_record_io_ren),
    .io_empty(data_req_record_io_empty),
    .io_full(data_req_record_io_full),
    .io_related_1(data_req_record_io_related_1),
    .io_input(data_req_record_io_input),
    .io_output(data_req_record_io_output),
    .io_related_data_1(data_req_record_io_related_data_1)
  );
  assign io_instMemory_data_ok = ~read_inst_resp_empty; // @[SramAXITrans.scala 381:28]
  assign io_instMemory_addr_ok = read_req_sel_inst & _T; // @[SramAXITrans.scala 347:41]
  assign io_instMemory_rdata = read_inst_resp_buff_io_output; // @[SramAXITrans.scala 198:35 206:33]
  assign io_dataMemory_addr_ok = read_data_req_ok | write_data_req_ok; // @[SramAXITrans.scala 388:45]
  assign io_dataMemory_data_ok = data_read_ready & ~read_data_resp_empty | data_write_ready & ~write_data_resp_empty; // @[SramAXITrans.scala 400:71]
  assign io_dataMemory_rdata = read_data_resp_buff_io_output; // @[SramAXITrans.scala 214:35 222:33]
  assign io_axi_arid = axi_ar_id; // @[SramAXITrans.scala 293:18]
  assign io_axi_araddr = axi_ar_addr; // @[SramAXITrans.scala 294:18]
  assign io_axi_arsize = axi_ar_size; // @[SramAXITrans.scala 295:18]
  assign io_axi_arvalid = axi_ar_busy; // @[SramAXITrans.scala 292:18]
  assign io_axi_rready = ~read_inst_resp_full & ~read_data_resp_full; // @[SramAXITrans.scala 302:41]
  assign io_axi_awaddr = axi_aw_addr; // @[SramAXITrans.scala 326:18]
  assign io_axi_awsize = axi_aw_size; // @[SramAXITrans.scala 327:18]
  assign io_axi_awvalid = axi_aw_busy; // @[SramAXITrans.scala 324:18]
  assign io_axi_wdata = axi_w_data; // @[SramAXITrans.scala 328:18]
  assign io_axi_wstrb = axi_w_strb; // @[SramAXITrans.scala 329:18]
  assign io_axi_wvalid = axi_w_busy; // @[SramAXITrans.scala 325:18]
  assign io_axi_bready = ~write_data_resp_full; // @[SramAXITrans.scala 333:20]
  assign read_inst_resp_buff_clock = clock;
  assign read_inst_resp_buff_reset = reset;
  assign read_inst_resp_buff_io_wen = _axi_r_data_ok_T & io_axi_rid == 4'h0; // @[SramAXITrans.scala 299:51]
  assign read_inst_resp_buff_io_input = io_axi_rdata; // @[SramAXITrans.scala 167:27 300:17]
  assign read_data_resp_buff_clock = clock;
  assign read_data_resp_buff_reset = reset;
  assign read_data_resp_buff_io_wen = io_axi_rvalid & io_axi_rready & io_axi_rid == 4'h1; // @[SramAXITrans.scala 298:51]
  assign read_data_resp_buff_io_ren = ~data_req_record_empty & ~data_req_record_output[32]; // @[SramAXITrans.scala 397:49]
  assign read_data_resp_buff_io_input = io_axi_rdata; // @[SramAXITrans.scala 167:27 300:17]
  assign write_data_resp_count_clock = clock;
  assign write_data_resp_count_reset = reset;
  assign write_data_resp_count_io_wen = io_axi_bvalid & io_axi_bready; // @[SramAXITrans.scala 332:34]
  assign write_data_resp_count_io_ren = _data_read_ready_T & data_req_record_output[32]; // @[SramAXITrans.scala 398:49]
  assign data_req_record_clock = clock;
  assign data_req_record_reset = reset;
  assign data_req_record_io_wen = io_dataMemory_req & io_dataMemory_addr_ok; // @[SramAXITrans.scala 392:46]
  assign data_req_record_io_ren = io_dataMemory_data_ok; // @[SramAXITrans.scala 258:39 391:25]
  assign data_req_record_io_input = {io_dataMemory_wr,io_dataMemory_addr}; // @[Cat.scala 33:92]
  assign data_req_record_io_related_data_1 = io_dataMemory_addr; // @[SramAXITrans.scala 273:37]
  always @(posedge clock) begin
    if (reset) begin // @[SramAXITrans.scala 159:28]
      axi_ar_busy <= 1'h0; // @[SramAXITrans.scala 159:28]
    end else begin
      axi_ar_busy <= _GEN_4;
    end
    if (reset) begin // @[SramAXITrans.scala 160:28]
      axi_ar_id <= 4'h0; // @[SramAXITrans.scala 160:28]
    end else if (~axi_ar_busy & read_req_valid) begin // @[SramAXITrans.scala 280:40]
      if (data_read_valid) begin // @[SramAXITrans.scala 341:24]
        axi_ar_id <= 4'h1;
      end else begin
        axi_ar_id <= 4'h0;
      end
    end else if (axi_ar_busy & io_axi_arvalid & io_axi_arready) begin // @[SramAXITrans.scala 285:63]
      axi_ar_id <= 4'h0; // @[SramAXITrans.scala 287:17]
    end
    if (reset) begin // @[SramAXITrans.scala 161:28]
      axi_ar_addr <= 32'h0; // @[SramAXITrans.scala 161:28]
    end else if (~axi_ar_busy & read_req_valid) begin // @[SramAXITrans.scala 280:40]
      if (data_read_valid) begin // @[SramAXITrans.scala 342:24]
        axi_ar_addr <= io_dataMemory_addr;
      end else begin
        axi_ar_addr <= io_instMemory_addr;
      end
    end else if (axi_ar_busy & io_axi_arvalid & io_axi_arready) begin // @[SramAXITrans.scala 285:63]
      axi_ar_addr <= 32'h0; // @[SramAXITrans.scala 288:17]
    end
    if (reset) begin // @[SramAXITrans.scala 162:28]
      axi_ar_size <= 3'h0; // @[SramAXITrans.scala 162:28]
    end else if (~axi_ar_busy & read_req_valid) begin // @[SramAXITrans.scala 280:40]
      axi_ar_size <= read_req_size; // @[SramAXITrans.scala 284:17]
    end else if (axi_ar_busy & io_axi_arvalid & io_axi_arready) begin // @[SramAXITrans.scala 285:63]
      axi_ar_size <= 3'h0; // @[SramAXITrans.scala 289:17]
    end
    if (reset) begin // @[SramAXITrans.scala 170:28]
      axi_aw_busy <= 1'h0; // @[SramAXITrans.scala 170:28]
    end else begin
      axi_aw_busy <= _GEN_11;
    end
    if (reset) begin // @[SramAXITrans.scala 171:28]
      axi_aw_addr <= 32'h0; // @[SramAXITrans.scala 171:28]
    end else if (~axi_aw_busy & ~axi_w_busy & data_write_valid) begin // @[SramAXITrans.scala 305:56]
      axi_aw_addr <= io_dataMemory_addr; // @[SramAXITrans.scala 307:17]
    end else if (axi_aw_busy & io_axi_awvalid & io_axi_awready) begin // @[SramAXITrans.scala 309:63]
      axi_aw_addr <= 32'h0; // @[SramAXITrans.scala 311:17]
    end
    if (reset) begin // @[SramAXITrans.scala 172:28]
      axi_aw_size <= 3'h0; // @[SramAXITrans.scala 172:28]
    end else if (~axi_aw_busy & ~axi_w_busy & data_write_valid) begin // @[SramAXITrans.scala 305:56]
      axi_aw_size <= write_req_size; // @[SramAXITrans.scala 308:17]
    end else if (axi_aw_busy & io_axi_awvalid & io_axi_awready) begin // @[SramAXITrans.scala 309:63]
      axi_aw_size <= 3'h3; // @[SramAXITrans.scala 312:17]
    end
    if (reset) begin // @[SramAXITrans.scala 173:28]
      axi_w_busy <= 1'h0; // @[SramAXITrans.scala 173:28]
    end else begin
      axi_w_busy <= _GEN_17;
    end
    if (reset) begin // @[SramAXITrans.scala 174:28]
      axi_w_data <= 32'h0; // @[SramAXITrans.scala 174:28]
    end else if (_T_7) begin // @[SramAXITrans.scala 315:56]
      axi_w_data <= io_dataMemory_wdata; // @[SramAXITrans.scala 317:16]
    end else if (axi_w_busy & io_axi_wvalid & io_axi_wready) begin // @[SramAXITrans.scala 319:60]
      axi_w_data <= 32'h0; // @[SramAXITrans.scala 321:16]
    end
    if (reset) begin // @[SramAXITrans.scala 175:28]
      axi_w_strb <= 4'h0; // @[SramAXITrans.scala 175:28]
    end else if (_T_7) begin // @[SramAXITrans.scala 315:56]
      axi_w_strb <= io_dataMemory_wstrb; // @[SramAXITrans.scala 318:16]
    end else if (axi_w_busy & io_axi_wvalid & io_axi_wready) begin // @[SramAXITrans.scala 319:60]
      axi_w_strb <= 4'h0; // @[SramAXITrans.scala 322:16]
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
  axi_ar_busy = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  axi_ar_id = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  axi_ar_addr = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  axi_ar_size = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  axi_aw_busy = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  axi_aw_addr = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  axi_aw_size = _RAND_6[2:0];
  _RAND_7 = {1{`RANDOM}};
  axi_w_busy = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  axi_w_data = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  axi_w_strb = _RAND_9[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MemoryStage(
  input         clock,
  input         reset,
  input  [6:0]  io_fromExecute_aluop,
  input  [31:0] io_fromExecute_hi,
  input  [31:0] io_fromExecute_lo,
  input  [31:0] io_fromExecute_reg2,
  input  [4:0]  io_fromExecute_reg_waddr,
  input  [31:0] io_fromExecute_reg_wdata,
  input         io_fromExecute_whilo,
  input  [3:0]  io_fromExecute_reg_wen,
  input  [31:0] io_fromExecute_pc,
  input         io_fromExecute_valid,
  input  [31:0] io_fromExecute_mem_addr,
  input         io_fromExecute_bd,
  input  [31:0] io_fromExecute_badvaddr,
  input  [7:0]  io_fromExecute_cp0_addr,
  input  [4:0]  io_fromExecute_excode,
  input         io_fromExecute_ex,
  input         io_fromExecute_data_ok,
  input         io_fromExecute_wait_mem,
  input         io_fromExecute_res_from_mem,
  input         io_fromExecute_tlb_refill,
  input         io_fromExecute_after_tlb,
  input         io_fromExecute_s1_found,
  input  [3:0]  io_fromExecute_s1_index,
  input         io_fromMemory_allowin,
  input         io_fromCtrl_do_flush,
  output        io_memory_do_flush,
  output [6:0]  io_memory_aluop,
  output [31:0] io_memory_hi,
  output [31:0] io_memory_lo,
  output        io_memory_whilo,
  output [31:0] io_memory_mem_addr,
  output [31:0] io_memory_reg2,
  output [4:0]  io_memory_reg_waddr,
  output [3:0]  io_memory_reg_wen,
  output [31:0] io_memory_reg_wdata,
  output [31:0] io_memory_pc,
  output        io_memory_valid,
  output        io_memory_bd,
  output [31:0] io_memory_badvaddr,
  output [7:0]  io_memory_cp0_addr,
  output [4:0]  io_memory_excode,
  output        io_memory_ex,
  output        io_memory_data_ok,
  output        io_memory_wait_mem,
  output        io_memory_res_from_mem,
  output        io_memory_tlb_refill,
  output        io_memory_after_tlb,
  output        io_memory_s1_found,
  output [3:0]  io_memory_s1_index
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pc; // @[MemoryStage.scala 23:32]
  reg [4:0] reg_waddr; // @[MemoryStage.scala 24:32]
  reg [3:0] reg_wen; // @[MemoryStage.scala 25:32]
  reg [31:0] reg_wdata; // @[MemoryStage.scala 26:32]
  reg [31:0] hi; // @[MemoryStage.scala 27:32]
  reg [31:0] lo; // @[MemoryStage.scala 28:32]
  reg  whilo; // @[MemoryStage.scala 29:32]
  reg [6:0] aluop; // @[MemoryStage.scala 30:32]
  reg [31:0] mem_addr; // @[MemoryStage.scala 31:32]
  reg [31:0] reg2; // @[MemoryStage.scala 32:32]
  reg  valid; // @[MemoryStage.scala 36:32]
  reg  ex; // @[MemoryStage.scala 37:32]
  reg  bd; // @[MemoryStage.scala 38:32]
  reg [31:0] badvaddr; // @[MemoryStage.scala 39:32]
  reg [7:0] cp0_addr; // @[MemoryStage.scala 40:32]
  reg [4:0] excode; // @[MemoryStage.scala 41:32]
  reg  data_ok; // @[MemoryStage.scala 42:32]
  reg  wait_mem; // @[MemoryStage.scala 44:32]
  reg  res_from_mem; // @[MemoryStage.scala 45:32]
  reg  tlb_refill; // @[MemoryStage.scala 46:32]
  reg  after_tlb; // @[MemoryStage.scala 47:32]
  reg  s1_found; // @[MemoryStage.scala 48:32]
  reg [3:0] s1_index; // @[MemoryStage.scala 49:32]
  assign io_memory_do_flush = io_fromCtrl_do_flush; // @[MemoryStage.scala 21:22]
  assign io_memory_aluop = aluop; // @[MemoryStage.scala 59:29]
  assign io_memory_hi = hi; // @[MemoryStage.scala 56:29]
  assign io_memory_lo = lo; // @[MemoryStage.scala 57:29]
  assign io_memory_whilo = whilo; // @[MemoryStage.scala 58:29]
  assign io_memory_mem_addr = mem_addr; // @[MemoryStage.scala 60:29]
  assign io_memory_reg2 = reg2; // @[MemoryStage.scala 61:29]
  assign io_memory_reg_waddr = reg_waddr; // @[MemoryStage.scala 53:29]
  assign io_memory_reg_wen = reg_wen; // @[MemoryStage.scala 54:29]
  assign io_memory_reg_wdata = reg_wdata; // @[MemoryStage.scala 55:29]
  assign io_memory_pc = pc; // @[MemoryStage.scala 52:29]
  assign io_memory_valid = valid; // @[MemoryStage.scala 72:29]
  assign io_memory_bd = bd; // @[MemoryStage.scala 63:29]
  assign io_memory_badvaddr = badvaddr; // @[MemoryStage.scala 64:29]
  assign io_memory_cp0_addr = cp0_addr; // @[MemoryStage.scala 65:29]
  assign io_memory_excode = excode; // @[MemoryStage.scala 66:29]
  assign io_memory_ex = ex; // @[MemoryStage.scala 62:29]
  assign io_memory_data_ok = data_ok; // @[MemoryStage.scala 67:29]
  assign io_memory_wait_mem = wait_mem; // @[MemoryStage.scala 69:29]
  assign io_memory_res_from_mem = res_from_mem; // @[MemoryStage.scala 70:29]
  assign io_memory_tlb_refill = tlb_refill; // @[MemoryStage.scala 76:29]
  assign io_memory_after_tlb = after_tlb; // @[MemoryStage.scala 73:29]
  assign io_memory_s1_found = s1_found; // @[MemoryStage.scala 74:29]
  assign io_memory_s1_index = s1_index; // @[MemoryStage.scala 75:29]
  always @(posedge clock) begin
    if (reset) begin // @[MemoryStage.scala 23:32]
      pc <= 32'h0; // @[MemoryStage.scala 23:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      pc <= io_fromExecute_pc; // @[MemoryStage.scala 101:21]
    end
    if (reset) begin // @[MemoryStage.scala 24:32]
      reg_waddr <= 5'h0; // @[MemoryStage.scala 24:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      reg_waddr <= io_fromExecute_reg_waddr; // @[MemoryStage.scala 90:21]
    end
    if (reset) begin // @[MemoryStage.scala 25:32]
      reg_wen <= 4'h0; // @[MemoryStage.scala 25:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      reg_wen <= io_fromExecute_reg_wen; // @[MemoryStage.scala 91:21]
    end
    if (reset) begin // @[MemoryStage.scala 26:32]
      reg_wdata <= 32'h0; // @[MemoryStage.scala 26:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      reg_wdata <= io_fromExecute_reg_wdata; // @[MemoryStage.scala 92:21]
    end
    if (reset) begin // @[MemoryStage.scala 27:32]
      hi <= 32'h0; // @[MemoryStage.scala 27:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      hi <= io_fromExecute_hi; // @[MemoryStage.scala 93:21]
    end
    if (reset) begin // @[MemoryStage.scala 28:32]
      lo <= 32'h0; // @[MemoryStage.scala 28:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      lo <= io_fromExecute_lo; // @[MemoryStage.scala 94:21]
    end
    if (reset) begin // @[MemoryStage.scala 29:32]
      whilo <= 1'h0; // @[MemoryStage.scala 29:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      whilo <= io_fromExecute_whilo; // @[MemoryStage.scala 95:21]
    end
    if (reset) begin // @[MemoryStage.scala 30:32]
      aluop <= 7'h0; // @[MemoryStage.scala 30:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      aluop <= io_fromExecute_aluop; // @[MemoryStage.scala 98:21]
    end
    if (reset) begin // @[MemoryStage.scala 31:32]
      mem_addr <= 32'h0; // @[MemoryStage.scala 31:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      mem_addr <= io_fromExecute_mem_addr; // @[MemoryStage.scala 102:21]
    end
    if (reset) begin // @[MemoryStage.scala 32:32]
      reg2 <= 32'h0; // @[MemoryStage.scala 32:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      reg2 <= io_fromExecute_reg2; // @[MemoryStage.scala 99:21]
    end
    if (reset) begin // @[MemoryStage.scala 36:32]
      valid <= 1'h0; // @[MemoryStage.scala 36:32]
    end else if (io_fromCtrl_do_flush) begin // @[MemoryStage.scala 83:30]
      valid <= 1'h0; // @[MemoryStage.scala 84:11]
    end else if (io_fromMemory_allowin) begin // @[MemoryStage.scala 85:37]
      valid <= io_fromExecute_valid; // @[MemoryStage.scala 86:11]
    end
    if (reset) begin // @[MemoryStage.scala 37:32]
      ex <= 1'h0; // @[MemoryStage.scala 37:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      ex <= io_fromExecute_ex; // @[MemoryStage.scala 103:21]
    end
    if (reset) begin // @[MemoryStage.scala 38:32]
      bd <= 1'h0; // @[MemoryStage.scala 38:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      bd <= io_fromExecute_bd; // @[MemoryStage.scala 104:21]
    end
    if (reset) begin // @[MemoryStage.scala 39:32]
      badvaddr <= 32'h0; // @[MemoryStage.scala 39:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      badvaddr <= io_fromExecute_badvaddr; // @[MemoryStage.scala 105:21]
    end
    if (reset) begin // @[MemoryStage.scala 40:32]
      cp0_addr <= 8'h0; // @[MemoryStage.scala 40:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      cp0_addr <= io_fromExecute_cp0_addr; // @[MemoryStage.scala 106:21]
    end
    if (reset) begin // @[MemoryStage.scala 41:32]
      excode <= 5'h0; // @[MemoryStage.scala 41:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      excode <= io_fromExecute_excode; // @[MemoryStage.scala 107:21]
    end
    if (reset) begin // @[MemoryStage.scala 42:32]
      data_ok <= 1'h0; // @[MemoryStage.scala 42:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      data_ok <= io_fromExecute_data_ok; // @[MemoryStage.scala 108:21]
    end
    if (reset) begin // @[MemoryStage.scala 44:32]
      wait_mem <= 1'h0; // @[MemoryStage.scala 44:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      wait_mem <= io_fromExecute_wait_mem; // @[MemoryStage.scala 110:21]
    end
    if (reset) begin // @[MemoryStage.scala 45:32]
      res_from_mem <= 1'h0; // @[MemoryStage.scala 45:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      res_from_mem <= io_fromExecute_res_from_mem; // @[MemoryStage.scala 111:21]
    end
    if (reset) begin // @[MemoryStage.scala 46:32]
      tlb_refill <= 1'h0; // @[MemoryStage.scala 46:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      tlb_refill <= io_fromExecute_tlb_refill; // @[MemoryStage.scala 112:21]
    end
    if (reset) begin // @[MemoryStage.scala 47:32]
      after_tlb <= 1'h0; // @[MemoryStage.scala 47:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      after_tlb <= io_fromExecute_after_tlb; // @[MemoryStage.scala 113:21]
    end
    if (reset) begin // @[MemoryStage.scala 48:32]
      s1_found <= 1'h0; // @[MemoryStage.scala 48:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      s1_found <= io_fromExecute_s1_found; // @[MemoryStage.scala 114:21]
    end
    if (reset) begin // @[MemoryStage.scala 49:32]
      s1_index <= 4'h0; // @[MemoryStage.scala 49:32]
    end else if (io_fromExecute_valid & io_fromMemory_allowin) begin // @[MemoryStage.scala 89:55]
      s1_index <= io_fromExecute_s1_index; // @[MemoryStage.scala 115:21]
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
  _RAND_1 = {1{`RANDOM}};
  reg_waddr = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  reg_wen = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  reg_wdata = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  hi = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  lo = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  whilo = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  aluop = _RAND_7[6:0];
  _RAND_8 = {1{`RANDOM}};
  mem_addr = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  reg2 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  valid = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  ex = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  bd = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  badvaddr = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  cp0_addr = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  excode = _RAND_15[4:0];
  _RAND_16 = {1{`RANDOM}};
  data_ok = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  wait_mem = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  res_from_mem = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  tlb_refill = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  after_tlb = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  s1_found = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  s1_index = _RAND_22[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Memory(
  input         reset,
  input         io_fromMemoryStage_do_flush,
  input  [6:0]  io_fromMemoryStage_aluop,
  input  [31:0] io_fromMemoryStage_hi,
  input  [31:0] io_fromMemoryStage_lo,
  input         io_fromMemoryStage_whilo,
  input  [31:0] io_fromMemoryStage_mem_addr,
  input  [31:0] io_fromMemoryStage_reg2,
  input  [4:0]  io_fromMemoryStage_reg_waddr,
  input  [3:0]  io_fromMemoryStage_reg_wen,
  input  [31:0] io_fromMemoryStage_reg_wdata,
  input  [31:0] io_fromMemoryStage_pc,
  input         io_fromMemoryStage_valid,
  input         io_fromMemoryStage_bd,
  input  [31:0] io_fromMemoryStage_badvaddr,
  input  [7:0]  io_fromMemoryStage_cp0_addr,
  input  [4:0]  io_fromMemoryStage_excode,
  input         io_fromMemoryStage_ex,
  input         io_fromMemoryStage_data_ok,
  input         io_fromMemoryStage_wait_mem,
  input         io_fromMemoryStage_res_from_mem,
  input         io_fromMemoryStage_tlb_refill,
  input         io_fromMemoryStage_after_tlb,
  input         io_fromMemoryStage_s1_found,
  input  [3:0]  io_fromMemoryStage_s1_index,
  input         io_fromDataMemory_data_ok,
  input  [31:0] io_fromDataMemory_rdata,
  output [4:0]  io_decoder_reg_waddr,
  output [31:0] io_decoder_reg_wdata,
  output [3:0]  io_decoder_reg_wen,
  output        io_decoder_inst_is_mfc0,
  output        io_decoder_ms_fwd_valid,
  output        io_decoder_blk_valid,
  output        io_mov_cp0_wen,
  output        io_mov_cp0_waddr,
  output        io_mov_cp0_wdata,
  output        io_memoryStage_allowin,
  output        io_dataMemory_waiting,
  output        io_execute_whilo,
  output [31:0] io_execute_hi,
  output [31:0] io_execute_lo,
  output        io_execute_allowin,
  output        io_execute_inst_unable,
  output [31:0] io_writeBackStage_pc,
  output [31:0] io_writeBackStage_reg_wdata,
  output [4:0]  io_writeBackStage_reg_waddr,
  output [3:0]  io_writeBackStage_reg_wen,
  output        io_writeBackStage_whilo,
  output [31:0] io_writeBackStage_hi,
  output [31:0] io_writeBackStage_lo,
  output        io_writeBackStage_valid,
  output        io_writeBackStage_inst_is_mfc0,
  output        io_writeBackStage_inst_is_mtc0,
  output        io_writeBackStage_inst_is_eret,
  output        io_writeBackStage_bd,
  output [31:0] io_writeBackStage_badvaddr,
  output [7:0]  io_writeBackStage_cp0_addr,
  output [4:0]  io_writeBackStage_excode,
  output        io_writeBackStage_ex,
  output        io_writeBackStage_inst_is_tlbp,
  output        io_writeBackStage_inst_is_tlbr,
  output        io_writeBackStage_inst_is_tlbwi,
  output        io_writeBackStage_tlb_refill,
  output        io_writeBackStage_after_tlb,
  output        io_writeBackStage_s1_found,
  output [3:0]  io_writeBackStage_s1_index,
  output        io_ctrl_ex
);
  wire  whilo = reset ? 1'h0 : io_fromMemoryStage_whilo; // @[Memory.scala 157:37 163:15 172:15]
  wire  data_ok = io_fromMemoryStage_data_ok | io_fromMemoryStage_wait_mem & io_fromDataMemory_data_ok; // @[Memory.scala 93:54]
  wire  ready_go = io_fromMemoryStage_wait_mem ? data_ok : 1'h1; // @[Memory.scala 148:21]
  wire  _ms_to_ws_valid_T_1 = ~io_fromMemoryStage_do_flush; // @[Memory.scala 150:45]
  wire  ms_to_ws_valid = io_fromMemoryStage_valid & ready_go & ~io_fromMemoryStage_do_flush; // @[Memory.scala 150:42]
  wire  _io_execute_inst_unable_T = ~io_fromMemoryStage_valid; // @[Memory.scala 77:29]
  wire  _inst_is_mtc0_T = io_fromMemoryStage_aluop == 7'h12; // @[Memory.scala 141:41]
  wire [1:0] addrLowBit2 = io_fromMemoryStage_mem_addr[1:0]; // @[Memory.scala 178:50]
  wire [3:0] _reg_wen_T_1 = 2'h1 == addrLowBit2 ? 4'hc : 4'h8; // @[Mux.scala 81:58]
  wire [3:0] _reg_wen_T_3 = 2'h2 == addrLowBit2 ? 4'he : _reg_wen_T_1; // @[Mux.scala 81:58]
  wire [3:0] _reg_wen_T_5 = 2'h3 == addrLowBit2 ? 4'hf : _reg_wen_T_3; // @[Mux.scala 81:58]
  wire [3:0] _reg_wen_T_7 = 2'h1 == addrLowBit2 ? 4'h7 : 4'hf; // @[Mux.scala 81:58]
  wire [3:0] _reg_wen_T_9 = 2'h2 == addrLowBit2 ? 4'h3 : _reg_wen_T_7; // @[Mux.scala 81:58]
  wire [3:0] _reg_wen_T_11 = 2'h3 == addrLowBit2 ? 4'h1 : _reg_wen_T_9; // @[Mux.scala 81:58]
  wire [3:0] _reg_wen_T_13 = 7'h36 == io_fromMemoryStage_aluop ? _reg_wen_T_5 : io_fromMemoryStage_reg_wen; // @[Mux.scala 81:58]
  wire [3:0] _reg_wen_T_15 = 7'h37 == io_fromMemoryStage_aluop ? _reg_wen_T_11 : _reg_wen_T_13; // @[Mux.scala 81:58]
  wire [23:0] _reg_wdata_T_3 = io_fromDataMemory_rdata[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _reg_wdata_T_4 = {_reg_wdata_T_3,io_fromDataMemory_rdata[7:0]}; // @[Cat.scala 33:92]
  wire [23:0] _reg_wdata_T_8 = io_fromDataMemory_rdata[15] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _reg_wdata_T_9 = {_reg_wdata_T_8,io_fromDataMemory_rdata[15:8]}; // @[Cat.scala 33:92]
  wire [23:0] _reg_wdata_T_13 = io_fromDataMemory_rdata[23] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _reg_wdata_T_14 = {_reg_wdata_T_13,io_fromDataMemory_rdata[23:16]}; // @[Cat.scala 33:92]
  wire [23:0] _reg_wdata_T_18 = io_fromDataMemory_rdata[31] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _reg_wdata_T_19 = {_reg_wdata_T_18,io_fromDataMemory_rdata[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_21 = 2'h1 == addrLowBit2 ? _reg_wdata_T_9 : _reg_wdata_T_4; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_23 = 2'h2 == addrLowBit2 ? _reg_wdata_T_14 : _reg_wdata_T_21; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_25 = 2'h3 == addrLowBit2 ? _reg_wdata_T_19 : _reg_wdata_T_23; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_28 = {24'h0,io_fromDataMemory_rdata[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_31 = {24'h0,io_fromDataMemory_rdata[15:8]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_34 = {24'h0,io_fromDataMemory_rdata[23:16]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_37 = {24'h0,io_fromDataMemory_rdata[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_39 = 2'h1 == addrLowBit2 ? _reg_wdata_T_31 : _reg_wdata_T_28; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_41 = 2'h2 == addrLowBit2 ? _reg_wdata_T_34 : _reg_wdata_T_39; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_43 = 2'h3 == addrLowBit2 ? _reg_wdata_T_37 : _reg_wdata_T_41; // @[Mux.scala 81:58]
  wire [15:0] _reg_wdata_T_47 = io_fromDataMemory_rdata[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _reg_wdata_T_48 = {_reg_wdata_T_47,io_fromDataMemory_rdata[15:0]}; // @[Cat.scala 33:92]
  wire [15:0] _reg_wdata_T_52 = io_fromDataMemory_rdata[31] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _reg_wdata_T_53 = {_reg_wdata_T_52,io_fromDataMemory_rdata[31:16]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_55 = 2'h0 == addrLowBit2 ? _reg_wdata_T_48 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_57 = 2'h2 == addrLowBit2 ? _reg_wdata_T_53 : _reg_wdata_T_55; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_60 = {16'h0,io_fromDataMemory_rdata[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_63 = {16'h0,io_fromDataMemory_rdata[31:16]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_65 = 2'h0 == addrLowBit2 ? _reg_wdata_T_60 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_67 = 2'h2 == addrLowBit2 ? _reg_wdata_T_63 : _reg_wdata_T_65; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_70 = {io_fromDataMemory_rdata[7:0],io_fromMemoryStage_reg2[23:0]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_73 = {io_fromDataMemory_rdata[15:0],io_fromMemoryStage_reg2[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_76 = {io_fromDataMemory_rdata[23:0],io_fromMemoryStage_reg2[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_78 = 2'h1 == addrLowBit2 ? _reg_wdata_T_73 : _reg_wdata_T_70; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_80 = 2'h2 == addrLowBit2 ? _reg_wdata_T_76 : _reg_wdata_T_78; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_82 = 2'h3 == addrLowBit2 ? io_fromDataMemory_rdata : _reg_wdata_T_80; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_85 = {io_fromMemoryStage_reg2[31:24],io_fromDataMemory_rdata[31:8]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_88 = {io_fromMemoryStage_reg2[31:16],io_fromDataMemory_rdata[31:16]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_91 = {io_fromMemoryStage_reg2[31:8],io_fromDataMemory_rdata[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _reg_wdata_T_93 = 2'h1 == addrLowBit2 ? _reg_wdata_T_85 : io_fromDataMemory_rdata; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_95 = 2'h2 == addrLowBit2 ? _reg_wdata_T_88 : _reg_wdata_T_93; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_97 = 2'h3 == addrLowBit2 ? _reg_wdata_T_91 : _reg_wdata_T_95; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_99 = 7'h30 == io_fromMemoryStage_aluop ? _reg_wdata_T_25 : io_fromMemoryStage_reg_wdata; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_101 = 7'h31 == io_fromMemoryStage_aluop ? _reg_wdata_T_43 : _reg_wdata_T_99; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_103 = 7'h32 == io_fromMemoryStage_aluop ? _reg_wdata_T_57 : _reg_wdata_T_101; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_105 = 7'h33 == io_fromMemoryStage_aluop ? _reg_wdata_T_67 : _reg_wdata_T_103; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_107 = 7'h35 == io_fromMemoryStage_aluop ? io_fromDataMemory_rdata : _reg_wdata_T_105; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_109 = 7'h36 == io_fromMemoryStage_aluop ? _reg_wdata_T_82 : _reg_wdata_T_107; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_111 = 7'h37 == io_fromMemoryStage_aluop ? _reg_wdata_T_97 : _reg_wdata_T_109; // @[Mux.scala 81:58]
  wire [31:0] _reg_wdata_T_113 = 7'h34 == io_fromMemoryStage_aluop ? io_fromDataMemory_rdata : _reg_wdata_T_111; // @[Mux.scala 81:58]
  wire [31:0] reg_wdata = reset ? 32'h0 : _reg_wdata_T_113; // @[Memory.scala 157:37 160:15 207:15]
  wire [7:0] cp0_waddr = reset ? 8'h0 : io_fromMemoryStage_cp0_addr; // @[Memory.scala 157:37 165:15 174:15]
  wire [31:0] cp0_wdata = reset ? 32'h0 : reg_wdata; // @[Memory.scala 157:37 166:15 176:15]
  assign io_decoder_reg_waddr = reset ? 5'h0 : io_fromMemoryStage_reg_waddr; // @[Memory.scala 157:37 158:15 169:15]
  assign io_decoder_reg_wdata = reset ? 32'h0 : _reg_wdata_T_113; // @[Memory.scala 157:37 160:15 207:15]
  assign io_decoder_reg_wen = reset ? 4'h0 : _reg_wen_T_15; // @[Memory.scala 157:37 159:15 180:13]
  assign io_decoder_inst_is_mfc0 = io_fromMemoryStage_valid & io_fromMemoryStage_aluop == 7'h11; // @[Memory.scala 140:31]
  assign io_decoder_ms_fwd_valid = io_fromMemoryStage_valid & ready_go & ~io_fromMemoryStage_do_flush; // @[Memory.scala 150:42]
  assign io_decoder_blk_valid = io_fromMemoryStage_valid & io_fromMemoryStage_res_from_mem & ~ready_go &
    _ms_to_ws_valid_T_1; // @[Memory.scala 153:76]
  assign io_mov_cp0_wen = reset ? 1'h0 : _inst_is_mtc0_T & io_fromMemoryStage_valid; // @[Memory.scala 157:37 164:15 175:15]
  assign io_mov_cp0_waddr = cp0_waddr[0]; // @[Memory.scala 133:20]
  assign io_mov_cp0_wdata = cp0_wdata[0]; // @[Memory.scala 134:20]
  assign io_memoryStage_allowin = _io_execute_inst_unable_T | ready_go; // @[Memory.scala 149:31]
  assign io_dataMemory_waiting = io_fromMemoryStage_valid & io_fromMemoryStage_wait_mem & ~data_ok; // @[Memory.scala 101:68]
  assign io_execute_whilo = whilo & ms_to_ws_valid; // @[Memory.scala 75:35]
  assign io_execute_hi = reset ? 32'h0 : io_fromMemoryStage_hi; // @[Memory.scala 157:37 161:15 170:15]
  assign io_execute_lo = reset ? 32'h0 : io_fromMemoryStage_lo; // @[Memory.scala 157:37 162:15 171:15]
  assign io_execute_allowin = _io_execute_inst_unable_T | ready_go; // @[Memory.scala 149:31]
  assign io_execute_inst_unable = ~io_fromMemoryStage_valid | io_fromMemoryStage_data_ok; // @[Memory.scala 77:61]
  assign io_writeBackStage_pc = io_fromMemoryStage_pc; // @[Memory.scala 109:37]
  assign io_writeBackStage_reg_wdata = reset ? 32'h0 : _reg_wdata_T_113; // @[Memory.scala 157:37 160:15 207:15]
  assign io_writeBackStage_reg_waddr = reset ? 5'h0 : io_fromMemoryStage_reg_waddr; // @[Memory.scala 157:37 158:15 169:15]
  assign io_writeBackStage_reg_wen = reset ? 4'h0 : _reg_wen_T_15; // @[Memory.scala 157:37 159:15 180:13]
  assign io_writeBackStage_whilo = reset ? 1'h0 : io_fromMemoryStage_whilo; // @[Memory.scala 157:37 163:15 172:15]
  assign io_writeBackStage_hi = reset ? 32'h0 : io_fromMemoryStage_hi; // @[Memory.scala 157:37 161:15 170:15]
  assign io_writeBackStage_lo = reset ? 32'h0 : io_fromMemoryStage_lo; // @[Memory.scala 157:37 162:15 171:15]
  assign io_writeBackStage_valid = io_fromMemoryStage_valid & ready_go & ~io_fromMemoryStage_do_flush; // @[Memory.scala 150:42]
  assign io_writeBackStage_inst_is_mfc0 = io_fromMemoryStage_valid & io_fromMemoryStage_aluop == 7'h11; // @[Memory.scala 140:31]
  assign io_writeBackStage_inst_is_mtc0 = io_fromMemoryStage_valid & io_fromMemoryStage_aluop == 7'h12; // @[Memory.scala 141:31]
  assign io_writeBackStage_inst_is_eret = io_fromMemoryStage_valid & io_fromMemoryStage_aluop == 7'h46; // @[Memory.scala 142:31]
  assign io_writeBackStage_bd = io_fromMemoryStage_bd; // @[Memory.scala 123:37]
  assign io_writeBackStage_badvaddr = io_fromMemoryStage_badvaddr; // @[Memory.scala 121:37]
  assign io_writeBackStage_cp0_addr = io_fromMemoryStage_cp0_addr; // @[Memory.scala 119:37]
  assign io_writeBackStage_excode = io_fromMemoryStage_excode; // @[Memory.scala 120:37]
  assign io_writeBackStage_ex = io_fromMemoryStage_valid & io_fromMemoryStage_ex; // @[Memory.scala 272:18]
  assign io_writeBackStage_inst_is_tlbp = io_fromMemoryStage_valid & io_fromMemoryStage_aluop == 7'h48; // @[Memory.scala 144:31]
  assign io_writeBackStage_inst_is_tlbr = io_fromMemoryStage_valid & io_fromMemoryStage_aluop == 7'h49; // @[Memory.scala 145:31]
  assign io_writeBackStage_inst_is_tlbwi = io_fromMemoryStage_valid & io_fromMemoryStage_aluop == 7'h4a; // @[Memory.scala 146:31]
  assign io_writeBackStage_tlb_refill = io_fromMemoryStage_tlb_refill; // @[Memory.scala 127:37]
  assign io_writeBackStage_after_tlb = io_fromMemoryStage_after_tlb; // @[Memory.scala 128:37]
  assign io_writeBackStage_s1_found = io_fromMemoryStage_s1_found; // @[Memory.scala 129:37]
  assign io_writeBackStage_s1_index = io_fromMemoryStage_s1_index; // @[Memory.scala 130:37]
  assign io_ctrl_ex = io_fromMemoryStage_valid & io_fromMemoryStage_ex; // @[Memory.scala 272:18]
endmodule
module WriteBackStage(
  input         clock,
  input         reset,
  input  [31:0] io_fromMemory_pc,
  input  [31:0] io_fromMemory_reg_wdata,
  input  [4:0]  io_fromMemory_reg_waddr,
  input  [3:0]  io_fromMemory_reg_wen,
  input         io_fromMemory_whilo,
  input  [31:0] io_fromMemory_hi,
  input  [31:0] io_fromMemory_lo,
  input         io_fromMemory_valid,
  input         io_fromMemory_inst_is_mfc0,
  input         io_fromMemory_inst_is_mtc0,
  input         io_fromMemory_inst_is_eret,
  input         io_fromMemory_bd,
  input  [31:0] io_fromMemory_badvaddr,
  input  [7:0]  io_fromMemory_cp0_addr,
  input  [4:0]  io_fromMemory_excode,
  input         io_fromMemory_ex,
  input         io_fromMemory_inst_is_tlbp,
  input         io_fromMemory_inst_is_tlbr,
  input         io_fromMemory_inst_is_tlbwi,
  input         io_fromMemory_tlb_refill,
  input         io_fromMemory_after_tlb,
  input         io_fromMemory_s1_found,
  input  [3:0]  io_fromMemory_s1_index,
  input  [31:0] io_fromCP0_cp0_rdata,
  input  [31:0] io_fromCP0_cp0_status,
  input  [31:0] io_fromCP0_cp0_cause,
  input  [31:0] io_fromCP0_cp0_epc,
  input  [31:0] io_fromCP0_cp0_entryhi,
  input  [31:0] io_fromCP0_cp0_entrylo0,
  input  [31:0] io_fromCP0_cp0_entrylo1,
  input  [31:0] io_fromCP0_cp0_index,
  input  [18:0] io_fromTLB_r_vpn2,
  input  [7:0]  io_fromTLB_r_asid,
  input         io_fromTLB_r_g,
  input  [19:0] io_fromTLB_r_pfn0,
  input  [2:0]  io_fromTLB_r_c0,
  input         io_fromTLB_r_d0,
  input         io_fromTLB_r_v0,
  input  [19:0] io_fromTLB_r_pfn1,
  input  [2:0]  io_fromTLB_r_c1,
  input         io_fromTLB_r_d1,
  input         io_fromTLB_r_v1,
  input  [5:0]  io_ext_int,
  output        io_decoder_inst_is_mfc0,
  output [4:0]  io_decoder_reg_waddr,
  output [31:0] io_decoder_cp0_cause,
  output [31:0] io_decoder_cp0_status,
  output [31:0] io_regFile_reg_wdata,
  output [4:0]  io_regFile_reg_waddr,
  output [3:0]  io_regFile_reg_wen,
  output        io_execute_whilo,
  output [31:0] io_execute_hi,
  output [31:0] io_execute_lo,
  output        io_mov_cp0_wen,
  output        io_mov_cp0_waddr,
  output        io_mov_cp0_wdata,
  output [31:0] io_mov_cp0_rdata,
  output        io_hilo_whilo,
  output [31:0] io_hilo_hi,
  output [31:0] io_hilo_lo,
  output        io_cp0_wb_ex,
  output        io_cp0_wb_bd,
  output        io_cp0_eret_flush,
  output [4:0]  io_cp0_wb_excode,
  output [31:0] io_cp0_wb_pc,
  output [31:0] io_cp0_wb_badvaddr,
  output [5:0]  io_cp0_ext_int_in,
  output [7:0]  io_cp0_cp0_addr,
  output        io_cp0_mtc0_we,
  output [31:0] io_cp0_cp0_wdata,
  output        io_cp0_tlbp,
  output        io_cp0_tlbr,
  output        io_cp0_s1_found,
  output [3:0]  io_cp0_s1_index,
  output [18:0] io_cp0_r_vpn2,
  output [7:0]  io_cp0_r_asid,
  output        io_cp0_r_g,
  output [19:0] io_cp0_r_pfn0,
  output [2:0]  io_cp0_r_c0,
  output        io_cp0_r_d0,
  output        io_cp0_r_v0,
  output [19:0] io_cp0_r_pfn1,
  output [2:0]  io_cp0_r_c1,
  output        io_cp0_r_d1,
  output        io_cp0_r_v1,
  output        io_ctrl_ex,
  output        io_ctrl_do_flush,
  output [31:0] io_ctrl_flush_pc,
  output        io_tlb_we,
  output [3:0]  io_tlb_w_index,
  output [18:0] io_tlb_w_vpn2,
  output [7:0]  io_tlb_w_asid,
  output        io_tlb_w_g,
  output [19:0] io_tlb_w_pfn0,
  output [2:0]  io_tlb_w_c0,
  output        io_tlb_w_d0,
  output        io_tlb_w_v0,
  output [19:0] io_tlb_w_pfn1,
  output [2:0]  io_tlb_w_c1,
  output        io_tlb_w_d1,
  output        io_tlb_w_v1,
  output [3:0]  io_tlb_r_index,
  output [31:0] io_instMMU_cp0_entryhi,
  output [31:0] io_dataMMU_cp0_entryhi,
  output [31:0] io_debug_pc,
  output [3:0]  io_debug_wen,
  output [4:0]  io_debug_waddr,
  output [31:0] io_debug_wdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ws_pc; // @[WriteBackStage.scala 29:35]
  reg [4:0] ws_reg_waddr; // @[WriteBackStage.scala 30:35]
  reg [3:0] ws_reg_wen; // @[WriteBackStage.scala 31:35]
  reg [31:0] ws_reg_wdata; // @[WriteBackStage.scala 32:35]
  reg [31:0] ws_hi; // @[WriteBackStage.scala 33:35]
  reg [31:0] ws_lo; // @[WriteBackStage.scala 34:35]
  reg  ws_whilo; // @[WriteBackStage.scala 35:35]
  reg  ws_valid; // @[WriteBackStage.scala 36:35]
  reg  ws_inst_is_mtc0; // @[WriteBackStage.scala 37:35]
  reg  ws_inst_is_mfc0; // @[WriteBackStage.scala 38:35]
  reg  ws_inst_is_eret; // @[WriteBackStage.scala 39:35]
  reg  ws_bd; // @[WriteBackStage.scala 41:35]
  reg [31:0] badvaddr; // @[WriteBackStage.scala 42:35]
  reg [7:0] ws_cp0_addr; // @[WriteBackStage.scala 43:35]
  reg [4:0] excode; // @[WriteBackStage.scala 44:35]
  reg  ws_ex; // @[WriteBackStage.scala 45:35]
  reg  ws_inst_is_tlbp; // @[WriteBackStage.scala 47:35]
  reg  ws_inst_is_tlbr; // @[WriteBackStage.scala 48:35]
  reg  ws_inst_is_tlbwi; // @[WriteBackStage.scala 49:35]
  reg  ws_tlb_refill; // @[WriteBackStage.scala 50:35]
  reg  ws_after_tlb; // @[WriteBackStage.scala 51:35]
  reg  ws_s1_found; // @[WriteBackStage.scala 52:35]
  reg [3:0] ws_s1_index; // @[WriteBackStage.scala 53:35]
  wire  do_flush = ws_valid & ws_ex; // @[WriteBackStage.scala 69:31]
  wire  ex_tlb_refill_entry = (excode == 5'h2 | excode == 5'h3) & ws_tlb_refill & ws_valid; // @[WriteBackStage.scala 72:71]
  wire [31:0] _flush_pc_T = ex_tlb_refill_entry ? 32'hbfc00200 : 32'hbfc00380; // @[Mux.scala 101:16]
  wire [31:0] _flush_pc_T_1 = ws_inst_is_eret ? io_fromCP0_cp0_epc : _flush_pc_T; // @[Mux.scala 101:16]
  wire  _io_regFile_reg_wen_T = ~ws_ex; // @[WriteBackStage.scala 95:59]
  wire  _io_regFile_reg_wen_T_1 = ws_valid & ~ws_ex; // @[WriteBackStage.scala 95:57]
  wire [3:0] _io_regFile_reg_wen_T_3 = _io_regFile_reg_wen_T_1 ? 4'hf : 4'h0; // @[Bitwise.scala 77:12]
  assign io_decoder_inst_is_mfc0 = ws_valid & ws_inst_is_mfc0; // @[WriteBackStage.scala 213:28]
  assign io_decoder_reg_waddr = ws_reg_waddr; // @[WriteBackStage.scala 105:27]
  assign io_decoder_cp0_cause = io_fromCP0_cp0_cause; // @[WriteBackStage.scala 106:27]
  assign io_decoder_cp0_status = io_fromCP0_cp0_status; // @[WriteBackStage.scala 107:27]
  assign io_regFile_reg_wdata = ws_inst_is_mfc0 ? io_fromCP0_cp0_rdata : ws_reg_wdata; // @[WriteBackStage.scala 96:30]
  assign io_regFile_reg_waddr = ws_reg_waddr; // @[WriteBackStage.scala 94:24]
  assign io_regFile_reg_wen = ws_reg_wen & _io_regFile_reg_wen_T_3; // @[WriteBackStage.scala 95:38]
  assign io_execute_whilo = ws_whilo & ws_valid; // @[WriteBackStage.scala 112:32]
  assign io_execute_hi = ws_hi; // @[WriteBackStage.scala 110:20]
  assign io_execute_lo = ws_lo; // @[WriteBackStage.scala 111:20]
  assign io_mov_cp0_wen = ws_valid & ws_inst_is_mtc0 & _io_regFile_reg_wen_T; // @[WriteBackStage.scala 215:44]
  assign io_mov_cp0_waddr = ws_cp0_addr[0]; // @[WriteBackStage.scala 116:20]
  assign io_mov_cp0_wdata = ws_reg_wdata[0]; // @[WriteBackStage.scala 117:20]
  assign io_mov_cp0_rdata = io_fromCP0_cp0_rdata; // @[WriteBackStage.scala 118:20]
  assign io_hilo_whilo = ws_whilo & ws_valid; // @[WriteBackStage.scala 101:29]
  assign io_hilo_hi = ws_hi; // @[WriteBackStage.scala 99:17]
  assign io_hilo_lo = ws_lo; // @[WriteBackStage.scala 100:17]
  assign io_cp0_wb_ex = do_flush & ~ws_inst_is_eret & ~ws_after_tlb; // @[WriteBackStage.scala 130:48]
  assign io_cp0_wb_bd = ws_bd; // @[WriteBackStage.scala 131:22]
  assign io_cp0_eret_flush = ws_valid & ws_inst_is_eret; // @[WriteBackStage.scala 68:31]
  assign io_cp0_wb_excode = excode; // @[WriteBackStage.scala 133:22]
  assign io_cp0_wb_pc = ws_pc; // @[WriteBackStage.scala 134:22]
  assign io_cp0_wb_badvaddr = badvaddr; // @[WriteBackStage.scala 135:22]
  assign io_cp0_ext_int_in = io_ext_int; // @[WriteBackStage.scala 136:22]
  assign io_cp0_cp0_addr = ws_cp0_addr; // @[WriteBackStage.scala 137:22]
  assign io_cp0_mtc0_we = ws_valid & ws_inst_is_mtc0 & _io_regFile_reg_wen_T; // @[WriteBackStage.scala 215:44]
  assign io_cp0_cp0_wdata = ws_reg_wdata; // @[WriteBackStage.scala 216:13 65:26]
  assign io_cp0_tlbp = ws_inst_is_tlbp; // @[WriteBackStage.scala 140:22]
  assign io_cp0_tlbr = ws_inst_is_tlbr; // @[WriteBackStage.scala 141:22]
  assign io_cp0_s1_found = ws_s1_found; // @[WriteBackStage.scala 143:22]
  assign io_cp0_s1_index = ws_s1_index; // @[WriteBackStage.scala 144:22]
  assign io_cp0_r_vpn2 = io_fromTLB_r_vpn2; // @[WriteBackStage.scala 145:22]
  assign io_cp0_r_asid = io_fromTLB_r_asid; // @[WriteBackStage.scala 146:22]
  assign io_cp0_r_g = io_fromTLB_r_g; // @[WriteBackStage.scala 147:22]
  assign io_cp0_r_pfn0 = io_fromTLB_r_pfn0; // @[WriteBackStage.scala 148:22]
  assign io_cp0_r_c0 = io_fromTLB_r_c0; // @[WriteBackStage.scala 149:22]
  assign io_cp0_r_d0 = io_fromTLB_r_d0; // @[WriteBackStage.scala 150:22]
  assign io_cp0_r_v0 = io_fromTLB_r_v0; // @[WriteBackStage.scala 151:22]
  assign io_cp0_r_pfn1 = io_fromTLB_r_pfn1; // @[WriteBackStage.scala 152:22]
  assign io_cp0_r_c1 = io_fromTLB_r_c1; // @[WriteBackStage.scala 153:22]
  assign io_cp0_r_d1 = io_fromTLB_r_d1; // @[WriteBackStage.scala 154:22]
  assign io_cp0_r_v1 = io_fromTLB_r_v1; // @[WriteBackStage.scala 155:22]
  assign io_ctrl_ex = ws_valid & ws_ex; // @[WriteBackStage.scala 69:31]
  assign io_ctrl_do_flush = ws_valid & ws_ex; // @[WriteBackStage.scala 69:31]
  assign io_ctrl_flush_pc = ws_after_tlb ? ws_pc : _flush_pc_T_1; // @[Mux.scala 101:16]
  assign io_tlb_we = ws_inst_is_tlbwi & ws_valid; // @[WriteBackStage.scala 158:38]
  assign io_tlb_w_index = io_fromCP0_cp0_index[3:0]; // @[WriteBackStage.scala 162:41]
  assign io_tlb_w_vpn2 = io_fromCP0_cp0_entryhi[31:13]; // @[WriteBackStage.scala 163:43]
  assign io_tlb_w_asid = io_fromCP0_cp0_entryhi[7:0]; // @[WriteBackStage.scala 164:43]
  assign io_tlb_w_g = io_fromCP0_cp0_entrylo0[0] & io_fromCP0_cp0_entrylo1[0]; // @[WriteBackStage.scala 165:48]
  assign io_tlb_w_pfn0 = io_fromCP0_cp0_entrylo0[25:6]; // @[WriteBackStage.scala 167:43]
  assign io_tlb_w_c0 = io_fromCP0_cp0_entrylo0[5:3]; // @[WriteBackStage.scala 168:43]
  assign io_tlb_w_d0 = io_fromCP0_cp0_entrylo0[2]; // @[WriteBackStage.scala 169:43]
  assign io_tlb_w_v0 = io_fromCP0_cp0_entrylo0[1]; // @[WriteBackStage.scala 170:43]
  assign io_tlb_w_pfn1 = io_fromCP0_cp0_entrylo1[25:6]; // @[WriteBackStage.scala 172:43]
  assign io_tlb_w_c1 = io_fromCP0_cp0_entrylo1[5:3]; // @[WriteBackStage.scala 173:43]
  assign io_tlb_w_d1 = io_fromCP0_cp0_entrylo1[2]; // @[WriteBackStage.scala 174:43]
  assign io_tlb_w_v1 = io_fromCP0_cp0_entrylo1[1]; // @[WriteBackStage.scala 175:43]
  assign io_tlb_r_index = io_fromCP0_cp0_index[3:0]; // @[WriteBackStage.scala 159:41]
  assign io_instMMU_cp0_entryhi = io_fromCP0_cp0_entryhi; // @[WriteBackStage.scala 91:26]
  assign io_dataMMU_cp0_entryhi = io_fromCP0_cp0_entryhi; // @[WriteBackStage.scala 90:26]
  assign io_debug_pc = ws_pc; // @[WriteBackStage.scala 124:18]
  assign io_debug_wen = io_regFile_reg_wen; // @[WriteBackStage.scala 126:18]
  assign io_debug_waddr = io_regFile_reg_waddr; // @[WriteBackStage.scala 125:18]
  assign io_debug_wdata = io_regFile_reg_wdata; // @[WriteBackStage.scala 127:18]
  always @(posedge clock) begin
    if (reset) begin // @[WriteBackStage.scala 29:35]
      ws_pc <= 32'h0; // @[WriteBackStage.scala 29:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_pc <= io_fromMemory_pc; // @[WriteBackStage.scala 194:24]
    end
    if (reset) begin // @[WriteBackStage.scala 30:35]
      ws_reg_waddr <= 5'h0; // @[WriteBackStage.scala 30:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_reg_waddr <= io_fromMemory_reg_waddr; // @[WriteBackStage.scala 188:24]
    end
    if (reset) begin // @[WriteBackStage.scala 31:35]
      ws_reg_wen <= 4'h0; // @[WriteBackStage.scala 31:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_reg_wen <= io_fromMemory_reg_wen; // @[WriteBackStage.scala 189:24]
    end
    if (reset) begin // @[WriteBackStage.scala 32:35]
      ws_reg_wdata <= 32'h0; // @[WriteBackStage.scala 32:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_reg_wdata <= io_fromMemory_reg_wdata; // @[WriteBackStage.scala 190:24]
    end
    if (reset) begin // @[WriteBackStage.scala 33:35]
      ws_hi <= 32'h0; // @[WriteBackStage.scala 33:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_hi <= io_fromMemory_hi; // @[WriteBackStage.scala 191:24]
    end
    if (reset) begin // @[WriteBackStage.scala 34:35]
      ws_lo <= 32'h0; // @[WriteBackStage.scala 34:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_lo <= io_fromMemory_lo; // @[WriteBackStage.scala 192:24]
    end
    if (reset) begin // @[WriteBackStage.scala 35:35]
      ws_whilo <= 1'h0; // @[WriteBackStage.scala 35:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_whilo <= io_fromMemory_whilo; // @[WriteBackStage.scala 193:24]
    end
    if (reset) begin // @[WriteBackStage.scala 36:35]
      ws_valid <= 1'h0; // @[WriteBackStage.scala 36:35]
    end else begin
      ws_valid <= io_fromMemory_valid;
    end
    if (reset) begin // @[WriteBackStage.scala 37:35]
      ws_inst_is_mtc0 <= 1'h0; // @[WriteBackStage.scala 37:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_inst_is_mtc0 <= io_fromMemory_inst_is_mtc0; // @[WriteBackStage.scala 196:24]
    end
    if (reset) begin // @[WriteBackStage.scala 38:35]
      ws_inst_is_mfc0 <= 1'h0; // @[WriteBackStage.scala 38:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_inst_is_mfc0 <= io_fromMemory_inst_is_mfc0; // @[WriteBackStage.scala 195:24]
    end
    if (reset) begin // @[WriteBackStage.scala 39:35]
      ws_inst_is_eret <= 1'h0; // @[WriteBackStage.scala 39:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_inst_is_eret <= io_fromMemory_inst_is_eret; // @[WriteBackStage.scala 198:24]
    end
    if (reset) begin // @[WriteBackStage.scala 41:35]
      ws_bd <= 1'h0; // @[WriteBackStage.scala 41:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_bd <= io_fromMemory_bd; // @[WriteBackStage.scala 203:24]
    end
    if (reset) begin // @[WriteBackStage.scala 42:35]
      badvaddr <= 32'h0; // @[WriteBackStage.scala 42:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      badvaddr <= io_fromMemory_badvaddr; // @[WriteBackStage.scala 200:24]
    end
    if (reset) begin // @[WriteBackStage.scala 43:35]
      ws_cp0_addr <= 8'h0; // @[WriteBackStage.scala 43:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_cp0_addr <= io_fromMemory_cp0_addr; // @[WriteBackStage.scala 201:24]
    end
    if (reset) begin // @[WriteBackStage.scala 44:35]
      excode <= 5'h0; // @[WriteBackStage.scala 44:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      excode <= io_fromMemory_excode; // @[WriteBackStage.scala 199:24]
    end
    if (reset) begin // @[WriteBackStage.scala 45:35]
      ws_ex <= 1'h0; // @[WriteBackStage.scala 45:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_ex <= io_fromMemory_ex; // @[WriteBackStage.scala 202:24]
    end
    if (reset) begin // @[WriteBackStage.scala 47:35]
      ws_inst_is_tlbp <= 1'h0; // @[WriteBackStage.scala 47:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_inst_is_tlbp <= io_fromMemory_inst_is_tlbp; // @[WriteBackStage.scala 204:24]
    end
    if (reset) begin // @[WriteBackStage.scala 48:35]
      ws_inst_is_tlbr <= 1'h0; // @[WriteBackStage.scala 48:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_inst_is_tlbr <= io_fromMemory_inst_is_tlbr; // @[WriteBackStage.scala 205:24]
    end
    if (reset) begin // @[WriteBackStage.scala 49:35]
      ws_inst_is_tlbwi <= 1'h0; // @[WriteBackStage.scala 49:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_inst_is_tlbwi <= io_fromMemory_inst_is_tlbwi; // @[WriteBackStage.scala 206:24]
    end
    if (reset) begin // @[WriteBackStage.scala 50:35]
      ws_tlb_refill <= 1'h0; // @[WriteBackStage.scala 50:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_tlb_refill <= io_fromMemory_tlb_refill; // @[WriteBackStage.scala 207:24]
    end
    if (reset) begin // @[WriteBackStage.scala 51:35]
      ws_after_tlb <= 1'h0; // @[WriteBackStage.scala 51:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_after_tlb <= io_fromMemory_after_tlb; // @[WriteBackStage.scala 208:24]
    end
    if (reset) begin // @[WriteBackStage.scala 52:35]
      ws_s1_found <= 1'h0; // @[WriteBackStage.scala 52:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_s1_found <= io_fromMemory_s1_found; // @[WriteBackStage.scala 209:24]
    end
    if (reset) begin // @[WriteBackStage.scala 53:35]
      ws_s1_index <= 4'h0; // @[WriteBackStage.scala 53:35]
    end else if (io_fromMemory_valid) begin // @[WriteBackStage.scala 186:40]
      ws_s1_index <= io_fromMemory_s1_index; // @[WriteBackStage.scala 210:24]
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
  ws_pc = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  ws_reg_waddr = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  ws_reg_wen = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  ws_reg_wdata = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  ws_hi = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  ws_lo = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  ws_whilo = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  ws_valid = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  ws_inst_is_mtc0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  ws_inst_is_mfc0 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  ws_inst_is_eret = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  ws_bd = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  badvaddr = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  ws_cp0_addr = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  excode = _RAND_14[4:0];
  _RAND_15 = {1{`RANDOM}};
  ws_ex = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  ws_inst_is_tlbp = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  ws_inst_is_tlbr = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  ws_inst_is_tlbwi = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  ws_tlb_refill = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  ws_after_tlb = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  ws_s1_found = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  ws_s1_index = _RAND_22[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Regfile(
  input         clock,
  input         reset,
  input  [4:0]  io_fromDecoder_reg1_raddr,
  input  [4:0]  io_fromDecoder_reg2_raddr,
  input  [31:0] io_fromWriteBackStage_reg_wdata,
  input  [4:0]  io_fromWriteBackStage_reg_waddr,
  input  [3:0]  io_fromWriteBackStage_reg_wen,
  output [31:0] io_decoder_reg1_data,
  output [31:0] io_decoder_reg2_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regs_0; // @[Regfile.scala 39:21]
  reg [31:0] regs_1; // @[Regfile.scala 39:21]
  reg [31:0] regs_2; // @[Regfile.scala 39:21]
  reg [31:0] regs_3; // @[Regfile.scala 39:21]
  reg [31:0] regs_4; // @[Regfile.scala 39:21]
  reg [31:0] regs_5; // @[Regfile.scala 39:21]
  reg [31:0] regs_6; // @[Regfile.scala 39:21]
  reg [31:0] regs_7; // @[Regfile.scala 39:21]
  reg [31:0] regs_8; // @[Regfile.scala 39:21]
  reg [31:0] regs_9; // @[Regfile.scala 39:21]
  reg [31:0] regs_10; // @[Regfile.scala 39:21]
  reg [31:0] regs_11; // @[Regfile.scala 39:21]
  reg [31:0] regs_12; // @[Regfile.scala 39:21]
  reg [31:0] regs_13; // @[Regfile.scala 39:21]
  reg [31:0] regs_14; // @[Regfile.scala 39:21]
  reg [31:0] regs_15; // @[Regfile.scala 39:21]
  reg [31:0] regs_16; // @[Regfile.scala 39:21]
  reg [31:0] regs_17; // @[Regfile.scala 39:21]
  reg [31:0] regs_18; // @[Regfile.scala 39:21]
  reg [31:0] regs_19; // @[Regfile.scala 39:21]
  reg [31:0] regs_20; // @[Regfile.scala 39:21]
  reg [31:0] regs_21; // @[Regfile.scala 39:21]
  reg [31:0] regs_22; // @[Regfile.scala 39:21]
  reg [31:0] regs_23; // @[Regfile.scala 39:21]
  reg [31:0] regs_24; // @[Regfile.scala 39:21]
  reg [31:0] regs_25; // @[Regfile.scala 39:21]
  reg [31:0] regs_26; // @[Regfile.scala 39:21]
  reg [31:0] regs_27; // @[Regfile.scala 39:21]
  reg [31:0] regs_28; // @[Regfile.scala 39:21]
  reg [31:0] regs_29; // @[Regfile.scala 39:21]
  reg [31:0] regs_30; // @[Regfile.scala 39:21]
  reg [31:0] regs_31; // @[Regfile.scala 39:21]
  wire  _T_1 = |io_fromWriteBackStage_reg_waddr; // @[Regfile.scala 41:25]
  wire [31:0] _GEN_1 = 5'h1 == io_fromWriteBackStage_reg_waddr ? regs_1 : regs_0; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_2 = 5'h2 == io_fromWriteBackStage_reg_waddr ? regs_2 : _GEN_1; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_3 = 5'h3 == io_fromWriteBackStage_reg_waddr ? regs_3 : _GEN_2; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_4 = 5'h4 == io_fromWriteBackStage_reg_waddr ? regs_4 : _GEN_3; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_5 = 5'h5 == io_fromWriteBackStage_reg_waddr ? regs_5 : _GEN_4; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_6 = 5'h6 == io_fromWriteBackStage_reg_waddr ? regs_6 : _GEN_5; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_7 = 5'h7 == io_fromWriteBackStage_reg_waddr ? regs_7 : _GEN_6; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_8 = 5'h8 == io_fromWriteBackStage_reg_waddr ? regs_8 : _GEN_7; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_9 = 5'h9 == io_fromWriteBackStage_reg_waddr ? regs_9 : _GEN_8; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_10 = 5'ha == io_fromWriteBackStage_reg_waddr ? regs_10 : _GEN_9; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_11 = 5'hb == io_fromWriteBackStage_reg_waddr ? regs_11 : _GEN_10; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_12 = 5'hc == io_fromWriteBackStage_reg_waddr ? regs_12 : _GEN_11; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_13 = 5'hd == io_fromWriteBackStage_reg_waddr ? regs_13 : _GEN_12; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_14 = 5'he == io_fromWriteBackStage_reg_waddr ? regs_14 : _GEN_13; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_15 = 5'hf == io_fromWriteBackStage_reg_waddr ? regs_15 : _GEN_14; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_16 = 5'h10 == io_fromWriteBackStage_reg_waddr ? regs_16 : _GEN_15; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_17 = 5'h11 == io_fromWriteBackStage_reg_waddr ? regs_17 : _GEN_16; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_18 = 5'h12 == io_fromWriteBackStage_reg_waddr ? regs_18 : _GEN_17; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_19 = 5'h13 == io_fromWriteBackStage_reg_waddr ? regs_19 : _GEN_18; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_20 = 5'h14 == io_fromWriteBackStage_reg_waddr ? regs_20 : _GEN_19; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_21 = 5'h15 == io_fromWriteBackStage_reg_waddr ? regs_21 : _GEN_20; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_22 = 5'h16 == io_fromWriteBackStage_reg_waddr ? regs_22 : _GEN_21; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_23 = 5'h17 == io_fromWriteBackStage_reg_waddr ? regs_23 : _GEN_22; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_24 = 5'h18 == io_fromWriteBackStage_reg_waddr ? regs_24 : _GEN_23; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_25 = 5'h19 == io_fromWriteBackStage_reg_waddr ? regs_25 : _GEN_24; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_26 = 5'h1a == io_fromWriteBackStage_reg_waddr ? regs_26 : _GEN_25; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_27 = 5'h1b == io_fromWriteBackStage_reg_waddr ? regs_27 : _GEN_26; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_28 = 5'h1c == io_fromWriteBackStage_reg_waddr ? regs_28 : _GEN_27; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_29 = 5'h1d == io_fromWriteBackStage_reg_waddr ? regs_29 : _GEN_28; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_30 = 5'h1e == io_fromWriteBackStage_reg_waddr ? regs_30 : _GEN_29; // @[Regfile.scala 43:{45,45}]
  wire [31:0] _GEN_31 = 5'h1f == io_fromWriteBackStage_reg_waddr ? regs_31 : _GEN_30; // @[Regfile.scala 43:{45,45}]
  wire [7:0] _regs_T_3 = io_fromWriteBackStage_reg_wen[3] ? io_fromWriteBackStage_reg_wdata[31:24] : _GEN_31[31:24]; // @[Regfile.scala 43:10]
  wire [7:0] _regs_T_7 = io_fromWriteBackStage_reg_wen[2] ? io_fromWriteBackStage_reg_wdata[23:16] : _GEN_31[23:16]; // @[Regfile.scala 44:10]
  wire [7:0] _regs_T_11 = io_fromWriteBackStage_reg_wen[1] ? io_fromWriteBackStage_reg_wdata[15:8] : _GEN_31[15:8]; // @[Regfile.scala 45:10]
  wire [7:0] _regs_T_15 = io_fromWriteBackStage_reg_wen[0] ? io_fromWriteBackStage_reg_wdata[7:0] : _GEN_31[7:0]; // @[Regfile.scala 46:10]
  wire [31:0] _regs_T_16 = {_regs_T_3,_regs_T_7,_regs_T_11,_regs_T_15}; // @[Cat.scala 33:92]
  wire  _T_12 = io_fromWriteBackStage_reg_wen[1] & io_fromWriteBackStage_reg_waddr == io_fromDecoder_reg1_raddr & _T_1; // @[Regfile.scala 57:34]
  wire [31:0] _GEN_97 = 5'h1 == io_fromDecoder_reg1_raddr ? regs_1 : regs_0; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_98 = 5'h2 == io_fromDecoder_reg1_raddr ? regs_2 : _GEN_97; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_99 = 5'h3 == io_fromDecoder_reg1_raddr ? regs_3 : _GEN_98; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_100 = 5'h4 == io_fromDecoder_reg1_raddr ? regs_4 : _GEN_99; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_101 = 5'h5 == io_fromDecoder_reg1_raddr ? regs_5 : _GEN_100; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_102 = 5'h6 == io_fromDecoder_reg1_raddr ? regs_6 : _GEN_101; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_103 = 5'h7 == io_fromDecoder_reg1_raddr ? regs_7 : _GEN_102; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_104 = 5'h8 == io_fromDecoder_reg1_raddr ? regs_8 : _GEN_103; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_105 = 5'h9 == io_fromDecoder_reg1_raddr ? regs_9 : _GEN_104; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_106 = 5'ha == io_fromDecoder_reg1_raddr ? regs_10 : _GEN_105; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_107 = 5'hb == io_fromDecoder_reg1_raddr ? regs_11 : _GEN_106; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_108 = 5'hc == io_fromDecoder_reg1_raddr ? regs_12 : _GEN_107; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_109 = 5'hd == io_fromDecoder_reg1_raddr ? regs_13 : _GEN_108; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_110 = 5'he == io_fromDecoder_reg1_raddr ? regs_14 : _GEN_109; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_111 = 5'hf == io_fromDecoder_reg1_raddr ? regs_15 : _GEN_110; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_112 = 5'h10 == io_fromDecoder_reg1_raddr ? regs_16 : _GEN_111; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_113 = 5'h11 == io_fromDecoder_reg1_raddr ? regs_17 : _GEN_112; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_114 = 5'h12 == io_fromDecoder_reg1_raddr ? regs_18 : _GEN_113; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_115 = 5'h13 == io_fromDecoder_reg1_raddr ? regs_19 : _GEN_114; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_116 = 5'h14 == io_fromDecoder_reg1_raddr ? regs_20 : _GEN_115; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_117 = 5'h15 == io_fromDecoder_reg1_raddr ? regs_21 : _GEN_116; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_118 = 5'h16 == io_fromDecoder_reg1_raddr ? regs_22 : _GEN_117; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_119 = 5'h17 == io_fromDecoder_reg1_raddr ? regs_23 : _GEN_118; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_120 = 5'h18 == io_fromDecoder_reg1_raddr ? regs_24 : _GEN_119; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_121 = 5'h19 == io_fromDecoder_reg1_raddr ? regs_25 : _GEN_120; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_122 = 5'h1a == io_fromDecoder_reg1_raddr ? regs_26 : _GEN_121; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_123 = 5'h1b == io_fromDecoder_reg1_raddr ? regs_27 : _GEN_122; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_124 = 5'h1c == io_fromDecoder_reg1_raddr ? regs_28 : _GEN_123; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_125 = 5'h1d == io_fromDecoder_reg1_raddr ? regs_29 : _GEN_124; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_126 = 5'h1e == io_fromDecoder_reg1_raddr ? regs_30 : _GEN_125; // @[Regfile.scala 61:{38,38}]
  wire [31:0] _GEN_127 = 5'h1f == io_fromDecoder_reg1_raddr ? regs_31 : _GEN_126; // @[Regfile.scala 61:{38,38}]
  wire [7:0] rdata1_value_1 = _T_12 ? io_fromWriteBackStage_reg_wdata[15:8] : _GEN_127[15:8]; // @[Regfile.scala 58:7 59:23 61:23]
  wire  _T_7 = io_fromWriteBackStage_reg_wen[0] & io_fromWriteBackStage_reg_waddr == io_fromDecoder_reg1_raddr & _T_1; // @[Regfile.scala 57:34]
  wire [7:0] rdata1_value_0 = _T_7 ? io_fromWriteBackStage_reg_wdata[7:0] : _GEN_127[7:0]; // @[Regfile.scala 58:7 59:23 61:23]
  wire [15:0] rdata1_lo = {rdata1_value_1,rdata1_value_0}; // @[Regfile.scala 54:26]
  wire  _T_22 = io_fromWriteBackStage_reg_wen[3] & io_fromWriteBackStage_reg_waddr == io_fromDecoder_reg1_raddr & _T_1; // @[Regfile.scala 57:34]
  wire [7:0] rdata1_value_3 = _T_22 ? io_fromWriteBackStage_reg_wdata[31:24] : _GEN_127[31:24]; // @[Regfile.scala 58:7 59:23 61:23]
  wire  _T_17 = io_fromWriteBackStage_reg_wen[2] & io_fromWriteBackStage_reg_waddr == io_fromDecoder_reg1_raddr & _T_1; // @[Regfile.scala 57:34]
  wire [7:0] rdata1_value_2 = _T_17 ? io_fromWriteBackStage_reg_wdata[23:16] : _GEN_127[23:16]; // @[Regfile.scala 58:7 59:23 61:23]
  wire [15:0] rdata1_hi = {rdata1_value_3,rdata1_value_2}; // @[Regfile.scala 54:26]
  wire  _T_32 = io_fromWriteBackStage_reg_wen[1] & io_fromWriteBackStage_reg_waddr == io_fromDecoder_reg2_raddr & _T_1; // @[Regfile.scala 68:34]
  wire [31:0] _GEN_133 = 5'h1 == io_fromDecoder_reg2_raddr ? regs_1 : regs_0; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_134 = 5'h2 == io_fromDecoder_reg2_raddr ? regs_2 : _GEN_133; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_135 = 5'h3 == io_fromDecoder_reg2_raddr ? regs_3 : _GEN_134; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_136 = 5'h4 == io_fromDecoder_reg2_raddr ? regs_4 : _GEN_135; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_137 = 5'h5 == io_fromDecoder_reg2_raddr ? regs_5 : _GEN_136; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_138 = 5'h6 == io_fromDecoder_reg2_raddr ? regs_6 : _GEN_137; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_139 = 5'h7 == io_fromDecoder_reg2_raddr ? regs_7 : _GEN_138; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_140 = 5'h8 == io_fromDecoder_reg2_raddr ? regs_8 : _GEN_139; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_141 = 5'h9 == io_fromDecoder_reg2_raddr ? regs_9 : _GEN_140; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_142 = 5'ha == io_fromDecoder_reg2_raddr ? regs_10 : _GEN_141; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_143 = 5'hb == io_fromDecoder_reg2_raddr ? regs_11 : _GEN_142; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_144 = 5'hc == io_fromDecoder_reg2_raddr ? regs_12 : _GEN_143; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_145 = 5'hd == io_fromDecoder_reg2_raddr ? regs_13 : _GEN_144; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_146 = 5'he == io_fromDecoder_reg2_raddr ? regs_14 : _GEN_145; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_147 = 5'hf == io_fromDecoder_reg2_raddr ? regs_15 : _GEN_146; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_148 = 5'h10 == io_fromDecoder_reg2_raddr ? regs_16 : _GEN_147; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_149 = 5'h11 == io_fromDecoder_reg2_raddr ? regs_17 : _GEN_148; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_150 = 5'h12 == io_fromDecoder_reg2_raddr ? regs_18 : _GEN_149; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_151 = 5'h13 == io_fromDecoder_reg2_raddr ? regs_19 : _GEN_150; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_152 = 5'h14 == io_fromDecoder_reg2_raddr ? regs_20 : _GEN_151; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_153 = 5'h15 == io_fromDecoder_reg2_raddr ? regs_21 : _GEN_152; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_154 = 5'h16 == io_fromDecoder_reg2_raddr ? regs_22 : _GEN_153; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_155 = 5'h17 == io_fromDecoder_reg2_raddr ? regs_23 : _GEN_154; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_156 = 5'h18 == io_fromDecoder_reg2_raddr ? regs_24 : _GEN_155; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_157 = 5'h19 == io_fromDecoder_reg2_raddr ? regs_25 : _GEN_156; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_158 = 5'h1a == io_fromDecoder_reg2_raddr ? regs_26 : _GEN_157; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_159 = 5'h1b == io_fromDecoder_reg2_raddr ? regs_27 : _GEN_158; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_160 = 5'h1c == io_fromDecoder_reg2_raddr ? regs_28 : _GEN_159; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_161 = 5'h1d == io_fromDecoder_reg2_raddr ? regs_29 : _GEN_160; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_162 = 5'h1e == io_fromDecoder_reg2_raddr ? regs_30 : _GEN_161; // @[Regfile.scala 72:{38,38}]
  wire [31:0] _GEN_163 = 5'h1f == io_fromDecoder_reg2_raddr ? regs_31 : _GEN_162; // @[Regfile.scala 72:{38,38}]
  wire [7:0] rdata2_value_1 = _T_32 ? io_fromWriteBackStage_reg_wdata[15:8] : _GEN_163[15:8]; // @[Regfile.scala 69:7 70:23 72:23]
  wire  _T_27 = io_fromWriteBackStage_reg_wen[0] & io_fromWriteBackStage_reg_waddr == io_fromDecoder_reg2_raddr & _T_1; // @[Regfile.scala 68:34]
  wire [7:0] rdata2_value_0 = _T_27 ? io_fromWriteBackStage_reg_wdata[7:0] : _GEN_163[7:0]; // @[Regfile.scala 69:7 70:23 72:23]
  wire [15:0] rdata2_lo = {rdata2_value_1,rdata2_value_0}; // @[Regfile.scala 65:26]
  wire  _T_42 = io_fromWriteBackStage_reg_wen[3] & io_fromWriteBackStage_reg_waddr == io_fromDecoder_reg2_raddr & _T_1; // @[Regfile.scala 68:34]
  wire [7:0] rdata2_value_3 = _T_42 ? io_fromWriteBackStage_reg_wdata[31:24] : _GEN_163[31:24]; // @[Regfile.scala 69:7 70:23 72:23]
  wire  _T_37 = io_fromWriteBackStage_reg_wen[2] & io_fromWriteBackStage_reg_waddr == io_fromDecoder_reg2_raddr & _T_1; // @[Regfile.scala 68:34]
  wire [7:0] rdata2_value_2 = _T_37 ? io_fromWriteBackStage_reg_wdata[23:16] : _GEN_163[23:16]; // @[Regfile.scala 69:7 70:23 72:23]
  wire [15:0] rdata2_hi = {rdata2_value_3,rdata2_value_2}; // @[Regfile.scala 65:26]
  assign io_decoder_reg1_data = {rdata1_hi,rdata1_lo}; // @[Regfile.scala 54:26]
  assign io_decoder_reg2_data = {rdata2_hi,rdata2_lo}; // @[Regfile.scala 65:26]
  always @(posedge clock) begin
    if (reset) begin // @[Regfile.scala 39:21]
      regs_0 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h0 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_0 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_1 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h1 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_1 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_2 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h2 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_2 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_3 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h3 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_3 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_4 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h4 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_4 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_5 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h5 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_5 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_6 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h6 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_6 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_7 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h7 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_7 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_8 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h8 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_8 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_9 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h9 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_9 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_10 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'ha == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_10 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_11 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'hb == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_11 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_12 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'hc == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_12 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_13 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'hd == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_13 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_14 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'he == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_14 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_15 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'hf == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_15 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_16 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h10 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_16 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_17 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h11 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_17 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_18 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h12 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_18 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_19 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h13 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_19 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_20 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h14 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_20 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_21 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h15 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_21 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_22 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h16 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_22 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_23 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h17 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_23 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_24 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h18 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_24 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_25 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h19 == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_25 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_26 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h1a == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_26 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_27 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h1b == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_27 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_28 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h1c == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_28 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_29 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h1d == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_29 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_30 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h1e == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_30 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
    end
    if (reset) begin // @[Regfile.scala 39:21]
      regs_31 <= 32'h0; // @[Regfile.scala 39:21]
    end else if (|io_fromWriteBackStage_reg_wen & |io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 41:30]
      if (5'h1f == io_fromWriteBackStage_reg_waddr) begin // @[Regfile.scala 42:17]
        regs_31 <= _regs_T_16; // @[Regfile.scala 42:17]
      end
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
  regs_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  regs_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  regs_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  regs_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  regs_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  regs_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  regs_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  regs_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  regs_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  regs_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  regs_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  regs_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  regs_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  regs_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  regs_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  regs_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  regs_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  regs_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  regs_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  regs_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  regs_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  regs_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  regs_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  regs_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  regs_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  regs_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  regs_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  regs_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  regs_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  regs_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  regs_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  regs_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module HILO(
  input         clock,
  input         reset,
  input         io_fromWriteBackStage_whilo,
  input  [31:0] io_fromWriteBackStage_hi,
  input  [31:0] io_fromWriteBackStage_lo,
  output [31:0] io_execute_hi,
  output [31:0] io_execute_lo
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] hi; // @[HILO.scala 14:19]
  reg [31:0] lo; // @[HILO.scala 16:19]
  assign io_execute_hi = hi; // @[HILO.scala 15:17]
  assign io_execute_lo = lo; // @[HILO.scala 17:17]
  always @(posedge clock) begin
    if (reset) begin // @[HILO.scala 14:19]
      hi <= 32'h0; // @[HILO.scala 14:19]
    end else if (io_fromWriteBackStage_whilo) begin // @[HILO.scala 19:54]
      hi <= io_fromWriteBackStage_hi; // @[HILO.scala 20:8]
    end
    if (reset) begin // @[HILO.scala 16:19]
      lo <= 32'h0; // @[HILO.scala 16:19]
    end else if (io_fromWriteBackStage_whilo) begin // @[HILO.scala 19:54]
      lo <= io_fromWriteBackStage_lo; // @[HILO.scala 21:8]
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
  hi = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  lo = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CP0Reg(
  input         clock,
  input         reset,
  input         io_fromWriteBackStage_wb_ex,
  input         io_fromWriteBackStage_wb_bd,
  input         io_fromWriteBackStage_eret_flush,
  input  [4:0]  io_fromWriteBackStage_wb_excode,
  input  [31:0] io_fromWriteBackStage_wb_pc,
  input  [31:0] io_fromWriteBackStage_wb_badvaddr,
  input  [5:0]  io_fromWriteBackStage_ext_int_in,
  input  [7:0]  io_fromWriteBackStage_cp0_addr,
  input         io_fromWriteBackStage_mtc0_we,
  input  [31:0] io_fromWriteBackStage_cp0_wdata,
  input         io_fromWriteBackStage_tlbp,
  input         io_fromWriteBackStage_tlbr,
  input         io_fromWriteBackStage_s1_found,
  input  [3:0]  io_fromWriteBackStage_s1_index,
  input  [18:0] io_fromWriteBackStage_r_vpn2,
  input  [7:0]  io_fromWriteBackStage_r_asid,
  input         io_fromWriteBackStage_r_g,
  input  [19:0] io_fromWriteBackStage_r_pfn0,
  input  [2:0]  io_fromWriteBackStage_r_c0,
  input         io_fromWriteBackStage_r_d0,
  input         io_fromWriteBackStage_r_v0,
  input  [19:0] io_fromWriteBackStage_r_pfn1,
  input  [2:0]  io_fromWriteBackStage_r_c1,
  input         io_fromWriteBackStage_r_d1,
  input         io_fromWriteBackStage_r_v1,
  output [31:0] io_writeBackStage_cp0_rdata,
  output [31:0] io_writeBackStage_cp0_status,
  output [31:0] io_writeBackStage_cp0_cause,
  output [31:0] io_writeBackStage_cp0_epc,
  output [31:0] io_writeBackStage_cp0_entryhi,
  output [31:0] io_writeBackStage_cp0_entrylo0,
  output [31:0] io_writeBackStage_cp0_entrylo1,
  output [31:0] io_writeBackStage_cp0_index
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] cp0_entryhi; // @[CP0Reg.scala 50:29]
  reg [31:0] cp0_entrylo0; // @[CP0Reg.scala 51:29]
  reg [31:0] cp0_entrylo1; // @[CP0Reg.scala 52:29]
  reg [31:0] cp0_index; // @[CP0Reg.scala 53:29]
  reg [7:0] cp0_status_im; // @[CP0Reg.scala 69:30]
  wire  _T_1 = io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h60; // @[CP0Reg.scala 70:16]
  reg  cp0_status_exl; // @[CP0Reg.scala 74:31]
  wire  _GEN_1 = _T_1 ? io_fromWriteBackStage_cp0_wdata[1] : cp0_status_exl; // @[CP0Reg.scala 81:5 82:20 74:31]
  wire  _GEN_2 = io_fromWriteBackStage_eret_flush ? 1'h0 : _GEN_1; // @[CP0Reg.scala 77:26 78:20]
  wire  _GEN_3 = io_fromWriteBackStage_wb_ex | _GEN_2; // @[CP0Reg.scala 75:15 76:20]
  reg  cp0_status_ie; // @[CP0Reg.scala 85:30]
  wire [7:0] cp0_status_lo = {6'h0,cp0_status_exl,cp0_status_ie}; // @[Cat.scala 33:92]
  wire [23:0] cp0_status_hi = {10'h1,6'h0,cp0_status_im}; // @[Cat.scala 33:92]
  wire [31:0] cp0_status = {10'h1,6'h0,cp0_status_im,6'h0,cp0_status_exl,cp0_status_ie}; // @[Cat.scala 33:92]
  reg  cp0_cause_bd; // @[CP0Reg.scala 100:29]
  wire  _T_7 = io_fromWriteBackStage_wb_ex & ~cp0_status_exl; // @[CP0Reg.scala 101:14]
  reg  cp0_cause_ti; // @[CP0Reg.scala 105:33]
  reg [31:0] c0_count; // @[CP0Reg.scala 169:25]
  reg [31:0] c0_compare; // @[CP0Reg.scala 179:27]
  wire  count_eq_compare = c0_count == c0_compare; // @[CP0Reg.scala 106:37]
  wire  _T_9 = io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h58; // @[CP0Reg.scala 108:16]
  wire  _GEN_6 = count_eq_compare | cp0_cause_ti; // @[CP0Reg.scala 110:32 111:18 105:33]
  reg [7:0] cp0_cause_ip; // @[CP0Reg.scala 114:29]
  wire  _cp0_cause_ip_T_1 = io_fromWriteBackStage_ext_int_in[5] | cp0_cause_ti; // @[CP0Reg.scala 116:20]
  wire [7:0] _cp0_cause_ip_T_4 = {_cp0_cause_ip_T_1,io_fromWriteBackStage_ext_int_in[4:0],cp0_cause_ip[1:0]}; // @[Cat.scala 33:92]
  wire [7:0] _cp0_cause_ip_T_7 = {cp0_cause_ip[7:2],io_fromWriteBackStage_cp0_wdata[9:8]}; // @[Cat.scala 33:92]
  reg [4:0] cp0_cause_excode; // @[CP0Reg.scala 128:33]
  wire [7:0] cp0_cause_lo = {1'h0,cp0_cause_excode,2'h0}; // @[Cat.scala 33:92]
  wire [23:0] cp0_cause_hi = {cp0_cause_bd,cp0_cause_ti,14'h0,cp0_cause_ip}; // @[Cat.scala 33:92]
  wire [31:0] cp0_cause = {cp0_cause_bd,cp0_cause_ti,14'h0,cp0_cause_ip,1'h0,cp0_cause_excode,2'h0}; // @[Cat.scala 33:92]
  reg [31:0] c0_epc; // @[CP0Reg.scala 144:23]
  wire [31:0] _c0_epc_T_1 = io_fromWriteBackStage_wb_pc - 32'h4; // @[CP0Reg.scala 146:32]
  reg [31:0] c0_badvaddr; // @[CP0Reg.scala 154:28]
  wire  excode_tlb = io_fromWriteBackStage_wb_excode == 5'h1 | io_fromWriteBackStage_wb_excode == 5'h2 |
    io_fromWriteBackStage_wb_excode == 5'h3; // @[CP0Reg.scala 156:55]
  wire  _T_20 = io_fromWriteBackStage_wb_ex & (io_fromWriteBackStage_wb_excode == 5'h4 | io_fromWriteBackStage_wb_excode
     == 5'h5 | excode_tlb); // @[CP0Reg.scala 158:11]
  reg  tick; // @[CP0Reg.scala 166:21]
  wire [31:0] _c0_count_T_1 = c0_count + 32'h1; // @[CP0Reg.scala 173:26]
  wire [31:0] _cp0_rdata_T_1 = 8'h60 == io_fromWriteBackStage_cp0_addr ? cp0_status : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _cp0_rdata_T_3 = 8'h68 == io_fromWriteBackStage_cp0_addr ? cp0_cause : _cp0_rdata_T_1; // @[Mux.scala 81:58]
  wire [31:0] _cp0_rdata_T_5 = 8'h70 == io_fromWriteBackStage_cp0_addr ? c0_epc : _cp0_rdata_T_3; // @[Mux.scala 81:58]
  wire [31:0] _cp0_rdata_T_7 = 8'h40 == io_fromWriteBackStage_cp0_addr ? c0_badvaddr : _cp0_rdata_T_5; // @[Mux.scala 81:58]
  wire [31:0] _cp0_rdata_T_9 = 8'h48 == io_fromWriteBackStage_cp0_addr ? c0_count : _cp0_rdata_T_7; // @[Mux.scala 81:58]
  wire [31:0] _cp0_rdata_T_11 = 8'h58 == io_fromWriteBackStage_cp0_addr ? c0_compare : _cp0_rdata_T_9; // @[Mux.scala 81:58]
  wire [31:0] _cp0_rdata_T_13 = 8'h50 == io_fromWriteBackStage_cp0_addr ? cp0_entryhi : _cp0_rdata_T_11; // @[Mux.scala 81:58]
  wire [31:0] _cp0_rdata_T_15 = 8'h10 == io_fromWriteBackStage_cp0_addr ? cp0_entrylo0 : _cp0_rdata_T_13; // @[Mux.scala 81:58]
  wire [31:0] _cp0_rdata_T_17 = 8'h18 == io_fromWriteBackStage_cp0_addr ? cp0_entrylo1 : _cp0_rdata_T_15; // @[Mux.scala 81:58]
  reg [18:0] entry_hi_vpn2; // @[CP0Reg.scala 204:30]
  wire  _T_27 = io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h50; // @[CP0Reg.scala 207:22]
  reg [7:0] entry_hi_asid; // @[CP0Reg.scala 213:30]
  wire [31:0] _cp0_entryhi_T = {entry_hi_vpn2,5'h0,entry_hi_asid}; // @[Cat.scala 33:92]
  reg [19:0] entrylo0_pfn; // @[CP0Reg.scala 227:29]
  wire  _T_31 = io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h10; // @[CP0Reg.scala 228:16]
  reg [2:0] entrylo0_c; // @[CP0Reg.scala 234:27]
  reg  entrylo0_d; // @[CP0Reg.scala 241:27]
  reg  entrylo0_v; // @[CP0Reg.scala 248:27]
  reg  entrylo0_g; // @[CP0Reg.scala 255:27]
  wire [31:0] _cp0_entrylo0_T = {6'h0,entrylo0_pfn,entrylo0_c,entrylo0_d,entrylo0_v,entrylo0_g}; // @[Cat.scala 33:92]
  reg [19:0] entrylo1_pfn; // @[CP0Reg.scala 272:29]
  wire  _T_41 = io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h18; // @[CP0Reg.scala 273:16]
  reg [2:0] entrylo1_c; // @[CP0Reg.scala 279:27]
  reg  entrylo1_d; // @[CP0Reg.scala 286:27]
  reg  entrylo1_v; // @[CP0Reg.scala 293:27]
  reg  entrylo1_g; // @[CP0Reg.scala 300:27]
  wire [31:0] _cp0_entrylo1_T = {6'h0,entrylo1_pfn,entrylo1_c,entrylo1_d,entrylo1_v,entrylo1_g}; // @[Cat.scala 33:92]
  reg  index_p; // @[CP0Reg.scala 317:24]
  reg [3:0] index_index; // @[CP0Reg.scala 322:28]
  wire [31:0] _cp0_index_T = {index_p,27'h0,index_index}; // @[Cat.scala 33:92]
  assign io_writeBackStage_cp0_rdata = 8'h0 == io_fromWriteBackStage_cp0_addr ? cp0_index : _cp0_rdata_T_17; // @[Mux.scala 81:58]
  assign io_writeBackStage_cp0_status = {cp0_status_hi,cp0_status_lo}; // @[Cat.scala 33:92]
  assign io_writeBackStage_cp0_cause = {cp0_cause_hi,cp0_cause_lo}; // @[Cat.scala 33:92]
  assign io_writeBackStage_cp0_epc = c0_epc; // @[CP0Reg.scala 151:11 46:26]
  assign io_writeBackStage_cp0_entryhi = cp0_entryhi; // @[CP0Reg.scala 61:34]
  assign io_writeBackStage_cp0_entrylo0 = cp0_entrylo0; // @[CP0Reg.scala 62:34]
  assign io_writeBackStage_cp0_entrylo1 = cp0_entrylo1; // @[CP0Reg.scala 63:34]
  assign io_writeBackStage_cp0_index = cp0_index; // @[CP0Reg.scala 64:34]
  always @(posedge clock) begin
    if (reset) begin // @[CP0Reg.scala 50:29]
      cp0_entryhi <= 32'h0; // @[CP0Reg.scala 50:29]
    end else begin
      cp0_entryhi <= _cp0_entryhi_T; // @[CP0Reg.scala 220:15]
    end
    if (reset) begin // @[CP0Reg.scala 51:29]
      cp0_entrylo0 <= 32'h0; // @[CP0Reg.scala 51:29]
    end else begin
      cp0_entrylo0 <= _cp0_entrylo0_T; // @[CP0Reg.scala 262:16]
    end
    if (reset) begin // @[CP0Reg.scala 52:29]
      cp0_entrylo1 <= 32'h0; // @[CP0Reg.scala 52:29]
    end else begin
      cp0_entrylo1 <= _cp0_entrylo1_T; // @[CP0Reg.scala 307:16]
    end
    if (reset) begin // @[CP0Reg.scala 53:29]
      cp0_index <= 32'h0; // @[CP0Reg.scala 53:29]
    end else begin
      cp0_index <= _cp0_index_T; // @[CP0Reg.scala 329:13]
    end
    if (reset) begin // @[CP0Reg.scala 69:30]
      cp0_status_im <= 8'h0; // @[CP0Reg.scala 69:30]
    end else if (io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h60) begin // @[CP0Reg.scala 70:49]
      cp0_status_im <= io_fromWriteBackStage_cp0_wdata[15:8]; // @[CP0Reg.scala 71:19]
    end
    if (reset) begin // @[CP0Reg.scala 74:31]
      cp0_status_exl <= 1'h0; // @[CP0Reg.scala 74:31]
    end else begin
      cp0_status_exl <= _GEN_3;
    end
    if (reset) begin // @[CP0Reg.scala 85:30]
      cp0_status_ie <= 1'h0; // @[CP0Reg.scala 85:30]
    end else if (_T_1) begin // @[CP0Reg.scala 86:51]
      cp0_status_ie <= io_fromWriteBackStage_cp0_wdata[0]; // @[CP0Reg.scala 87:19]
    end
    if (reset) begin // @[CP0Reg.scala 100:29]
      cp0_cause_bd <= 1'h0; // @[CP0Reg.scala 100:29]
    end else if (io_fromWriteBackStage_wb_ex & ~cp0_status_exl) begin // @[CP0Reg.scala 101:34]
      cp0_cause_bd <= io_fromWriteBackStage_wb_bd; // @[CP0Reg.scala 102:18]
    end
    if (reset) begin // @[CP0Reg.scala 105:33]
      cp0_cause_ti <= 1'h0; // @[CP0Reg.scala 105:33]
    end else if (io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h58) begin // @[CP0Reg.scala 108:49]
      cp0_cause_ti <= 1'h0; // @[CP0Reg.scala 109:18]
    end else begin
      cp0_cause_ti <= _GEN_6;
    end
    if (reset) begin // @[CP0Reg.scala 169:25]
      c0_count <= 32'h0; // @[CP0Reg.scala 169:25]
    end else if (io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h48) begin // @[CP0Reg.scala 170:48]
      c0_count <= io_fromWriteBackStage_cp0_wdata; // @[CP0Reg.scala 171:14]
    end else if (tick) begin // @[CP0Reg.scala 172:20]
      c0_count <= _c0_count_T_1; // @[CP0Reg.scala 173:14]
    end
    if (reset) begin // @[CP0Reg.scala 179:27]
      c0_compare <= 32'h0; // @[CP0Reg.scala 179:27]
    end else if (_T_9) begin // @[CP0Reg.scala 180:47]
      c0_compare <= io_fromWriteBackStage_cp0_wdata; // @[CP0Reg.scala 181:16]
    end
    if (reset) begin // @[CP0Reg.scala 114:29]
      cp0_cause_ip <= 8'h0; // @[CP0Reg.scala 114:29]
    end else if (io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h68) begin // @[CP0Reg.scala 121:48]
      cp0_cause_ip <= _cp0_cause_ip_T_7; // @[CP0Reg.scala 122:18]
    end else begin
      cp0_cause_ip <= _cp0_cause_ip_T_4; // @[CP0Reg.scala 115:16]
    end
    if (reset) begin // @[CP0Reg.scala 128:33]
      cp0_cause_excode <= 5'h0; // @[CP0Reg.scala 128:33]
    end else if (io_fromWriteBackStage_wb_ex) begin // @[CP0Reg.scala 129:15]
      cp0_cause_excode <= io_fromWriteBackStage_wb_excode; // @[CP0Reg.scala 130:22]
    end
    if (reset) begin // @[CP0Reg.scala 144:23]
      c0_epc <= 32'h0; // @[CP0Reg.scala 144:23]
    end else if (_T_7) begin // @[CP0Reg.scala 145:34]
      if (io_fromWriteBackStage_wb_bd) begin // @[CP0Reg.scala 146:18]
        c0_epc <= _c0_epc_T_1;
      end else begin
        c0_epc <= io_fromWriteBackStage_wb_pc;
      end
    end else if (io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h70) begin // @[CP0Reg.scala 147:52]
      c0_epc <= io_fromWriteBackStage_cp0_wdata; // @[CP0Reg.scala 148:12]
    end
    if (reset) begin // @[CP0Reg.scala 154:28]
      c0_badvaddr <= 32'h0; // @[CP0Reg.scala 154:28]
    end else if (_T_20) begin // @[CP0Reg.scala 159:5]
      c0_badvaddr <= io_fromWriteBackStage_wb_badvaddr; // @[CP0Reg.scala 160:17]
    end
    if (reset) begin // @[CP0Reg.scala 166:21]
      tick <= 1'h0; // @[CP0Reg.scala 166:21]
    end else begin
      tick <= ~tick; // @[CP0Reg.scala 167:8]
    end
    if (reset) begin // @[CP0Reg.scala 204:30]
      entry_hi_vpn2 <= 19'h0; // @[CP0Reg.scala 204:30]
    end else if (io_fromWriteBackStage_wb_ex & excode_tlb) begin // @[CP0Reg.scala 205:29]
      entry_hi_vpn2 <= io_fromWriteBackStage_wb_badvaddr[31:13]; // @[CP0Reg.scala 206:19]
    end else if (io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h50) begin // @[CP0Reg.scala 207:56]
      entry_hi_vpn2 <= io_fromWriteBackStage_cp0_wdata[31:13]; // @[CP0Reg.scala 208:19]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 209:20]
      entry_hi_vpn2 <= io_fromWriteBackStage_r_vpn2; // @[CP0Reg.scala 210:19]
    end
    if (reset) begin // @[CP0Reg.scala 213:30]
      entry_hi_asid <= 8'h0; // @[CP0Reg.scala 213:30]
    end else if (_T_27) begin // @[CP0Reg.scala 214:50]
      entry_hi_asid <= io_fromWriteBackStage_cp0_wdata[7:0]; // @[CP0Reg.scala 215:19]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 216:20]
      entry_hi_asid <= io_fromWriteBackStage_r_asid; // @[CP0Reg.scala 217:19]
    end
    if (reset) begin // @[CP0Reg.scala 227:29]
      entrylo0_pfn <= 20'h0; // @[CP0Reg.scala 227:29]
    end else if (io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h10) begin // @[CP0Reg.scala 228:51]
      entrylo0_pfn <= io_fromWriteBackStage_cp0_wdata[25:6]; // @[CP0Reg.scala 229:18]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 230:20]
      entrylo0_pfn <= io_fromWriteBackStage_r_pfn0; // @[CP0Reg.scala 231:18]
    end
    if (reset) begin // @[CP0Reg.scala 234:27]
      entrylo0_c <= 3'h0; // @[CP0Reg.scala 234:27]
    end else if (_T_31) begin // @[CP0Reg.scala 235:51]
      entrylo0_c <= io_fromWriteBackStage_cp0_wdata[5:3]; // @[CP0Reg.scala 236:16]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 237:20]
      entrylo0_c <= io_fromWriteBackStage_r_c0; // @[CP0Reg.scala 238:16]
    end
    if (reset) begin // @[CP0Reg.scala 241:27]
      entrylo0_d <= 1'h0; // @[CP0Reg.scala 241:27]
    end else if (_T_31) begin // @[CP0Reg.scala 242:51]
      entrylo0_d <= io_fromWriteBackStage_cp0_wdata[2]; // @[CP0Reg.scala 243:16]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 244:20]
      entrylo0_d <= io_fromWriteBackStage_r_d0; // @[CP0Reg.scala 245:16]
    end
    if (reset) begin // @[CP0Reg.scala 248:27]
      entrylo0_v <= 1'h0; // @[CP0Reg.scala 248:27]
    end else if (_T_31) begin // @[CP0Reg.scala 249:51]
      entrylo0_v <= io_fromWriteBackStage_cp0_wdata[1]; // @[CP0Reg.scala 250:16]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 251:20]
      entrylo0_v <= io_fromWriteBackStage_r_v0; // @[CP0Reg.scala 252:16]
    end
    if (reset) begin // @[CP0Reg.scala 255:27]
      entrylo0_g <= 1'h0; // @[CP0Reg.scala 255:27]
    end else if (_T_31) begin // @[CP0Reg.scala 256:51]
      entrylo0_g <= io_fromWriteBackStage_cp0_wdata[0]; // @[CP0Reg.scala 257:16]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 258:20]
      entrylo0_g <= io_fromWriteBackStage_r_g; // @[CP0Reg.scala 259:16]
    end
    if (reset) begin // @[CP0Reg.scala 272:29]
      entrylo1_pfn <= 20'h0; // @[CP0Reg.scala 272:29]
    end else if (io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h18) begin // @[CP0Reg.scala 273:51]
      entrylo1_pfn <= io_fromWriteBackStage_cp0_wdata[25:6]; // @[CP0Reg.scala 274:18]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 275:20]
      entrylo1_pfn <= io_fromWriteBackStage_r_pfn1; // @[CP0Reg.scala 276:18]
    end
    if (reset) begin // @[CP0Reg.scala 279:27]
      entrylo1_c <= 3'h0; // @[CP0Reg.scala 279:27]
    end else if (_T_41) begin // @[CP0Reg.scala 280:51]
      entrylo1_c <= io_fromWriteBackStage_cp0_wdata[5:3]; // @[CP0Reg.scala 281:16]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 282:20]
      entrylo1_c <= io_fromWriteBackStage_r_c1; // @[CP0Reg.scala 283:16]
    end
    if (reset) begin // @[CP0Reg.scala 286:27]
      entrylo1_d <= 1'h0; // @[CP0Reg.scala 286:27]
    end else if (_T_41) begin // @[CP0Reg.scala 287:51]
      entrylo1_d <= io_fromWriteBackStage_cp0_wdata[2]; // @[CP0Reg.scala 288:16]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 289:20]
      entrylo1_d <= io_fromWriteBackStage_r_d1; // @[CP0Reg.scala 290:16]
    end
    if (reset) begin // @[CP0Reg.scala 293:27]
      entrylo1_v <= 1'h0; // @[CP0Reg.scala 293:27]
    end else if (_T_41) begin // @[CP0Reg.scala 294:51]
      entrylo1_v <= io_fromWriteBackStage_cp0_wdata[1]; // @[CP0Reg.scala 295:16]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 296:20]
      entrylo1_v <= io_fromWriteBackStage_r_v1; // @[CP0Reg.scala 297:16]
    end
    if (reset) begin // @[CP0Reg.scala 300:27]
      entrylo1_g <= 1'h0; // @[CP0Reg.scala 300:27]
    end else if (_T_41) begin // @[CP0Reg.scala 301:51]
      entrylo1_g <= io_fromWriteBackStage_cp0_wdata[0]; // @[CP0Reg.scala 302:16]
    end else if (io_fromWriteBackStage_tlbr) begin // @[CP0Reg.scala 303:20]
      entrylo1_g <= io_fromWriteBackStage_r_g; // @[CP0Reg.scala 304:16]
    end
    if (reset) begin // @[CP0Reg.scala 317:24]
      index_p <= 1'h0; // @[CP0Reg.scala 317:24]
    end else if (io_fromWriteBackStage_tlbp) begin // @[CP0Reg.scala 318:14]
      index_p <= ~io_fromWriteBackStage_s1_found; // @[CP0Reg.scala 319:13]
    end
    if (reset) begin // @[CP0Reg.scala 322:28]
      index_index <= 4'h0; // @[CP0Reg.scala 322:28]
    end else if (io_fromWriteBackStage_mtc0_we & io_fromWriteBackStage_cp0_addr == 8'h0) begin // @[CP0Reg.scala 323:48]
      index_index <= io_fromWriteBackStage_cp0_wdata[3:0]; // @[CP0Reg.scala 324:17]
    end else if (io_fromWriteBackStage_tlbp) begin // @[CP0Reg.scala 325:20]
      index_index <= io_fromWriteBackStage_s1_index; // @[CP0Reg.scala 326:17]
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
  cp0_entryhi = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  cp0_entrylo0 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  cp0_entrylo1 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  cp0_index = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  cp0_status_im = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  cp0_status_exl = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  cp0_status_ie = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  cp0_cause_bd = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  cp0_cause_ti = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  c0_count = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  c0_compare = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  cp0_cause_ip = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  cp0_cause_excode = _RAND_12[4:0];
  _RAND_13 = {1{`RANDOM}};
  c0_epc = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  c0_badvaddr = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  tick = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  entry_hi_vpn2 = _RAND_16[18:0];
  _RAND_17 = {1{`RANDOM}};
  entry_hi_asid = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  entrylo0_pfn = _RAND_18[19:0];
  _RAND_19 = {1{`RANDOM}};
  entrylo0_c = _RAND_19[2:0];
  _RAND_20 = {1{`RANDOM}};
  entrylo0_d = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  entrylo0_v = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  entrylo0_g = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  entrylo1_pfn = _RAND_23[19:0];
  _RAND_24 = {1{`RANDOM}};
  entrylo1_c = _RAND_24[2:0];
  _RAND_25 = {1{`RANDOM}};
  entrylo1_d = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  entrylo1_v = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  entrylo1_g = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  index_p = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  index_index = _RAND_29[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InstMMU(
  input  [31:0] io_fromPreFetchStage_vaddr,
  input  [31:0] io_fromWriteBackStage_cp0_entryhi,
  input         io_fromTLB_tlb_found,
  input  [19:0] io_fromTLB_tlb_pfn,
  input         io_fromTLB_tlb_v,
  output        io_preFetchStage_tlb_refill,
  output        io_preFetchStage_tlb_invalid,
  output [31:0] io_instMemory_paddr,
  output [18:0] io_tlb_tlb_vpn2,
  output        io_tlb_tlb_odd_page,
  output [7:0]  io_tlb_tlb_asid
);
  wire  unmapped = io_fromPreFetchStage_vaddr[31] & ~io_fromPreFetchStage_vaddr[30]; // @[InstMMU.scala 44:25]
  wire [31:0] _paddr_T_1 = {3'h0,io_fromPreFetchStage_vaddr[28:0]}; // @[Cat.scala 33:92]
  wire [31:0] _paddr_T_3 = {io_fromTLB_tlb_pfn,io_fromPreFetchStage_vaddr[11:0]}; // @[Cat.scala 33:92]
  wire  _tlb_refill_T = ~unmapped; // @[InstMMU.scala 56:19]
  assign io_preFetchStage_tlb_refill = ~unmapped & ~io_fromTLB_tlb_found; // @[InstMMU.scala 56:29]
  assign io_preFetchStage_tlb_invalid = _tlb_refill_T & io_fromTLB_tlb_found & ~io_fromTLB_tlb_v; // @[InstMMU.scala 57:42]
  assign io_instMemory_paddr = unmapped ? _paddr_T_1 : _paddr_T_3; // @[InstMMU.scala 50:15]
  assign io_tlb_tlb_vpn2 = io_fromPreFetchStage_vaddr[31:13]; // @[InstMMU.scala 46:60]
  assign io_tlb_tlb_odd_page = io_fromPreFetchStage_vaddr[12]; // @[InstMMU.scala 47:24]
  assign io_tlb_tlb_asid = io_fromWriteBackStage_cp0_entryhi[7:0]; // @[InstMMU.scala 48:30]
endmodule
module DataMMU(
  input  [31:0] io_fromWriteBackStage_cp0_entryhi,
  input         io_fromTLB_tlb_found,
  input  [19:0] io_fromTLB_tlb_pfn,
  input         io_fromTLB_tlb_d,
  input         io_fromTLB_tlb_v,
  input  [31:0] io_fromExecute_vaddr,
  input         io_fromExecute_inst_is_tlbp,
  output        io_execute_tlb_refill,
  output        io_execute_tlb_invalid,
  output        io_execute_tlb_modified,
  output [31:0] io_dataMemory_paddr,
  output [18:0] io_tlb_tlb_vpn2,
  output        io_tlb_tlb_odd_page,
  output [7:0]  io_tlb_tlb_asid
);
  wire  unmapped = io_fromExecute_vaddr[31] & ~io_fromExecute_vaddr[30]; // @[DataMMU.scala 44:25]
  wire [31:0] _paddr_T_1 = {3'h0,io_fromExecute_vaddr[28:0]}; // @[Cat.scala 33:92]
  wire [31:0] _paddr_T_3 = {io_fromTLB_tlb_pfn,io_fromExecute_vaddr[11:0]}; // @[Cat.scala 33:92]
  wire  _tlb_refill_T = ~unmapped; // @[DataMMU.scala 56:19]
  wire  _tlb_invalid_T_1 = _tlb_refill_T & io_fromTLB_tlb_found; // @[DataMMU.scala 57:29]
  assign io_execute_tlb_refill = ~unmapped & ~io_fromTLB_tlb_found; // @[DataMMU.scala 56:29]
  assign io_execute_tlb_invalid = _tlb_refill_T & io_fromTLB_tlb_found & ~io_fromTLB_tlb_v; // @[DataMMU.scala 57:42]
  assign io_execute_tlb_modified = _tlb_invalid_T_1 & io_fromTLB_tlb_v & ~io_fromTLB_tlb_d; // @[DataMMU.scala 58:51]
  assign io_dataMemory_paddr = unmapped ? _paddr_T_1 : _paddr_T_3; // @[DataMMU.scala 50:15]
  assign io_tlb_tlb_vpn2 = io_fromExecute_inst_is_tlbp ? io_fromWriteBackStage_cp0_entryhi[31:13] : io_fromExecute_vaddr
    [31:13]; // @[DataMMU.scala 46:22]
  assign io_tlb_tlb_odd_page = io_fromExecute_vaddr[12]; // @[DataMMU.scala 47:24]
  assign io_tlb_tlb_asid = io_fromWriteBackStage_cp0_entryhi[7:0]; // @[DataMMU.scala 48:30]
endmodule
module Ctrl(
  input  [1:0]  io_fromInstMemory_inst_sram_discard,
  input  [1:0]  io_fromDataMemory_data_sram_discard,
  input         io_fromFetchStage_ex,
  input         io_fromDecoder_ex,
  input         io_fromExecute_ex,
  input         io_fromMemory_ex,
  input         io_fromWriteBackStage_ex,
  input         io_fromWriteBackStage_do_flush,
  input  [31:0] io_fromWriteBackStage_flush_pc,
  output        io_preFetchStage_after_ex,
  output        io_preFetchStage_do_flush,
  output [31:0] io_preFetchStage_flush_pc,
  output        io_preFetchStage_block,
  output        io_fetchStage_do_flush,
  output        io_decoderStage_do_flush,
  output        io_executeStage_do_flush,
  output        io_executeStage_after_ex,
  output        io_memoryStage_do_flush,
  output        io_instMemory_do_flush,
  output        io_dataMemory_do_flush
);
  assign io_preFetchStage_after_ex = io_fromFetchStage_ex | io_fromDecoder_ex | io_fromExecute_ex | io_fromMemory_ex |
    io_fromWriteBackStage_ex; // @[Ctrl.scala 43:65]
  assign io_preFetchStage_do_flush = io_fromWriteBackStage_do_flush; // @[Ctrl.scala 44:29]
  assign io_preFetchStage_flush_pc = io_fromWriteBackStage_flush_pc; // @[Ctrl.scala 45:29]
  assign io_preFetchStage_block = |io_fromInstMemory_inst_sram_discard | |io_fromDataMemory_data_sram_discard; // @[Ctrl.scala 42:54]
  assign io_fetchStage_do_flush = io_fromWriteBackStage_do_flush; // @[Ctrl.scala 48:26]
  assign io_decoderStage_do_flush = io_fromWriteBackStage_do_flush; // @[Ctrl.scala 50:28]
  assign io_executeStage_do_flush = io_fromWriteBackStage_do_flush; // @[Ctrl.scala 53:28]
  assign io_executeStage_after_ex = io_fromMemory_ex | io_fromWriteBackStage_ex; // @[Ctrl.scala 54:37]
  assign io_memoryStage_do_flush = io_fromWriteBackStage_do_flush; // @[Ctrl.scala 56:27]
  assign io_instMemory_do_flush = io_fromWriteBackStage_do_flush; // @[Ctrl.scala 40:26]
  assign io_dataMemory_do_flush = io_fromWriteBackStage_do_flush; // @[Ctrl.scala 39:26]
endmodule
module TLB(
  input         clock,
  input         reset,
  input  [18:0] io_fromInstMMU_tlb_vpn2,
  input         io_fromInstMMU_tlb_odd_page,
  input  [7:0]  io_fromInstMMU_tlb_asid,
  input  [18:0] io_fromDataMMU_tlb_vpn2,
  input         io_fromDataMMU_tlb_odd_page,
  input  [7:0]  io_fromDataMMU_tlb_asid,
  input         io_fromWriteBackStage_we,
  input  [3:0]  io_fromWriteBackStage_w_index,
  input  [18:0] io_fromWriteBackStage_w_vpn2,
  input  [7:0]  io_fromWriteBackStage_w_asid,
  input         io_fromWriteBackStage_w_g,
  input  [19:0] io_fromWriteBackStage_w_pfn0,
  input  [2:0]  io_fromWriteBackStage_w_c0,
  input         io_fromWriteBackStage_w_d0,
  input         io_fromWriteBackStage_w_v0,
  input  [19:0] io_fromWriteBackStage_w_pfn1,
  input  [2:0]  io_fromWriteBackStage_w_c1,
  input         io_fromWriteBackStage_w_d1,
  input         io_fromWriteBackStage_w_v1,
  input  [3:0]  io_fromWriteBackStage_r_index,
  output        io_instMMU_tlb_found,
  output [19:0] io_instMMU_tlb_pfn,
  output        io_instMMU_tlb_v,
  output        io_dataMMU_tlb_found,
  output [19:0] io_dataMMU_tlb_pfn,
  output        io_dataMMU_tlb_d,
  output        io_dataMMU_tlb_v,
  output        io_execute_s1_found,
  output [3:0]  io_execute_s1_index,
  output [18:0] io_writeBackStage_r_vpn2,
  output [7:0]  io_writeBackStage_r_asid,
  output        io_writeBackStage_r_g,
  output [19:0] io_writeBackStage_r_pfn0,
  output [2:0]  io_writeBackStage_r_c0,
  output        io_writeBackStage_r_d0,
  output        io_writeBackStage_r_v0,
  output [19:0] io_writeBackStage_r_pfn1,
  output [2:0]  io_writeBackStage_r_c1,
  output        io_writeBackStage_r_d1,
  output        io_writeBackStage_r_v1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_175;
`endif // RANDOMIZE_REG_INIT
  reg [18:0] tlb_vpn2_0; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_1; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_2; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_3; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_4; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_5; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_6; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_7; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_8; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_9; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_10; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_11; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_12; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_13; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_14; // @[TLB.scala 101:25]
  reg [18:0] tlb_vpn2_15; // @[TLB.scala 101:25]
  reg [7:0] tlb_asid_0; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_1; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_2; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_3; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_4; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_5; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_6; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_7; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_8; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_9; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_10; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_11; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_12; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_13; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_14; // @[TLB.scala 102:25]
  reg [7:0] tlb_asid_15; // @[TLB.scala 102:25]
  reg  tlb_g_0; // @[TLB.scala 103:25]
  reg  tlb_g_1; // @[TLB.scala 103:25]
  reg  tlb_g_2; // @[TLB.scala 103:25]
  reg  tlb_g_3; // @[TLB.scala 103:25]
  reg  tlb_g_4; // @[TLB.scala 103:25]
  reg  tlb_g_5; // @[TLB.scala 103:25]
  reg  tlb_g_6; // @[TLB.scala 103:25]
  reg  tlb_g_7; // @[TLB.scala 103:25]
  reg  tlb_g_8; // @[TLB.scala 103:25]
  reg  tlb_g_9; // @[TLB.scala 103:25]
  reg  tlb_g_10; // @[TLB.scala 103:25]
  reg  tlb_g_11; // @[TLB.scala 103:25]
  reg  tlb_g_12; // @[TLB.scala 103:25]
  reg  tlb_g_13; // @[TLB.scala 103:25]
  reg  tlb_g_14; // @[TLB.scala 103:25]
  reg  tlb_g_15; // @[TLB.scala 103:25]
  reg [19:0] tlb_pfn0_0; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_1; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_2; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_3; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_4; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_5; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_6; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_7; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_8; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_9; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_10; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_11; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_12; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_13; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_14; // @[TLB.scala 104:25]
  reg [19:0] tlb_pfn0_15; // @[TLB.scala 104:25]
  reg [2:0] tlb_c0_0; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_1; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_2; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_3; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_4; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_5; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_6; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_7; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_8; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_9; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_10; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_11; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_12; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_13; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_14; // @[TLB.scala 105:25]
  reg [2:0] tlb_c0_15; // @[TLB.scala 105:25]
  reg  tlb_d0_0; // @[TLB.scala 106:25]
  reg  tlb_d0_1; // @[TLB.scala 106:25]
  reg  tlb_d0_2; // @[TLB.scala 106:25]
  reg  tlb_d0_3; // @[TLB.scala 106:25]
  reg  tlb_d0_4; // @[TLB.scala 106:25]
  reg  tlb_d0_5; // @[TLB.scala 106:25]
  reg  tlb_d0_6; // @[TLB.scala 106:25]
  reg  tlb_d0_7; // @[TLB.scala 106:25]
  reg  tlb_d0_8; // @[TLB.scala 106:25]
  reg  tlb_d0_9; // @[TLB.scala 106:25]
  reg  tlb_d0_10; // @[TLB.scala 106:25]
  reg  tlb_d0_11; // @[TLB.scala 106:25]
  reg  tlb_d0_12; // @[TLB.scala 106:25]
  reg  tlb_d0_13; // @[TLB.scala 106:25]
  reg  tlb_d0_14; // @[TLB.scala 106:25]
  reg  tlb_d0_15; // @[TLB.scala 106:25]
  reg  tlb_v0_0; // @[TLB.scala 107:25]
  reg  tlb_v0_1; // @[TLB.scala 107:25]
  reg  tlb_v0_2; // @[TLB.scala 107:25]
  reg  tlb_v0_3; // @[TLB.scala 107:25]
  reg  tlb_v0_4; // @[TLB.scala 107:25]
  reg  tlb_v0_5; // @[TLB.scala 107:25]
  reg  tlb_v0_6; // @[TLB.scala 107:25]
  reg  tlb_v0_7; // @[TLB.scala 107:25]
  reg  tlb_v0_8; // @[TLB.scala 107:25]
  reg  tlb_v0_9; // @[TLB.scala 107:25]
  reg  tlb_v0_10; // @[TLB.scala 107:25]
  reg  tlb_v0_11; // @[TLB.scala 107:25]
  reg  tlb_v0_12; // @[TLB.scala 107:25]
  reg  tlb_v0_13; // @[TLB.scala 107:25]
  reg  tlb_v0_14; // @[TLB.scala 107:25]
  reg  tlb_v0_15; // @[TLB.scala 107:25]
  reg [19:0] tlb_pfn1_0; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_1; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_2; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_3; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_4; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_5; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_6; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_7; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_8; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_9; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_10; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_11; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_12; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_13; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_14; // @[TLB.scala 108:25]
  reg [19:0] tlb_pfn1_15; // @[TLB.scala 108:25]
  reg [2:0] tlb_c1_0; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_1; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_2; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_3; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_4; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_5; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_6; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_7; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_8; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_9; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_10; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_11; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_12; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_13; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_14; // @[TLB.scala 109:25]
  reg [2:0] tlb_c1_15; // @[TLB.scala 109:25]
  reg  tlb_d1_0; // @[TLB.scala 110:25]
  reg  tlb_d1_1; // @[TLB.scala 110:25]
  reg  tlb_d1_2; // @[TLB.scala 110:25]
  reg  tlb_d1_3; // @[TLB.scala 110:25]
  reg  tlb_d1_4; // @[TLB.scala 110:25]
  reg  tlb_d1_5; // @[TLB.scala 110:25]
  reg  tlb_d1_6; // @[TLB.scala 110:25]
  reg  tlb_d1_7; // @[TLB.scala 110:25]
  reg  tlb_d1_8; // @[TLB.scala 110:25]
  reg  tlb_d1_9; // @[TLB.scala 110:25]
  reg  tlb_d1_10; // @[TLB.scala 110:25]
  reg  tlb_d1_11; // @[TLB.scala 110:25]
  reg  tlb_d1_12; // @[TLB.scala 110:25]
  reg  tlb_d1_13; // @[TLB.scala 110:25]
  reg  tlb_d1_14; // @[TLB.scala 110:25]
  reg  tlb_d1_15; // @[TLB.scala 110:25]
  reg  tlb_v1_0; // @[TLB.scala 111:25]
  reg  tlb_v1_1; // @[TLB.scala 111:25]
  reg  tlb_v1_2; // @[TLB.scala 111:25]
  reg  tlb_v1_3; // @[TLB.scala 111:25]
  reg  tlb_v1_4; // @[TLB.scala 111:25]
  reg  tlb_v1_5; // @[TLB.scala 111:25]
  reg  tlb_v1_6; // @[TLB.scala 111:25]
  reg  tlb_v1_7; // @[TLB.scala 111:25]
  reg  tlb_v1_8; // @[TLB.scala 111:25]
  reg  tlb_v1_9; // @[TLB.scala 111:25]
  reg  tlb_v1_10; // @[TLB.scala 111:25]
  reg  tlb_v1_11; // @[TLB.scala 111:25]
  reg  tlb_v1_12; // @[TLB.scala 111:25]
  reg  tlb_v1_13; // @[TLB.scala 111:25]
  reg  tlb_v1_14; // @[TLB.scala 111:25]
  reg  tlb_v1_15; // @[TLB.scala 111:25]
  wire  _match0_1_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_1 | tlb_g_1; // @[TLB.scala 140:38]
  wire  match0_1 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_1 & _match0_1_T_2; // @[TLB.scala 139:52]
  wire  _match0_0_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_0 | tlb_g_0; // @[TLB.scala 140:38]
  wire  match0_0 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_0 & _match0_0_T_2; // @[TLB.scala 139:52]
  wire  _match0_3_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_3 | tlb_g_3; // @[TLB.scala 140:38]
  wire  match0_3 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_3 & _match0_3_T_2; // @[TLB.scala 139:52]
  wire  _match0_2_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_2 | tlb_g_2; // @[TLB.scala 140:38]
  wire  match0_2 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_2 & _match0_2_T_2; // @[TLB.scala 139:52]
  wire  _match0_5_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_5 | tlb_g_5; // @[TLB.scala 140:38]
  wire  match0_5 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_5 & _match0_5_T_2; // @[TLB.scala 139:52]
  wire  _match0_4_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_4 | tlb_g_4; // @[TLB.scala 140:38]
  wire  match0_4 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_4 & _match0_4_T_2; // @[TLB.scala 139:52]
  wire  _match0_7_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_7 | tlb_g_7; // @[TLB.scala 140:38]
  wire  match0_7 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_7 & _match0_7_T_2; // @[TLB.scala 139:52]
  wire  _match0_6_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_6 | tlb_g_6; // @[TLB.scala 140:38]
  wire  match0_6 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_6 & _match0_6_T_2; // @[TLB.scala 139:52]
  wire [7:0] s0_found_lo = {match0_7,match0_6,match0_5,match0_4,match0_3,match0_2,match0_1,match0_0}; // @[TLB.scala 120:22]
  wire  _match0_9_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_9 | tlb_g_9; // @[TLB.scala 140:38]
  wire  match0_9 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_9 & _match0_9_T_2; // @[TLB.scala 139:52]
  wire  _match0_8_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_8 | tlb_g_8; // @[TLB.scala 140:38]
  wire  match0_8 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_8 & _match0_8_T_2; // @[TLB.scala 139:52]
  wire  _match0_11_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_11 | tlb_g_11; // @[TLB.scala 140:38]
  wire  match0_11 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_11 & _match0_11_T_2; // @[TLB.scala 139:52]
  wire  _match0_10_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_10 | tlb_g_10; // @[TLB.scala 140:38]
  wire  match0_10 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_10 & _match0_10_T_2; // @[TLB.scala 139:52]
  wire  _match0_13_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_13 | tlb_g_13; // @[TLB.scala 140:38]
  wire  match0_13 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_13 & _match0_13_T_2; // @[TLB.scala 139:52]
  wire  _match0_12_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_12 | tlb_g_12; // @[TLB.scala 140:38]
  wire  match0_12 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_12 & _match0_12_T_2; // @[TLB.scala 139:52]
  wire  _match0_15_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_15 | tlb_g_15; // @[TLB.scala 140:38]
  wire  match0_15 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_15 & _match0_15_T_2; // @[TLB.scala 139:52]
  wire  _match0_14_T_2 = io_fromInstMMU_tlb_asid == tlb_asid_14 | tlb_g_14; // @[TLB.scala 140:38]
  wire  match0_14 = io_fromInstMMU_tlb_vpn2 == tlb_vpn2_14 & _match0_14_T_2; // @[TLB.scala 139:52]
  wire [15:0] _s0_found_T = {match0_15,match0_14,match0_13,match0_12,match0_11,match0_10,match0_9,match0_8,s0_found_lo}; // @[TLB.scala 120:22]
  wire  _match1_1_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_1 | tlb_g_1; // @[TLB.scala 142:38]
  wire  match1_1 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_1 & _match1_1_T_2; // @[TLB.scala 141:52]
  wire  _match1_0_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_0 | tlb_g_0; // @[TLB.scala 142:38]
  wire  match1_0 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_0 & _match1_0_T_2; // @[TLB.scala 141:52]
  wire  _match1_3_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_3 | tlb_g_3; // @[TLB.scala 142:38]
  wire  match1_3 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_3 & _match1_3_T_2; // @[TLB.scala 141:52]
  wire  _match1_2_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_2 | tlb_g_2; // @[TLB.scala 142:38]
  wire  match1_2 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_2 & _match1_2_T_2; // @[TLB.scala 141:52]
  wire  _match1_5_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_5 | tlb_g_5; // @[TLB.scala 142:38]
  wire  match1_5 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_5 & _match1_5_T_2; // @[TLB.scala 141:52]
  wire  _match1_4_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_4 | tlb_g_4; // @[TLB.scala 142:38]
  wire  match1_4 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_4 & _match1_4_T_2; // @[TLB.scala 141:52]
  wire  _match1_7_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_7 | tlb_g_7; // @[TLB.scala 142:38]
  wire  match1_7 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_7 & _match1_7_T_2; // @[TLB.scala 141:52]
  wire  _match1_6_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_6 | tlb_g_6; // @[TLB.scala 142:38]
  wire  match1_6 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_6 & _match1_6_T_2; // @[TLB.scala 141:52]
  wire [7:0] s1_found_lo = {match1_7,match1_6,match1_5,match1_4,match1_3,match1_2,match1_1,match1_0}; // @[TLB.scala 121:22]
  wire  _match1_9_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_9 | tlb_g_9; // @[TLB.scala 142:38]
  wire  match1_9 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_9 & _match1_9_T_2; // @[TLB.scala 141:52]
  wire  _match1_8_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_8 | tlb_g_8; // @[TLB.scala 142:38]
  wire  match1_8 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_8 & _match1_8_T_2; // @[TLB.scala 141:52]
  wire  _match1_11_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_11 | tlb_g_11; // @[TLB.scala 142:38]
  wire  match1_11 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_11 & _match1_11_T_2; // @[TLB.scala 141:52]
  wire  _match1_10_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_10 | tlb_g_10; // @[TLB.scala 142:38]
  wire  match1_10 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_10 & _match1_10_T_2; // @[TLB.scala 141:52]
  wire  _match1_13_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_13 | tlb_g_13; // @[TLB.scala 142:38]
  wire  match1_13 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_13 & _match1_13_T_2; // @[TLB.scala 141:52]
  wire  _match1_12_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_12 | tlb_g_12; // @[TLB.scala 142:38]
  wire  match1_12 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_12 & _match1_12_T_2; // @[TLB.scala 141:52]
  wire  _match1_15_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_15 | tlb_g_15; // @[TLB.scala 142:38]
  wire  match1_15 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_15 & _match1_15_T_2; // @[TLB.scala 141:52]
  wire  _match1_14_T_2 = io_fromDataMMU_tlb_asid == tlb_asid_14 | tlb_g_14; // @[TLB.scala 142:38]
  wire  match1_14 = io_fromDataMMU_tlb_vpn2 == tlb_vpn2_14 & _match1_14_T_2; // @[TLB.scala 141:52]
  wire [15:0] _s1_found_T = {match1_15,match1_14,match1_13,match1_12,match1_11,match1_10,match1_9,match1_8,s1_found_lo}; // @[TLB.scala 121:22]
  wire [3:0] s0_index_arr_1 = {{3'd0}, match0_1}; // @[TLB.scala 148:54]
  wire [1:0] _s0_index_arr_2_T = match0_2 ? 2'h2 : 2'h0; // @[TLB.scala 149:12]
  wire [3:0] _GEN_608 = {{2'd0}, _s0_index_arr_2_T}; // @[TLB.scala 148:54]
  wire [3:0] s0_index_arr_2 = s0_index_arr_1 | _GEN_608; // @[TLB.scala 148:54]
  wire [1:0] _s0_index_arr_3_T = match0_3 ? 2'h3 : 2'h0; // @[TLB.scala 149:12]
  wire [3:0] _GEN_609 = {{2'd0}, _s0_index_arr_3_T}; // @[TLB.scala 148:54]
  wire [3:0] s0_index_arr_3 = s0_index_arr_2 | _GEN_609; // @[TLB.scala 148:54]
  wire [2:0] _s0_index_arr_4_T = match0_4 ? 3'h4 : 3'h0; // @[TLB.scala 149:12]
  wire [3:0] _GEN_610 = {{1'd0}, _s0_index_arr_4_T}; // @[TLB.scala 148:54]
  wire [3:0] s0_index_arr_4 = s0_index_arr_3 | _GEN_610; // @[TLB.scala 148:54]
  wire [2:0] _s0_index_arr_5_T = match0_5 ? 3'h5 : 3'h0; // @[TLB.scala 149:12]
  wire [3:0] _GEN_611 = {{1'd0}, _s0_index_arr_5_T}; // @[TLB.scala 148:54]
  wire [3:0] s0_index_arr_5 = s0_index_arr_4 | _GEN_611; // @[TLB.scala 148:54]
  wire [2:0] _s0_index_arr_6_T = match0_6 ? 3'h6 : 3'h0; // @[TLB.scala 149:12]
  wire [3:0] _GEN_612 = {{1'd0}, _s0_index_arr_6_T}; // @[TLB.scala 148:54]
  wire [3:0] s0_index_arr_6 = s0_index_arr_5 | _GEN_612; // @[TLB.scala 148:54]
  wire [2:0] _s0_index_arr_7_T = match0_7 ? 3'h7 : 3'h0; // @[TLB.scala 149:12]
  wire [3:0] _GEN_613 = {{1'd0}, _s0_index_arr_7_T}; // @[TLB.scala 148:54]
  wire [3:0] s0_index_arr_7 = s0_index_arr_6 | _GEN_613; // @[TLB.scala 148:54]
  wire [3:0] _s0_index_arr_8_T = match0_8 ? 4'h8 : 4'h0; // @[TLB.scala 149:12]
  wire [3:0] s0_index_arr_8 = s0_index_arr_7 | _s0_index_arr_8_T; // @[TLB.scala 148:54]
  wire [3:0] _s0_index_arr_9_T = match0_9 ? 4'h9 : 4'h0; // @[TLB.scala 149:12]
  wire [3:0] s0_index_arr_9 = s0_index_arr_8 | _s0_index_arr_9_T; // @[TLB.scala 148:54]
  wire [3:0] _s0_index_arr_10_T = match0_10 ? 4'ha : 4'h0; // @[TLB.scala 149:12]
  wire [3:0] s0_index_arr_10 = s0_index_arr_9 | _s0_index_arr_10_T; // @[TLB.scala 148:54]
  wire [3:0] _s0_index_arr_11_T = match0_11 ? 4'hb : 4'h0; // @[TLB.scala 149:12]
  wire [3:0] s0_index_arr_11 = s0_index_arr_10 | _s0_index_arr_11_T; // @[TLB.scala 148:54]
  wire [3:0] _s0_index_arr_12_T = match0_12 ? 4'hc : 4'h0; // @[TLB.scala 149:12]
  wire [3:0] s0_index_arr_12 = s0_index_arr_11 | _s0_index_arr_12_T; // @[TLB.scala 148:54]
  wire [3:0] _s0_index_arr_13_T = match0_13 ? 4'hd : 4'h0; // @[TLB.scala 149:12]
  wire [3:0] s0_index_arr_13 = s0_index_arr_12 | _s0_index_arr_13_T; // @[TLB.scala 148:54]
  wire [3:0] _s0_index_arr_14_T = match0_14 ? 4'he : 4'h0; // @[TLB.scala 149:12]
  wire [3:0] s0_index_arr_14 = s0_index_arr_13 | _s0_index_arr_14_T; // @[TLB.scala 148:54]
  wire [3:0] _s0_index_arr_15_T = match0_15 ? 4'hf : 4'h0; // @[TLB.scala 149:12]
  wire [3:0] s0_index_arr_15 = s0_index_arr_14 | _s0_index_arr_15_T; // @[TLB.scala 148:54]
  wire [19:0] _GEN_1 = 4'h1 == s0_index_arr_15 ? tlb_pfn1_1 : tlb_pfn1_0; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_2 = 4'h2 == s0_index_arr_15 ? tlb_pfn1_2 : _GEN_1; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_3 = 4'h3 == s0_index_arr_15 ? tlb_pfn1_3 : _GEN_2; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_4 = 4'h4 == s0_index_arr_15 ? tlb_pfn1_4 : _GEN_3; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_5 = 4'h5 == s0_index_arr_15 ? tlb_pfn1_5 : _GEN_4; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_6 = 4'h6 == s0_index_arr_15 ? tlb_pfn1_6 : _GEN_5; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_7 = 4'h7 == s0_index_arr_15 ? tlb_pfn1_7 : _GEN_6; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_8 = 4'h8 == s0_index_arr_15 ? tlb_pfn1_8 : _GEN_7; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_9 = 4'h9 == s0_index_arr_15 ? tlb_pfn1_9 : _GEN_8; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_10 = 4'ha == s0_index_arr_15 ? tlb_pfn1_10 : _GEN_9; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_11 = 4'hb == s0_index_arr_15 ? tlb_pfn1_11 : _GEN_10; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_12 = 4'hc == s0_index_arr_15 ? tlb_pfn1_12 : _GEN_11; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_13 = 4'hd == s0_index_arr_15 ? tlb_pfn1_13 : _GEN_12; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_14 = 4'he == s0_index_arr_15 ? tlb_pfn1_14 : _GEN_13; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_15 = 4'hf == s0_index_arr_15 ? tlb_pfn1_15 : _GEN_14; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_17 = 4'h1 == s0_index_arr_15 ? tlb_pfn0_1 : tlb_pfn0_0; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_18 = 4'h2 == s0_index_arr_15 ? tlb_pfn0_2 : _GEN_17; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_19 = 4'h3 == s0_index_arr_15 ? tlb_pfn0_3 : _GEN_18; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_20 = 4'h4 == s0_index_arr_15 ? tlb_pfn0_4 : _GEN_19; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_21 = 4'h5 == s0_index_arr_15 ? tlb_pfn0_5 : _GEN_20; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_22 = 4'h6 == s0_index_arr_15 ? tlb_pfn0_6 : _GEN_21; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_23 = 4'h7 == s0_index_arr_15 ? tlb_pfn0_7 : _GEN_22; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_24 = 4'h8 == s0_index_arr_15 ? tlb_pfn0_8 : _GEN_23; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_25 = 4'h9 == s0_index_arr_15 ? tlb_pfn0_9 : _GEN_24; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_26 = 4'ha == s0_index_arr_15 ? tlb_pfn0_10 : _GEN_25; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_27 = 4'hb == s0_index_arr_15 ? tlb_pfn0_11 : _GEN_26; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_28 = 4'hc == s0_index_arr_15 ? tlb_pfn0_12 : _GEN_27; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_29 = 4'hd == s0_index_arr_15 ? tlb_pfn0_13 : _GEN_28; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_30 = 4'he == s0_index_arr_15 ? tlb_pfn0_14 : _GEN_29; // @[TLB.scala 126:{16,16}]
  wire [19:0] _GEN_31 = 4'hf == s0_index_arr_15 ? tlb_pfn0_15 : _GEN_30; // @[TLB.scala 126:{16,16}]
  wire  _GEN_97 = 4'h1 == s0_index_arr_15 ? tlb_v1_1 : tlb_v1_0; // @[TLB.scala 129:{16,16}]
  wire  _GEN_98 = 4'h2 == s0_index_arr_15 ? tlb_v1_2 : _GEN_97; // @[TLB.scala 129:{16,16}]
  wire  _GEN_99 = 4'h3 == s0_index_arr_15 ? tlb_v1_3 : _GEN_98; // @[TLB.scala 129:{16,16}]
  wire  _GEN_100 = 4'h4 == s0_index_arr_15 ? tlb_v1_4 : _GEN_99; // @[TLB.scala 129:{16,16}]
  wire  _GEN_101 = 4'h5 == s0_index_arr_15 ? tlb_v1_5 : _GEN_100; // @[TLB.scala 129:{16,16}]
  wire  _GEN_102 = 4'h6 == s0_index_arr_15 ? tlb_v1_6 : _GEN_101; // @[TLB.scala 129:{16,16}]
  wire  _GEN_103 = 4'h7 == s0_index_arr_15 ? tlb_v1_7 : _GEN_102; // @[TLB.scala 129:{16,16}]
  wire  _GEN_104 = 4'h8 == s0_index_arr_15 ? tlb_v1_8 : _GEN_103; // @[TLB.scala 129:{16,16}]
  wire  _GEN_105 = 4'h9 == s0_index_arr_15 ? tlb_v1_9 : _GEN_104; // @[TLB.scala 129:{16,16}]
  wire  _GEN_106 = 4'ha == s0_index_arr_15 ? tlb_v1_10 : _GEN_105; // @[TLB.scala 129:{16,16}]
  wire  _GEN_107 = 4'hb == s0_index_arr_15 ? tlb_v1_11 : _GEN_106; // @[TLB.scala 129:{16,16}]
  wire  _GEN_108 = 4'hc == s0_index_arr_15 ? tlb_v1_12 : _GEN_107; // @[TLB.scala 129:{16,16}]
  wire  _GEN_109 = 4'hd == s0_index_arr_15 ? tlb_v1_13 : _GEN_108; // @[TLB.scala 129:{16,16}]
  wire  _GEN_110 = 4'he == s0_index_arr_15 ? tlb_v1_14 : _GEN_109; // @[TLB.scala 129:{16,16}]
  wire  _GEN_111 = 4'hf == s0_index_arr_15 ? tlb_v1_15 : _GEN_110; // @[TLB.scala 129:{16,16}]
  wire  _GEN_113 = 4'h1 == s0_index_arr_15 ? tlb_v0_1 : tlb_v0_0; // @[TLB.scala 129:{16,16}]
  wire  _GEN_114 = 4'h2 == s0_index_arr_15 ? tlb_v0_2 : _GEN_113; // @[TLB.scala 129:{16,16}]
  wire  _GEN_115 = 4'h3 == s0_index_arr_15 ? tlb_v0_3 : _GEN_114; // @[TLB.scala 129:{16,16}]
  wire  _GEN_116 = 4'h4 == s0_index_arr_15 ? tlb_v0_4 : _GEN_115; // @[TLB.scala 129:{16,16}]
  wire  _GEN_117 = 4'h5 == s0_index_arr_15 ? tlb_v0_5 : _GEN_116; // @[TLB.scala 129:{16,16}]
  wire  _GEN_118 = 4'h6 == s0_index_arr_15 ? tlb_v0_6 : _GEN_117; // @[TLB.scala 129:{16,16}]
  wire  _GEN_119 = 4'h7 == s0_index_arr_15 ? tlb_v0_7 : _GEN_118; // @[TLB.scala 129:{16,16}]
  wire  _GEN_120 = 4'h8 == s0_index_arr_15 ? tlb_v0_8 : _GEN_119; // @[TLB.scala 129:{16,16}]
  wire  _GEN_121 = 4'h9 == s0_index_arr_15 ? tlb_v0_9 : _GEN_120; // @[TLB.scala 129:{16,16}]
  wire  _GEN_122 = 4'ha == s0_index_arr_15 ? tlb_v0_10 : _GEN_121; // @[TLB.scala 129:{16,16}]
  wire  _GEN_123 = 4'hb == s0_index_arr_15 ? tlb_v0_11 : _GEN_122; // @[TLB.scala 129:{16,16}]
  wire  _GEN_124 = 4'hc == s0_index_arr_15 ? tlb_v0_12 : _GEN_123; // @[TLB.scala 129:{16,16}]
  wire  _GEN_125 = 4'hd == s0_index_arr_15 ? tlb_v0_13 : _GEN_124; // @[TLB.scala 129:{16,16}]
  wire  _GEN_126 = 4'he == s0_index_arr_15 ? tlb_v0_14 : _GEN_125; // @[TLB.scala 129:{16,16}]
  wire  _GEN_127 = 4'hf == s0_index_arr_15 ? tlb_v0_15 : _GEN_126; // @[TLB.scala 129:{16,16}]
  wire [3:0] s1_index_arr_1 = {{3'd0}, match1_1}; // @[TLB.scala 150:54]
  wire [1:0] _s1_index_arr_2_T = match1_2 ? 2'h2 : 2'h0; // @[TLB.scala 151:12]
  wire [3:0] _GEN_614 = {{2'd0}, _s1_index_arr_2_T}; // @[TLB.scala 150:54]
  wire [3:0] s1_index_arr_2 = s1_index_arr_1 | _GEN_614; // @[TLB.scala 150:54]
  wire [1:0] _s1_index_arr_3_T = match1_3 ? 2'h3 : 2'h0; // @[TLB.scala 151:12]
  wire [3:0] _GEN_615 = {{2'd0}, _s1_index_arr_3_T}; // @[TLB.scala 150:54]
  wire [3:0] s1_index_arr_3 = s1_index_arr_2 | _GEN_615; // @[TLB.scala 150:54]
  wire [2:0] _s1_index_arr_4_T = match1_4 ? 3'h4 : 3'h0; // @[TLB.scala 151:12]
  wire [3:0] _GEN_616 = {{1'd0}, _s1_index_arr_4_T}; // @[TLB.scala 150:54]
  wire [3:0] s1_index_arr_4 = s1_index_arr_3 | _GEN_616; // @[TLB.scala 150:54]
  wire [2:0] _s1_index_arr_5_T = match1_5 ? 3'h5 : 3'h0; // @[TLB.scala 151:12]
  wire [3:0] _GEN_617 = {{1'd0}, _s1_index_arr_5_T}; // @[TLB.scala 150:54]
  wire [3:0] s1_index_arr_5 = s1_index_arr_4 | _GEN_617; // @[TLB.scala 150:54]
  wire [2:0] _s1_index_arr_6_T = match1_6 ? 3'h6 : 3'h0; // @[TLB.scala 151:12]
  wire [3:0] _GEN_618 = {{1'd0}, _s1_index_arr_6_T}; // @[TLB.scala 150:54]
  wire [3:0] s1_index_arr_6 = s1_index_arr_5 | _GEN_618; // @[TLB.scala 150:54]
  wire [2:0] _s1_index_arr_7_T = match1_7 ? 3'h7 : 3'h0; // @[TLB.scala 151:12]
  wire [3:0] _GEN_619 = {{1'd0}, _s1_index_arr_7_T}; // @[TLB.scala 150:54]
  wire [3:0] s1_index_arr_7 = s1_index_arr_6 | _GEN_619; // @[TLB.scala 150:54]
  wire [3:0] _s1_index_arr_8_T = match1_8 ? 4'h8 : 4'h0; // @[TLB.scala 151:12]
  wire [3:0] s1_index_arr_8 = s1_index_arr_7 | _s1_index_arr_8_T; // @[TLB.scala 150:54]
  wire [3:0] _s1_index_arr_9_T = match1_9 ? 4'h9 : 4'h0; // @[TLB.scala 151:12]
  wire [3:0] s1_index_arr_9 = s1_index_arr_8 | _s1_index_arr_9_T; // @[TLB.scala 150:54]
  wire [3:0] _s1_index_arr_10_T = match1_10 ? 4'ha : 4'h0; // @[TLB.scala 151:12]
  wire [3:0] s1_index_arr_10 = s1_index_arr_9 | _s1_index_arr_10_T; // @[TLB.scala 150:54]
  wire [3:0] _s1_index_arr_11_T = match1_11 ? 4'hb : 4'h0; // @[TLB.scala 151:12]
  wire [3:0] s1_index_arr_11 = s1_index_arr_10 | _s1_index_arr_11_T; // @[TLB.scala 150:54]
  wire [3:0] _s1_index_arr_12_T = match1_12 ? 4'hc : 4'h0; // @[TLB.scala 151:12]
  wire [3:0] s1_index_arr_12 = s1_index_arr_11 | _s1_index_arr_12_T; // @[TLB.scala 150:54]
  wire [3:0] _s1_index_arr_13_T = match1_13 ? 4'hd : 4'h0; // @[TLB.scala 151:12]
  wire [3:0] s1_index_arr_13 = s1_index_arr_12 | _s1_index_arr_13_T; // @[TLB.scala 150:54]
  wire [3:0] _s1_index_arr_14_T = match1_14 ? 4'he : 4'h0; // @[TLB.scala 151:12]
  wire [3:0] s1_index_arr_14 = s1_index_arr_13 | _s1_index_arr_14_T; // @[TLB.scala 150:54]
  wire [3:0] _s1_index_arr_15_T = match1_15 ? 4'hf : 4'h0; // @[TLB.scala 151:12]
  wire [3:0] s1_index_arr_15 = s1_index_arr_14 | _s1_index_arr_15_T; // @[TLB.scala 150:54]
  wire [19:0] _GEN_129 = 4'h1 == s1_index_arr_15 ? tlb_pfn1_1 : tlb_pfn1_0; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_130 = 4'h2 == s1_index_arr_15 ? tlb_pfn1_2 : _GEN_129; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_131 = 4'h3 == s1_index_arr_15 ? tlb_pfn1_3 : _GEN_130; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_132 = 4'h4 == s1_index_arr_15 ? tlb_pfn1_4 : _GEN_131; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_133 = 4'h5 == s1_index_arr_15 ? tlb_pfn1_5 : _GEN_132; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_134 = 4'h6 == s1_index_arr_15 ? tlb_pfn1_6 : _GEN_133; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_135 = 4'h7 == s1_index_arr_15 ? tlb_pfn1_7 : _GEN_134; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_136 = 4'h8 == s1_index_arr_15 ? tlb_pfn1_8 : _GEN_135; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_137 = 4'h9 == s1_index_arr_15 ? tlb_pfn1_9 : _GEN_136; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_138 = 4'ha == s1_index_arr_15 ? tlb_pfn1_10 : _GEN_137; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_139 = 4'hb == s1_index_arr_15 ? tlb_pfn1_11 : _GEN_138; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_140 = 4'hc == s1_index_arr_15 ? tlb_pfn1_12 : _GEN_139; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_141 = 4'hd == s1_index_arr_15 ? tlb_pfn1_13 : _GEN_140; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_142 = 4'he == s1_index_arr_15 ? tlb_pfn1_14 : _GEN_141; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_143 = 4'hf == s1_index_arr_15 ? tlb_pfn1_15 : _GEN_142; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_145 = 4'h1 == s1_index_arr_15 ? tlb_pfn0_1 : tlb_pfn0_0; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_146 = 4'h2 == s1_index_arr_15 ? tlb_pfn0_2 : _GEN_145; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_147 = 4'h3 == s1_index_arr_15 ? tlb_pfn0_3 : _GEN_146; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_148 = 4'h4 == s1_index_arr_15 ? tlb_pfn0_4 : _GEN_147; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_149 = 4'h5 == s1_index_arr_15 ? tlb_pfn0_5 : _GEN_148; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_150 = 4'h6 == s1_index_arr_15 ? tlb_pfn0_6 : _GEN_149; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_151 = 4'h7 == s1_index_arr_15 ? tlb_pfn0_7 : _GEN_150; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_152 = 4'h8 == s1_index_arr_15 ? tlb_pfn0_8 : _GEN_151; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_153 = 4'h9 == s1_index_arr_15 ? tlb_pfn0_9 : _GEN_152; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_154 = 4'ha == s1_index_arr_15 ? tlb_pfn0_10 : _GEN_153; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_155 = 4'hb == s1_index_arr_15 ? tlb_pfn0_11 : _GEN_154; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_156 = 4'hc == s1_index_arr_15 ? tlb_pfn0_12 : _GEN_155; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_157 = 4'hd == s1_index_arr_15 ? tlb_pfn0_13 : _GEN_156; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_158 = 4'he == s1_index_arr_15 ? tlb_pfn0_14 : _GEN_157; // @[TLB.scala 131:{16,16}]
  wire [19:0] _GEN_159 = 4'hf == s1_index_arr_15 ? tlb_pfn0_15 : _GEN_158; // @[TLB.scala 131:{16,16}]
  wire  _GEN_193 = 4'h1 == s1_index_arr_15 ? tlb_d1_1 : tlb_d1_0; // @[TLB.scala 133:{16,16}]
  wire  _GEN_194 = 4'h2 == s1_index_arr_15 ? tlb_d1_2 : _GEN_193; // @[TLB.scala 133:{16,16}]
  wire  _GEN_195 = 4'h3 == s1_index_arr_15 ? tlb_d1_3 : _GEN_194; // @[TLB.scala 133:{16,16}]
  wire  _GEN_196 = 4'h4 == s1_index_arr_15 ? tlb_d1_4 : _GEN_195; // @[TLB.scala 133:{16,16}]
  wire  _GEN_197 = 4'h5 == s1_index_arr_15 ? tlb_d1_5 : _GEN_196; // @[TLB.scala 133:{16,16}]
  wire  _GEN_198 = 4'h6 == s1_index_arr_15 ? tlb_d1_6 : _GEN_197; // @[TLB.scala 133:{16,16}]
  wire  _GEN_199 = 4'h7 == s1_index_arr_15 ? tlb_d1_7 : _GEN_198; // @[TLB.scala 133:{16,16}]
  wire  _GEN_200 = 4'h8 == s1_index_arr_15 ? tlb_d1_8 : _GEN_199; // @[TLB.scala 133:{16,16}]
  wire  _GEN_201 = 4'h9 == s1_index_arr_15 ? tlb_d1_9 : _GEN_200; // @[TLB.scala 133:{16,16}]
  wire  _GEN_202 = 4'ha == s1_index_arr_15 ? tlb_d1_10 : _GEN_201; // @[TLB.scala 133:{16,16}]
  wire  _GEN_203 = 4'hb == s1_index_arr_15 ? tlb_d1_11 : _GEN_202; // @[TLB.scala 133:{16,16}]
  wire  _GEN_204 = 4'hc == s1_index_arr_15 ? tlb_d1_12 : _GEN_203; // @[TLB.scala 133:{16,16}]
  wire  _GEN_205 = 4'hd == s1_index_arr_15 ? tlb_d1_13 : _GEN_204; // @[TLB.scala 133:{16,16}]
  wire  _GEN_206 = 4'he == s1_index_arr_15 ? tlb_d1_14 : _GEN_205; // @[TLB.scala 133:{16,16}]
  wire  _GEN_207 = 4'hf == s1_index_arr_15 ? tlb_d1_15 : _GEN_206; // @[TLB.scala 133:{16,16}]
  wire  _GEN_209 = 4'h1 == s1_index_arr_15 ? tlb_d0_1 : tlb_d0_0; // @[TLB.scala 133:{16,16}]
  wire  _GEN_210 = 4'h2 == s1_index_arr_15 ? tlb_d0_2 : _GEN_209; // @[TLB.scala 133:{16,16}]
  wire  _GEN_211 = 4'h3 == s1_index_arr_15 ? tlb_d0_3 : _GEN_210; // @[TLB.scala 133:{16,16}]
  wire  _GEN_212 = 4'h4 == s1_index_arr_15 ? tlb_d0_4 : _GEN_211; // @[TLB.scala 133:{16,16}]
  wire  _GEN_213 = 4'h5 == s1_index_arr_15 ? tlb_d0_5 : _GEN_212; // @[TLB.scala 133:{16,16}]
  wire  _GEN_214 = 4'h6 == s1_index_arr_15 ? tlb_d0_6 : _GEN_213; // @[TLB.scala 133:{16,16}]
  wire  _GEN_215 = 4'h7 == s1_index_arr_15 ? tlb_d0_7 : _GEN_214; // @[TLB.scala 133:{16,16}]
  wire  _GEN_216 = 4'h8 == s1_index_arr_15 ? tlb_d0_8 : _GEN_215; // @[TLB.scala 133:{16,16}]
  wire  _GEN_217 = 4'h9 == s1_index_arr_15 ? tlb_d0_9 : _GEN_216; // @[TLB.scala 133:{16,16}]
  wire  _GEN_218 = 4'ha == s1_index_arr_15 ? tlb_d0_10 : _GEN_217; // @[TLB.scala 133:{16,16}]
  wire  _GEN_219 = 4'hb == s1_index_arr_15 ? tlb_d0_11 : _GEN_218; // @[TLB.scala 133:{16,16}]
  wire  _GEN_220 = 4'hc == s1_index_arr_15 ? tlb_d0_12 : _GEN_219; // @[TLB.scala 133:{16,16}]
  wire  _GEN_221 = 4'hd == s1_index_arr_15 ? tlb_d0_13 : _GEN_220; // @[TLB.scala 133:{16,16}]
  wire  _GEN_222 = 4'he == s1_index_arr_15 ? tlb_d0_14 : _GEN_221; // @[TLB.scala 133:{16,16}]
  wire  _GEN_223 = 4'hf == s1_index_arr_15 ? tlb_d0_15 : _GEN_222; // @[TLB.scala 133:{16,16}]
  wire  _GEN_225 = 4'h1 == s1_index_arr_15 ? tlb_v1_1 : tlb_v1_0; // @[TLB.scala 134:{16,16}]
  wire  _GEN_226 = 4'h2 == s1_index_arr_15 ? tlb_v1_2 : _GEN_225; // @[TLB.scala 134:{16,16}]
  wire  _GEN_227 = 4'h3 == s1_index_arr_15 ? tlb_v1_3 : _GEN_226; // @[TLB.scala 134:{16,16}]
  wire  _GEN_228 = 4'h4 == s1_index_arr_15 ? tlb_v1_4 : _GEN_227; // @[TLB.scala 134:{16,16}]
  wire  _GEN_229 = 4'h5 == s1_index_arr_15 ? tlb_v1_5 : _GEN_228; // @[TLB.scala 134:{16,16}]
  wire  _GEN_230 = 4'h6 == s1_index_arr_15 ? tlb_v1_6 : _GEN_229; // @[TLB.scala 134:{16,16}]
  wire  _GEN_231 = 4'h7 == s1_index_arr_15 ? tlb_v1_7 : _GEN_230; // @[TLB.scala 134:{16,16}]
  wire  _GEN_232 = 4'h8 == s1_index_arr_15 ? tlb_v1_8 : _GEN_231; // @[TLB.scala 134:{16,16}]
  wire  _GEN_233 = 4'h9 == s1_index_arr_15 ? tlb_v1_9 : _GEN_232; // @[TLB.scala 134:{16,16}]
  wire  _GEN_234 = 4'ha == s1_index_arr_15 ? tlb_v1_10 : _GEN_233; // @[TLB.scala 134:{16,16}]
  wire  _GEN_235 = 4'hb == s1_index_arr_15 ? tlb_v1_11 : _GEN_234; // @[TLB.scala 134:{16,16}]
  wire  _GEN_236 = 4'hc == s1_index_arr_15 ? tlb_v1_12 : _GEN_235; // @[TLB.scala 134:{16,16}]
  wire  _GEN_237 = 4'hd == s1_index_arr_15 ? tlb_v1_13 : _GEN_236; // @[TLB.scala 134:{16,16}]
  wire  _GEN_238 = 4'he == s1_index_arr_15 ? tlb_v1_14 : _GEN_237; // @[TLB.scala 134:{16,16}]
  wire  _GEN_239 = 4'hf == s1_index_arr_15 ? tlb_v1_15 : _GEN_238; // @[TLB.scala 134:{16,16}]
  wire  _GEN_241 = 4'h1 == s1_index_arr_15 ? tlb_v0_1 : tlb_v0_0; // @[TLB.scala 134:{16,16}]
  wire  _GEN_242 = 4'h2 == s1_index_arr_15 ? tlb_v0_2 : _GEN_241; // @[TLB.scala 134:{16,16}]
  wire  _GEN_243 = 4'h3 == s1_index_arr_15 ? tlb_v0_3 : _GEN_242; // @[TLB.scala 134:{16,16}]
  wire  _GEN_244 = 4'h4 == s1_index_arr_15 ? tlb_v0_4 : _GEN_243; // @[TLB.scala 134:{16,16}]
  wire  _GEN_245 = 4'h5 == s1_index_arr_15 ? tlb_v0_5 : _GEN_244; // @[TLB.scala 134:{16,16}]
  wire  _GEN_246 = 4'h6 == s1_index_arr_15 ? tlb_v0_6 : _GEN_245; // @[TLB.scala 134:{16,16}]
  wire  _GEN_247 = 4'h7 == s1_index_arr_15 ? tlb_v0_7 : _GEN_246; // @[TLB.scala 134:{16,16}]
  wire  _GEN_248 = 4'h8 == s1_index_arr_15 ? tlb_v0_8 : _GEN_247; // @[TLB.scala 134:{16,16}]
  wire  _GEN_249 = 4'h9 == s1_index_arr_15 ? tlb_v0_9 : _GEN_248; // @[TLB.scala 134:{16,16}]
  wire  _GEN_250 = 4'ha == s1_index_arr_15 ? tlb_v0_10 : _GEN_249; // @[TLB.scala 134:{16,16}]
  wire  _GEN_251 = 4'hb == s1_index_arr_15 ? tlb_v0_11 : _GEN_250; // @[TLB.scala 134:{16,16}]
  wire  _GEN_252 = 4'hc == s1_index_arr_15 ? tlb_v0_12 : _GEN_251; // @[TLB.scala 134:{16,16}]
  wire  _GEN_253 = 4'hd == s1_index_arr_15 ? tlb_v0_13 : _GEN_252; // @[TLB.scala 134:{16,16}]
  wire  _GEN_254 = 4'he == s1_index_arr_15 ? tlb_v0_14 : _GEN_253; // @[TLB.scala 134:{16,16}]
  wire  _GEN_255 = 4'hf == s1_index_arr_15 ? tlb_v0_15 : _GEN_254; // @[TLB.scala 134:{16,16}]
  wire [18:0] _GEN_433 = 4'h1 == io_fromWriteBackStage_r_index ? tlb_vpn2_1 : tlb_vpn2_0; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_434 = 4'h2 == io_fromWriteBackStage_r_index ? tlb_vpn2_2 : _GEN_433; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_435 = 4'h3 == io_fromWriteBackStage_r_index ? tlb_vpn2_3 : _GEN_434; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_436 = 4'h4 == io_fromWriteBackStage_r_index ? tlb_vpn2_4 : _GEN_435; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_437 = 4'h5 == io_fromWriteBackStage_r_index ? tlb_vpn2_5 : _GEN_436; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_438 = 4'h6 == io_fromWriteBackStage_r_index ? tlb_vpn2_6 : _GEN_437; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_439 = 4'h7 == io_fromWriteBackStage_r_index ? tlb_vpn2_7 : _GEN_438; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_440 = 4'h8 == io_fromWriteBackStage_r_index ? tlb_vpn2_8 : _GEN_439; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_441 = 4'h9 == io_fromWriteBackStage_r_index ? tlb_vpn2_9 : _GEN_440; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_442 = 4'ha == io_fromWriteBackStage_r_index ? tlb_vpn2_10 : _GEN_441; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_443 = 4'hb == io_fromWriteBackStage_r_index ? tlb_vpn2_11 : _GEN_442; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_444 = 4'hc == io_fromWriteBackStage_r_index ? tlb_vpn2_12 : _GEN_443; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_445 = 4'hd == io_fromWriteBackStage_r_index ? tlb_vpn2_13 : _GEN_444; // @[TLB.scala 172:{10,10}]
  wire [18:0] _GEN_446 = 4'he == io_fromWriteBackStage_r_index ? tlb_vpn2_14 : _GEN_445; // @[TLB.scala 172:{10,10}]
  wire [7:0] _GEN_449 = 4'h1 == io_fromWriteBackStage_r_index ? tlb_asid_1 : tlb_asid_0; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_450 = 4'h2 == io_fromWriteBackStage_r_index ? tlb_asid_2 : _GEN_449; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_451 = 4'h3 == io_fromWriteBackStage_r_index ? tlb_asid_3 : _GEN_450; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_452 = 4'h4 == io_fromWriteBackStage_r_index ? tlb_asid_4 : _GEN_451; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_453 = 4'h5 == io_fromWriteBackStage_r_index ? tlb_asid_5 : _GEN_452; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_454 = 4'h6 == io_fromWriteBackStage_r_index ? tlb_asid_6 : _GEN_453; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_455 = 4'h7 == io_fromWriteBackStage_r_index ? tlb_asid_7 : _GEN_454; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_456 = 4'h8 == io_fromWriteBackStage_r_index ? tlb_asid_8 : _GEN_455; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_457 = 4'h9 == io_fromWriteBackStage_r_index ? tlb_asid_9 : _GEN_456; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_458 = 4'ha == io_fromWriteBackStage_r_index ? tlb_asid_10 : _GEN_457; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_459 = 4'hb == io_fromWriteBackStage_r_index ? tlb_asid_11 : _GEN_458; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_460 = 4'hc == io_fromWriteBackStage_r_index ? tlb_asid_12 : _GEN_459; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_461 = 4'hd == io_fromWriteBackStage_r_index ? tlb_asid_13 : _GEN_460; // @[TLB.scala 173:{10,10}]
  wire [7:0] _GEN_462 = 4'he == io_fromWriteBackStage_r_index ? tlb_asid_14 : _GEN_461; // @[TLB.scala 173:{10,10}]
  wire  _GEN_465 = 4'h1 == io_fromWriteBackStage_r_index ? tlb_g_1 : tlb_g_0; // @[TLB.scala 174:{10,10}]
  wire  _GEN_466 = 4'h2 == io_fromWriteBackStage_r_index ? tlb_g_2 : _GEN_465; // @[TLB.scala 174:{10,10}]
  wire  _GEN_467 = 4'h3 == io_fromWriteBackStage_r_index ? tlb_g_3 : _GEN_466; // @[TLB.scala 174:{10,10}]
  wire  _GEN_468 = 4'h4 == io_fromWriteBackStage_r_index ? tlb_g_4 : _GEN_467; // @[TLB.scala 174:{10,10}]
  wire  _GEN_469 = 4'h5 == io_fromWriteBackStage_r_index ? tlb_g_5 : _GEN_468; // @[TLB.scala 174:{10,10}]
  wire  _GEN_470 = 4'h6 == io_fromWriteBackStage_r_index ? tlb_g_6 : _GEN_469; // @[TLB.scala 174:{10,10}]
  wire  _GEN_471 = 4'h7 == io_fromWriteBackStage_r_index ? tlb_g_7 : _GEN_470; // @[TLB.scala 174:{10,10}]
  wire  _GEN_472 = 4'h8 == io_fromWriteBackStage_r_index ? tlb_g_8 : _GEN_471; // @[TLB.scala 174:{10,10}]
  wire  _GEN_473 = 4'h9 == io_fromWriteBackStage_r_index ? tlb_g_9 : _GEN_472; // @[TLB.scala 174:{10,10}]
  wire  _GEN_474 = 4'ha == io_fromWriteBackStage_r_index ? tlb_g_10 : _GEN_473; // @[TLB.scala 174:{10,10}]
  wire  _GEN_475 = 4'hb == io_fromWriteBackStage_r_index ? tlb_g_11 : _GEN_474; // @[TLB.scala 174:{10,10}]
  wire  _GEN_476 = 4'hc == io_fromWriteBackStage_r_index ? tlb_g_12 : _GEN_475; // @[TLB.scala 174:{10,10}]
  wire  _GEN_477 = 4'hd == io_fromWriteBackStage_r_index ? tlb_g_13 : _GEN_476; // @[TLB.scala 174:{10,10}]
  wire  _GEN_478 = 4'he == io_fromWriteBackStage_r_index ? tlb_g_14 : _GEN_477; // @[TLB.scala 174:{10,10}]
  wire [19:0] _GEN_481 = 4'h1 == io_fromWriteBackStage_r_index ? tlb_pfn0_1 : tlb_pfn0_0; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_482 = 4'h2 == io_fromWriteBackStage_r_index ? tlb_pfn0_2 : _GEN_481; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_483 = 4'h3 == io_fromWriteBackStage_r_index ? tlb_pfn0_3 : _GEN_482; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_484 = 4'h4 == io_fromWriteBackStage_r_index ? tlb_pfn0_4 : _GEN_483; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_485 = 4'h5 == io_fromWriteBackStage_r_index ? tlb_pfn0_5 : _GEN_484; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_486 = 4'h6 == io_fromWriteBackStage_r_index ? tlb_pfn0_6 : _GEN_485; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_487 = 4'h7 == io_fromWriteBackStage_r_index ? tlb_pfn0_7 : _GEN_486; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_488 = 4'h8 == io_fromWriteBackStage_r_index ? tlb_pfn0_8 : _GEN_487; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_489 = 4'h9 == io_fromWriteBackStage_r_index ? tlb_pfn0_9 : _GEN_488; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_490 = 4'ha == io_fromWriteBackStage_r_index ? tlb_pfn0_10 : _GEN_489; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_491 = 4'hb == io_fromWriteBackStage_r_index ? tlb_pfn0_11 : _GEN_490; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_492 = 4'hc == io_fromWriteBackStage_r_index ? tlb_pfn0_12 : _GEN_491; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_493 = 4'hd == io_fromWriteBackStage_r_index ? tlb_pfn0_13 : _GEN_492; // @[TLB.scala 176:{10,10}]
  wire [19:0] _GEN_494 = 4'he == io_fromWriteBackStage_r_index ? tlb_pfn0_14 : _GEN_493; // @[TLB.scala 176:{10,10}]
  wire [2:0] _GEN_497 = 4'h1 == io_fromWriteBackStage_r_index ? tlb_c0_1 : tlb_c0_0; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_498 = 4'h2 == io_fromWriteBackStage_r_index ? tlb_c0_2 : _GEN_497; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_499 = 4'h3 == io_fromWriteBackStage_r_index ? tlb_c0_3 : _GEN_498; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_500 = 4'h4 == io_fromWriteBackStage_r_index ? tlb_c0_4 : _GEN_499; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_501 = 4'h5 == io_fromWriteBackStage_r_index ? tlb_c0_5 : _GEN_500; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_502 = 4'h6 == io_fromWriteBackStage_r_index ? tlb_c0_6 : _GEN_501; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_503 = 4'h7 == io_fromWriteBackStage_r_index ? tlb_c0_7 : _GEN_502; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_504 = 4'h8 == io_fromWriteBackStage_r_index ? tlb_c0_8 : _GEN_503; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_505 = 4'h9 == io_fromWriteBackStage_r_index ? tlb_c0_9 : _GEN_504; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_506 = 4'ha == io_fromWriteBackStage_r_index ? tlb_c0_10 : _GEN_505; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_507 = 4'hb == io_fromWriteBackStage_r_index ? tlb_c0_11 : _GEN_506; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_508 = 4'hc == io_fromWriteBackStage_r_index ? tlb_c0_12 : _GEN_507; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_509 = 4'hd == io_fromWriteBackStage_r_index ? tlb_c0_13 : _GEN_508; // @[TLB.scala 177:{10,10}]
  wire [2:0] _GEN_510 = 4'he == io_fromWriteBackStage_r_index ? tlb_c0_14 : _GEN_509; // @[TLB.scala 177:{10,10}]
  wire  _GEN_513 = 4'h1 == io_fromWriteBackStage_r_index ? tlb_d0_1 : tlb_d0_0; // @[TLB.scala 178:{10,10}]
  wire  _GEN_514 = 4'h2 == io_fromWriteBackStage_r_index ? tlb_d0_2 : _GEN_513; // @[TLB.scala 178:{10,10}]
  wire  _GEN_515 = 4'h3 == io_fromWriteBackStage_r_index ? tlb_d0_3 : _GEN_514; // @[TLB.scala 178:{10,10}]
  wire  _GEN_516 = 4'h4 == io_fromWriteBackStage_r_index ? tlb_d0_4 : _GEN_515; // @[TLB.scala 178:{10,10}]
  wire  _GEN_517 = 4'h5 == io_fromWriteBackStage_r_index ? tlb_d0_5 : _GEN_516; // @[TLB.scala 178:{10,10}]
  wire  _GEN_518 = 4'h6 == io_fromWriteBackStage_r_index ? tlb_d0_6 : _GEN_517; // @[TLB.scala 178:{10,10}]
  wire  _GEN_519 = 4'h7 == io_fromWriteBackStage_r_index ? tlb_d0_7 : _GEN_518; // @[TLB.scala 178:{10,10}]
  wire  _GEN_520 = 4'h8 == io_fromWriteBackStage_r_index ? tlb_d0_8 : _GEN_519; // @[TLB.scala 178:{10,10}]
  wire  _GEN_521 = 4'h9 == io_fromWriteBackStage_r_index ? tlb_d0_9 : _GEN_520; // @[TLB.scala 178:{10,10}]
  wire  _GEN_522 = 4'ha == io_fromWriteBackStage_r_index ? tlb_d0_10 : _GEN_521; // @[TLB.scala 178:{10,10}]
  wire  _GEN_523 = 4'hb == io_fromWriteBackStage_r_index ? tlb_d0_11 : _GEN_522; // @[TLB.scala 178:{10,10}]
  wire  _GEN_524 = 4'hc == io_fromWriteBackStage_r_index ? tlb_d0_12 : _GEN_523; // @[TLB.scala 178:{10,10}]
  wire  _GEN_525 = 4'hd == io_fromWriteBackStage_r_index ? tlb_d0_13 : _GEN_524; // @[TLB.scala 178:{10,10}]
  wire  _GEN_526 = 4'he == io_fromWriteBackStage_r_index ? tlb_d0_14 : _GEN_525; // @[TLB.scala 178:{10,10}]
  wire  _GEN_529 = 4'h1 == io_fromWriteBackStage_r_index ? tlb_v0_1 : tlb_v0_0; // @[TLB.scala 179:{10,10}]
  wire  _GEN_530 = 4'h2 == io_fromWriteBackStage_r_index ? tlb_v0_2 : _GEN_529; // @[TLB.scala 179:{10,10}]
  wire  _GEN_531 = 4'h3 == io_fromWriteBackStage_r_index ? tlb_v0_3 : _GEN_530; // @[TLB.scala 179:{10,10}]
  wire  _GEN_532 = 4'h4 == io_fromWriteBackStage_r_index ? tlb_v0_4 : _GEN_531; // @[TLB.scala 179:{10,10}]
  wire  _GEN_533 = 4'h5 == io_fromWriteBackStage_r_index ? tlb_v0_5 : _GEN_532; // @[TLB.scala 179:{10,10}]
  wire  _GEN_534 = 4'h6 == io_fromWriteBackStage_r_index ? tlb_v0_6 : _GEN_533; // @[TLB.scala 179:{10,10}]
  wire  _GEN_535 = 4'h7 == io_fromWriteBackStage_r_index ? tlb_v0_7 : _GEN_534; // @[TLB.scala 179:{10,10}]
  wire  _GEN_536 = 4'h8 == io_fromWriteBackStage_r_index ? tlb_v0_8 : _GEN_535; // @[TLB.scala 179:{10,10}]
  wire  _GEN_537 = 4'h9 == io_fromWriteBackStage_r_index ? tlb_v0_9 : _GEN_536; // @[TLB.scala 179:{10,10}]
  wire  _GEN_538 = 4'ha == io_fromWriteBackStage_r_index ? tlb_v0_10 : _GEN_537; // @[TLB.scala 179:{10,10}]
  wire  _GEN_539 = 4'hb == io_fromWriteBackStage_r_index ? tlb_v0_11 : _GEN_538; // @[TLB.scala 179:{10,10}]
  wire  _GEN_540 = 4'hc == io_fromWriteBackStage_r_index ? tlb_v0_12 : _GEN_539; // @[TLB.scala 179:{10,10}]
  wire  _GEN_541 = 4'hd == io_fromWriteBackStage_r_index ? tlb_v0_13 : _GEN_540; // @[TLB.scala 179:{10,10}]
  wire  _GEN_542 = 4'he == io_fromWriteBackStage_r_index ? tlb_v0_14 : _GEN_541; // @[TLB.scala 179:{10,10}]
  wire [19:0] _GEN_545 = 4'h1 == io_fromWriteBackStage_r_index ? tlb_pfn1_1 : tlb_pfn1_0; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_546 = 4'h2 == io_fromWriteBackStage_r_index ? tlb_pfn1_2 : _GEN_545; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_547 = 4'h3 == io_fromWriteBackStage_r_index ? tlb_pfn1_3 : _GEN_546; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_548 = 4'h4 == io_fromWriteBackStage_r_index ? tlb_pfn1_4 : _GEN_547; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_549 = 4'h5 == io_fromWriteBackStage_r_index ? tlb_pfn1_5 : _GEN_548; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_550 = 4'h6 == io_fromWriteBackStage_r_index ? tlb_pfn1_6 : _GEN_549; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_551 = 4'h7 == io_fromWriteBackStage_r_index ? tlb_pfn1_7 : _GEN_550; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_552 = 4'h8 == io_fromWriteBackStage_r_index ? tlb_pfn1_8 : _GEN_551; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_553 = 4'h9 == io_fromWriteBackStage_r_index ? tlb_pfn1_9 : _GEN_552; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_554 = 4'ha == io_fromWriteBackStage_r_index ? tlb_pfn1_10 : _GEN_553; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_555 = 4'hb == io_fromWriteBackStage_r_index ? tlb_pfn1_11 : _GEN_554; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_556 = 4'hc == io_fromWriteBackStage_r_index ? tlb_pfn1_12 : _GEN_555; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_557 = 4'hd == io_fromWriteBackStage_r_index ? tlb_pfn1_13 : _GEN_556; // @[TLB.scala 181:{10,10}]
  wire [19:0] _GEN_558 = 4'he == io_fromWriteBackStage_r_index ? tlb_pfn1_14 : _GEN_557; // @[TLB.scala 181:{10,10}]
  wire [2:0] _GEN_561 = 4'h1 == io_fromWriteBackStage_r_index ? tlb_c1_1 : tlb_c1_0; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_562 = 4'h2 == io_fromWriteBackStage_r_index ? tlb_c1_2 : _GEN_561; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_563 = 4'h3 == io_fromWriteBackStage_r_index ? tlb_c1_3 : _GEN_562; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_564 = 4'h4 == io_fromWriteBackStage_r_index ? tlb_c1_4 : _GEN_563; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_565 = 4'h5 == io_fromWriteBackStage_r_index ? tlb_c1_5 : _GEN_564; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_566 = 4'h6 == io_fromWriteBackStage_r_index ? tlb_c1_6 : _GEN_565; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_567 = 4'h7 == io_fromWriteBackStage_r_index ? tlb_c1_7 : _GEN_566; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_568 = 4'h8 == io_fromWriteBackStage_r_index ? tlb_c1_8 : _GEN_567; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_569 = 4'h9 == io_fromWriteBackStage_r_index ? tlb_c1_9 : _GEN_568; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_570 = 4'ha == io_fromWriteBackStage_r_index ? tlb_c1_10 : _GEN_569; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_571 = 4'hb == io_fromWriteBackStage_r_index ? tlb_c1_11 : _GEN_570; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_572 = 4'hc == io_fromWriteBackStage_r_index ? tlb_c1_12 : _GEN_571; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_573 = 4'hd == io_fromWriteBackStage_r_index ? tlb_c1_13 : _GEN_572; // @[TLB.scala 182:{10,10}]
  wire [2:0] _GEN_574 = 4'he == io_fromWriteBackStage_r_index ? tlb_c1_14 : _GEN_573; // @[TLB.scala 182:{10,10}]
  wire  _GEN_577 = 4'h1 == io_fromWriteBackStage_r_index ? tlb_d1_1 : tlb_d1_0; // @[TLB.scala 183:{10,10}]
  wire  _GEN_578 = 4'h2 == io_fromWriteBackStage_r_index ? tlb_d1_2 : _GEN_577; // @[TLB.scala 183:{10,10}]
  wire  _GEN_579 = 4'h3 == io_fromWriteBackStage_r_index ? tlb_d1_3 : _GEN_578; // @[TLB.scala 183:{10,10}]
  wire  _GEN_580 = 4'h4 == io_fromWriteBackStage_r_index ? tlb_d1_4 : _GEN_579; // @[TLB.scala 183:{10,10}]
  wire  _GEN_581 = 4'h5 == io_fromWriteBackStage_r_index ? tlb_d1_5 : _GEN_580; // @[TLB.scala 183:{10,10}]
  wire  _GEN_582 = 4'h6 == io_fromWriteBackStage_r_index ? tlb_d1_6 : _GEN_581; // @[TLB.scala 183:{10,10}]
  wire  _GEN_583 = 4'h7 == io_fromWriteBackStage_r_index ? tlb_d1_7 : _GEN_582; // @[TLB.scala 183:{10,10}]
  wire  _GEN_584 = 4'h8 == io_fromWriteBackStage_r_index ? tlb_d1_8 : _GEN_583; // @[TLB.scala 183:{10,10}]
  wire  _GEN_585 = 4'h9 == io_fromWriteBackStage_r_index ? tlb_d1_9 : _GEN_584; // @[TLB.scala 183:{10,10}]
  wire  _GEN_586 = 4'ha == io_fromWriteBackStage_r_index ? tlb_d1_10 : _GEN_585; // @[TLB.scala 183:{10,10}]
  wire  _GEN_587 = 4'hb == io_fromWriteBackStage_r_index ? tlb_d1_11 : _GEN_586; // @[TLB.scala 183:{10,10}]
  wire  _GEN_588 = 4'hc == io_fromWriteBackStage_r_index ? tlb_d1_12 : _GEN_587; // @[TLB.scala 183:{10,10}]
  wire  _GEN_589 = 4'hd == io_fromWriteBackStage_r_index ? tlb_d1_13 : _GEN_588; // @[TLB.scala 183:{10,10}]
  wire  _GEN_590 = 4'he == io_fromWriteBackStage_r_index ? tlb_d1_14 : _GEN_589; // @[TLB.scala 183:{10,10}]
  wire  _GEN_593 = 4'h1 == io_fromWriteBackStage_r_index ? tlb_v1_1 : tlb_v1_0; // @[TLB.scala 184:{10,10}]
  wire  _GEN_594 = 4'h2 == io_fromWriteBackStage_r_index ? tlb_v1_2 : _GEN_593; // @[TLB.scala 184:{10,10}]
  wire  _GEN_595 = 4'h3 == io_fromWriteBackStage_r_index ? tlb_v1_3 : _GEN_594; // @[TLB.scala 184:{10,10}]
  wire  _GEN_596 = 4'h4 == io_fromWriteBackStage_r_index ? tlb_v1_4 : _GEN_595; // @[TLB.scala 184:{10,10}]
  wire  _GEN_597 = 4'h5 == io_fromWriteBackStage_r_index ? tlb_v1_5 : _GEN_596; // @[TLB.scala 184:{10,10}]
  wire  _GEN_598 = 4'h6 == io_fromWriteBackStage_r_index ? tlb_v1_6 : _GEN_597; // @[TLB.scala 184:{10,10}]
  wire  _GEN_599 = 4'h7 == io_fromWriteBackStage_r_index ? tlb_v1_7 : _GEN_598; // @[TLB.scala 184:{10,10}]
  wire  _GEN_600 = 4'h8 == io_fromWriteBackStage_r_index ? tlb_v1_8 : _GEN_599; // @[TLB.scala 184:{10,10}]
  wire  _GEN_601 = 4'h9 == io_fromWriteBackStage_r_index ? tlb_v1_9 : _GEN_600; // @[TLB.scala 184:{10,10}]
  wire  _GEN_602 = 4'ha == io_fromWriteBackStage_r_index ? tlb_v1_10 : _GEN_601; // @[TLB.scala 184:{10,10}]
  wire  _GEN_603 = 4'hb == io_fromWriteBackStage_r_index ? tlb_v1_11 : _GEN_602; // @[TLB.scala 184:{10,10}]
  wire  _GEN_604 = 4'hc == io_fromWriteBackStage_r_index ? tlb_v1_12 : _GEN_603; // @[TLB.scala 184:{10,10}]
  wire  _GEN_605 = 4'hd == io_fromWriteBackStage_r_index ? tlb_v1_13 : _GEN_604; // @[TLB.scala 184:{10,10}]
  wire  _GEN_606 = 4'he == io_fromWriteBackStage_r_index ? tlb_v1_14 : _GEN_605; // @[TLB.scala 184:{10,10}]
  assign io_instMMU_tlb_found = |_s0_found_T; // @[TLB.scala 120:29]
  assign io_instMMU_tlb_pfn = io_fromInstMMU_tlb_odd_page ? _GEN_15 : _GEN_31; // @[TLB.scala 126:16]
  assign io_instMMU_tlb_v = io_fromInstMMU_tlb_odd_page ? _GEN_111 : _GEN_127; // @[TLB.scala 129:16]
  assign io_dataMMU_tlb_found = |_s1_found_T; // @[TLB.scala 121:29]
  assign io_dataMMU_tlb_pfn = io_fromDataMMU_tlb_odd_page ? _GEN_143 : _GEN_159; // @[TLB.scala 131:16]
  assign io_dataMMU_tlb_d = io_fromDataMMU_tlb_odd_page ? _GEN_207 : _GEN_223; // @[TLB.scala 133:16]
  assign io_dataMMU_tlb_v = io_fromDataMMU_tlb_odd_page ? _GEN_239 : _GEN_255; // @[TLB.scala 134:16]
  assign io_execute_s1_found = |_s1_found_T; // @[TLB.scala 121:29]
  assign io_execute_s1_index = s1_index_arr_14 | _s1_index_arr_15_T; // @[TLB.scala 150:54]
  assign io_writeBackStage_r_vpn2 = 4'hf == io_fromWriteBackStage_r_index ? tlb_vpn2_15 : _GEN_446; // @[TLB.scala 172:{10,10}]
  assign io_writeBackStage_r_asid = 4'hf == io_fromWriteBackStage_r_index ? tlb_asid_15 : _GEN_462; // @[TLB.scala 173:{10,10}]
  assign io_writeBackStage_r_g = 4'hf == io_fromWriteBackStage_r_index ? tlb_g_15 : _GEN_478; // @[TLB.scala 174:{10,10}]
  assign io_writeBackStage_r_pfn0 = 4'hf == io_fromWriteBackStage_r_index ? tlb_pfn0_15 : _GEN_494; // @[TLB.scala 176:{10,10}]
  assign io_writeBackStage_r_c0 = 4'hf == io_fromWriteBackStage_r_index ? tlb_c0_15 : _GEN_510; // @[TLB.scala 177:{10,10}]
  assign io_writeBackStage_r_d0 = 4'hf == io_fromWriteBackStage_r_index ? tlb_d0_15 : _GEN_526; // @[TLB.scala 178:{10,10}]
  assign io_writeBackStage_r_v0 = 4'hf == io_fromWriteBackStage_r_index ? tlb_v0_15 : _GEN_542; // @[TLB.scala 179:{10,10}]
  assign io_writeBackStage_r_pfn1 = 4'hf == io_fromWriteBackStage_r_index ? tlb_pfn1_15 : _GEN_558; // @[TLB.scala 181:{10,10}]
  assign io_writeBackStage_r_c1 = 4'hf == io_fromWriteBackStage_r_index ? tlb_c1_15 : _GEN_574; // @[TLB.scala 182:{10,10}]
  assign io_writeBackStage_r_d1 = 4'hf == io_fromWriteBackStage_r_index ? tlb_d1_15 : _GEN_590; // @[TLB.scala 183:{10,10}]
  assign io_writeBackStage_r_v1 = 4'hf == io_fromWriteBackStage_r_index ? tlb_v1_15 : _GEN_606; // @[TLB.scala 184:{10,10}]
  always @(posedge clock) begin
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_0 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h0) begin // @[TLB.scala 155:37]
      tlb_vpn2_0 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_1 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h1) begin // @[TLB.scala 155:37]
      tlb_vpn2_1 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_2 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h2) begin // @[TLB.scala 155:37]
      tlb_vpn2_2 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_3 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h3) begin // @[TLB.scala 155:37]
      tlb_vpn2_3 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_4 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h4) begin // @[TLB.scala 155:37]
      tlb_vpn2_4 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_5 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h5) begin // @[TLB.scala 155:37]
      tlb_vpn2_5 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_6 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h6) begin // @[TLB.scala 155:37]
      tlb_vpn2_6 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_7 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h7) begin // @[TLB.scala 155:37]
      tlb_vpn2_7 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_8 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h8) begin // @[TLB.scala 155:37]
      tlb_vpn2_8 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_9 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h9) begin // @[TLB.scala 155:37]
      tlb_vpn2_9 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_10 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'ha) begin // @[TLB.scala 155:37]
      tlb_vpn2_10 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_11 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hb) begin // @[TLB.scala 155:37]
      tlb_vpn2_11 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_12 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hc) begin // @[TLB.scala 155:37]
      tlb_vpn2_12 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_13 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hd) begin // @[TLB.scala 155:37]
      tlb_vpn2_13 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_14 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'he) begin // @[TLB.scala 155:37]
      tlb_vpn2_14 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 101:25]
      tlb_vpn2_15 <= 19'h0; // @[TLB.scala 101:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hf) begin // @[TLB.scala 155:37]
      tlb_vpn2_15 <= io_fromWriteBackStage_w_vpn2; // @[TLB.scala 156:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_0 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h0) begin // @[TLB.scala 155:37]
      tlb_asid_0 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_1 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h1) begin // @[TLB.scala 155:37]
      tlb_asid_1 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_2 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h2) begin // @[TLB.scala 155:37]
      tlb_asid_2 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_3 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h3) begin // @[TLB.scala 155:37]
      tlb_asid_3 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_4 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h4) begin // @[TLB.scala 155:37]
      tlb_asid_4 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_5 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h5) begin // @[TLB.scala 155:37]
      tlb_asid_5 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_6 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h6) begin // @[TLB.scala 155:37]
      tlb_asid_6 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_7 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h7) begin // @[TLB.scala 155:37]
      tlb_asid_7 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_8 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h8) begin // @[TLB.scala 155:37]
      tlb_asid_8 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_9 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h9) begin // @[TLB.scala 155:37]
      tlb_asid_9 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_10 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'ha) begin // @[TLB.scala 155:37]
      tlb_asid_10 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_11 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hb) begin // @[TLB.scala 155:37]
      tlb_asid_11 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_12 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hc) begin // @[TLB.scala 155:37]
      tlb_asid_12 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_13 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hd) begin // @[TLB.scala 155:37]
      tlb_asid_13 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_14 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'he) begin // @[TLB.scala 155:37]
      tlb_asid_14 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 102:25]
      tlb_asid_15 <= 8'h0; // @[TLB.scala 102:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hf) begin // @[TLB.scala 155:37]
      tlb_asid_15 <= io_fromWriteBackStage_w_asid; // @[TLB.scala 157:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_0 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h0) begin // @[TLB.scala 155:37]
      tlb_g_0 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_1 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h1) begin // @[TLB.scala 155:37]
      tlb_g_1 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_2 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h2) begin // @[TLB.scala 155:37]
      tlb_g_2 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_3 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h3) begin // @[TLB.scala 155:37]
      tlb_g_3 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_4 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h4) begin // @[TLB.scala 155:37]
      tlb_g_4 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_5 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h5) begin // @[TLB.scala 155:37]
      tlb_g_5 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_6 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h6) begin // @[TLB.scala 155:37]
      tlb_g_6 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_7 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h7) begin // @[TLB.scala 155:37]
      tlb_g_7 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_8 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h8) begin // @[TLB.scala 155:37]
      tlb_g_8 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_9 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h9) begin // @[TLB.scala 155:37]
      tlb_g_9 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_10 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'ha) begin // @[TLB.scala 155:37]
      tlb_g_10 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_11 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hb) begin // @[TLB.scala 155:37]
      tlb_g_11 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_12 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hc) begin // @[TLB.scala 155:37]
      tlb_g_12 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_13 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hd) begin // @[TLB.scala 155:37]
      tlb_g_13 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_14 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'he) begin // @[TLB.scala 155:37]
      tlb_g_14 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 103:25]
      tlb_g_15 <= 1'h0; // @[TLB.scala 103:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hf) begin // @[TLB.scala 155:37]
      tlb_g_15 <= io_fromWriteBackStage_w_g; // @[TLB.scala 158:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_0 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h0) begin // @[TLB.scala 155:37]
      tlb_pfn0_0 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_1 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h1) begin // @[TLB.scala 155:37]
      tlb_pfn0_1 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_2 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h2) begin // @[TLB.scala 155:37]
      tlb_pfn0_2 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_3 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h3) begin // @[TLB.scala 155:37]
      tlb_pfn0_3 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_4 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h4) begin // @[TLB.scala 155:37]
      tlb_pfn0_4 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_5 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h5) begin // @[TLB.scala 155:37]
      tlb_pfn0_5 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_6 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h6) begin // @[TLB.scala 155:37]
      tlb_pfn0_6 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_7 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h7) begin // @[TLB.scala 155:37]
      tlb_pfn0_7 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_8 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h8) begin // @[TLB.scala 155:37]
      tlb_pfn0_8 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_9 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h9) begin // @[TLB.scala 155:37]
      tlb_pfn0_9 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_10 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'ha) begin // @[TLB.scala 155:37]
      tlb_pfn0_10 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_11 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hb) begin // @[TLB.scala 155:37]
      tlb_pfn0_11 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_12 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hc) begin // @[TLB.scala 155:37]
      tlb_pfn0_12 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_13 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hd) begin // @[TLB.scala 155:37]
      tlb_pfn0_13 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_14 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'he) begin // @[TLB.scala 155:37]
      tlb_pfn0_14 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 104:25]
      tlb_pfn0_15 <= 20'h0; // @[TLB.scala 104:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hf) begin // @[TLB.scala 155:37]
      tlb_pfn0_15 <= io_fromWriteBackStage_w_pfn0; // @[TLB.scala 160:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_0 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h0) begin // @[TLB.scala 155:37]
      tlb_c0_0 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_1 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h1) begin // @[TLB.scala 155:37]
      tlb_c0_1 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_2 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h2) begin // @[TLB.scala 155:37]
      tlb_c0_2 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_3 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h3) begin // @[TLB.scala 155:37]
      tlb_c0_3 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_4 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h4) begin // @[TLB.scala 155:37]
      tlb_c0_4 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_5 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h5) begin // @[TLB.scala 155:37]
      tlb_c0_5 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_6 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h6) begin // @[TLB.scala 155:37]
      tlb_c0_6 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_7 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h7) begin // @[TLB.scala 155:37]
      tlb_c0_7 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_8 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h8) begin // @[TLB.scala 155:37]
      tlb_c0_8 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_9 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h9) begin // @[TLB.scala 155:37]
      tlb_c0_9 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_10 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'ha) begin // @[TLB.scala 155:37]
      tlb_c0_10 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_11 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hb) begin // @[TLB.scala 155:37]
      tlb_c0_11 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_12 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hc) begin // @[TLB.scala 155:37]
      tlb_c0_12 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_13 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hd) begin // @[TLB.scala 155:37]
      tlb_c0_13 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_14 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'he) begin // @[TLB.scala 155:37]
      tlb_c0_14 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 105:25]
      tlb_c0_15 <= 3'h0; // @[TLB.scala 105:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hf) begin // @[TLB.scala 155:37]
      tlb_c0_15 <= io_fromWriteBackStage_w_c0; // @[TLB.scala 161:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_0 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h0) begin // @[TLB.scala 155:37]
      tlb_d0_0 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_1 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h1) begin // @[TLB.scala 155:37]
      tlb_d0_1 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_2 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h2) begin // @[TLB.scala 155:37]
      tlb_d0_2 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_3 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h3) begin // @[TLB.scala 155:37]
      tlb_d0_3 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_4 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h4) begin // @[TLB.scala 155:37]
      tlb_d0_4 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_5 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h5) begin // @[TLB.scala 155:37]
      tlb_d0_5 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_6 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h6) begin // @[TLB.scala 155:37]
      tlb_d0_6 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_7 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h7) begin // @[TLB.scala 155:37]
      tlb_d0_7 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_8 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h8) begin // @[TLB.scala 155:37]
      tlb_d0_8 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_9 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h9) begin // @[TLB.scala 155:37]
      tlb_d0_9 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_10 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'ha) begin // @[TLB.scala 155:37]
      tlb_d0_10 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_11 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hb) begin // @[TLB.scala 155:37]
      tlb_d0_11 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_12 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hc) begin // @[TLB.scala 155:37]
      tlb_d0_12 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_13 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hd) begin // @[TLB.scala 155:37]
      tlb_d0_13 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_14 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'he) begin // @[TLB.scala 155:37]
      tlb_d0_14 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 106:25]
      tlb_d0_15 <= 1'h0; // @[TLB.scala 106:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hf) begin // @[TLB.scala 155:37]
      tlb_d0_15 <= io_fromWriteBackStage_w_d0; // @[TLB.scala 162:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_0 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h0) begin // @[TLB.scala 155:37]
      tlb_v0_0 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_1 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h1) begin // @[TLB.scala 155:37]
      tlb_v0_1 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_2 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h2) begin // @[TLB.scala 155:37]
      tlb_v0_2 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_3 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h3) begin // @[TLB.scala 155:37]
      tlb_v0_3 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_4 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h4) begin // @[TLB.scala 155:37]
      tlb_v0_4 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_5 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h5) begin // @[TLB.scala 155:37]
      tlb_v0_5 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_6 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h6) begin // @[TLB.scala 155:37]
      tlb_v0_6 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_7 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h7) begin // @[TLB.scala 155:37]
      tlb_v0_7 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_8 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h8) begin // @[TLB.scala 155:37]
      tlb_v0_8 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_9 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h9) begin // @[TLB.scala 155:37]
      tlb_v0_9 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_10 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'ha) begin // @[TLB.scala 155:37]
      tlb_v0_10 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_11 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hb) begin // @[TLB.scala 155:37]
      tlb_v0_11 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_12 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hc) begin // @[TLB.scala 155:37]
      tlb_v0_12 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_13 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hd) begin // @[TLB.scala 155:37]
      tlb_v0_13 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_14 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'he) begin // @[TLB.scala 155:37]
      tlb_v0_14 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 107:25]
      tlb_v0_15 <= 1'h0; // @[TLB.scala 107:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hf) begin // @[TLB.scala 155:37]
      tlb_v0_15 <= io_fromWriteBackStage_w_v0; // @[TLB.scala 163:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_0 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h0) begin // @[TLB.scala 155:37]
      tlb_pfn1_0 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_1 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h1) begin // @[TLB.scala 155:37]
      tlb_pfn1_1 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_2 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h2) begin // @[TLB.scala 155:37]
      tlb_pfn1_2 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_3 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h3) begin // @[TLB.scala 155:37]
      tlb_pfn1_3 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_4 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h4) begin // @[TLB.scala 155:37]
      tlb_pfn1_4 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_5 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h5) begin // @[TLB.scala 155:37]
      tlb_pfn1_5 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_6 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h6) begin // @[TLB.scala 155:37]
      tlb_pfn1_6 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_7 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h7) begin // @[TLB.scala 155:37]
      tlb_pfn1_7 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_8 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h8) begin // @[TLB.scala 155:37]
      tlb_pfn1_8 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_9 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h9) begin // @[TLB.scala 155:37]
      tlb_pfn1_9 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_10 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'ha) begin // @[TLB.scala 155:37]
      tlb_pfn1_10 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_11 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hb) begin // @[TLB.scala 155:37]
      tlb_pfn1_11 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_12 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hc) begin // @[TLB.scala 155:37]
      tlb_pfn1_12 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_13 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hd) begin // @[TLB.scala 155:37]
      tlb_pfn1_13 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_14 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'he) begin // @[TLB.scala 155:37]
      tlb_pfn1_14 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 108:25]
      tlb_pfn1_15 <= 20'h0; // @[TLB.scala 108:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hf) begin // @[TLB.scala 155:37]
      tlb_pfn1_15 <= io_fromWriteBackStage_w_pfn1; // @[TLB.scala 165:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_0 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h0) begin // @[TLB.scala 155:37]
      tlb_c1_0 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_1 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h1) begin // @[TLB.scala 155:37]
      tlb_c1_1 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_2 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h2) begin // @[TLB.scala 155:37]
      tlb_c1_2 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_3 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h3) begin // @[TLB.scala 155:37]
      tlb_c1_3 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_4 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h4) begin // @[TLB.scala 155:37]
      tlb_c1_4 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_5 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h5) begin // @[TLB.scala 155:37]
      tlb_c1_5 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_6 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h6) begin // @[TLB.scala 155:37]
      tlb_c1_6 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_7 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h7) begin // @[TLB.scala 155:37]
      tlb_c1_7 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_8 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h8) begin // @[TLB.scala 155:37]
      tlb_c1_8 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_9 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h9) begin // @[TLB.scala 155:37]
      tlb_c1_9 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_10 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'ha) begin // @[TLB.scala 155:37]
      tlb_c1_10 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_11 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hb) begin // @[TLB.scala 155:37]
      tlb_c1_11 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_12 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hc) begin // @[TLB.scala 155:37]
      tlb_c1_12 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_13 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hd) begin // @[TLB.scala 155:37]
      tlb_c1_13 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_14 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'he) begin // @[TLB.scala 155:37]
      tlb_c1_14 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 109:25]
      tlb_c1_15 <= 3'h0; // @[TLB.scala 109:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hf) begin // @[TLB.scala 155:37]
      tlb_c1_15 <= io_fromWriteBackStage_w_c1; // @[TLB.scala 166:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_0 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h0) begin // @[TLB.scala 155:37]
      tlb_d1_0 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_1 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h1) begin // @[TLB.scala 155:37]
      tlb_d1_1 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_2 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h2) begin // @[TLB.scala 155:37]
      tlb_d1_2 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_3 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h3) begin // @[TLB.scala 155:37]
      tlb_d1_3 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_4 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h4) begin // @[TLB.scala 155:37]
      tlb_d1_4 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_5 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h5) begin // @[TLB.scala 155:37]
      tlb_d1_5 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_6 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h6) begin // @[TLB.scala 155:37]
      tlb_d1_6 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_7 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h7) begin // @[TLB.scala 155:37]
      tlb_d1_7 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_8 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h8) begin // @[TLB.scala 155:37]
      tlb_d1_8 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_9 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h9) begin // @[TLB.scala 155:37]
      tlb_d1_9 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_10 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'ha) begin // @[TLB.scala 155:37]
      tlb_d1_10 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_11 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hb) begin // @[TLB.scala 155:37]
      tlb_d1_11 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_12 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hc) begin // @[TLB.scala 155:37]
      tlb_d1_12 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_13 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hd) begin // @[TLB.scala 155:37]
      tlb_d1_13 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_14 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'he) begin // @[TLB.scala 155:37]
      tlb_d1_14 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 110:25]
      tlb_d1_15 <= 1'h0; // @[TLB.scala 110:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hf) begin // @[TLB.scala 155:37]
      tlb_d1_15 <= io_fromWriteBackStage_w_d1; // @[TLB.scala 167:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_0 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h0) begin // @[TLB.scala 155:37]
      tlb_v1_0 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_1 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h1) begin // @[TLB.scala 155:37]
      tlb_v1_1 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_2 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h2) begin // @[TLB.scala 155:37]
      tlb_v1_2 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_3 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h3) begin // @[TLB.scala 155:37]
      tlb_v1_3 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_4 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h4) begin // @[TLB.scala 155:37]
      tlb_v1_4 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_5 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h5) begin // @[TLB.scala 155:37]
      tlb_v1_5 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_6 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h6) begin // @[TLB.scala 155:37]
      tlb_v1_6 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_7 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h7) begin // @[TLB.scala 155:37]
      tlb_v1_7 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_8 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h8) begin // @[TLB.scala 155:37]
      tlb_v1_8 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_9 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'h9) begin // @[TLB.scala 155:37]
      tlb_v1_9 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_10 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'ha) begin // @[TLB.scala 155:37]
      tlb_v1_10 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_11 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hb) begin // @[TLB.scala 155:37]
      tlb_v1_11 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_12 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hc) begin // @[TLB.scala 155:37]
      tlb_v1_12 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_13 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hd) begin // @[TLB.scala 155:37]
      tlb_v1_13 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_14 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'he) begin // @[TLB.scala 155:37]
      tlb_v1_14 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
    end
    if (reset) begin // @[TLB.scala 111:25]
      tlb_v1_15 <= 1'h0; // @[TLB.scala 111:25]
    end else if (io_fromWriteBackStage_we & io_fromWriteBackStage_w_index == 4'hf) begin // @[TLB.scala 155:37]
      tlb_v1_15 <= io_fromWriteBackStage_w_v1; // @[TLB.scala 168:23]
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
  tlb_vpn2_0 = _RAND_0[18:0];
  _RAND_1 = {1{`RANDOM}};
  tlb_vpn2_1 = _RAND_1[18:0];
  _RAND_2 = {1{`RANDOM}};
  tlb_vpn2_2 = _RAND_2[18:0];
  _RAND_3 = {1{`RANDOM}};
  tlb_vpn2_3 = _RAND_3[18:0];
  _RAND_4 = {1{`RANDOM}};
  tlb_vpn2_4 = _RAND_4[18:0];
  _RAND_5 = {1{`RANDOM}};
  tlb_vpn2_5 = _RAND_5[18:0];
  _RAND_6 = {1{`RANDOM}};
  tlb_vpn2_6 = _RAND_6[18:0];
  _RAND_7 = {1{`RANDOM}};
  tlb_vpn2_7 = _RAND_7[18:0];
  _RAND_8 = {1{`RANDOM}};
  tlb_vpn2_8 = _RAND_8[18:0];
  _RAND_9 = {1{`RANDOM}};
  tlb_vpn2_9 = _RAND_9[18:0];
  _RAND_10 = {1{`RANDOM}};
  tlb_vpn2_10 = _RAND_10[18:0];
  _RAND_11 = {1{`RANDOM}};
  tlb_vpn2_11 = _RAND_11[18:0];
  _RAND_12 = {1{`RANDOM}};
  tlb_vpn2_12 = _RAND_12[18:0];
  _RAND_13 = {1{`RANDOM}};
  tlb_vpn2_13 = _RAND_13[18:0];
  _RAND_14 = {1{`RANDOM}};
  tlb_vpn2_14 = _RAND_14[18:0];
  _RAND_15 = {1{`RANDOM}};
  tlb_vpn2_15 = _RAND_15[18:0];
  _RAND_16 = {1{`RANDOM}};
  tlb_asid_0 = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  tlb_asid_1 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  tlb_asid_2 = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  tlb_asid_3 = _RAND_19[7:0];
  _RAND_20 = {1{`RANDOM}};
  tlb_asid_4 = _RAND_20[7:0];
  _RAND_21 = {1{`RANDOM}};
  tlb_asid_5 = _RAND_21[7:0];
  _RAND_22 = {1{`RANDOM}};
  tlb_asid_6 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  tlb_asid_7 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  tlb_asid_8 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  tlb_asid_9 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  tlb_asid_10 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  tlb_asid_11 = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  tlb_asid_12 = _RAND_28[7:0];
  _RAND_29 = {1{`RANDOM}};
  tlb_asid_13 = _RAND_29[7:0];
  _RAND_30 = {1{`RANDOM}};
  tlb_asid_14 = _RAND_30[7:0];
  _RAND_31 = {1{`RANDOM}};
  tlb_asid_15 = _RAND_31[7:0];
  _RAND_32 = {1{`RANDOM}};
  tlb_g_0 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  tlb_g_1 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  tlb_g_2 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  tlb_g_3 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  tlb_g_4 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  tlb_g_5 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  tlb_g_6 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  tlb_g_7 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  tlb_g_8 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  tlb_g_9 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  tlb_g_10 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  tlb_g_11 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  tlb_g_12 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  tlb_g_13 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  tlb_g_14 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  tlb_g_15 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  tlb_pfn0_0 = _RAND_48[19:0];
  _RAND_49 = {1{`RANDOM}};
  tlb_pfn0_1 = _RAND_49[19:0];
  _RAND_50 = {1{`RANDOM}};
  tlb_pfn0_2 = _RAND_50[19:0];
  _RAND_51 = {1{`RANDOM}};
  tlb_pfn0_3 = _RAND_51[19:0];
  _RAND_52 = {1{`RANDOM}};
  tlb_pfn0_4 = _RAND_52[19:0];
  _RAND_53 = {1{`RANDOM}};
  tlb_pfn0_5 = _RAND_53[19:0];
  _RAND_54 = {1{`RANDOM}};
  tlb_pfn0_6 = _RAND_54[19:0];
  _RAND_55 = {1{`RANDOM}};
  tlb_pfn0_7 = _RAND_55[19:0];
  _RAND_56 = {1{`RANDOM}};
  tlb_pfn0_8 = _RAND_56[19:0];
  _RAND_57 = {1{`RANDOM}};
  tlb_pfn0_9 = _RAND_57[19:0];
  _RAND_58 = {1{`RANDOM}};
  tlb_pfn0_10 = _RAND_58[19:0];
  _RAND_59 = {1{`RANDOM}};
  tlb_pfn0_11 = _RAND_59[19:0];
  _RAND_60 = {1{`RANDOM}};
  tlb_pfn0_12 = _RAND_60[19:0];
  _RAND_61 = {1{`RANDOM}};
  tlb_pfn0_13 = _RAND_61[19:0];
  _RAND_62 = {1{`RANDOM}};
  tlb_pfn0_14 = _RAND_62[19:0];
  _RAND_63 = {1{`RANDOM}};
  tlb_pfn0_15 = _RAND_63[19:0];
  _RAND_64 = {1{`RANDOM}};
  tlb_c0_0 = _RAND_64[2:0];
  _RAND_65 = {1{`RANDOM}};
  tlb_c0_1 = _RAND_65[2:0];
  _RAND_66 = {1{`RANDOM}};
  tlb_c0_2 = _RAND_66[2:0];
  _RAND_67 = {1{`RANDOM}};
  tlb_c0_3 = _RAND_67[2:0];
  _RAND_68 = {1{`RANDOM}};
  tlb_c0_4 = _RAND_68[2:0];
  _RAND_69 = {1{`RANDOM}};
  tlb_c0_5 = _RAND_69[2:0];
  _RAND_70 = {1{`RANDOM}};
  tlb_c0_6 = _RAND_70[2:0];
  _RAND_71 = {1{`RANDOM}};
  tlb_c0_7 = _RAND_71[2:0];
  _RAND_72 = {1{`RANDOM}};
  tlb_c0_8 = _RAND_72[2:0];
  _RAND_73 = {1{`RANDOM}};
  tlb_c0_9 = _RAND_73[2:0];
  _RAND_74 = {1{`RANDOM}};
  tlb_c0_10 = _RAND_74[2:0];
  _RAND_75 = {1{`RANDOM}};
  tlb_c0_11 = _RAND_75[2:0];
  _RAND_76 = {1{`RANDOM}};
  tlb_c0_12 = _RAND_76[2:0];
  _RAND_77 = {1{`RANDOM}};
  tlb_c0_13 = _RAND_77[2:0];
  _RAND_78 = {1{`RANDOM}};
  tlb_c0_14 = _RAND_78[2:0];
  _RAND_79 = {1{`RANDOM}};
  tlb_c0_15 = _RAND_79[2:0];
  _RAND_80 = {1{`RANDOM}};
  tlb_d0_0 = _RAND_80[0:0];
  _RAND_81 = {1{`RANDOM}};
  tlb_d0_1 = _RAND_81[0:0];
  _RAND_82 = {1{`RANDOM}};
  tlb_d0_2 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  tlb_d0_3 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  tlb_d0_4 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  tlb_d0_5 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  tlb_d0_6 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  tlb_d0_7 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  tlb_d0_8 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  tlb_d0_9 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  tlb_d0_10 = _RAND_90[0:0];
  _RAND_91 = {1{`RANDOM}};
  tlb_d0_11 = _RAND_91[0:0];
  _RAND_92 = {1{`RANDOM}};
  tlb_d0_12 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  tlb_d0_13 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  tlb_d0_14 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  tlb_d0_15 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  tlb_v0_0 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  tlb_v0_1 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  tlb_v0_2 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  tlb_v0_3 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  tlb_v0_4 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  tlb_v0_5 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  tlb_v0_6 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  tlb_v0_7 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  tlb_v0_8 = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  tlb_v0_9 = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  tlb_v0_10 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  tlb_v0_11 = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  tlb_v0_12 = _RAND_108[0:0];
  _RAND_109 = {1{`RANDOM}};
  tlb_v0_13 = _RAND_109[0:0];
  _RAND_110 = {1{`RANDOM}};
  tlb_v0_14 = _RAND_110[0:0];
  _RAND_111 = {1{`RANDOM}};
  tlb_v0_15 = _RAND_111[0:0];
  _RAND_112 = {1{`RANDOM}};
  tlb_pfn1_0 = _RAND_112[19:0];
  _RAND_113 = {1{`RANDOM}};
  tlb_pfn1_1 = _RAND_113[19:0];
  _RAND_114 = {1{`RANDOM}};
  tlb_pfn1_2 = _RAND_114[19:0];
  _RAND_115 = {1{`RANDOM}};
  tlb_pfn1_3 = _RAND_115[19:0];
  _RAND_116 = {1{`RANDOM}};
  tlb_pfn1_4 = _RAND_116[19:0];
  _RAND_117 = {1{`RANDOM}};
  tlb_pfn1_5 = _RAND_117[19:0];
  _RAND_118 = {1{`RANDOM}};
  tlb_pfn1_6 = _RAND_118[19:0];
  _RAND_119 = {1{`RANDOM}};
  tlb_pfn1_7 = _RAND_119[19:0];
  _RAND_120 = {1{`RANDOM}};
  tlb_pfn1_8 = _RAND_120[19:0];
  _RAND_121 = {1{`RANDOM}};
  tlb_pfn1_9 = _RAND_121[19:0];
  _RAND_122 = {1{`RANDOM}};
  tlb_pfn1_10 = _RAND_122[19:0];
  _RAND_123 = {1{`RANDOM}};
  tlb_pfn1_11 = _RAND_123[19:0];
  _RAND_124 = {1{`RANDOM}};
  tlb_pfn1_12 = _RAND_124[19:0];
  _RAND_125 = {1{`RANDOM}};
  tlb_pfn1_13 = _RAND_125[19:0];
  _RAND_126 = {1{`RANDOM}};
  tlb_pfn1_14 = _RAND_126[19:0];
  _RAND_127 = {1{`RANDOM}};
  tlb_pfn1_15 = _RAND_127[19:0];
  _RAND_128 = {1{`RANDOM}};
  tlb_c1_0 = _RAND_128[2:0];
  _RAND_129 = {1{`RANDOM}};
  tlb_c1_1 = _RAND_129[2:0];
  _RAND_130 = {1{`RANDOM}};
  tlb_c1_2 = _RAND_130[2:0];
  _RAND_131 = {1{`RANDOM}};
  tlb_c1_3 = _RAND_131[2:0];
  _RAND_132 = {1{`RANDOM}};
  tlb_c1_4 = _RAND_132[2:0];
  _RAND_133 = {1{`RANDOM}};
  tlb_c1_5 = _RAND_133[2:0];
  _RAND_134 = {1{`RANDOM}};
  tlb_c1_6 = _RAND_134[2:0];
  _RAND_135 = {1{`RANDOM}};
  tlb_c1_7 = _RAND_135[2:0];
  _RAND_136 = {1{`RANDOM}};
  tlb_c1_8 = _RAND_136[2:0];
  _RAND_137 = {1{`RANDOM}};
  tlb_c1_9 = _RAND_137[2:0];
  _RAND_138 = {1{`RANDOM}};
  tlb_c1_10 = _RAND_138[2:0];
  _RAND_139 = {1{`RANDOM}};
  tlb_c1_11 = _RAND_139[2:0];
  _RAND_140 = {1{`RANDOM}};
  tlb_c1_12 = _RAND_140[2:0];
  _RAND_141 = {1{`RANDOM}};
  tlb_c1_13 = _RAND_141[2:0];
  _RAND_142 = {1{`RANDOM}};
  tlb_c1_14 = _RAND_142[2:0];
  _RAND_143 = {1{`RANDOM}};
  tlb_c1_15 = _RAND_143[2:0];
  _RAND_144 = {1{`RANDOM}};
  tlb_d1_0 = _RAND_144[0:0];
  _RAND_145 = {1{`RANDOM}};
  tlb_d1_1 = _RAND_145[0:0];
  _RAND_146 = {1{`RANDOM}};
  tlb_d1_2 = _RAND_146[0:0];
  _RAND_147 = {1{`RANDOM}};
  tlb_d1_3 = _RAND_147[0:0];
  _RAND_148 = {1{`RANDOM}};
  tlb_d1_4 = _RAND_148[0:0];
  _RAND_149 = {1{`RANDOM}};
  tlb_d1_5 = _RAND_149[0:0];
  _RAND_150 = {1{`RANDOM}};
  tlb_d1_6 = _RAND_150[0:0];
  _RAND_151 = {1{`RANDOM}};
  tlb_d1_7 = _RAND_151[0:0];
  _RAND_152 = {1{`RANDOM}};
  tlb_d1_8 = _RAND_152[0:0];
  _RAND_153 = {1{`RANDOM}};
  tlb_d1_9 = _RAND_153[0:0];
  _RAND_154 = {1{`RANDOM}};
  tlb_d1_10 = _RAND_154[0:0];
  _RAND_155 = {1{`RANDOM}};
  tlb_d1_11 = _RAND_155[0:0];
  _RAND_156 = {1{`RANDOM}};
  tlb_d1_12 = _RAND_156[0:0];
  _RAND_157 = {1{`RANDOM}};
  tlb_d1_13 = _RAND_157[0:0];
  _RAND_158 = {1{`RANDOM}};
  tlb_d1_14 = _RAND_158[0:0];
  _RAND_159 = {1{`RANDOM}};
  tlb_d1_15 = _RAND_159[0:0];
  _RAND_160 = {1{`RANDOM}};
  tlb_v1_0 = _RAND_160[0:0];
  _RAND_161 = {1{`RANDOM}};
  tlb_v1_1 = _RAND_161[0:0];
  _RAND_162 = {1{`RANDOM}};
  tlb_v1_2 = _RAND_162[0:0];
  _RAND_163 = {1{`RANDOM}};
  tlb_v1_3 = _RAND_163[0:0];
  _RAND_164 = {1{`RANDOM}};
  tlb_v1_4 = _RAND_164[0:0];
  _RAND_165 = {1{`RANDOM}};
  tlb_v1_5 = _RAND_165[0:0];
  _RAND_166 = {1{`RANDOM}};
  tlb_v1_6 = _RAND_166[0:0];
  _RAND_167 = {1{`RANDOM}};
  tlb_v1_7 = _RAND_167[0:0];
  _RAND_168 = {1{`RANDOM}};
  tlb_v1_8 = _RAND_168[0:0];
  _RAND_169 = {1{`RANDOM}};
  tlb_v1_9 = _RAND_169[0:0];
  _RAND_170 = {1{`RANDOM}};
  tlb_v1_10 = _RAND_170[0:0];
  _RAND_171 = {1{`RANDOM}};
  tlb_v1_11 = _RAND_171[0:0];
  _RAND_172 = {1{`RANDOM}};
  tlb_v1_12 = _RAND_172[0:0];
  _RAND_173 = {1{`RANDOM}};
  tlb_v1_13 = _RAND_173[0:0];
  _RAND_174 = {1{`RANDOM}};
  tlb_v1_14 = _RAND_174[0:0];
  _RAND_175 = {1{`RANDOM}};
  tlb_v1_15 = _RAND_175[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PuaMips(
  input         clock,
  input         reset,
  input  [5:0]  io_ext_int,
  output [3:0]  io_axi_arid,
  output [31:0] io_axi_araddr,
  output [7:0]  io_axi_arlen,
  output [2:0]  io_axi_arsize,
  output [1:0]  io_axi_arburst,
  output [1:0]  io_axi_arlock,
  output [3:0]  io_axi_arcache,
  output [2:0]  io_axi_arprot,
  output        io_axi_arvalid,
  input         io_axi_arready,
  input  [3:0]  io_axi_rid,
  input  [31:0] io_axi_rdata,
  input  [1:0]  io_axi_rresp,
  input         io_axi_rlast,
  input         io_axi_rvalid,
  output        io_axi_rready,
  output [3:0]  io_axi_awid,
  output [31:0] io_axi_awaddr,
  output [7:0]  io_axi_awlen,
  output [2:0]  io_axi_awsize,
  output [1:0]  io_axi_awburst,
  output [1:0]  io_axi_awlock,
  output [3:0]  io_axi_awcache,
  output [2:0]  io_axi_awprot,
  output        io_axi_awvalid,
  input         io_axi_awready,
  output [3:0]  io_axi_wid,
  output [31:0] io_axi_wdata,
  output [3:0]  io_axi_wstrb,
  output        io_axi_wlast,
  output        io_axi_wvalid,
  input         io_axi_wready,
  input  [3:0]  io_axi_bid,
  input  [1:0]  io_axi_bresp,
  input         io_axi_bvalid,
  output        io_axi_bready,
  output [31:0] io_debug_pc,
  output [3:0]  io_debug_wen,
  output [4:0]  io_debug_waddr,
  output [31:0] io_debug_wdata
);
  wire  preFetchStage_clock; // @[PuaMips.scala 25:30]
  wire  preFetchStage_reset; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromFetchStage_valid; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromFetchStage_allowin; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromFetchStage_inst_unable; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromDecoder_br_leaving_ds; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromDecoder_branch_stall; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromDecoder_branch_flag; // @[PuaMips.scala 25:30]
  wire [31:0] preFetchStage_io_fromDecoder_branch_target_address; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromInstMemory_addr_ok; // @[PuaMips.scala 25:30]
  wire [31:0] preFetchStage_io_fromInstMemory_rdata; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromInstMemory_data_ok; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromInstMMU_tlb_refill; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromInstMMU_tlb_invalid; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromCtrl_after_ex; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromCtrl_do_flush; // @[PuaMips.scala 25:30]
  wire [31:0] preFetchStage_io_fromCtrl_flush_pc; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fromCtrl_block; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fetchStage_valid; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fetchStage_inst_ok; // @[PuaMips.scala 25:30]
  wire [31:0] preFetchStage_io_fetchStage_inst; // @[PuaMips.scala 25:30]
  wire [31:0] preFetchStage_io_fetchStage_pc; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fetchStage_tlb_refill; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_fetchStage_ex; // @[PuaMips.scala 25:30]
  wire [31:0] preFetchStage_io_fetchStage_badvaddr; // @[PuaMips.scala 25:30]
  wire [4:0] preFetchStage_io_fetchStage_excode; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_instMemory_req; // @[PuaMips.scala 25:30]
  wire  preFetchStage_io_instMemory_waiting; // @[PuaMips.scala 25:30]
  wire [31:0] preFetchStage_io_instMMU_vaddr; // @[PuaMips.scala 25:30]
  wire  fetchStage_clock; // @[PuaMips.scala 26:30]
  wire  fetchStage_reset; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_fromPreFetchStage_valid; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_fromPreFetchStage_inst_ok; // @[PuaMips.scala 26:30]
  wire [31:0] fetchStage_io_fromPreFetchStage_inst; // @[PuaMips.scala 26:30]
  wire [31:0] fetchStage_io_fromPreFetchStage_pc; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_fromPreFetchStage_tlb_refill; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_fromPreFetchStage_ex; // @[PuaMips.scala 26:30]
  wire [31:0] fetchStage_io_fromPreFetchStage_badvaddr; // @[PuaMips.scala 26:30]
  wire [4:0] fetchStage_io_fromPreFetchStage_excode; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_fromInstMemory_data_ok; // @[PuaMips.scala 26:30]
  wire [31:0] fetchStage_io_fromInstMemory_rdata; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_fromDecoder_allowin; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_fromCtrl_do_flush; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_ctrl_ex; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_preFetchStage_valid; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_preFetchStage_allowin; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_preFetchStage_inst_unable; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_decoderStage_valid; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_decoderStage_tlb_refill; // @[PuaMips.scala 26:30]
  wire [4:0] fetchStage_io_decoderStage_excode; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_decoderStage_ex; // @[PuaMips.scala 26:30]
  wire [31:0] fetchStage_io_decoderStage_badvaddr; // @[PuaMips.scala 26:30]
  wire [31:0] fetchStage_io_decoderStage_inst; // @[PuaMips.scala 26:30]
  wire [31:0] fetchStage_io_decoderStage_pc; // @[PuaMips.scala 26:30]
  wire  fetchStage_io_instMemory_waiting; // @[PuaMips.scala 26:30]
  wire  decoderStage_clock; // @[PuaMips.scala 27:30]
  wire  decoderStage_reset; // @[PuaMips.scala 27:30]
  wire  decoderStage_io_fromFetchStage_valid; // @[PuaMips.scala 27:30]
  wire  decoderStage_io_fromFetchStage_tlb_refill; // @[PuaMips.scala 27:30]
  wire [4:0] decoderStage_io_fromFetchStage_excode; // @[PuaMips.scala 27:30]
  wire  decoderStage_io_fromFetchStage_ex; // @[PuaMips.scala 27:30]
  wire [31:0] decoderStage_io_fromFetchStage_badvaddr; // @[PuaMips.scala 27:30]
  wire [31:0] decoderStage_io_fromFetchStage_inst; // @[PuaMips.scala 27:30]
  wire [31:0] decoderStage_io_fromFetchStage_pc; // @[PuaMips.scala 27:30]
  wire  decoderStage_io_fromDecoder_allowin; // @[PuaMips.scala 27:30]
  wire  decoderStage_io_fromCtrl_do_flush; // @[PuaMips.scala 27:30]
  wire  decoderStage_io_decoder_do_flush; // @[PuaMips.scala 27:30]
  wire  decoderStage_io_decoder_valid; // @[PuaMips.scala 27:30]
  wire  decoderStage_io_decoder_tlb_refill; // @[PuaMips.scala 27:30]
  wire [4:0] decoderStage_io_decoder_excode; // @[PuaMips.scala 27:30]
  wire  decoderStage_io_decoder_ex; // @[PuaMips.scala 27:30]
  wire [31:0] decoderStage_io_decoder_badvaddr; // @[PuaMips.scala 27:30]
  wire [31:0] decoderStage_io_decoder_inst; // @[PuaMips.scala 27:30]
  wire [31:0] decoderStage_io_decoder_pc; // @[PuaMips.scala 27:30]
  wire  decoder_clock; // @[PuaMips.scala 28:30]
  wire  decoder_reset; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromDecoderStage_do_flush; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromDecoderStage_valid; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromDecoderStage_tlb_refill; // @[PuaMips.scala 28:30]
  wire [4:0] decoder_io_fromDecoderStage_excode; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromDecoderStage_ex; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_fromDecoderStage_badvaddr; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_fromDecoderStage_inst; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_fromDecoderStage_pc; // @[PuaMips.scala 28:30]
  wire [4:0] decoder_io_fromExecute_reg_waddr; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_fromExecute_reg_wdata; // @[PuaMips.scala 28:30]
  wire [3:0] decoder_io_fromExecute_reg_wen; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromExecute_allowin; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromExecute_blk_valid; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromExecute_inst_is_mfc0; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromExecute_es_fwd_valid; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_fromRegfile_reg1_data; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_fromRegfile_reg2_data; // @[PuaMips.scala 28:30]
  wire [4:0] decoder_io_fromMemory_reg_waddr; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_fromMemory_reg_wdata; // @[PuaMips.scala 28:30]
  wire [3:0] decoder_io_fromMemory_reg_wen; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromMemory_inst_is_mfc0; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromMemory_ms_fwd_valid; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromMemory_blk_valid; // @[PuaMips.scala 28:30]
  wire  decoder_io_fromWriteBackStage_inst_is_mfc0; // @[PuaMips.scala 28:30]
  wire [4:0] decoder_io_fromWriteBackStage_reg_waddr; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_fromWriteBackStage_cp0_cause; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_fromWriteBackStage_cp0_status; // @[PuaMips.scala 28:30]
  wire  decoder_io_preFetchStage_br_leaving_ds; // @[PuaMips.scala 28:30]
  wire  decoder_io_preFetchStage_branch_stall; // @[PuaMips.scala 28:30]
  wire  decoder_io_preFetchStage_branch_flag; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_preFetchStage_branch_target_address; // @[PuaMips.scala 28:30]
  wire  decoder_io_fetchStage_allowin; // @[PuaMips.scala 28:30]
  wire  decoder_io_decoderStage_allowin; // @[PuaMips.scala 28:30]
  wire [6:0] decoder_io_executeStage_aluop; // @[PuaMips.scala 28:30]
  wire [2:0] decoder_io_executeStage_alusel; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_executeStage_inst; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_executeStage_link_addr; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_executeStage_reg1; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_executeStage_reg2; // @[PuaMips.scala 28:30]
  wire [4:0] decoder_io_executeStage_reg_waddr; // @[PuaMips.scala 28:30]
  wire [3:0] decoder_io_executeStage_reg_wen; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_executeStage_pc; // @[PuaMips.scala 28:30]
  wire  decoder_io_executeStage_valid; // @[PuaMips.scala 28:30]
  wire  decoder_io_executeStage_ex; // @[PuaMips.scala 28:30]
  wire  decoder_io_executeStage_bd; // @[PuaMips.scala 28:30]
  wire [31:0] decoder_io_executeStage_badvaddr; // @[PuaMips.scala 28:30]
  wire [7:0] decoder_io_executeStage_cp0_addr; // @[PuaMips.scala 28:30]
  wire [4:0] decoder_io_executeStage_excode; // @[PuaMips.scala 28:30]
  wire  decoder_io_executeStage_overflow_inst; // @[PuaMips.scala 28:30]
  wire  decoder_io_executeStage_tlb_refill; // @[PuaMips.scala 28:30]
  wire  decoder_io_executeStage_after_tlb; // @[PuaMips.scala 28:30]
  wire  decoder_io_executeStage_mem_re; // @[PuaMips.scala 28:30]
  wire  decoder_io_executeStage_mem_we; // @[PuaMips.scala 28:30]
  wire [4:0] decoder_io_regfile_reg1_raddr; // @[PuaMips.scala 28:30]
  wire [4:0] decoder_io_regfile_reg2_raddr; // @[PuaMips.scala 28:30]
  wire  decoder_io_ctrl_ex; // @[PuaMips.scala 28:30]
  wire  executeStage_clock; // @[PuaMips.scala 29:30]
  wire  executeStage_reset; // @[PuaMips.scala 29:30]
  wire [6:0] executeStage_io_fromDecoder_aluop; // @[PuaMips.scala 29:30]
  wire [2:0] executeStage_io_fromDecoder_alusel; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_fromDecoder_inst; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_fromDecoder_link_addr; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_fromDecoder_reg1; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_fromDecoder_reg2; // @[PuaMips.scala 29:30]
  wire [4:0] executeStage_io_fromDecoder_reg_waddr; // @[PuaMips.scala 29:30]
  wire [3:0] executeStage_io_fromDecoder_reg_wen; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_fromDecoder_pc; // @[PuaMips.scala 29:30]
  wire  executeStage_io_fromDecoder_valid; // @[PuaMips.scala 29:30]
  wire  executeStage_io_fromDecoder_ex; // @[PuaMips.scala 29:30]
  wire  executeStage_io_fromDecoder_bd; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_fromDecoder_badvaddr; // @[PuaMips.scala 29:30]
  wire [7:0] executeStage_io_fromDecoder_cp0_addr; // @[PuaMips.scala 29:30]
  wire [4:0] executeStage_io_fromDecoder_excode; // @[PuaMips.scala 29:30]
  wire  executeStage_io_fromDecoder_overflow_inst; // @[PuaMips.scala 29:30]
  wire  executeStage_io_fromDecoder_tlb_refill; // @[PuaMips.scala 29:30]
  wire  executeStage_io_fromDecoder_after_tlb; // @[PuaMips.scala 29:30]
  wire  executeStage_io_fromDecoder_mem_re; // @[PuaMips.scala 29:30]
  wire  executeStage_io_fromDecoder_mem_we; // @[PuaMips.scala 29:30]
  wire  executeStage_io_fromExecute_allowin; // @[PuaMips.scala 29:30]
  wire  executeStage_io_fromCtrl_do_flush; // @[PuaMips.scala 29:30]
  wire  executeStage_io_fromCtrl_after_ex; // @[PuaMips.scala 29:30]
  wire  executeStage_io_execute_do_flush; // @[PuaMips.scala 29:30]
  wire  executeStage_io_execute_after_ex; // @[PuaMips.scala 29:30]
  wire  executeStage_io_execute_valid; // @[PuaMips.scala 29:30]
  wire [6:0] executeStage_io_execute_aluop; // @[PuaMips.scala 29:30]
  wire [2:0] executeStage_io_execute_alusel; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_execute_inst; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_execute_link_addr; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_execute_reg1; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_execute_reg2; // @[PuaMips.scala 29:30]
  wire [4:0] executeStage_io_execute_reg_waddr; // @[PuaMips.scala 29:30]
  wire [3:0] executeStage_io_execute_reg_wen; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_execute_pc; // @[PuaMips.scala 29:30]
  wire  executeStage_io_execute_bd; // @[PuaMips.scala 29:30]
  wire [31:0] executeStage_io_execute_badvaddr; // @[PuaMips.scala 29:30]
  wire [7:0] executeStage_io_execute_cp0_addr; // @[PuaMips.scala 29:30]
  wire [4:0] executeStage_io_execute_excode; // @[PuaMips.scala 29:30]
  wire  executeStage_io_execute_overflow_inst; // @[PuaMips.scala 29:30]
  wire  executeStage_io_execute_ds_to_es_ex; // @[PuaMips.scala 29:30]
  wire  executeStage_io_execute_tlb_refill; // @[PuaMips.scala 29:30]
  wire  executeStage_io_execute_after_tlb; // @[PuaMips.scala 29:30]
  wire  executeStage_io_execute_mem_re; // @[PuaMips.scala 29:30]
  wire  executeStage_io_execute_mem_we; // @[PuaMips.scala 29:30]
  wire  execute_clock; // @[PuaMips.scala 30:30]
  wire  execute_reset; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromAlu_out; // @[PuaMips.scala 30:30]
  wire  execute_io_fromAlu_ov; // @[PuaMips.scala 30:30]
  wire [63:0] execute_io_fromMul_out; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromDiv_quotient; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromDiv_remainder; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromMov_out; // @[PuaMips.scala 30:30]
  wire  execute_io_fromDataMemory_addr_ok; // @[PuaMips.scala 30:30]
  wire  execute_io_fromDataMemory_data_ok; // @[PuaMips.scala 30:30]
  wire  execute_io_fromExecuteStage_do_flush; // @[PuaMips.scala 30:30]
  wire  execute_io_fromExecuteStage_after_ex; // @[PuaMips.scala 30:30]
  wire  execute_io_fromExecuteStage_valid; // @[PuaMips.scala 30:30]
  wire [6:0] execute_io_fromExecuteStage_aluop; // @[PuaMips.scala 30:30]
  wire [2:0] execute_io_fromExecuteStage_alusel; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromExecuteStage_inst; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromExecuteStage_link_addr; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromExecuteStage_reg1; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromExecuteStage_reg2; // @[PuaMips.scala 30:30]
  wire [4:0] execute_io_fromExecuteStage_reg_waddr; // @[PuaMips.scala 30:30]
  wire [3:0] execute_io_fromExecuteStage_reg_wen; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromExecuteStage_pc; // @[PuaMips.scala 30:30]
  wire  execute_io_fromExecuteStage_bd; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromExecuteStage_badvaddr; // @[PuaMips.scala 30:30]
  wire [7:0] execute_io_fromExecuteStage_cp0_addr; // @[PuaMips.scala 30:30]
  wire [4:0] execute_io_fromExecuteStage_excode; // @[PuaMips.scala 30:30]
  wire  execute_io_fromExecuteStage_overflow_inst; // @[PuaMips.scala 30:30]
  wire  execute_io_fromExecuteStage_ds_to_es_ex; // @[PuaMips.scala 30:30]
  wire  execute_io_fromExecuteStage_tlb_refill; // @[PuaMips.scala 30:30]
  wire  execute_io_fromExecuteStage_after_tlb; // @[PuaMips.scala 30:30]
  wire  execute_io_fromExecuteStage_mem_re; // @[PuaMips.scala 30:30]
  wire  execute_io_fromExecuteStage_mem_we; // @[PuaMips.scala 30:30]
  wire  execute_io_fromMemory_whilo; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromMemory_hi; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromMemory_lo; // @[PuaMips.scala 30:30]
  wire  execute_io_fromMemory_allowin; // @[PuaMips.scala 30:30]
  wire  execute_io_fromMemory_inst_unable; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromHILO_hi; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromHILO_lo; // @[PuaMips.scala 30:30]
  wire  execute_io_fromWriteBackStage_whilo; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromWriteBackStage_hi; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_fromWriteBackStage_lo; // @[PuaMips.scala 30:30]
  wire  execute_io_fromDataMMU_tlb_refill; // @[PuaMips.scala 30:30]
  wire  execute_io_fromDataMMU_tlb_invalid; // @[PuaMips.scala 30:30]
  wire  execute_io_fromDataMMU_tlb_modified; // @[PuaMips.scala 30:30]
  wire  execute_io_fromTLB_s1_found; // @[PuaMips.scala 30:30]
  wire [3:0] execute_io_fromTLB_s1_index; // @[PuaMips.scala 30:30]
  wire [6:0] execute_io_alu_op; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_alu_in1; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_alu_in2; // @[PuaMips.scala 30:30]
  wire [6:0] execute_io_mul_op; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_mul_in1; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_mul_in2; // @[PuaMips.scala 30:30]
  wire [6:0] execute_io_div_op; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_div_divisor; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_div_dividend; // @[PuaMips.scala 30:30]
  wire [6:0] execute_io_mov_op; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_mov_inst; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_mov_in; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_mov_hi; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_mov_lo; // @[PuaMips.scala 30:30]
  wire [4:0] execute_io_decoder_reg_waddr; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_decoder_reg_wdata; // @[PuaMips.scala 30:30]
  wire [3:0] execute_io_decoder_reg_wen; // @[PuaMips.scala 30:30]
  wire  execute_io_decoder_allowin; // @[PuaMips.scala 30:30]
  wire  execute_io_decoder_blk_valid; // @[PuaMips.scala 30:30]
  wire  execute_io_decoder_inst_is_mfc0; // @[PuaMips.scala 30:30]
  wire  execute_io_decoder_es_fwd_valid; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_dataMMU_vaddr; // @[PuaMips.scala 30:30]
  wire  execute_io_dataMMU_inst_is_tlbp; // @[PuaMips.scala 30:30]
  wire [6:0] execute_io_memoryStage_aluop; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_memoryStage_hi; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_memoryStage_lo; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_memoryStage_reg2; // @[PuaMips.scala 30:30]
  wire [4:0] execute_io_memoryStage_reg_waddr; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_memoryStage_reg_wdata; // @[PuaMips.scala 30:30]
  wire  execute_io_memoryStage_whilo; // @[PuaMips.scala 30:30]
  wire [3:0] execute_io_memoryStage_reg_wen; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_memoryStage_pc; // @[PuaMips.scala 30:30]
  wire  execute_io_memoryStage_valid; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_memoryStage_mem_addr; // @[PuaMips.scala 30:30]
  wire  execute_io_memoryStage_bd; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_memoryStage_badvaddr; // @[PuaMips.scala 30:30]
  wire [7:0] execute_io_memoryStage_cp0_addr; // @[PuaMips.scala 30:30]
  wire [4:0] execute_io_memoryStage_excode; // @[PuaMips.scala 30:30]
  wire  execute_io_memoryStage_ex; // @[PuaMips.scala 30:30]
  wire  execute_io_memoryStage_data_ok; // @[PuaMips.scala 30:30]
  wire  execute_io_memoryStage_wait_mem; // @[PuaMips.scala 30:30]
  wire  execute_io_memoryStage_res_from_mem; // @[PuaMips.scala 30:30]
  wire  execute_io_memoryStage_tlb_refill; // @[PuaMips.scala 30:30]
  wire  execute_io_memoryStage_after_tlb; // @[PuaMips.scala 30:30]
  wire  execute_io_memoryStage_s1_found; // @[PuaMips.scala 30:30]
  wire [3:0] execute_io_memoryStage_s1_index; // @[PuaMips.scala 30:30]
  wire [6:0] execute_io_dataMemory_aluop; // @[PuaMips.scala 30:30]
  wire [1:0] execute_io_dataMemory_addrLowBit2; // @[PuaMips.scala 30:30]
  wire  execute_io_dataMemory_req; // @[PuaMips.scala 30:30]
  wire  execute_io_dataMemory_wr; // @[PuaMips.scala 30:30]
  wire [1:0] execute_io_dataMemory_size; // @[PuaMips.scala 30:30]
  wire [31:0] execute_io_dataMemory_wdata; // @[PuaMips.scala 30:30]
  wire [3:0] execute_io_dataMemory_wstrb; // @[PuaMips.scala 30:30]
  wire  execute_io_dataMemory_waiting; // @[PuaMips.scala 30:30]
  wire  execute_io_executeStage_allowin; // @[PuaMips.scala 30:30]
  wire  execute_io_ctrl_ex; // @[PuaMips.scala 30:30]
  wire [6:0] alu_io_fromExecute_op; // @[PuaMips.scala 31:30]
  wire [31:0] alu_io_fromExecute_in1; // @[PuaMips.scala 31:30]
  wire [31:0] alu_io_fromExecute_in2; // @[PuaMips.scala 31:30]
  wire [31:0] alu_io_execute_out; // @[PuaMips.scala 31:30]
  wire  alu_io_execute_ov; // @[PuaMips.scala 31:30]
  wire [6:0] mul_io_fromExecute_op; // @[PuaMips.scala 32:30]
  wire [31:0] mul_io_fromExecute_in1; // @[PuaMips.scala 32:30]
  wire [31:0] mul_io_fromExecute_in2; // @[PuaMips.scala 32:30]
  wire [63:0] mul_io_execute_out; // @[PuaMips.scala 32:30]
  wire [6:0] div_io_fromExecute_op; // @[PuaMips.scala 33:30]
  wire [31:0] div_io_fromExecute_divisor; // @[PuaMips.scala 33:30]
  wire [31:0] div_io_fromExecute_dividend; // @[PuaMips.scala 33:30]
  wire [31:0] div_io_execute_quotient; // @[PuaMips.scala 33:30]
  wire [31:0] div_io_execute_remainder; // @[PuaMips.scala 33:30]
  wire  mov_io_fromMemory_cp0_wen; // @[PuaMips.scala 34:30]
  wire  mov_io_fromMemory_cp0_waddr; // @[PuaMips.scala 34:30]
  wire  mov_io_fromMemory_cp0_wdata; // @[PuaMips.scala 34:30]
  wire  mov_io_fromWriteBackStage_cp0_wen; // @[PuaMips.scala 34:30]
  wire  mov_io_fromWriteBackStage_cp0_waddr; // @[PuaMips.scala 34:30]
  wire  mov_io_fromWriteBackStage_cp0_wdata; // @[PuaMips.scala 34:30]
  wire [31:0] mov_io_fromWriteBackStage_cp0_rdata; // @[PuaMips.scala 34:30]
  wire [6:0] mov_io_fromExecute_op; // @[PuaMips.scala 34:30]
  wire [31:0] mov_io_fromExecute_inst; // @[PuaMips.scala 34:30]
  wire [31:0] mov_io_fromExecute_in; // @[PuaMips.scala 34:30]
  wire [31:0] mov_io_fromExecute_hi; // @[PuaMips.scala 34:30]
  wire [31:0] mov_io_fromExecute_lo; // @[PuaMips.scala 34:30]
  wire [31:0] mov_io_execute_out; // @[PuaMips.scala 34:30]
  wire  instMemory_clock; // @[PuaMips.scala 35:30]
  wire  instMemory_reset; // @[PuaMips.scala 35:30]
  wire  instMemory_io_fromPreFetchStage_req; // @[PuaMips.scala 35:30]
  wire  instMemory_io_fromPreFetchStage_waiting; // @[PuaMips.scala 35:30]
  wire  instMemory_io_fromFetchStage_waiting; // @[PuaMips.scala 35:30]
  wire [31:0] instMemory_io_fromInstMMU_paddr; // @[PuaMips.scala 35:30]
  wire  instMemory_io_fromCtrl_do_flush; // @[PuaMips.scala 35:30]
  wire  instMemory_io_preFetchStage_addr_ok; // @[PuaMips.scala 35:30]
  wire [31:0] instMemory_io_preFetchStage_rdata; // @[PuaMips.scala 35:30]
  wire  instMemory_io_preFetchStage_data_ok; // @[PuaMips.scala 35:30]
  wire  instMemory_io_fetchStage_data_ok; // @[PuaMips.scala 35:30]
  wire [31:0] instMemory_io_fetchStage_rdata; // @[PuaMips.scala 35:30]
  wire  instMemory_io_sramAXITrans_req; // @[PuaMips.scala 35:30]
  wire [31:0] instMemory_io_sramAXITrans_addr; // @[PuaMips.scala 35:30]
  wire  instMemory_io_sramAXITrans_data_ok; // @[PuaMips.scala 35:30]
  wire  instMemory_io_sramAXITrans_addr_ok; // @[PuaMips.scala 35:30]
  wire [31:0] instMemory_io_sramAXITrans_rdata; // @[PuaMips.scala 35:30]
  wire [1:0] instMemory_io_ctrl_inst_sram_discard; // @[PuaMips.scala 35:30]
  wire  dataMemory_clock; // @[PuaMips.scala 36:30]
  wire  dataMemory_reset; // @[PuaMips.scala 36:30]
  wire [6:0] dataMemory_io_fromExecute_aluop; // @[PuaMips.scala 36:30]
  wire [1:0] dataMemory_io_fromExecute_addrLowBit2; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_fromExecute_req; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_fromExecute_wr; // @[PuaMips.scala 36:30]
  wire [1:0] dataMemory_io_fromExecute_size; // @[PuaMips.scala 36:30]
  wire [31:0] dataMemory_io_fromExecute_wdata; // @[PuaMips.scala 36:30]
  wire [3:0] dataMemory_io_fromExecute_wstrb; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_fromExecute_waiting; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_fromMemory_waiting; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_fromCtrl_do_flush; // @[PuaMips.scala 36:30]
  wire [31:0] dataMemory_io_fromDataMMU_paddr; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_execute_addr_ok; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_execute_data_ok; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_memory_data_ok; // @[PuaMips.scala 36:30]
  wire [31:0] dataMemory_io_memory_rdata; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_sramAXITrans_req; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_sramAXITrans_wr; // @[PuaMips.scala 36:30]
  wire [1:0] dataMemory_io_sramAXITrans_size; // @[PuaMips.scala 36:30]
  wire [31:0] dataMemory_io_sramAXITrans_addr; // @[PuaMips.scala 36:30]
  wire [3:0] dataMemory_io_sramAXITrans_wstrb; // @[PuaMips.scala 36:30]
  wire [31:0] dataMemory_io_sramAXITrans_wdata; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_sramAXITrans_addr_ok; // @[PuaMips.scala 36:30]
  wire  dataMemory_io_sramAXITrans_data_ok; // @[PuaMips.scala 36:30]
  wire [31:0] dataMemory_io_sramAXITrans_rdata; // @[PuaMips.scala 36:30]
  wire [1:0] dataMemory_io_ctrl_data_sram_discard; // @[PuaMips.scala 36:30]
  wire  sramAXITrans_clock; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_reset; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_instMemory_req; // @[PuaMips.scala 37:30]
  wire [31:0] sramAXITrans_io_instMemory_addr; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_instMemory_data_ok; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_instMemory_addr_ok; // @[PuaMips.scala 37:30]
  wire [31:0] sramAXITrans_io_instMemory_rdata; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_dataMemory_req; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_dataMemory_wr; // @[PuaMips.scala 37:30]
  wire [1:0] sramAXITrans_io_dataMemory_size; // @[PuaMips.scala 37:30]
  wire [31:0] sramAXITrans_io_dataMemory_addr; // @[PuaMips.scala 37:30]
  wire [3:0] sramAXITrans_io_dataMemory_wstrb; // @[PuaMips.scala 37:30]
  wire [31:0] sramAXITrans_io_dataMemory_wdata; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_dataMemory_addr_ok; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_dataMemory_data_ok; // @[PuaMips.scala 37:30]
  wire [31:0] sramAXITrans_io_dataMemory_rdata; // @[PuaMips.scala 37:30]
  wire [3:0] sramAXITrans_io_axi_arid; // @[PuaMips.scala 37:30]
  wire [31:0] sramAXITrans_io_axi_araddr; // @[PuaMips.scala 37:30]
  wire [2:0] sramAXITrans_io_axi_arsize; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_axi_arvalid; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_axi_arready; // @[PuaMips.scala 37:30]
  wire [3:0] sramAXITrans_io_axi_rid; // @[PuaMips.scala 37:30]
  wire [31:0] sramAXITrans_io_axi_rdata; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_axi_rvalid; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_axi_rready; // @[PuaMips.scala 37:30]
  wire [31:0] sramAXITrans_io_axi_awaddr; // @[PuaMips.scala 37:30]
  wire [2:0] sramAXITrans_io_axi_awsize; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_axi_awvalid; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_axi_awready; // @[PuaMips.scala 37:30]
  wire [31:0] sramAXITrans_io_axi_wdata; // @[PuaMips.scala 37:30]
  wire [3:0] sramAXITrans_io_axi_wstrb; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_axi_wvalid; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_axi_wready; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_axi_bvalid; // @[PuaMips.scala 37:30]
  wire  sramAXITrans_io_axi_bready; // @[PuaMips.scala 37:30]
  wire  memoryStage_clock; // @[PuaMips.scala 38:30]
  wire  memoryStage_reset; // @[PuaMips.scala 38:30]
  wire [6:0] memoryStage_io_fromExecute_aluop; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_fromExecute_hi; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_fromExecute_lo; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_fromExecute_reg2; // @[PuaMips.scala 38:30]
  wire [4:0] memoryStage_io_fromExecute_reg_waddr; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_fromExecute_reg_wdata; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromExecute_whilo; // @[PuaMips.scala 38:30]
  wire [3:0] memoryStage_io_fromExecute_reg_wen; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_fromExecute_pc; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromExecute_valid; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_fromExecute_mem_addr; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromExecute_bd; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_fromExecute_badvaddr; // @[PuaMips.scala 38:30]
  wire [7:0] memoryStage_io_fromExecute_cp0_addr; // @[PuaMips.scala 38:30]
  wire [4:0] memoryStage_io_fromExecute_excode; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromExecute_ex; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromExecute_data_ok; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromExecute_wait_mem; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromExecute_res_from_mem; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromExecute_tlb_refill; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromExecute_after_tlb; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromExecute_s1_found; // @[PuaMips.scala 38:30]
  wire [3:0] memoryStage_io_fromExecute_s1_index; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromMemory_allowin; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_fromCtrl_do_flush; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_memory_do_flush; // @[PuaMips.scala 38:30]
  wire [6:0] memoryStage_io_memory_aluop; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_memory_hi; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_memory_lo; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_memory_whilo; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_memory_mem_addr; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_memory_reg2; // @[PuaMips.scala 38:30]
  wire [4:0] memoryStage_io_memory_reg_waddr; // @[PuaMips.scala 38:30]
  wire [3:0] memoryStage_io_memory_reg_wen; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_memory_reg_wdata; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_memory_pc; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_memory_valid; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_memory_bd; // @[PuaMips.scala 38:30]
  wire [31:0] memoryStage_io_memory_badvaddr; // @[PuaMips.scala 38:30]
  wire [7:0] memoryStage_io_memory_cp0_addr; // @[PuaMips.scala 38:30]
  wire [4:0] memoryStage_io_memory_excode; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_memory_ex; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_memory_data_ok; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_memory_wait_mem; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_memory_res_from_mem; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_memory_tlb_refill; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_memory_after_tlb; // @[PuaMips.scala 38:30]
  wire  memoryStage_io_memory_s1_found; // @[PuaMips.scala 38:30]
  wire [3:0] memoryStage_io_memory_s1_index; // @[PuaMips.scala 38:30]
  wire  memory_reset; // @[PuaMips.scala 39:30]
  wire  memory_io_fromMemoryStage_do_flush; // @[PuaMips.scala 39:30]
  wire [6:0] memory_io_fromMemoryStage_aluop; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_fromMemoryStage_hi; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_fromMemoryStage_lo; // @[PuaMips.scala 39:30]
  wire  memory_io_fromMemoryStage_whilo; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_fromMemoryStage_mem_addr; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_fromMemoryStage_reg2; // @[PuaMips.scala 39:30]
  wire [4:0] memory_io_fromMemoryStage_reg_waddr; // @[PuaMips.scala 39:30]
  wire [3:0] memory_io_fromMemoryStage_reg_wen; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_fromMemoryStage_reg_wdata; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_fromMemoryStage_pc; // @[PuaMips.scala 39:30]
  wire  memory_io_fromMemoryStage_valid; // @[PuaMips.scala 39:30]
  wire  memory_io_fromMemoryStage_bd; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_fromMemoryStage_badvaddr; // @[PuaMips.scala 39:30]
  wire [7:0] memory_io_fromMemoryStage_cp0_addr; // @[PuaMips.scala 39:30]
  wire [4:0] memory_io_fromMemoryStage_excode; // @[PuaMips.scala 39:30]
  wire  memory_io_fromMemoryStage_ex; // @[PuaMips.scala 39:30]
  wire  memory_io_fromMemoryStage_data_ok; // @[PuaMips.scala 39:30]
  wire  memory_io_fromMemoryStage_wait_mem; // @[PuaMips.scala 39:30]
  wire  memory_io_fromMemoryStage_res_from_mem; // @[PuaMips.scala 39:30]
  wire  memory_io_fromMemoryStage_tlb_refill; // @[PuaMips.scala 39:30]
  wire  memory_io_fromMemoryStage_after_tlb; // @[PuaMips.scala 39:30]
  wire  memory_io_fromMemoryStage_s1_found; // @[PuaMips.scala 39:30]
  wire [3:0] memory_io_fromMemoryStage_s1_index; // @[PuaMips.scala 39:30]
  wire  memory_io_fromDataMemory_data_ok; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_fromDataMemory_rdata; // @[PuaMips.scala 39:30]
  wire [4:0] memory_io_decoder_reg_waddr; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_decoder_reg_wdata; // @[PuaMips.scala 39:30]
  wire [3:0] memory_io_decoder_reg_wen; // @[PuaMips.scala 39:30]
  wire  memory_io_decoder_inst_is_mfc0; // @[PuaMips.scala 39:30]
  wire  memory_io_decoder_ms_fwd_valid; // @[PuaMips.scala 39:30]
  wire  memory_io_decoder_blk_valid; // @[PuaMips.scala 39:30]
  wire  memory_io_mov_cp0_wen; // @[PuaMips.scala 39:30]
  wire  memory_io_mov_cp0_waddr; // @[PuaMips.scala 39:30]
  wire  memory_io_mov_cp0_wdata; // @[PuaMips.scala 39:30]
  wire  memory_io_memoryStage_allowin; // @[PuaMips.scala 39:30]
  wire  memory_io_dataMemory_waiting; // @[PuaMips.scala 39:30]
  wire  memory_io_execute_whilo; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_execute_hi; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_execute_lo; // @[PuaMips.scala 39:30]
  wire  memory_io_execute_allowin; // @[PuaMips.scala 39:30]
  wire  memory_io_execute_inst_unable; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_writeBackStage_pc; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_writeBackStage_reg_wdata; // @[PuaMips.scala 39:30]
  wire [4:0] memory_io_writeBackStage_reg_waddr; // @[PuaMips.scala 39:30]
  wire [3:0] memory_io_writeBackStage_reg_wen; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_whilo; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_writeBackStage_hi; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_writeBackStage_lo; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_valid; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_inst_is_mfc0; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_inst_is_mtc0; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_inst_is_eret; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_bd; // @[PuaMips.scala 39:30]
  wire [31:0] memory_io_writeBackStage_badvaddr; // @[PuaMips.scala 39:30]
  wire [7:0] memory_io_writeBackStage_cp0_addr; // @[PuaMips.scala 39:30]
  wire [4:0] memory_io_writeBackStage_excode; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_ex; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_inst_is_tlbp; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_inst_is_tlbr; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_inst_is_tlbwi; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_tlb_refill; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_after_tlb; // @[PuaMips.scala 39:30]
  wire  memory_io_writeBackStage_s1_found; // @[PuaMips.scala 39:30]
  wire [3:0] memory_io_writeBackStage_s1_index; // @[PuaMips.scala 39:30]
  wire  memory_io_ctrl_ex; // @[PuaMips.scala 39:30]
  wire  writeBackStage_clock; // @[PuaMips.scala 40:30]
  wire  writeBackStage_reset; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromMemory_pc; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromMemory_reg_wdata; // @[PuaMips.scala 40:30]
  wire [4:0] writeBackStage_io_fromMemory_reg_waddr; // @[PuaMips.scala 40:30]
  wire [3:0] writeBackStage_io_fromMemory_reg_wen; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_whilo; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromMemory_hi; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromMemory_lo; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_valid; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_inst_is_mfc0; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_inst_is_mtc0; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_inst_is_eret; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_bd; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromMemory_badvaddr; // @[PuaMips.scala 40:30]
  wire [7:0] writeBackStage_io_fromMemory_cp0_addr; // @[PuaMips.scala 40:30]
  wire [4:0] writeBackStage_io_fromMemory_excode; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_ex; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_inst_is_tlbp; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_inst_is_tlbr; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_inst_is_tlbwi; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_tlb_refill; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_after_tlb; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromMemory_s1_found; // @[PuaMips.scala 40:30]
  wire [3:0] writeBackStage_io_fromMemory_s1_index; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromCP0_cp0_rdata; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromCP0_cp0_status; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromCP0_cp0_cause; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromCP0_cp0_epc; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromCP0_cp0_entryhi; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromCP0_cp0_entrylo0; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromCP0_cp0_entrylo1; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_fromCP0_cp0_index; // @[PuaMips.scala 40:30]
  wire [18:0] writeBackStage_io_fromTLB_r_vpn2; // @[PuaMips.scala 40:30]
  wire [7:0] writeBackStage_io_fromTLB_r_asid; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromTLB_r_g; // @[PuaMips.scala 40:30]
  wire [19:0] writeBackStage_io_fromTLB_r_pfn0; // @[PuaMips.scala 40:30]
  wire [2:0] writeBackStage_io_fromTLB_r_c0; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromTLB_r_d0; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromTLB_r_v0; // @[PuaMips.scala 40:30]
  wire [19:0] writeBackStage_io_fromTLB_r_pfn1; // @[PuaMips.scala 40:30]
  wire [2:0] writeBackStage_io_fromTLB_r_c1; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromTLB_r_d1; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_fromTLB_r_v1; // @[PuaMips.scala 40:30]
  wire [5:0] writeBackStage_io_ext_int; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_decoder_inst_is_mfc0; // @[PuaMips.scala 40:30]
  wire [4:0] writeBackStage_io_decoder_reg_waddr; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_decoder_cp0_cause; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_decoder_cp0_status; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_regFile_reg_wdata; // @[PuaMips.scala 40:30]
  wire [4:0] writeBackStage_io_regFile_reg_waddr; // @[PuaMips.scala 40:30]
  wire [3:0] writeBackStage_io_regFile_reg_wen; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_execute_whilo; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_execute_hi; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_execute_lo; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_mov_cp0_wen; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_mov_cp0_waddr; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_mov_cp0_wdata; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_mov_cp0_rdata; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_hilo_whilo; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_hilo_hi; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_hilo_lo; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_wb_ex; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_wb_bd; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_eret_flush; // @[PuaMips.scala 40:30]
  wire [4:0] writeBackStage_io_cp0_wb_excode; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_cp0_wb_pc; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_cp0_wb_badvaddr; // @[PuaMips.scala 40:30]
  wire [5:0] writeBackStage_io_cp0_ext_int_in; // @[PuaMips.scala 40:30]
  wire [7:0] writeBackStage_io_cp0_cp0_addr; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_mtc0_we; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_cp0_cp0_wdata; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_tlbp; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_tlbr; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_s1_found; // @[PuaMips.scala 40:30]
  wire [3:0] writeBackStage_io_cp0_s1_index; // @[PuaMips.scala 40:30]
  wire [18:0] writeBackStage_io_cp0_r_vpn2; // @[PuaMips.scala 40:30]
  wire [7:0] writeBackStage_io_cp0_r_asid; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_r_g; // @[PuaMips.scala 40:30]
  wire [19:0] writeBackStage_io_cp0_r_pfn0; // @[PuaMips.scala 40:30]
  wire [2:0] writeBackStage_io_cp0_r_c0; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_r_d0; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_r_v0; // @[PuaMips.scala 40:30]
  wire [19:0] writeBackStage_io_cp0_r_pfn1; // @[PuaMips.scala 40:30]
  wire [2:0] writeBackStage_io_cp0_r_c1; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_r_d1; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_cp0_r_v1; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_ctrl_ex; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_ctrl_do_flush; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_ctrl_flush_pc; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_tlb_we; // @[PuaMips.scala 40:30]
  wire [3:0] writeBackStage_io_tlb_w_index; // @[PuaMips.scala 40:30]
  wire [18:0] writeBackStage_io_tlb_w_vpn2; // @[PuaMips.scala 40:30]
  wire [7:0] writeBackStage_io_tlb_w_asid; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_tlb_w_g; // @[PuaMips.scala 40:30]
  wire [19:0] writeBackStage_io_tlb_w_pfn0; // @[PuaMips.scala 40:30]
  wire [2:0] writeBackStage_io_tlb_w_c0; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_tlb_w_d0; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_tlb_w_v0; // @[PuaMips.scala 40:30]
  wire [19:0] writeBackStage_io_tlb_w_pfn1; // @[PuaMips.scala 40:30]
  wire [2:0] writeBackStage_io_tlb_w_c1; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_tlb_w_d1; // @[PuaMips.scala 40:30]
  wire  writeBackStage_io_tlb_w_v1; // @[PuaMips.scala 40:30]
  wire [3:0] writeBackStage_io_tlb_r_index; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_instMMU_cp0_entryhi; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_dataMMU_cp0_entryhi; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_debug_pc; // @[PuaMips.scala 40:30]
  wire [3:0] writeBackStage_io_debug_wen; // @[PuaMips.scala 40:30]
  wire [4:0] writeBackStage_io_debug_waddr; // @[PuaMips.scala 40:30]
  wire [31:0] writeBackStage_io_debug_wdata; // @[PuaMips.scala 40:30]
  wire  regfile_clock; // @[PuaMips.scala 41:30]
  wire  regfile_reset; // @[PuaMips.scala 41:30]
  wire [4:0] regfile_io_fromDecoder_reg1_raddr; // @[PuaMips.scala 41:30]
  wire [4:0] regfile_io_fromDecoder_reg2_raddr; // @[PuaMips.scala 41:30]
  wire [31:0] regfile_io_fromWriteBackStage_reg_wdata; // @[PuaMips.scala 41:30]
  wire [4:0] regfile_io_fromWriteBackStage_reg_waddr; // @[PuaMips.scala 41:30]
  wire [3:0] regfile_io_fromWriteBackStage_reg_wen; // @[PuaMips.scala 41:30]
  wire [31:0] regfile_io_decoder_reg1_data; // @[PuaMips.scala 41:30]
  wire [31:0] regfile_io_decoder_reg2_data; // @[PuaMips.scala 41:30]
  wire  hilo_clock; // @[PuaMips.scala 42:30]
  wire  hilo_reset; // @[PuaMips.scala 42:30]
  wire  hilo_io_fromWriteBackStage_whilo; // @[PuaMips.scala 42:30]
  wire [31:0] hilo_io_fromWriteBackStage_hi; // @[PuaMips.scala 42:30]
  wire [31:0] hilo_io_fromWriteBackStage_lo; // @[PuaMips.scala 42:30]
  wire [31:0] hilo_io_execute_hi; // @[PuaMips.scala 42:30]
  wire [31:0] hilo_io_execute_lo; // @[PuaMips.scala 42:30]
  wire  cp0_clock; // @[PuaMips.scala 43:30]
  wire  cp0_reset; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_wb_ex; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_wb_bd; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_eret_flush; // @[PuaMips.scala 43:30]
  wire [4:0] cp0_io_fromWriteBackStage_wb_excode; // @[PuaMips.scala 43:30]
  wire [31:0] cp0_io_fromWriteBackStage_wb_pc; // @[PuaMips.scala 43:30]
  wire [31:0] cp0_io_fromWriteBackStage_wb_badvaddr; // @[PuaMips.scala 43:30]
  wire [5:0] cp0_io_fromWriteBackStage_ext_int_in; // @[PuaMips.scala 43:30]
  wire [7:0] cp0_io_fromWriteBackStage_cp0_addr; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_mtc0_we; // @[PuaMips.scala 43:30]
  wire [31:0] cp0_io_fromWriteBackStage_cp0_wdata; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_tlbp; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_tlbr; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_s1_found; // @[PuaMips.scala 43:30]
  wire [3:0] cp0_io_fromWriteBackStage_s1_index; // @[PuaMips.scala 43:30]
  wire [18:0] cp0_io_fromWriteBackStage_r_vpn2; // @[PuaMips.scala 43:30]
  wire [7:0] cp0_io_fromWriteBackStage_r_asid; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_r_g; // @[PuaMips.scala 43:30]
  wire [19:0] cp0_io_fromWriteBackStage_r_pfn0; // @[PuaMips.scala 43:30]
  wire [2:0] cp0_io_fromWriteBackStage_r_c0; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_r_d0; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_r_v0; // @[PuaMips.scala 43:30]
  wire [19:0] cp0_io_fromWriteBackStage_r_pfn1; // @[PuaMips.scala 43:30]
  wire [2:0] cp0_io_fromWriteBackStage_r_c1; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_r_d1; // @[PuaMips.scala 43:30]
  wire  cp0_io_fromWriteBackStage_r_v1; // @[PuaMips.scala 43:30]
  wire [31:0] cp0_io_writeBackStage_cp0_rdata; // @[PuaMips.scala 43:30]
  wire [31:0] cp0_io_writeBackStage_cp0_status; // @[PuaMips.scala 43:30]
  wire [31:0] cp0_io_writeBackStage_cp0_cause; // @[PuaMips.scala 43:30]
  wire [31:0] cp0_io_writeBackStage_cp0_epc; // @[PuaMips.scala 43:30]
  wire [31:0] cp0_io_writeBackStage_cp0_entryhi; // @[PuaMips.scala 43:30]
  wire [31:0] cp0_io_writeBackStage_cp0_entrylo0; // @[PuaMips.scala 43:30]
  wire [31:0] cp0_io_writeBackStage_cp0_entrylo1; // @[PuaMips.scala 43:30]
  wire [31:0] cp0_io_writeBackStage_cp0_index; // @[PuaMips.scala 43:30]
  wire [31:0] instMMU_io_fromPreFetchStage_vaddr; // @[PuaMips.scala 44:30]
  wire [31:0] instMMU_io_fromWriteBackStage_cp0_entryhi; // @[PuaMips.scala 44:30]
  wire  instMMU_io_fromTLB_tlb_found; // @[PuaMips.scala 44:30]
  wire [19:0] instMMU_io_fromTLB_tlb_pfn; // @[PuaMips.scala 44:30]
  wire  instMMU_io_fromTLB_tlb_v; // @[PuaMips.scala 44:30]
  wire  instMMU_io_preFetchStage_tlb_refill; // @[PuaMips.scala 44:30]
  wire  instMMU_io_preFetchStage_tlb_invalid; // @[PuaMips.scala 44:30]
  wire [31:0] instMMU_io_instMemory_paddr; // @[PuaMips.scala 44:30]
  wire [18:0] instMMU_io_tlb_tlb_vpn2; // @[PuaMips.scala 44:30]
  wire  instMMU_io_tlb_tlb_odd_page; // @[PuaMips.scala 44:30]
  wire [7:0] instMMU_io_tlb_tlb_asid; // @[PuaMips.scala 44:30]
  wire [31:0] dataMMU_io_fromWriteBackStage_cp0_entryhi; // @[PuaMips.scala 45:30]
  wire  dataMMU_io_fromTLB_tlb_found; // @[PuaMips.scala 45:30]
  wire [19:0] dataMMU_io_fromTLB_tlb_pfn; // @[PuaMips.scala 45:30]
  wire  dataMMU_io_fromTLB_tlb_d; // @[PuaMips.scala 45:30]
  wire  dataMMU_io_fromTLB_tlb_v; // @[PuaMips.scala 45:30]
  wire [31:0] dataMMU_io_fromExecute_vaddr; // @[PuaMips.scala 45:30]
  wire  dataMMU_io_fromExecute_inst_is_tlbp; // @[PuaMips.scala 45:30]
  wire  dataMMU_io_execute_tlb_refill; // @[PuaMips.scala 45:30]
  wire  dataMMU_io_execute_tlb_invalid; // @[PuaMips.scala 45:30]
  wire  dataMMU_io_execute_tlb_modified; // @[PuaMips.scala 45:30]
  wire [31:0] dataMMU_io_dataMemory_paddr; // @[PuaMips.scala 45:30]
  wire [18:0] dataMMU_io_tlb_tlb_vpn2; // @[PuaMips.scala 45:30]
  wire  dataMMU_io_tlb_tlb_odd_page; // @[PuaMips.scala 45:30]
  wire [7:0] dataMMU_io_tlb_tlb_asid; // @[PuaMips.scala 45:30]
  wire [1:0] ctrl_io_fromInstMemory_inst_sram_discard; // @[PuaMips.scala 46:30]
  wire [1:0] ctrl_io_fromDataMemory_data_sram_discard; // @[PuaMips.scala 46:30]
  wire  ctrl_io_fromFetchStage_ex; // @[PuaMips.scala 46:30]
  wire  ctrl_io_fromDecoder_ex; // @[PuaMips.scala 46:30]
  wire  ctrl_io_fromExecute_ex; // @[PuaMips.scala 46:30]
  wire  ctrl_io_fromMemory_ex; // @[PuaMips.scala 46:30]
  wire  ctrl_io_fromWriteBackStage_ex; // @[PuaMips.scala 46:30]
  wire  ctrl_io_fromWriteBackStage_do_flush; // @[PuaMips.scala 46:30]
  wire [31:0] ctrl_io_fromWriteBackStage_flush_pc; // @[PuaMips.scala 46:30]
  wire  ctrl_io_preFetchStage_after_ex; // @[PuaMips.scala 46:30]
  wire  ctrl_io_preFetchStage_do_flush; // @[PuaMips.scala 46:30]
  wire [31:0] ctrl_io_preFetchStage_flush_pc; // @[PuaMips.scala 46:30]
  wire  ctrl_io_preFetchStage_block; // @[PuaMips.scala 46:30]
  wire  ctrl_io_fetchStage_do_flush; // @[PuaMips.scala 46:30]
  wire  ctrl_io_decoderStage_do_flush; // @[PuaMips.scala 46:30]
  wire  ctrl_io_executeStage_do_flush; // @[PuaMips.scala 46:30]
  wire  ctrl_io_executeStage_after_ex; // @[PuaMips.scala 46:30]
  wire  ctrl_io_memoryStage_do_flush; // @[PuaMips.scala 46:30]
  wire  ctrl_io_instMemory_do_flush; // @[PuaMips.scala 46:30]
  wire  ctrl_io_dataMemory_do_flush; // @[PuaMips.scala 46:30]
  wire  tlb_clock; // @[PuaMips.scala 47:30]
  wire  tlb_reset; // @[PuaMips.scala 47:30]
  wire [18:0] tlb_io_fromInstMMU_tlb_vpn2; // @[PuaMips.scala 47:30]
  wire  tlb_io_fromInstMMU_tlb_odd_page; // @[PuaMips.scala 47:30]
  wire [7:0] tlb_io_fromInstMMU_tlb_asid; // @[PuaMips.scala 47:30]
  wire [18:0] tlb_io_fromDataMMU_tlb_vpn2; // @[PuaMips.scala 47:30]
  wire  tlb_io_fromDataMMU_tlb_odd_page; // @[PuaMips.scala 47:30]
  wire [7:0] tlb_io_fromDataMMU_tlb_asid; // @[PuaMips.scala 47:30]
  wire  tlb_io_fromWriteBackStage_we; // @[PuaMips.scala 47:30]
  wire [3:0] tlb_io_fromWriteBackStage_w_index; // @[PuaMips.scala 47:30]
  wire [18:0] tlb_io_fromWriteBackStage_w_vpn2; // @[PuaMips.scala 47:30]
  wire [7:0] tlb_io_fromWriteBackStage_w_asid; // @[PuaMips.scala 47:30]
  wire  tlb_io_fromWriteBackStage_w_g; // @[PuaMips.scala 47:30]
  wire [19:0] tlb_io_fromWriteBackStage_w_pfn0; // @[PuaMips.scala 47:30]
  wire [2:0] tlb_io_fromWriteBackStage_w_c0; // @[PuaMips.scala 47:30]
  wire  tlb_io_fromWriteBackStage_w_d0; // @[PuaMips.scala 47:30]
  wire  tlb_io_fromWriteBackStage_w_v0; // @[PuaMips.scala 47:30]
  wire [19:0] tlb_io_fromWriteBackStage_w_pfn1; // @[PuaMips.scala 47:30]
  wire [2:0] tlb_io_fromWriteBackStage_w_c1; // @[PuaMips.scala 47:30]
  wire  tlb_io_fromWriteBackStage_w_d1; // @[PuaMips.scala 47:30]
  wire  tlb_io_fromWriteBackStage_w_v1; // @[PuaMips.scala 47:30]
  wire [3:0] tlb_io_fromWriteBackStage_r_index; // @[PuaMips.scala 47:30]
  wire  tlb_io_instMMU_tlb_found; // @[PuaMips.scala 47:30]
  wire [19:0] tlb_io_instMMU_tlb_pfn; // @[PuaMips.scala 47:30]
  wire  tlb_io_instMMU_tlb_v; // @[PuaMips.scala 47:30]
  wire  tlb_io_dataMMU_tlb_found; // @[PuaMips.scala 47:30]
  wire [19:0] tlb_io_dataMMU_tlb_pfn; // @[PuaMips.scala 47:30]
  wire  tlb_io_dataMMU_tlb_d; // @[PuaMips.scala 47:30]
  wire  tlb_io_dataMMU_tlb_v; // @[PuaMips.scala 47:30]
  wire  tlb_io_execute_s1_found; // @[PuaMips.scala 47:30]
  wire [3:0] tlb_io_execute_s1_index; // @[PuaMips.scala 47:30]
  wire [18:0] tlb_io_writeBackStage_r_vpn2; // @[PuaMips.scala 47:30]
  wire [7:0] tlb_io_writeBackStage_r_asid; // @[PuaMips.scala 47:30]
  wire  tlb_io_writeBackStage_r_g; // @[PuaMips.scala 47:30]
  wire [19:0] tlb_io_writeBackStage_r_pfn0; // @[PuaMips.scala 47:30]
  wire [2:0] tlb_io_writeBackStage_r_c0; // @[PuaMips.scala 47:30]
  wire  tlb_io_writeBackStage_r_d0; // @[PuaMips.scala 47:30]
  wire  tlb_io_writeBackStage_r_v0; // @[PuaMips.scala 47:30]
  wire [19:0] tlb_io_writeBackStage_r_pfn1; // @[PuaMips.scala 47:30]
  wire [2:0] tlb_io_writeBackStage_r_c1; // @[PuaMips.scala 47:30]
  wire  tlb_io_writeBackStage_r_d1; // @[PuaMips.scala 47:30]
  wire  tlb_io_writeBackStage_r_v1; // @[PuaMips.scala 47:30]
  PreFetchStage preFetchStage ( // @[PuaMips.scala 25:30]
    .clock(preFetchStage_clock),
    .reset(preFetchStage_reset),
    .io_fromFetchStage_valid(preFetchStage_io_fromFetchStage_valid),
    .io_fromFetchStage_allowin(preFetchStage_io_fromFetchStage_allowin),
    .io_fromFetchStage_inst_unable(preFetchStage_io_fromFetchStage_inst_unable),
    .io_fromDecoder_br_leaving_ds(preFetchStage_io_fromDecoder_br_leaving_ds),
    .io_fromDecoder_branch_stall(preFetchStage_io_fromDecoder_branch_stall),
    .io_fromDecoder_branch_flag(preFetchStage_io_fromDecoder_branch_flag),
    .io_fromDecoder_branch_target_address(preFetchStage_io_fromDecoder_branch_target_address),
    .io_fromInstMemory_addr_ok(preFetchStage_io_fromInstMemory_addr_ok),
    .io_fromInstMemory_rdata(preFetchStage_io_fromInstMemory_rdata),
    .io_fromInstMemory_data_ok(preFetchStage_io_fromInstMemory_data_ok),
    .io_fromInstMMU_tlb_refill(preFetchStage_io_fromInstMMU_tlb_refill),
    .io_fromInstMMU_tlb_invalid(preFetchStage_io_fromInstMMU_tlb_invalid),
    .io_fromCtrl_after_ex(preFetchStage_io_fromCtrl_after_ex),
    .io_fromCtrl_do_flush(preFetchStage_io_fromCtrl_do_flush),
    .io_fromCtrl_flush_pc(preFetchStage_io_fromCtrl_flush_pc),
    .io_fromCtrl_block(preFetchStage_io_fromCtrl_block),
    .io_fetchStage_valid(preFetchStage_io_fetchStage_valid),
    .io_fetchStage_inst_ok(preFetchStage_io_fetchStage_inst_ok),
    .io_fetchStage_inst(preFetchStage_io_fetchStage_inst),
    .io_fetchStage_pc(preFetchStage_io_fetchStage_pc),
    .io_fetchStage_tlb_refill(preFetchStage_io_fetchStage_tlb_refill),
    .io_fetchStage_ex(preFetchStage_io_fetchStage_ex),
    .io_fetchStage_badvaddr(preFetchStage_io_fetchStage_badvaddr),
    .io_fetchStage_excode(preFetchStage_io_fetchStage_excode),
    .io_instMemory_req(preFetchStage_io_instMemory_req),
    .io_instMemory_waiting(preFetchStage_io_instMemory_waiting),
    .io_instMMU_vaddr(preFetchStage_io_instMMU_vaddr)
  );
  FetchStage fetchStage ( // @[PuaMips.scala 26:30]
    .clock(fetchStage_clock),
    .reset(fetchStage_reset),
    .io_fromPreFetchStage_valid(fetchStage_io_fromPreFetchStage_valid),
    .io_fromPreFetchStage_inst_ok(fetchStage_io_fromPreFetchStage_inst_ok),
    .io_fromPreFetchStage_inst(fetchStage_io_fromPreFetchStage_inst),
    .io_fromPreFetchStage_pc(fetchStage_io_fromPreFetchStage_pc),
    .io_fromPreFetchStage_tlb_refill(fetchStage_io_fromPreFetchStage_tlb_refill),
    .io_fromPreFetchStage_ex(fetchStage_io_fromPreFetchStage_ex),
    .io_fromPreFetchStage_badvaddr(fetchStage_io_fromPreFetchStage_badvaddr),
    .io_fromPreFetchStage_excode(fetchStage_io_fromPreFetchStage_excode),
    .io_fromInstMemory_data_ok(fetchStage_io_fromInstMemory_data_ok),
    .io_fromInstMemory_rdata(fetchStage_io_fromInstMemory_rdata),
    .io_fromDecoder_allowin(fetchStage_io_fromDecoder_allowin),
    .io_fromCtrl_do_flush(fetchStage_io_fromCtrl_do_flush),
    .io_ctrl_ex(fetchStage_io_ctrl_ex),
    .io_preFetchStage_valid(fetchStage_io_preFetchStage_valid),
    .io_preFetchStage_allowin(fetchStage_io_preFetchStage_allowin),
    .io_preFetchStage_inst_unable(fetchStage_io_preFetchStage_inst_unable),
    .io_decoderStage_valid(fetchStage_io_decoderStage_valid),
    .io_decoderStage_tlb_refill(fetchStage_io_decoderStage_tlb_refill),
    .io_decoderStage_excode(fetchStage_io_decoderStage_excode),
    .io_decoderStage_ex(fetchStage_io_decoderStage_ex),
    .io_decoderStage_badvaddr(fetchStage_io_decoderStage_badvaddr),
    .io_decoderStage_inst(fetchStage_io_decoderStage_inst),
    .io_decoderStage_pc(fetchStage_io_decoderStage_pc),
    .io_instMemory_waiting(fetchStage_io_instMemory_waiting)
  );
  DecoderStage decoderStage ( // @[PuaMips.scala 27:30]
    .clock(decoderStage_clock),
    .reset(decoderStage_reset),
    .io_fromFetchStage_valid(decoderStage_io_fromFetchStage_valid),
    .io_fromFetchStage_tlb_refill(decoderStage_io_fromFetchStage_tlb_refill),
    .io_fromFetchStage_excode(decoderStage_io_fromFetchStage_excode),
    .io_fromFetchStage_ex(decoderStage_io_fromFetchStage_ex),
    .io_fromFetchStage_badvaddr(decoderStage_io_fromFetchStage_badvaddr),
    .io_fromFetchStage_inst(decoderStage_io_fromFetchStage_inst),
    .io_fromFetchStage_pc(decoderStage_io_fromFetchStage_pc),
    .io_fromDecoder_allowin(decoderStage_io_fromDecoder_allowin),
    .io_fromCtrl_do_flush(decoderStage_io_fromCtrl_do_flush),
    .io_decoder_do_flush(decoderStage_io_decoder_do_flush),
    .io_decoder_valid(decoderStage_io_decoder_valid),
    .io_decoder_tlb_refill(decoderStage_io_decoder_tlb_refill),
    .io_decoder_excode(decoderStage_io_decoder_excode),
    .io_decoder_ex(decoderStage_io_decoder_ex),
    .io_decoder_badvaddr(decoderStage_io_decoder_badvaddr),
    .io_decoder_inst(decoderStage_io_decoder_inst),
    .io_decoder_pc(decoderStage_io_decoder_pc)
  );
  Decoder decoder ( // @[PuaMips.scala 28:30]
    .clock(decoder_clock),
    .reset(decoder_reset),
    .io_fromDecoderStage_do_flush(decoder_io_fromDecoderStage_do_flush),
    .io_fromDecoderStage_valid(decoder_io_fromDecoderStage_valid),
    .io_fromDecoderStage_tlb_refill(decoder_io_fromDecoderStage_tlb_refill),
    .io_fromDecoderStage_excode(decoder_io_fromDecoderStage_excode),
    .io_fromDecoderStage_ex(decoder_io_fromDecoderStage_ex),
    .io_fromDecoderStage_badvaddr(decoder_io_fromDecoderStage_badvaddr),
    .io_fromDecoderStage_inst(decoder_io_fromDecoderStage_inst),
    .io_fromDecoderStage_pc(decoder_io_fromDecoderStage_pc),
    .io_fromExecute_reg_waddr(decoder_io_fromExecute_reg_waddr),
    .io_fromExecute_reg_wdata(decoder_io_fromExecute_reg_wdata),
    .io_fromExecute_reg_wen(decoder_io_fromExecute_reg_wen),
    .io_fromExecute_allowin(decoder_io_fromExecute_allowin),
    .io_fromExecute_blk_valid(decoder_io_fromExecute_blk_valid),
    .io_fromExecute_inst_is_mfc0(decoder_io_fromExecute_inst_is_mfc0),
    .io_fromExecute_es_fwd_valid(decoder_io_fromExecute_es_fwd_valid),
    .io_fromRegfile_reg1_data(decoder_io_fromRegfile_reg1_data),
    .io_fromRegfile_reg2_data(decoder_io_fromRegfile_reg2_data),
    .io_fromMemory_reg_waddr(decoder_io_fromMemory_reg_waddr),
    .io_fromMemory_reg_wdata(decoder_io_fromMemory_reg_wdata),
    .io_fromMemory_reg_wen(decoder_io_fromMemory_reg_wen),
    .io_fromMemory_inst_is_mfc0(decoder_io_fromMemory_inst_is_mfc0),
    .io_fromMemory_ms_fwd_valid(decoder_io_fromMemory_ms_fwd_valid),
    .io_fromMemory_blk_valid(decoder_io_fromMemory_blk_valid),
    .io_fromWriteBackStage_inst_is_mfc0(decoder_io_fromWriteBackStage_inst_is_mfc0),
    .io_fromWriteBackStage_reg_waddr(decoder_io_fromWriteBackStage_reg_waddr),
    .io_fromWriteBackStage_cp0_cause(decoder_io_fromWriteBackStage_cp0_cause),
    .io_fromWriteBackStage_cp0_status(decoder_io_fromWriteBackStage_cp0_status),
    .io_preFetchStage_br_leaving_ds(decoder_io_preFetchStage_br_leaving_ds),
    .io_preFetchStage_branch_stall(decoder_io_preFetchStage_branch_stall),
    .io_preFetchStage_branch_flag(decoder_io_preFetchStage_branch_flag),
    .io_preFetchStage_branch_target_address(decoder_io_preFetchStage_branch_target_address),
    .io_fetchStage_allowin(decoder_io_fetchStage_allowin),
    .io_decoderStage_allowin(decoder_io_decoderStage_allowin),
    .io_executeStage_aluop(decoder_io_executeStage_aluop),
    .io_executeStage_alusel(decoder_io_executeStage_alusel),
    .io_executeStage_inst(decoder_io_executeStage_inst),
    .io_executeStage_link_addr(decoder_io_executeStage_link_addr),
    .io_executeStage_reg1(decoder_io_executeStage_reg1),
    .io_executeStage_reg2(decoder_io_executeStage_reg2),
    .io_executeStage_reg_waddr(decoder_io_executeStage_reg_waddr),
    .io_executeStage_reg_wen(decoder_io_executeStage_reg_wen),
    .io_executeStage_pc(decoder_io_executeStage_pc),
    .io_executeStage_valid(decoder_io_executeStage_valid),
    .io_executeStage_ex(decoder_io_executeStage_ex),
    .io_executeStage_bd(decoder_io_executeStage_bd),
    .io_executeStage_badvaddr(decoder_io_executeStage_badvaddr),
    .io_executeStage_cp0_addr(decoder_io_executeStage_cp0_addr),
    .io_executeStage_excode(decoder_io_executeStage_excode),
    .io_executeStage_overflow_inst(decoder_io_executeStage_overflow_inst),
    .io_executeStage_tlb_refill(decoder_io_executeStage_tlb_refill),
    .io_executeStage_after_tlb(decoder_io_executeStage_after_tlb),
    .io_executeStage_mem_re(decoder_io_executeStage_mem_re),
    .io_executeStage_mem_we(decoder_io_executeStage_mem_we),
    .io_regfile_reg1_raddr(decoder_io_regfile_reg1_raddr),
    .io_regfile_reg2_raddr(decoder_io_regfile_reg2_raddr),
    .io_ctrl_ex(decoder_io_ctrl_ex)
  );
  ExecuteStage executeStage ( // @[PuaMips.scala 29:30]
    .clock(executeStage_clock),
    .reset(executeStage_reset),
    .io_fromDecoder_aluop(executeStage_io_fromDecoder_aluop),
    .io_fromDecoder_alusel(executeStage_io_fromDecoder_alusel),
    .io_fromDecoder_inst(executeStage_io_fromDecoder_inst),
    .io_fromDecoder_link_addr(executeStage_io_fromDecoder_link_addr),
    .io_fromDecoder_reg1(executeStage_io_fromDecoder_reg1),
    .io_fromDecoder_reg2(executeStage_io_fromDecoder_reg2),
    .io_fromDecoder_reg_waddr(executeStage_io_fromDecoder_reg_waddr),
    .io_fromDecoder_reg_wen(executeStage_io_fromDecoder_reg_wen),
    .io_fromDecoder_pc(executeStage_io_fromDecoder_pc),
    .io_fromDecoder_valid(executeStage_io_fromDecoder_valid),
    .io_fromDecoder_ex(executeStage_io_fromDecoder_ex),
    .io_fromDecoder_bd(executeStage_io_fromDecoder_bd),
    .io_fromDecoder_badvaddr(executeStage_io_fromDecoder_badvaddr),
    .io_fromDecoder_cp0_addr(executeStage_io_fromDecoder_cp0_addr),
    .io_fromDecoder_excode(executeStage_io_fromDecoder_excode),
    .io_fromDecoder_overflow_inst(executeStage_io_fromDecoder_overflow_inst),
    .io_fromDecoder_tlb_refill(executeStage_io_fromDecoder_tlb_refill),
    .io_fromDecoder_after_tlb(executeStage_io_fromDecoder_after_tlb),
    .io_fromDecoder_mem_re(executeStage_io_fromDecoder_mem_re),
    .io_fromDecoder_mem_we(executeStage_io_fromDecoder_mem_we),
    .io_fromExecute_allowin(executeStage_io_fromExecute_allowin),
    .io_fromCtrl_do_flush(executeStage_io_fromCtrl_do_flush),
    .io_fromCtrl_after_ex(executeStage_io_fromCtrl_after_ex),
    .io_execute_do_flush(executeStage_io_execute_do_flush),
    .io_execute_after_ex(executeStage_io_execute_after_ex),
    .io_execute_valid(executeStage_io_execute_valid),
    .io_execute_aluop(executeStage_io_execute_aluop),
    .io_execute_alusel(executeStage_io_execute_alusel),
    .io_execute_inst(executeStage_io_execute_inst),
    .io_execute_link_addr(executeStage_io_execute_link_addr),
    .io_execute_reg1(executeStage_io_execute_reg1),
    .io_execute_reg2(executeStage_io_execute_reg2),
    .io_execute_reg_waddr(executeStage_io_execute_reg_waddr),
    .io_execute_reg_wen(executeStage_io_execute_reg_wen),
    .io_execute_pc(executeStage_io_execute_pc),
    .io_execute_bd(executeStage_io_execute_bd),
    .io_execute_badvaddr(executeStage_io_execute_badvaddr),
    .io_execute_cp0_addr(executeStage_io_execute_cp0_addr),
    .io_execute_excode(executeStage_io_execute_excode),
    .io_execute_overflow_inst(executeStage_io_execute_overflow_inst),
    .io_execute_ds_to_es_ex(executeStage_io_execute_ds_to_es_ex),
    .io_execute_tlb_refill(executeStage_io_execute_tlb_refill),
    .io_execute_after_tlb(executeStage_io_execute_after_tlb),
    .io_execute_mem_re(executeStage_io_execute_mem_re),
    .io_execute_mem_we(executeStage_io_execute_mem_we)
  );
  Execute execute ( // @[PuaMips.scala 30:30]
    .clock(execute_clock),
    .reset(execute_reset),
    .io_fromAlu_out(execute_io_fromAlu_out),
    .io_fromAlu_ov(execute_io_fromAlu_ov),
    .io_fromMul_out(execute_io_fromMul_out),
    .io_fromDiv_quotient(execute_io_fromDiv_quotient),
    .io_fromDiv_remainder(execute_io_fromDiv_remainder),
    .io_fromMov_out(execute_io_fromMov_out),
    .io_fromDataMemory_addr_ok(execute_io_fromDataMemory_addr_ok),
    .io_fromDataMemory_data_ok(execute_io_fromDataMemory_data_ok),
    .io_fromExecuteStage_do_flush(execute_io_fromExecuteStage_do_flush),
    .io_fromExecuteStage_after_ex(execute_io_fromExecuteStage_after_ex),
    .io_fromExecuteStage_valid(execute_io_fromExecuteStage_valid),
    .io_fromExecuteStage_aluop(execute_io_fromExecuteStage_aluop),
    .io_fromExecuteStage_alusel(execute_io_fromExecuteStage_alusel),
    .io_fromExecuteStage_inst(execute_io_fromExecuteStage_inst),
    .io_fromExecuteStage_link_addr(execute_io_fromExecuteStage_link_addr),
    .io_fromExecuteStage_reg1(execute_io_fromExecuteStage_reg1),
    .io_fromExecuteStage_reg2(execute_io_fromExecuteStage_reg2),
    .io_fromExecuteStage_reg_waddr(execute_io_fromExecuteStage_reg_waddr),
    .io_fromExecuteStage_reg_wen(execute_io_fromExecuteStage_reg_wen),
    .io_fromExecuteStage_pc(execute_io_fromExecuteStage_pc),
    .io_fromExecuteStage_bd(execute_io_fromExecuteStage_bd),
    .io_fromExecuteStage_badvaddr(execute_io_fromExecuteStage_badvaddr),
    .io_fromExecuteStage_cp0_addr(execute_io_fromExecuteStage_cp0_addr),
    .io_fromExecuteStage_excode(execute_io_fromExecuteStage_excode),
    .io_fromExecuteStage_overflow_inst(execute_io_fromExecuteStage_overflow_inst),
    .io_fromExecuteStage_ds_to_es_ex(execute_io_fromExecuteStage_ds_to_es_ex),
    .io_fromExecuteStage_tlb_refill(execute_io_fromExecuteStage_tlb_refill),
    .io_fromExecuteStage_after_tlb(execute_io_fromExecuteStage_after_tlb),
    .io_fromExecuteStage_mem_re(execute_io_fromExecuteStage_mem_re),
    .io_fromExecuteStage_mem_we(execute_io_fromExecuteStage_mem_we),
    .io_fromMemory_whilo(execute_io_fromMemory_whilo),
    .io_fromMemory_hi(execute_io_fromMemory_hi),
    .io_fromMemory_lo(execute_io_fromMemory_lo),
    .io_fromMemory_allowin(execute_io_fromMemory_allowin),
    .io_fromMemory_inst_unable(execute_io_fromMemory_inst_unable),
    .io_fromHILO_hi(execute_io_fromHILO_hi),
    .io_fromHILO_lo(execute_io_fromHILO_lo),
    .io_fromWriteBackStage_whilo(execute_io_fromWriteBackStage_whilo),
    .io_fromWriteBackStage_hi(execute_io_fromWriteBackStage_hi),
    .io_fromWriteBackStage_lo(execute_io_fromWriteBackStage_lo),
    .io_fromDataMMU_tlb_refill(execute_io_fromDataMMU_tlb_refill),
    .io_fromDataMMU_tlb_invalid(execute_io_fromDataMMU_tlb_invalid),
    .io_fromDataMMU_tlb_modified(execute_io_fromDataMMU_tlb_modified),
    .io_fromTLB_s1_found(execute_io_fromTLB_s1_found),
    .io_fromTLB_s1_index(execute_io_fromTLB_s1_index),
    .io_alu_op(execute_io_alu_op),
    .io_alu_in1(execute_io_alu_in1),
    .io_alu_in2(execute_io_alu_in2),
    .io_mul_op(execute_io_mul_op),
    .io_mul_in1(execute_io_mul_in1),
    .io_mul_in2(execute_io_mul_in2),
    .io_div_op(execute_io_div_op),
    .io_div_divisor(execute_io_div_divisor),
    .io_div_dividend(execute_io_div_dividend),
    .io_mov_op(execute_io_mov_op),
    .io_mov_inst(execute_io_mov_inst),
    .io_mov_in(execute_io_mov_in),
    .io_mov_hi(execute_io_mov_hi),
    .io_mov_lo(execute_io_mov_lo),
    .io_decoder_reg_waddr(execute_io_decoder_reg_waddr),
    .io_decoder_reg_wdata(execute_io_decoder_reg_wdata),
    .io_decoder_reg_wen(execute_io_decoder_reg_wen),
    .io_decoder_allowin(execute_io_decoder_allowin),
    .io_decoder_blk_valid(execute_io_decoder_blk_valid),
    .io_decoder_inst_is_mfc0(execute_io_decoder_inst_is_mfc0),
    .io_decoder_es_fwd_valid(execute_io_decoder_es_fwd_valid),
    .io_dataMMU_vaddr(execute_io_dataMMU_vaddr),
    .io_dataMMU_inst_is_tlbp(execute_io_dataMMU_inst_is_tlbp),
    .io_memoryStage_aluop(execute_io_memoryStage_aluop),
    .io_memoryStage_hi(execute_io_memoryStage_hi),
    .io_memoryStage_lo(execute_io_memoryStage_lo),
    .io_memoryStage_reg2(execute_io_memoryStage_reg2),
    .io_memoryStage_reg_waddr(execute_io_memoryStage_reg_waddr),
    .io_memoryStage_reg_wdata(execute_io_memoryStage_reg_wdata),
    .io_memoryStage_whilo(execute_io_memoryStage_whilo),
    .io_memoryStage_reg_wen(execute_io_memoryStage_reg_wen),
    .io_memoryStage_pc(execute_io_memoryStage_pc),
    .io_memoryStage_valid(execute_io_memoryStage_valid),
    .io_memoryStage_mem_addr(execute_io_memoryStage_mem_addr),
    .io_memoryStage_bd(execute_io_memoryStage_bd),
    .io_memoryStage_badvaddr(execute_io_memoryStage_badvaddr),
    .io_memoryStage_cp0_addr(execute_io_memoryStage_cp0_addr),
    .io_memoryStage_excode(execute_io_memoryStage_excode),
    .io_memoryStage_ex(execute_io_memoryStage_ex),
    .io_memoryStage_data_ok(execute_io_memoryStage_data_ok),
    .io_memoryStage_wait_mem(execute_io_memoryStage_wait_mem),
    .io_memoryStage_res_from_mem(execute_io_memoryStage_res_from_mem),
    .io_memoryStage_tlb_refill(execute_io_memoryStage_tlb_refill),
    .io_memoryStage_after_tlb(execute_io_memoryStage_after_tlb),
    .io_memoryStage_s1_found(execute_io_memoryStage_s1_found),
    .io_memoryStage_s1_index(execute_io_memoryStage_s1_index),
    .io_dataMemory_aluop(execute_io_dataMemory_aluop),
    .io_dataMemory_addrLowBit2(execute_io_dataMemory_addrLowBit2),
    .io_dataMemory_req(execute_io_dataMemory_req),
    .io_dataMemory_wr(execute_io_dataMemory_wr),
    .io_dataMemory_size(execute_io_dataMemory_size),
    .io_dataMemory_wdata(execute_io_dataMemory_wdata),
    .io_dataMemory_wstrb(execute_io_dataMemory_wstrb),
    .io_dataMemory_waiting(execute_io_dataMemory_waiting),
    .io_executeStage_allowin(execute_io_executeStage_allowin),
    .io_ctrl_ex(execute_io_ctrl_ex)
  );
  ALU alu ( // @[PuaMips.scala 31:30]
    .io_fromExecute_op(alu_io_fromExecute_op),
    .io_fromExecute_in1(alu_io_fromExecute_in1),
    .io_fromExecute_in2(alu_io_fromExecute_in2),
    .io_execute_out(alu_io_execute_out),
    .io_execute_ov(alu_io_execute_ov)
  );
  Mul mul ( // @[PuaMips.scala 32:30]
    .io_fromExecute_op(mul_io_fromExecute_op),
    .io_fromExecute_in1(mul_io_fromExecute_in1),
    .io_fromExecute_in2(mul_io_fromExecute_in2),
    .io_execute_out(mul_io_execute_out)
  );
  Div div ( // @[PuaMips.scala 33:30]
    .io_fromExecute_op(div_io_fromExecute_op),
    .io_fromExecute_divisor(div_io_fromExecute_divisor),
    .io_fromExecute_dividend(div_io_fromExecute_dividend),
    .io_execute_quotient(div_io_execute_quotient),
    .io_execute_remainder(div_io_execute_remainder)
  );
  Mov mov ( // @[PuaMips.scala 34:30]
    .io_fromMemory_cp0_wen(mov_io_fromMemory_cp0_wen),
    .io_fromMemory_cp0_waddr(mov_io_fromMemory_cp0_waddr),
    .io_fromMemory_cp0_wdata(mov_io_fromMemory_cp0_wdata),
    .io_fromWriteBackStage_cp0_wen(mov_io_fromWriteBackStage_cp0_wen),
    .io_fromWriteBackStage_cp0_waddr(mov_io_fromWriteBackStage_cp0_waddr),
    .io_fromWriteBackStage_cp0_wdata(mov_io_fromWriteBackStage_cp0_wdata),
    .io_fromWriteBackStage_cp0_rdata(mov_io_fromWriteBackStage_cp0_rdata),
    .io_fromExecute_op(mov_io_fromExecute_op),
    .io_fromExecute_inst(mov_io_fromExecute_inst),
    .io_fromExecute_in(mov_io_fromExecute_in),
    .io_fromExecute_hi(mov_io_fromExecute_hi),
    .io_fromExecute_lo(mov_io_fromExecute_lo),
    .io_execute_out(mov_io_execute_out)
  );
  InstMemory instMemory ( // @[PuaMips.scala 35:30]
    .clock(instMemory_clock),
    .reset(instMemory_reset),
    .io_fromPreFetchStage_req(instMemory_io_fromPreFetchStage_req),
    .io_fromPreFetchStage_waiting(instMemory_io_fromPreFetchStage_waiting),
    .io_fromFetchStage_waiting(instMemory_io_fromFetchStage_waiting),
    .io_fromInstMMU_paddr(instMemory_io_fromInstMMU_paddr),
    .io_fromCtrl_do_flush(instMemory_io_fromCtrl_do_flush),
    .io_preFetchStage_addr_ok(instMemory_io_preFetchStage_addr_ok),
    .io_preFetchStage_rdata(instMemory_io_preFetchStage_rdata),
    .io_preFetchStage_data_ok(instMemory_io_preFetchStage_data_ok),
    .io_fetchStage_data_ok(instMemory_io_fetchStage_data_ok),
    .io_fetchStage_rdata(instMemory_io_fetchStage_rdata),
    .io_sramAXITrans_req(instMemory_io_sramAXITrans_req),
    .io_sramAXITrans_addr(instMemory_io_sramAXITrans_addr),
    .io_sramAXITrans_data_ok(instMemory_io_sramAXITrans_data_ok),
    .io_sramAXITrans_addr_ok(instMemory_io_sramAXITrans_addr_ok),
    .io_sramAXITrans_rdata(instMemory_io_sramAXITrans_rdata),
    .io_ctrl_inst_sram_discard(instMemory_io_ctrl_inst_sram_discard)
  );
  DataMemory dataMemory ( // @[PuaMips.scala 36:30]
    .clock(dataMemory_clock),
    .reset(dataMemory_reset),
    .io_fromExecute_aluop(dataMemory_io_fromExecute_aluop),
    .io_fromExecute_addrLowBit2(dataMemory_io_fromExecute_addrLowBit2),
    .io_fromExecute_req(dataMemory_io_fromExecute_req),
    .io_fromExecute_wr(dataMemory_io_fromExecute_wr),
    .io_fromExecute_size(dataMemory_io_fromExecute_size),
    .io_fromExecute_wdata(dataMemory_io_fromExecute_wdata),
    .io_fromExecute_wstrb(dataMemory_io_fromExecute_wstrb),
    .io_fromExecute_waiting(dataMemory_io_fromExecute_waiting),
    .io_fromMemory_waiting(dataMemory_io_fromMemory_waiting),
    .io_fromCtrl_do_flush(dataMemory_io_fromCtrl_do_flush),
    .io_fromDataMMU_paddr(dataMemory_io_fromDataMMU_paddr),
    .io_execute_addr_ok(dataMemory_io_execute_addr_ok),
    .io_execute_data_ok(dataMemory_io_execute_data_ok),
    .io_memory_data_ok(dataMemory_io_memory_data_ok),
    .io_memory_rdata(dataMemory_io_memory_rdata),
    .io_sramAXITrans_req(dataMemory_io_sramAXITrans_req),
    .io_sramAXITrans_wr(dataMemory_io_sramAXITrans_wr),
    .io_sramAXITrans_size(dataMemory_io_sramAXITrans_size),
    .io_sramAXITrans_addr(dataMemory_io_sramAXITrans_addr),
    .io_sramAXITrans_wstrb(dataMemory_io_sramAXITrans_wstrb),
    .io_sramAXITrans_wdata(dataMemory_io_sramAXITrans_wdata),
    .io_sramAXITrans_addr_ok(dataMemory_io_sramAXITrans_addr_ok),
    .io_sramAXITrans_data_ok(dataMemory_io_sramAXITrans_data_ok),
    .io_sramAXITrans_rdata(dataMemory_io_sramAXITrans_rdata),
    .io_ctrl_data_sram_discard(dataMemory_io_ctrl_data_sram_discard)
  );
  SramAXITrans sramAXITrans ( // @[PuaMips.scala 37:30]
    .clock(sramAXITrans_clock),
    .reset(sramAXITrans_reset),
    .io_instMemory_req(sramAXITrans_io_instMemory_req),
    .io_instMemory_addr(sramAXITrans_io_instMemory_addr),
    .io_instMemory_data_ok(sramAXITrans_io_instMemory_data_ok),
    .io_instMemory_addr_ok(sramAXITrans_io_instMemory_addr_ok),
    .io_instMemory_rdata(sramAXITrans_io_instMemory_rdata),
    .io_dataMemory_req(sramAXITrans_io_dataMemory_req),
    .io_dataMemory_wr(sramAXITrans_io_dataMemory_wr),
    .io_dataMemory_size(sramAXITrans_io_dataMemory_size),
    .io_dataMemory_addr(sramAXITrans_io_dataMemory_addr),
    .io_dataMemory_wstrb(sramAXITrans_io_dataMemory_wstrb),
    .io_dataMemory_wdata(sramAXITrans_io_dataMemory_wdata),
    .io_dataMemory_addr_ok(sramAXITrans_io_dataMemory_addr_ok),
    .io_dataMemory_data_ok(sramAXITrans_io_dataMemory_data_ok),
    .io_dataMemory_rdata(sramAXITrans_io_dataMemory_rdata),
    .io_axi_arid(sramAXITrans_io_axi_arid),
    .io_axi_araddr(sramAXITrans_io_axi_araddr),
    .io_axi_arsize(sramAXITrans_io_axi_arsize),
    .io_axi_arvalid(sramAXITrans_io_axi_arvalid),
    .io_axi_arready(sramAXITrans_io_axi_arready),
    .io_axi_rid(sramAXITrans_io_axi_rid),
    .io_axi_rdata(sramAXITrans_io_axi_rdata),
    .io_axi_rvalid(sramAXITrans_io_axi_rvalid),
    .io_axi_rready(sramAXITrans_io_axi_rready),
    .io_axi_awaddr(sramAXITrans_io_axi_awaddr),
    .io_axi_awsize(sramAXITrans_io_axi_awsize),
    .io_axi_awvalid(sramAXITrans_io_axi_awvalid),
    .io_axi_awready(sramAXITrans_io_axi_awready),
    .io_axi_wdata(sramAXITrans_io_axi_wdata),
    .io_axi_wstrb(sramAXITrans_io_axi_wstrb),
    .io_axi_wvalid(sramAXITrans_io_axi_wvalid),
    .io_axi_wready(sramAXITrans_io_axi_wready),
    .io_axi_bvalid(sramAXITrans_io_axi_bvalid),
    .io_axi_bready(sramAXITrans_io_axi_bready)
  );
  MemoryStage memoryStage ( // @[PuaMips.scala 38:30]
    .clock(memoryStage_clock),
    .reset(memoryStage_reset),
    .io_fromExecute_aluop(memoryStage_io_fromExecute_aluop),
    .io_fromExecute_hi(memoryStage_io_fromExecute_hi),
    .io_fromExecute_lo(memoryStage_io_fromExecute_lo),
    .io_fromExecute_reg2(memoryStage_io_fromExecute_reg2),
    .io_fromExecute_reg_waddr(memoryStage_io_fromExecute_reg_waddr),
    .io_fromExecute_reg_wdata(memoryStage_io_fromExecute_reg_wdata),
    .io_fromExecute_whilo(memoryStage_io_fromExecute_whilo),
    .io_fromExecute_reg_wen(memoryStage_io_fromExecute_reg_wen),
    .io_fromExecute_pc(memoryStage_io_fromExecute_pc),
    .io_fromExecute_valid(memoryStage_io_fromExecute_valid),
    .io_fromExecute_mem_addr(memoryStage_io_fromExecute_mem_addr),
    .io_fromExecute_bd(memoryStage_io_fromExecute_bd),
    .io_fromExecute_badvaddr(memoryStage_io_fromExecute_badvaddr),
    .io_fromExecute_cp0_addr(memoryStage_io_fromExecute_cp0_addr),
    .io_fromExecute_excode(memoryStage_io_fromExecute_excode),
    .io_fromExecute_ex(memoryStage_io_fromExecute_ex),
    .io_fromExecute_data_ok(memoryStage_io_fromExecute_data_ok),
    .io_fromExecute_wait_mem(memoryStage_io_fromExecute_wait_mem),
    .io_fromExecute_res_from_mem(memoryStage_io_fromExecute_res_from_mem),
    .io_fromExecute_tlb_refill(memoryStage_io_fromExecute_tlb_refill),
    .io_fromExecute_after_tlb(memoryStage_io_fromExecute_after_tlb),
    .io_fromExecute_s1_found(memoryStage_io_fromExecute_s1_found),
    .io_fromExecute_s1_index(memoryStage_io_fromExecute_s1_index),
    .io_fromMemory_allowin(memoryStage_io_fromMemory_allowin),
    .io_fromCtrl_do_flush(memoryStage_io_fromCtrl_do_flush),
    .io_memory_do_flush(memoryStage_io_memory_do_flush),
    .io_memory_aluop(memoryStage_io_memory_aluop),
    .io_memory_hi(memoryStage_io_memory_hi),
    .io_memory_lo(memoryStage_io_memory_lo),
    .io_memory_whilo(memoryStage_io_memory_whilo),
    .io_memory_mem_addr(memoryStage_io_memory_mem_addr),
    .io_memory_reg2(memoryStage_io_memory_reg2),
    .io_memory_reg_waddr(memoryStage_io_memory_reg_waddr),
    .io_memory_reg_wen(memoryStage_io_memory_reg_wen),
    .io_memory_reg_wdata(memoryStage_io_memory_reg_wdata),
    .io_memory_pc(memoryStage_io_memory_pc),
    .io_memory_valid(memoryStage_io_memory_valid),
    .io_memory_bd(memoryStage_io_memory_bd),
    .io_memory_badvaddr(memoryStage_io_memory_badvaddr),
    .io_memory_cp0_addr(memoryStage_io_memory_cp0_addr),
    .io_memory_excode(memoryStage_io_memory_excode),
    .io_memory_ex(memoryStage_io_memory_ex),
    .io_memory_data_ok(memoryStage_io_memory_data_ok),
    .io_memory_wait_mem(memoryStage_io_memory_wait_mem),
    .io_memory_res_from_mem(memoryStage_io_memory_res_from_mem),
    .io_memory_tlb_refill(memoryStage_io_memory_tlb_refill),
    .io_memory_after_tlb(memoryStage_io_memory_after_tlb),
    .io_memory_s1_found(memoryStage_io_memory_s1_found),
    .io_memory_s1_index(memoryStage_io_memory_s1_index)
  );
  Memory memory ( // @[PuaMips.scala 39:30]
    .reset(memory_reset),
    .io_fromMemoryStage_do_flush(memory_io_fromMemoryStage_do_flush),
    .io_fromMemoryStage_aluop(memory_io_fromMemoryStage_aluop),
    .io_fromMemoryStage_hi(memory_io_fromMemoryStage_hi),
    .io_fromMemoryStage_lo(memory_io_fromMemoryStage_lo),
    .io_fromMemoryStage_whilo(memory_io_fromMemoryStage_whilo),
    .io_fromMemoryStage_mem_addr(memory_io_fromMemoryStage_mem_addr),
    .io_fromMemoryStage_reg2(memory_io_fromMemoryStage_reg2),
    .io_fromMemoryStage_reg_waddr(memory_io_fromMemoryStage_reg_waddr),
    .io_fromMemoryStage_reg_wen(memory_io_fromMemoryStage_reg_wen),
    .io_fromMemoryStage_reg_wdata(memory_io_fromMemoryStage_reg_wdata),
    .io_fromMemoryStage_pc(memory_io_fromMemoryStage_pc),
    .io_fromMemoryStage_valid(memory_io_fromMemoryStage_valid),
    .io_fromMemoryStage_bd(memory_io_fromMemoryStage_bd),
    .io_fromMemoryStage_badvaddr(memory_io_fromMemoryStage_badvaddr),
    .io_fromMemoryStage_cp0_addr(memory_io_fromMemoryStage_cp0_addr),
    .io_fromMemoryStage_excode(memory_io_fromMemoryStage_excode),
    .io_fromMemoryStage_ex(memory_io_fromMemoryStage_ex),
    .io_fromMemoryStage_data_ok(memory_io_fromMemoryStage_data_ok),
    .io_fromMemoryStage_wait_mem(memory_io_fromMemoryStage_wait_mem),
    .io_fromMemoryStage_res_from_mem(memory_io_fromMemoryStage_res_from_mem),
    .io_fromMemoryStage_tlb_refill(memory_io_fromMemoryStage_tlb_refill),
    .io_fromMemoryStage_after_tlb(memory_io_fromMemoryStage_after_tlb),
    .io_fromMemoryStage_s1_found(memory_io_fromMemoryStage_s1_found),
    .io_fromMemoryStage_s1_index(memory_io_fromMemoryStage_s1_index),
    .io_fromDataMemory_data_ok(memory_io_fromDataMemory_data_ok),
    .io_fromDataMemory_rdata(memory_io_fromDataMemory_rdata),
    .io_decoder_reg_waddr(memory_io_decoder_reg_waddr),
    .io_decoder_reg_wdata(memory_io_decoder_reg_wdata),
    .io_decoder_reg_wen(memory_io_decoder_reg_wen),
    .io_decoder_inst_is_mfc0(memory_io_decoder_inst_is_mfc0),
    .io_decoder_ms_fwd_valid(memory_io_decoder_ms_fwd_valid),
    .io_decoder_blk_valid(memory_io_decoder_blk_valid),
    .io_mov_cp0_wen(memory_io_mov_cp0_wen),
    .io_mov_cp0_waddr(memory_io_mov_cp0_waddr),
    .io_mov_cp0_wdata(memory_io_mov_cp0_wdata),
    .io_memoryStage_allowin(memory_io_memoryStage_allowin),
    .io_dataMemory_waiting(memory_io_dataMemory_waiting),
    .io_execute_whilo(memory_io_execute_whilo),
    .io_execute_hi(memory_io_execute_hi),
    .io_execute_lo(memory_io_execute_lo),
    .io_execute_allowin(memory_io_execute_allowin),
    .io_execute_inst_unable(memory_io_execute_inst_unable),
    .io_writeBackStage_pc(memory_io_writeBackStage_pc),
    .io_writeBackStage_reg_wdata(memory_io_writeBackStage_reg_wdata),
    .io_writeBackStage_reg_waddr(memory_io_writeBackStage_reg_waddr),
    .io_writeBackStage_reg_wen(memory_io_writeBackStage_reg_wen),
    .io_writeBackStage_whilo(memory_io_writeBackStage_whilo),
    .io_writeBackStage_hi(memory_io_writeBackStage_hi),
    .io_writeBackStage_lo(memory_io_writeBackStage_lo),
    .io_writeBackStage_valid(memory_io_writeBackStage_valid),
    .io_writeBackStage_inst_is_mfc0(memory_io_writeBackStage_inst_is_mfc0),
    .io_writeBackStage_inst_is_mtc0(memory_io_writeBackStage_inst_is_mtc0),
    .io_writeBackStage_inst_is_eret(memory_io_writeBackStage_inst_is_eret),
    .io_writeBackStage_bd(memory_io_writeBackStage_bd),
    .io_writeBackStage_badvaddr(memory_io_writeBackStage_badvaddr),
    .io_writeBackStage_cp0_addr(memory_io_writeBackStage_cp0_addr),
    .io_writeBackStage_excode(memory_io_writeBackStage_excode),
    .io_writeBackStage_ex(memory_io_writeBackStage_ex),
    .io_writeBackStage_inst_is_tlbp(memory_io_writeBackStage_inst_is_tlbp),
    .io_writeBackStage_inst_is_tlbr(memory_io_writeBackStage_inst_is_tlbr),
    .io_writeBackStage_inst_is_tlbwi(memory_io_writeBackStage_inst_is_tlbwi),
    .io_writeBackStage_tlb_refill(memory_io_writeBackStage_tlb_refill),
    .io_writeBackStage_after_tlb(memory_io_writeBackStage_after_tlb),
    .io_writeBackStage_s1_found(memory_io_writeBackStage_s1_found),
    .io_writeBackStage_s1_index(memory_io_writeBackStage_s1_index),
    .io_ctrl_ex(memory_io_ctrl_ex)
  );
  WriteBackStage writeBackStage ( // @[PuaMips.scala 40:30]
    .clock(writeBackStage_clock),
    .reset(writeBackStage_reset),
    .io_fromMemory_pc(writeBackStage_io_fromMemory_pc),
    .io_fromMemory_reg_wdata(writeBackStage_io_fromMemory_reg_wdata),
    .io_fromMemory_reg_waddr(writeBackStage_io_fromMemory_reg_waddr),
    .io_fromMemory_reg_wen(writeBackStage_io_fromMemory_reg_wen),
    .io_fromMemory_whilo(writeBackStage_io_fromMemory_whilo),
    .io_fromMemory_hi(writeBackStage_io_fromMemory_hi),
    .io_fromMemory_lo(writeBackStage_io_fromMemory_lo),
    .io_fromMemory_valid(writeBackStage_io_fromMemory_valid),
    .io_fromMemory_inst_is_mfc0(writeBackStage_io_fromMemory_inst_is_mfc0),
    .io_fromMemory_inst_is_mtc0(writeBackStage_io_fromMemory_inst_is_mtc0),
    .io_fromMemory_inst_is_eret(writeBackStage_io_fromMemory_inst_is_eret),
    .io_fromMemory_bd(writeBackStage_io_fromMemory_bd),
    .io_fromMemory_badvaddr(writeBackStage_io_fromMemory_badvaddr),
    .io_fromMemory_cp0_addr(writeBackStage_io_fromMemory_cp0_addr),
    .io_fromMemory_excode(writeBackStage_io_fromMemory_excode),
    .io_fromMemory_ex(writeBackStage_io_fromMemory_ex),
    .io_fromMemory_inst_is_tlbp(writeBackStage_io_fromMemory_inst_is_tlbp),
    .io_fromMemory_inst_is_tlbr(writeBackStage_io_fromMemory_inst_is_tlbr),
    .io_fromMemory_inst_is_tlbwi(writeBackStage_io_fromMemory_inst_is_tlbwi),
    .io_fromMemory_tlb_refill(writeBackStage_io_fromMemory_tlb_refill),
    .io_fromMemory_after_tlb(writeBackStage_io_fromMemory_after_tlb),
    .io_fromMemory_s1_found(writeBackStage_io_fromMemory_s1_found),
    .io_fromMemory_s1_index(writeBackStage_io_fromMemory_s1_index),
    .io_fromCP0_cp0_rdata(writeBackStage_io_fromCP0_cp0_rdata),
    .io_fromCP0_cp0_status(writeBackStage_io_fromCP0_cp0_status),
    .io_fromCP0_cp0_cause(writeBackStage_io_fromCP0_cp0_cause),
    .io_fromCP0_cp0_epc(writeBackStage_io_fromCP0_cp0_epc),
    .io_fromCP0_cp0_entryhi(writeBackStage_io_fromCP0_cp0_entryhi),
    .io_fromCP0_cp0_entrylo0(writeBackStage_io_fromCP0_cp0_entrylo0),
    .io_fromCP0_cp0_entrylo1(writeBackStage_io_fromCP0_cp0_entrylo1),
    .io_fromCP0_cp0_index(writeBackStage_io_fromCP0_cp0_index),
    .io_fromTLB_r_vpn2(writeBackStage_io_fromTLB_r_vpn2),
    .io_fromTLB_r_asid(writeBackStage_io_fromTLB_r_asid),
    .io_fromTLB_r_g(writeBackStage_io_fromTLB_r_g),
    .io_fromTLB_r_pfn0(writeBackStage_io_fromTLB_r_pfn0),
    .io_fromTLB_r_c0(writeBackStage_io_fromTLB_r_c0),
    .io_fromTLB_r_d0(writeBackStage_io_fromTLB_r_d0),
    .io_fromTLB_r_v0(writeBackStage_io_fromTLB_r_v0),
    .io_fromTLB_r_pfn1(writeBackStage_io_fromTLB_r_pfn1),
    .io_fromTLB_r_c1(writeBackStage_io_fromTLB_r_c1),
    .io_fromTLB_r_d1(writeBackStage_io_fromTLB_r_d1),
    .io_fromTLB_r_v1(writeBackStage_io_fromTLB_r_v1),
    .io_ext_int(writeBackStage_io_ext_int),
    .io_decoder_inst_is_mfc0(writeBackStage_io_decoder_inst_is_mfc0),
    .io_decoder_reg_waddr(writeBackStage_io_decoder_reg_waddr),
    .io_decoder_cp0_cause(writeBackStage_io_decoder_cp0_cause),
    .io_decoder_cp0_status(writeBackStage_io_decoder_cp0_status),
    .io_regFile_reg_wdata(writeBackStage_io_regFile_reg_wdata),
    .io_regFile_reg_waddr(writeBackStage_io_regFile_reg_waddr),
    .io_regFile_reg_wen(writeBackStage_io_regFile_reg_wen),
    .io_execute_whilo(writeBackStage_io_execute_whilo),
    .io_execute_hi(writeBackStage_io_execute_hi),
    .io_execute_lo(writeBackStage_io_execute_lo),
    .io_mov_cp0_wen(writeBackStage_io_mov_cp0_wen),
    .io_mov_cp0_waddr(writeBackStage_io_mov_cp0_waddr),
    .io_mov_cp0_wdata(writeBackStage_io_mov_cp0_wdata),
    .io_mov_cp0_rdata(writeBackStage_io_mov_cp0_rdata),
    .io_hilo_whilo(writeBackStage_io_hilo_whilo),
    .io_hilo_hi(writeBackStage_io_hilo_hi),
    .io_hilo_lo(writeBackStage_io_hilo_lo),
    .io_cp0_wb_ex(writeBackStage_io_cp0_wb_ex),
    .io_cp0_wb_bd(writeBackStage_io_cp0_wb_bd),
    .io_cp0_eret_flush(writeBackStage_io_cp0_eret_flush),
    .io_cp0_wb_excode(writeBackStage_io_cp0_wb_excode),
    .io_cp0_wb_pc(writeBackStage_io_cp0_wb_pc),
    .io_cp0_wb_badvaddr(writeBackStage_io_cp0_wb_badvaddr),
    .io_cp0_ext_int_in(writeBackStage_io_cp0_ext_int_in),
    .io_cp0_cp0_addr(writeBackStage_io_cp0_cp0_addr),
    .io_cp0_mtc0_we(writeBackStage_io_cp0_mtc0_we),
    .io_cp0_cp0_wdata(writeBackStage_io_cp0_cp0_wdata),
    .io_cp0_tlbp(writeBackStage_io_cp0_tlbp),
    .io_cp0_tlbr(writeBackStage_io_cp0_tlbr),
    .io_cp0_s1_found(writeBackStage_io_cp0_s1_found),
    .io_cp0_s1_index(writeBackStage_io_cp0_s1_index),
    .io_cp0_r_vpn2(writeBackStage_io_cp0_r_vpn2),
    .io_cp0_r_asid(writeBackStage_io_cp0_r_asid),
    .io_cp0_r_g(writeBackStage_io_cp0_r_g),
    .io_cp0_r_pfn0(writeBackStage_io_cp0_r_pfn0),
    .io_cp0_r_c0(writeBackStage_io_cp0_r_c0),
    .io_cp0_r_d0(writeBackStage_io_cp0_r_d0),
    .io_cp0_r_v0(writeBackStage_io_cp0_r_v0),
    .io_cp0_r_pfn1(writeBackStage_io_cp0_r_pfn1),
    .io_cp0_r_c1(writeBackStage_io_cp0_r_c1),
    .io_cp0_r_d1(writeBackStage_io_cp0_r_d1),
    .io_cp0_r_v1(writeBackStage_io_cp0_r_v1),
    .io_ctrl_ex(writeBackStage_io_ctrl_ex),
    .io_ctrl_do_flush(writeBackStage_io_ctrl_do_flush),
    .io_ctrl_flush_pc(writeBackStage_io_ctrl_flush_pc),
    .io_tlb_we(writeBackStage_io_tlb_we),
    .io_tlb_w_index(writeBackStage_io_tlb_w_index),
    .io_tlb_w_vpn2(writeBackStage_io_tlb_w_vpn2),
    .io_tlb_w_asid(writeBackStage_io_tlb_w_asid),
    .io_tlb_w_g(writeBackStage_io_tlb_w_g),
    .io_tlb_w_pfn0(writeBackStage_io_tlb_w_pfn0),
    .io_tlb_w_c0(writeBackStage_io_tlb_w_c0),
    .io_tlb_w_d0(writeBackStage_io_tlb_w_d0),
    .io_tlb_w_v0(writeBackStage_io_tlb_w_v0),
    .io_tlb_w_pfn1(writeBackStage_io_tlb_w_pfn1),
    .io_tlb_w_c1(writeBackStage_io_tlb_w_c1),
    .io_tlb_w_d1(writeBackStage_io_tlb_w_d1),
    .io_tlb_w_v1(writeBackStage_io_tlb_w_v1),
    .io_tlb_r_index(writeBackStage_io_tlb_r_index),
    .io_instMMU_cp0_entryhi(writeBackStage_io_instMMU_cp0_entryhi),
    .io_dataMMU_cp0_entryhi(writeBackStage_io_dataMMU_cp0_entryhi),
    .io_debug_pc(writeBackStage_io_debug_pc),
    .io_debug_wen(writeBackStage_io_debug_wen),
    .io_debug_waddr(writeBackStage_io_debug_waddr),
    .io_debug_wdata(writeBackStage_io_debug_wdata)
  );
  Regfile regfile ( // @[PuaMips.scala 41:30]
    .clock(regfile_clock),
    .reset(regfile_reset),
    .io_fromDecoder_reg1_raddr(regfile_io_fromDecoder_reg1_raddr),
    .io_fromDecoder_reg2_raddr(regfile_io_fromDecoder_reg2_raddr),
    .io_fromWriteBackStage_reg_wdata(regfile_io_fromWriteBackStage_reg_wdata),
    .io_fromWriteBackStage_reg_waddr(regfile_io_fromWriteBackStage_reg_waddr),
    .io_fromWriteBackStage_reg_wen(regfile_io_fromWriteBackStage_reg_wen),
    .io_decoder_reg1_data(regfile_io_decoder_reg1_data),
    .io_decoder_reg2_data(regfile_io_decoder_reg2_data)
  );
  HILO hilo ( // @[PuaMips.scala 42:30]
    .clock(hilo_clock),
    .reset(hilo_reset),
    .io_fromWriteBackStage_whilo(hilo_io_fromWriteBackStage_whilo),
    .io_fromWriteBackStage_hi(hilo_io_fromWriteBackStage_hi),
    .io_fromWriteBackStage_lo(hilo_io_fromWriteBackStage_lo),
    .io_execute_hi(hilo_io_execute_hi),
    .io_execute_lo(hilo_io_execute_lo)
  );
  CP0Reg cp0 ( // @[PuaMips.scala 43:30]
    .clock(cp0_clock),
    .reset(cp0_reset),
    .io_fromWriteBackStage_wb_ex(cp0_io_fromWriteBackStage_wb_ex),
    .io_fromWriteBackStage_wb_bd(cp0_io_fromWriteBackStage_wb_bd),
    .io_fromWriteBackStage_eret_flush(cp0_io_fromWriteBackStage_eret_flush),
    .io_fromWriteBackStage_wb_excode(cp0_io_fromWriteBackStage_wb_excode),
    .io_fromWriteBackStage_wb_pc(cp0_io_fromWriteBackStage_wb_pc),
    .io_fromWriteBackStage_wb_badvaddr(cp0_io_fromWriteBackStage_wb_badvaddr),
    .io_fromWriteBackStage_ext_int_in(cp0_io_fromWriteBackStage_ext_int_in),
    .io_fromWriteBackStage_cp0_addr(cp0_io_fromWriteBackStage_cp0_addr),
    .io_fromWriteBackStage_mtc0_we(cp0_io_fromWriteBackStage_mtc0_we),
    .io_fromWriteBackStage_cp0_wdata(cp0_io_fromWriteBackStage_cp0_wdata),
    .io_fromWriteBackStage_tlbp(cp0_io_fromWriteBackStage_tlbp),
    .io_fromWriteBackStage_tlbr(cp0_io_fromWriteBackStage_tlbr),
    .io_fromWriteBackStage_s1_found(cp0_io_fromWriteBackStage_s1_found),
    .io_fromWriteBackStage_s1_index(cp0_io_fromWriteBackStage_s1_index),
    .io_fromWriteBackStage_r_vpn2(cp0_io_fromWriteBackStage_r_vpn2),
    .io_fromWriteBackStage_r_asid(cp0_io_fromWriteBackStage_r_asid),
    .io_fromWriteBackStage_r_g(cp0_io_fromWriteBackStage_r_g),
    .io_fromWriteBackStage_r_pfn0(cp0_io_fromWriteBackStage_r_pfn0),
    .io_fromWriteBackStage_r_c0(cp0_io_fromWriteBackStage_r_c0),
    .io_fromWriteBackStage_r_d0(cp0_io_fromWriteBackStage_r_d0),
    .io_fromWriteBackStage_r_v0(cp0_io_fromWriteBackStage_r_v0),
    .io_fromWriteBackStage_r_pfn1(cp0_io_fromWriteBackStage_r_pfn1),
    .io_fromWriteBackStage_r_c1(cp0_io_fromWriteBackStage_r_c1),
    .io_fromWriteBackStage_r_d1(cp0_io_fromWriteBackStage_r_d1),
    .io_fromWriteBackStage_r_v1(cp0_io_fromWriteBackStage_r_v1),
    .io_writeBackStage_cp0_rdata(cp0_io_writeBackStage_cp0_rdata),
    .io_writeBackStage_cp0_status(cp0_io_writeBackStage_cp0_status),
    .io_writeBackStage_cp0_cause(cp0_io_writeBackStage_cp0_cause),
    .io_writeBackStage_cp0_epc(cp0_io_writeBackStage_cp0_epc),
    .io_writeBackStage_cp0_entryhi(cp0_io_writeBackStage_cp0_entryhi),
    .io_writeBackStage_cp0_entrylo0(cp0_io_writeBackStage_cp0_entrylo0),
    .io_writeBackStage_cp0_entrylo1(cp0_io_writeBackStage_cp0_entrylo1),
    .io_writeBackStage_cp0_index(cp0_io_writeBackStage_cp0_index)
  );
  InstMMU instMMU ( // @[PuaMips.scala 44:30]
    .io_fromPreFetchStage_vaddr(instMMU_io_fromPreFetchStage_vaddr),
    .io_fromWriteBackStage_cp0_entryhi(instMMU_io_fromWriteBackStage_cp0_entryhi),
    .io_fromTLB_tlb_found(instMMU_io_fromTLB_tlb_found),
    .io_fromTLB_tlb_pfn(instMMU_io_fromTLB_tlb_pfn),
    .io_fromTLB_tlb_v(instMMU_io_fromTLB_tlb_v),
    .io_preFetchStage_tlb_refill(instMMU_io_preFetchStage_tlb_refill),
    .io_preFetchStage_tlb_invalid(instMMU_io_preFetchStage_tlb_invalid),
    .io_instMemory_paddr(instMMU_io_instMemory_paddr),
    .io_tlb_tlb_vpn2(instMMU_io_tlb_tlb_vpn2),
    .io_tlb_tlb_odd_page(instMMU_io_tlb_tlb_odd_page),
    .io_tlb_tlb_asid(instMMU_io_tlb_tlb_asid)
  );
  DataMMU dataMMU ( // @[PuaMips.scala 45:30]
    .io_fromWriteBackStage_cp0_entryhi(dataMMU_io_fromWriteBackStage_cp0_entryhi),
    .io_fromTLB_tlb_found(dataMMU_io_fromTLB_tlb_found),
    .io_fromTLB_tlb_pfn(dataMMU_io_fromTLB_tlb_pfn),
    .io_fromTLB_tlb_d(dataMMU_io_fromTLB_tlb_d),
    .io_fromTLB_tlb_v(dataMMU_io_fromTLB_tlb_v),
    .io_fromExecute_vaddr(dataMMU_io_fromExecute_vaddr),
    .io_fromExecute_inst_is_tlbp(dataMMU_io_fromExecute_inst_is_tlbp),
    .io_execute_tlb_refill(dataMMU_io_execute_tlb_refill),
    .io_execute_tlb_invalid(dataMMU_io_execute_tlb_invalid),
    .io_execute_tlb_modified(dataMMU_io_execute_tlb_modified),
    .io_dataMemory_paddr(dataMMU_io_dataMemory_paddr),
    .io_tlb_tlb_vpn2(dataMMU_io_tlb_tlb_vpn2),
    .io_tlb_tlb_odd_page(dataMMU_io_tlb_tlb_odd_page),
    .io_tlb_tlb_asid(dataMMU_io_tlb_tlb_asid)
  );
  Ctrl ctrl ( // @[PuaMips.scala 46:30]
    .io_fromInstMemory_inst_sram_discard(ctrl_io_fromInstMemory_inst_sram_discard),
    .io_fromDataMemory_data_sram_discard(ctrl_io_fromDataMemory_data_sram_discard),
    .io_fromFetchStage_ex(ctrl_io_fromFetchStage_ex),
    .io_fromDecoder_ex(ctrl_io_fromDecoder_ex),
    .io_fromExecute_ex(ctrl_io_fromExecute_ex),
    .io_fromMemory_ex(ctrl_io_fromMemory_ex),
    .io_fromWriteBackStage_ex(ctrl_io_fromWriteBackStage_ex),
    .io_fromWriteBackStage_do_flush(ctrl_io_fromWriteBackStage_do_flush),
    .io_fromWriteBackStage_flush_pc(ctrl_io_fromWriteBackStage_flush_pc),
    .io_preFetchStage_after_ex(ctrl_io_preFetchStage_after_ex),
    .io_preFetchStage_do_flush(ctrl_io_preFetchStage_do_flush),
    .io_preFetchStage_flush_pc(ctrl_io_preFetchStage_flush_pc),
    .io_preFetchStage_block(ctrl_io_preFetchStage_block),
    .io_fetchStage_do_flush(ctrl_io_fetchStage_do_flush),
    .io_decoderStage_do_flush(ctrl_io_decoderStage_do_flush),
    .io_executeStage_do_flush(ctrl_io_executeStage_do_flush),
    .io_executeStage_after_ex(ctrl_io_executeStage_after_ex),
    .io_memoryStage_do_flush(ctrl_io_memoryStage_do_flush),
    .io_instMemory_do_flush(ctrl_io_instMemory_do_flush),
    .io_dataMemory_do_flush(ctrl_io_dataMemory_do_flush)
  );
  TLB tlb ( // @[PuaMips.scala 47:30]
    .clock(tlb_clock),
    .reset(tlb_reset),
    .io_fromInstMMU_tlb_vpn2(tlb_io_fromInstMMU_tlb_vpn2),
    .io_fromInstMMU_tlb_odd_page(tlb_io_fromInstMMU_tlb_odd_page),
    .io_fromInstMMU_tlb_asid(tlb_io_fromInstMMU_tlb_asid),
    .io_fromDataMMU_tlb_vpn2(tlb_io_fromDataMMU_tlb_vpn2),
    .io_fromDataMMU_tlb_odd_page(tlb_io_fromDataMMU_tlb_odd_page),
    .io_fromDataMMU_tlb_asid(tlb_io_fromDataMMU_tlb_asid),
    .io_fromWriteBackStage_we(tlb_io_fromWriteBackStage_we),
    .io_fromWriteBackStage_w_index(tlb_io_fromWriteBackStage_w_index),
    .io_fromWriteBackStage_w_vpn2(tlb_io_fromWriteBackStage_w_vpn2),
    .io_fromWriteBackStage_w_asid(tlb_io_fromWriteBackStage_w_asid),
    .io_fromWriteBackStage_w_g(tlb_io_fromWriteBackStage_w_g),
    .io_fromWriteBackStage_w_pfn0(tlb_io_fromWriteBackStage_w_pfn0),
    .io_fromWriteBackStage_w_c0(tlb_io_fromWriteBackStage_w_c0),
    .io_fromWriteBackStage_w_d0(tlb_io_fromWriteBackStage_w_d0),
    .io_fromWriteBackStage_w_v0(tlb_io_fromWriteBackStage_w_v0),
    .io_fromWriteBackStage_w_pfn1(tlb_io_fromWriteBackStage_w_pfn1),
    .io_fromWriteBackStage_w_c1(tlb_io_fromWriteBackStage_w_c1),
    .io_fromWriteBackStage_w_d1(tlb_io_fromWriteBackStage_w_d1),
    .io_fromWriteBackStage_w_v1(tlb_io_fromWriteBackStage_w_v1),
    .io_fromWriteBackStage_r_index(tlb_io_fromWriteBackStage_r_index),
    .io_instMMU_tlb_found(tlb_io_instMMU_tlb_found),
    .io_instMMU_tlb_pfn(tlb_io_instMMU_tlb_pfn),
    .io_instMMU_tlb_v(tlb_io_instMMU_tlb_v),
    .io_dataMMU_tlb_found(tlb_io_dataMMU_tlb_found),
    .io_dataMMU_tlb_pfn(tlb_io_dataMMU_tlb_pfn),
    .io_dataMMU_tlb_d(tlb_io_dataMMU_tlb_d),
    .io_dataMMU_tlb_v(tlb_io_dataMMU_tlb_v),
    .io_execute_s1_found(tlb_io_execute_s1_found),
    .io_execute_s1_index(tlb_io_execute_s1_index),
    .io_writeBackStage_r_vpn2(tlb_io_writeBackStage_r_vpn2),
    .io_writeBackStage_r_asid(tlb_io_writeBackStage_r_asid),
    .io_writeBackStage_r_g(tlb_io_writeBackStage_r_g),
    .io_writeBackStage_r_pfn0(tlb_io_writeBackStage_r_pfn0),
    .io_writeBackStage_r_c0(tlb_io_writeBackStage_r_c0),
    .io_writeBackStage_r_d0(tlb_io_writeBackStage_r_d0),
    .io_writeBackStage_r_v0(tlb_io_writeBackStage_r_v0),
    .io_writeBackStage_r_pfn1(tlb_io_writeBackStage_r_pfn1),
    .io_writeBackStage_r_c1(tlb_io_writeBackStage_r_c1),
    .io_writeBackStage_r_d1(tlb_io_writeBackStage_r_d1),
    .io_writeBackStage_r_v1(tlb_io_writeBackStage_r_v1)
  );
  assign io_axi_arid = sramAXITrans_io_axi_arid; // @[PuaMips.scala 50:10]
  assign io_axi_araddr = sramAXITrans_io_axi_araddr; // @[PuaMips.scala 50:10]
  assign io_axi_arlen = 8'h0; // @[PuaMips.scala 50:10]
  assign io_axi_arsize = sramAXITrans_io_axi_arsize; // @[PuaMips.scala 50:10]
  assign io_axi_arburst = 2'h1; // @[PuaMips.scala 50:10]
  assign io_axi_arlock = 2'h0; // @[PuaMips.scala 50:10]
  assign io_axi_arcache = 4'h0; // @[PuaMips.scala 50:10]
  assign io_axi_arprot = 3'h0; // @[PuaMips.scala 50:10]
  assign io_axi_arvalid = sramAXITrans_io_axi_arvalid; // @[PuaMips.scala 50:10]
  assign io_axi_rready = sramAXITrans_io_axi_rready; // @[PuaMips.scala 50:10]
  assign io_axi_awid = 4'h1; // @[PuaMips.scala 50:10]
  assign io_axi_awaddr = sramAXITrans_io_axi_awaddr; // @[PuaMips.scala 50:10]
  assign io_axi_awlen = 8'h0; // @[PuaMips.scala 50:10]
  assign io_axi_awsize = sramAXITrans_io_axi_awsize; // @[PuaMips.scala 50:10]
  assign io_axi_awburst = 2'h1; // @[PuaMips.scala 50:10]
  assign io_axi_awlock = 2'h0; // @[PuaMips.scala 50:10]
  assign io_axi_awcache = 4'h0; // @[PuaMips.scala 50:10]
  assign io_axi_awprot = 3'h0; // @[PuaMips.scala 50:10]
  assign io_axi_awvalid = sramAXITrans_io_axi_awvalid; // @[PuaMips.scala 50:10]
  assign io_axi_wid = 4'h1; // @[PuaMips.scala 50:10]
  assign io_axi_wdata = sramAXITrans_io_axi_wdata; // @[PuaMips.scala 50:10]
  assign io_axi_wstrb = sramAXITrans_io_axi_wstrb; // @[PuaMips.scala 50:10]
  assign io_axi_wlast = 1'h1; // @[PuaMips.scala 50:10]
  assign io_axi_wvalid = sramAXITrans_io_axi_wvalid; // @[PuaMips.scala 50:10]
  assign io_axi_bready = sramAXITrans_io_axi_bready; // @[PuaMips.scala 50:10]
  assign io_debug_pc = writeBackStage_io_debug_pc; // @[PuaMips.scala 55:12]
  assign io_debug_wen = writeBackStage_io_debug_wen; // @[PuaMips.scala 55:12]
  assign io_debug_waddr = writeBackStage_io_debug_waddr; // @[PuaMips.scala 55:12]
  assign io_debug_wdata = writeBackStage_io_debug_wdata; // @[PuaMips.scala 55:12]
  assign preFetchStage_clock = clock;
  assign preFetchStage_reset = reset;
  assign preFetchStage_io_fromFetchStage_valid = fetchStage_io_preFetchStage_valid; // @[PuaMips.scala 72:31]
  assign preFetchStage_io_fromFetchStage_allowin = fetchStage_io_preFetchStage_allowin; // @[PuaMips.scala 72:31]
  assign preFetchStage_io_fromFetchStage_inst_unable = fetchStage_io_preFetchStage_inst_unable; // @[PuaMips.scala 72:31]
  assign preFetchStage_io_fromDecoder_br_leaving_ds = decoder_io_preFetchStage_br_leaving_ds; // @[PuaMips.scala 81:28]
  assign preFetchStage_io_fromDecoder_branch_stall = decoder_io_preFetchStage_branch_stall; // @[PuaMips.scala 81:28]
  assign preFetchStage_io_fromDecoder_branch_flag = decoder_io_preFetchStage_branch_flag; // @[PuaMips.scala 81:28]
  assign preFetchStage_io_fromDecoder_branch_target_address = decoder_io_preFetchStage_branch_target_address; // @[PuaMips.scala 81:28]
  assign preFetchStage_io_fromInstMemory_addr_ok = instMemory_io_preFetchStage_addr_ok; // @[PuaMips.scala 58:31]
  assign preFetchStage_io_fromInstMemory_rdata = instMemory_io_preFetchStage_rdata; // @[PuaMips.scala 58:31]
  assign preFetchStage_io_fromInstMemory_data_ok = instMemory_io_preFetchStage_data_ok; // @[PuaMips.scala 58:31]
  assign preFetchStage_io_fromInstMMU_tlb_refill = instMMU_io_preFetchStage_tlb_refill; // @[PuaMips.scala 164:28]
  assign preFetchStage_io_fromInstMMU_tlb_invalid = instMMU_io_preFetchStage_tlb_invalid; // @[PuaMips.scala 164:28]
  assign preFetchStage_io_fromCtrl_after_ex = ctrl_io_preFetchStage_after_ex; // @[PuaMips.scala 151:25]
  assign preFetchStage_io_fromCtrl_do_flush = ctrl_io_preFetchStage_do_flush; // @[PuaMips.scala 151:25]
  assign preFetchStage_io_fromCtrl_flush_pc = ctrl_io_preFetchStage_flush_pc; // @[PuaMips.scala 151:25]
  assign preFetchStage_io_fromCtrl_block = ctrl_io_preFetchStage_block; // @[PuaMips.scala 151:25]
  assign fetchStage_clock = clock;
  assign fetchStage_reset = reset;
  assign fetchStage_io_fromPreFetchStage_valid = preFetchStage_io_fetchStage_valid; // @[PuaMips.scala 67:31]
  assign fetchStage_io_fromPreFetchStage_inst_ok = preFetchStage_io_fetchStage_inst_ok; // @[PuaMips.scala 67:31]
  assign fetchStage_io_fromPreFetchStage_inst = preFetchStage_io_fetchStage_inst; // @[PuaMips.scala 67:31]
  assign fetchStage_io_fromPreFetchStage_pc = preFetchStage_io_fetchStage_pc; // @[PuaMips.scala 67:31]
  assign fetchStage_io_fromPreFetchStage_tlb_refill = preFetchStage_io_fetchStage_tlb_refill; // @[PuaMips.scala 67:31]
  assign fetchStage_io_fromPreFetchStage_ex = preFetchStage_io_fetchStage_ex; // @[PuaMips.scala 67:31]
  assign fetchStage_io_fromPreFetchStage_badvaddr = preFetchStage_io_fetchStage_badvaddr; // @[PuaMips.scala 67:31]
  assign fetchStage_io_fromPreFetchStage_excode = preFetchStage_io_fetchStage_excode; // @[PuaMips.scala 67:31]
  assign fetchStage_io_fromInstMemory_data_ok = instMemory_io_fetchStage_data_ok; // @[PuaMips.scala 59:28]
  assign fetchStage_io_fromInstMemory_rdata = instMemory_io_fetchStage_rdata; // @[PuaMips.scala 59:28]
  assign fetchStage_io_fromDecoder_allowin = decoder_io_fetchStage_allowin; // @[PuaMips.scala 82:25]
  assign fetchStage_io_fromCtrl_do_flush = ctrl_io_fetchStage_do_flush; // @[PuaMips.scala 152:22]
  assign decoderStage_clock = clock;
  assign decoderStage_reset = reset;
  assign decoderStage_io_fromFetchStage_valid = fetchStage_io_decoderStage_valid; // @[PuaMips.scala 73:30]
  assign decoderStage_io_fromFetchStage_tlb_refill = fetchStage_io_decoderStage_tlb_refill; // @[PuaMips.scala 73:30]
  assign decoderStage_io_fromFetchStage_excode = fetchStage_io_decoderStage_excode; // @[PuaMips.scala 73:30]
  assign decoderStage_io_fromFetchStage_ex = fetchStage_io_decoderStage_ex; // @[PuaMips.scala 73:30]
  assign decoderStage_io_fromFetchStage_badvaddr = fetchStage_io_decoderStage_badvaddr; // @[PuaMips.scala 73:30]
  assign decoderStage_io_fromFetchStage_inst = fetchStage_io_decoderStage_inst; // @[PuaMips.scala 73:30]
  assign decoderStage_io_fromFetchStage_pc = fetchStage_io_decoderStage_pc; // @[PuaMips.scala 73:30]
  assign decoderStage_io_fromDecoder_allowin = decoder_io_decoderStage_allowin; // @[PuaMips.scala 85:27]
  assign decoderStage_io_fromCtrl_do_flush = ctrl_io_decoderStage_do_flush; // @[PuaMips.scala 153:24]
  assign decoder_clock = clock;
  assign decoder_reset = reset;
  assign decoder_io_fromDecoderStage_do_flush = decoderStage_io_decoder_do_flush; // @[PuaMips.scala 78:27]
  assign decoder_io_fromDecoderStage_valid = decoderStage_io_decoder_valid; // @[PuaMips.scala 78:27]
  assign decoder_io_fromDecoderStage_tlb_refill = decoderStage_io_decoder_tlb_refill; // @[PuaMips.scala 78:27]
  assign decoder_io_fromDecoderStage_excode = decoderStage_io_decoder_excode; // @[PuaMips.scala 78:27]
  assign decoder_io_fromDecoderStage_ex = decoderStage_io_decoder_ex; // @[PuaMips.scala 78:27]
  assign decoder_io_fromDecoderStage_badvaddr = decoderStage_io_decoder_badvaddr; // @[PuaMips.scala 78:27]
  assign decoder_io_fromDecoderStage_inst = decoderStage_io_decoder_inst; // @[PuaMips.scala 78:27]
  assign decoder_io_fromDecoderStage_pc = decoderStage_io_decoder_pc; // @[PuaMips.scala 78:27]
  assign decoder_io_fromExecute_reg_waddr = execute_io_decoder_reg_waddr; // @[PuaMips.scala 102:22]
  assign decoder_io_fromExecute_reg_wdata = execute_io_decoder_reg_wdata; // @[PuaMips.scala 102:22]
  assign decoder_io_fromExecute_reg_wen = execute_io_decoder_reg_wen; // @[PuaMips.scala 102:22]
  assign decoder_io_fromExecute_allowin = execute_io_decoder_allowin; // @[PuaMips.scala 102:22]
  assign decoder_io_fromExecute_blk_valid = execute_io_decoder_blk_valid; // @[PuaMips.scala 102:22]
  assign decoder_io_fromExecute_inst_is_mfc0 = execute_io_decoder_inst_is_mfc0; // @[PuaMips.scala 102:22]
  assign decoder_io_fromExecute_es_fwd_valid = execute_io_decoder_es_fwd_valid; // @[PuaMips.scala 102:22]
  assign decoder_io_fromRegfile_reg1_data = regfile_io_decoder_reg1_data; // @[PuaMips.scala 148:22]
  assign decoder_io_fromRegfile_reg2_data = regfile_io_decoder_reg2_data; // @[PuaMips.scala 148:22]
  assign decoder_io_fromMemory_reg_waddr = memory_io_decoder_reg_waddr; // @[PuaMips.scala 119:21]
  assign decoder_io_fromMemory_reg_wdata = memory_io_decoder_reg_wdata; // @[PuaMips.scala 119:21]
  assign decoder_io_fromMemory_reg_wen = memory_io_decoder_reg_wen; // @[PuaMips.scala 119:21]
  assign decoder_io_fromMemory_inst_is_mfc0 = memory_io_decoder_inst_is_mfc0; // @[PuaMips.scala 119:21]
  assign decoder_io_fromMemory_ms_fwd_valid = memory_io_decoder_ms_fwd_valid; // @[PuaMips.scala 119:21]
  assign decoder_io_fromMemory_blk_valid = memory_io_decoder_blk_valid; // @[PuaMips.scala 119:21]
  assign decoder_io_fromWriteBackStage_inst_is_mfc0 = writeBackStage_io_decoder_inst_is_mfc0; // @[PuaMips.scala 128:29]
  assign decoder_io_fromWriteBackStage_reg_waddr = writeBackStage_io_decoder_reg_waddr; // @[PuaMips.scala 128:29]
  assign decoder_io_fromWriteBackStage_cp0_cause = writeBackStage_io_decoder_cp0_cause; // @[PuaMips.scala 128:29]
  assign decoder_io_fromWriteBackStage_cp0_status = writeBackStage_io_decoder_cp0_status; // @[PuaMips.scala 128:29]
  assign executeStage_clock = clock;
  assign executeStage_reset = reset;
  assign executeStage_io_fromDecoder_aluop = decoder_io_executeStage_aluop; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_alusel = decoder_io_executeStage_alusel; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_inst = decoder_io_executeStage_inst; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_link_addr = decoder_io_executeStage_link_addr; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_reg1 = decoder_io_executeStage_reg1; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_reg2 = decoder_io_executeStage_reg2; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_reg_waddr = decoder_io_executeStage_reg_waddr; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_reg_wen = decoder_io_executeStage_reg_wen; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_pc = decoder_io_executeStage_pc; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_valid = decoder_io_executeStage_valid; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_ex = decoder_io_executeStage_ex; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_bd = decoder_io_executeStage_bd; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_badvaddr = decoder_io_executeStage_badvaddr; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_cp0_addr = decoder_io_executeStage_cp0_addr; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_excode = decoder_io_executeStage_excode; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_overflow_inst = decoder_io_executeStage_overflow_inst; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_tlb_refill = decoder_io_executeStage_tlb_refill; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_after_tlb = decoder_io_executeStage_after_tlb; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_mem_re = decoder_io_executeStage_mem_re; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromDecoder_mem_we = decoder_io_executeStage_mem_we; // @[PuaMips.scala 83:27]
  assign executeStage_io_fromExecute_allowin = execute_io_executeStage_allowin; // @[PuaMips.scala 105:27]
  assign executeStage_io_fromCtrl_do_flush = ctrl_io_executeStage_do_flush; // @[PuaMips.scala 154:24]
  assign executeStage_io_fromCtrl_after_ex = ctrl_io_executeStage_after_ex; // @[PuaMips.scala 154:24]
  assign execute_clock = clock;
  assign execute_reset = reset;
  assign execute_io_fromAlu_out = alu_io_execute_out; // @[PuaMips.scala 97:18]
  assign execute_io_fromAlu_ov = alu_io_execute_ov; // @[PuaMips.scala 97:18]
  assign execute_io_fromMul_out = mul_io_execute_out; // @[PuaMips.scala 98:18]
  assign execute_io_fromDiv_quotient = div_io_execute_quotient; // @[PuaMips.scala 99:18]
  assign execute_io_fromDiv_remainder = div_io_execute_remainder; // @[PuaMips.scala 99:18]
  assign execute_io_fromMov_out = mov_io_execute_out; // @[PuaMips.scala 100:18]
  assign execute_io_fromDataMemory_addr_ok = dataMemory_io_execute_addr_ok; // @[PuaMips.scala 115:25]
  assign execute_io_fromDataMemory_data_ok = dataMemory_io_execute_data_ok; // @[PuaMips.scala 115:25]
  assign execute_io_fromExecuteStage_do_flush = executeStage_io_execute_do_flush; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_after_ex = executeStage_io_execute_after_ex; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_valid = executeStage_io_execute_valid; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_aluop = executeStage_io_execute_aluop; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_alusel = executeStage_io_execute_alusel; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_inst = executeStage_io_execute_inst; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_link_addr = executeStage_io_execute_link_addr; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_reg1 = executeStage_io_execute_reg1; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_reg2 = executeStage_io_execute_reg2; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_reg_waddr = executeStage_io_execute_reg_waddr; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_reg_wen = executeStage_io_execute_reg_wen; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_pc = executeStage_io_execute_pc; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_bd = executeStage_io_execute_bd; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_badvaddr = executeStage_io_execute_badvaddr; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_cp0_addr = executeStage_io_execute_cp0_addr; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_excode = executeStage_io_execute_excode; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_overflow_inst = executeStage_io_execute_overflow_inst; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_ds_to_es_ex = executeStage_io_execute_ds_to_es_ex; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_tlb_refill = executeStage_io_execute_tlb_refill; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_after_tlb = executeStage_io_execute_after_tlb; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_mem_re = executeStage_io_execute_mem_re; // @[PuaMips.scala 90:27]
  assign execute_io_fromExecuteStage_mem_we = executeStage_io_execute_mem_we; // @[PuaMips.scala 90:27]
  assign execute_io_fromMemory_whilo = memory_io_execute_whilo; // @[PuaMips.scala 123:21]
  assign execute_io_fromMemory_hi = memory_io_execute_hi; // @[PuaMips.scala 123:21]
  assign execute_io_fromMemory_lo = memory_io_execute_lo; // @[PuaMips.scala 123:21]
  assign execute_io_fromMemory_allowin = memory_io_execute_allowin; // @[PuaMips.scala 123:21]
  assign execute_io_fromMemory_inst_unable = memory_io_execute_inst_unable; // @[PuaMips.scala 123:21]
  assign execute_io_fromHILO_hi = hilo_io_execute_hi; // @[PuaMips.scala 145:19]
  assign execute_io_fromHILO_lo = hilo_io_execute_lo; // @[PuaMips.scala 145:19]
  assign execute_io_fromWriteBackStage_whilo = writeBackStage_io_execute_whilo; // @[PuaMips.scala 129:29]
  assign execute_io_fromWriteBackStage_hi = writeBackStage_io_execute_hi; // @[PuaMips.scala 129:29]
  assign execute_io_fromWriteBackStage_lo = writeBackStage_io_execute_lo; // @[PuaMips.scala 129:29]
  assign execute_io_fromDataMMU_tlb_refill = dataMMU_io_execute_tlb_refill; // @[PuaMips.scala 160:22]
  assign execute_io_fromDataMMU_tlb_invalid = dataMMU_io_execute_tlb_invalid; // @[PuaMips.scala 160:22]
  assign execute_io_fromDataMMU_tlb_modified = dataMMU_io_execute_tlb_modified; // @[PuaMips.scala 160:22]
  assign execute_io_fromTLB_s1_found = tlb_io_execute_s1_found; // @[PuaMips.scala 172:18]
  assign execute_io_fromTLB_s1_index = tlb_io_execute_s1_index; // @[PuaMips.scala 172:18]
  assign alu_io_fromExecute_op = execute_io_alu_op; // @[PuaMips.scala 93:18]
  assign alu_io_fromExecute_in1 = execute_io_alu_in1; // @[PuaMips.scala 93:18]
  assign alu_io_fromExecute_in2 = execute_io_alu_in2; // @[PuaMips.scala 93:18]
  assign mul_io_fromExecute_op = execute_io_mul_op; // @[PuaMips.scala 94:18]
  assign mul_io_fromExecute_in1 = execute_io_mul_in1; // @[PuaMips.scala 94:18]
  assign mul_io_fromExecute_in2 = execute_io_mul_in2; // @[PuaMips.scala 94:18]
  assign div_io_fromExecute_op = execute_io_div_op; // @[PuaMips.scala 95:18]
  assign div_io_fromExecute_divisor = execute_io_div_divisor; // @[PuaMips.scala 95:18]
  assign div_io_fromExecute_dividend = execute_io_div_dividend; // @[PuaMips.scala 95:18]
  assign mov_io_fromMemory_cp0_wen = memory_io_mov_cp0_wen; // @[PuaMips.scala 120:17]
  assign mov_io_fromMemory_cp0_waddr = memory_io_mov_cp0_waddr; // @[PuaMips.scala 120:17]
  assign mov_io_fromMemory_cp0_wdata = memory_io_mov_cp0_wdata; // @[PuaMips.scala 120:17]
  assign mov_io_fromWriteBackStage_cp0_wen = writeBackStage_io_mov_cp0_wen; // @[PuaMips.scala 132:25]
  assign mov_io_fromWriteBackStage_cp0_waddr = writeBackStage_io_mov_cp0_waddr; // @[PuaMips.scala 132:25]
  assign mov_io_fromWriteBackStage_cp0_wdata = writeBackStage_io_mov_cp0_wdata; // @[PuaMips.scala 132:25]
  assign mov_io_fromWriteBackStage_cp0_rdata = writeBackStage_io_mov_cp0_rdata; // @[PuaMips.scala 132:25]
  assign mov_io_fromExecute_op = execute_io_mov_op; // @[PuaMips.scala 96:18]
  assign mov_io_fromExecute_inst = execute_io_mov_inst; // @[PuaMips.scala 96:18]
  assign mov_io_fromExecute_in = execute_io_mov_in; // @[PuaMips.scala 96:18]
  assign mov_io_fromExecute_hi = execute_io_mov_hi; // @[PuaMips.scala 96:18]
  assign mov_io_fromExecute_lo = execute_io_mov_lo; // @[PuaMips.scala 96:18]
  assign instMemory_clock = clock;
  assign instMemory_reset = reset;
  assign instMemory_io_fromPreFetchStage_req = preFetchStage_io_instMemory_req; // @[PuaMips.scala 68:31]
  assign instMemory_io_fromPreFetchStage_waiting = preFetchStage_io_instMemory_waiting; // @[PuaMips.scala 68:31]
  assign instMemory_io_fromFetchStage_waiting = fetchStage_io_instMemory_waiting; // @[PuaMips.scala 74:28]
  assign instMemory_io_fromInstMMU_paddr = instMMU_io_instMemory_paddr; // @[PuaMips.scala 166:25]
  assign instMemory_io_fromCtrl_do_flush = ctrl_io_instMemory_do_flush; // @[PuaMips.scala 156:22]
  assign instMemory_io_sramAXITrans_data_ok = sramAXITrans_io_instMemory_data_ok; // @[PuaMips.scala 52:30]
  assign instMemory_io_sramAXITrans_addr_ok = sramAXITrans_io_instMemory_addr_ok; // @[PuaMips.scala 52:30]
  assign instMemory_io_sramAXITrans_rdata = sramAXITrans_io_instMemory_rdata; // @[PuaMips.scala 52:30]
  assign dataMemory_clock = clock;
  assign dataMemory_reset = reset;
  assign dataMemory_io_fromExecute_aluop = execute_io_dataMemory_aluop; // @[PuaMips.scala 104:25]
  assign dataMemory_io_fromExecute_addrLowBit2 = execute_io_dataMemory_addrLowBit2; // @[PuaMips.scala 104:25]
  assign dataMemory_io_fromExecute_req = execute_io_dataMemory_req; // @[PuaMips.scala 104:25]
  assign dataMemory_io_fromExecute_wr = execute_io_dataMemory_wr; // @[PuaMips.scala 104:25]
  assign dataMemory_io_fromExecute_size = execute_io_dataMemory_size; // @[PuaMips.scala 104:25]
  assign dataMemory_io_fromExecute_wdata = execute_io_dataMemory_wdata; // @[PuaMips.scala 104:25]
  assign dataMemory_io_fromExecute_wstrb = execute_io_dataMemory_wstrb; // @[PuaMips.scala 104:25]
  assign dataMemory_io_fromExecute_waiting = execute_io_dataMemory_waiting; // @[PuaMips.scala 104:25]
  assign dataMemory_io_fromMemory_waiting = memory_io_dataMemory_waiting; // @[PuaMips.scala 122:24]
  assign dataMemory_io_fromCtrl_do_flush = ctrl_io_dataMemory_do_flush; // @[PuaMips.scala 157:22]
  assign dataMemory_io_fromDataMMU_paddr = dataMMU_io_dataMemory_paddr; // @[PuaMips.scala 162:25]
  assign dataMemory_io_sramAXITrans_addr_ok = sramAXITrans_io_dataMemory_addr_ok; // @[PuaMips.scala 51:30]
  assign dataMemory_io_sramAXITrans_data_ok = sramAXITrans_io_dataMemory_data_ok; // @[PuaMips.scala 51:30]
  assign dataMemory_io_sramAXITrans_rdata = sramAXITrans_io_dataMemory_rdata; // @[PuaMips.scala 51:30]
  assign sramAXITrans_clock = clock;
  assign sramAXITrans_reset = reset;
  assign sramAXITrans_io_instMemory_req = instMemory_io_sramAXITrans_req; // @[PuaMips.scala 52:30]
  assign sramAXITrans_io_instMemory_addr = instMemory_io_sramAXITrans_addr; // @[PuaMips.scala 52:30]
  assign sramAXITrans_io_dataMemory_req = dataMemory_io_sramAXITrans_req; // @[PuaMips.scala 51:30]
  assign sramAXITrans_io_dataMemory_wr = dataMemory_io_sramAXITrans_wr; // @[PuaMips.scala 51:30]
  assign sramAXITrans_io_dataMemory_size = dataMemory_io_sramAXITrans_size; // @[PuaMips.scala 51:30]
  assign sramAXITrans_io_dataMemory_addr = dataMemory_io_sramAXITrans_addr; // @[PuaMips.scala 51:30]
  assign sramAXITrans_io_dataMemory_wstrb = dataMemory_io_sramAXITrans_wstrb; // @[PuaMips.scala 51:30]
  assign sramAXITrans_io_dataMemory_wdata = dataMemory_io_sramAXITrans_wdata; // @[PuaMips.scala 51:30]
  assign sramAXITrans_io_axi_arready = io_axi_arready; // @[PuaMips.scala 50:10]
  assign sramAXITrans_io_axi_rid = io_axi_rid; // @[PuaMips.scala 50:10]
  assign sramAXITrans_io_axi_rdata = io_axi_rdata; // @[PuaMips.scala 50:10]
  assign sramAXITrans_io_axi_rvalid = io_axi_rvalid; // @[PuaMips.scala 50:10]
  assign sramAXITrans_io_axi_awready = io_axi_awready; // @[PuaMips.scala 50:10]
  assign sramAXITrans_io_axi_wready = io_axi_wready; // @[PuaMips.scala 50:10]
  assign sramAXITrans_io_axi_bvalid = io_axi_bvalid; // @[PuaMips.scala 50:10]
  assign memoryStage_clock = clock;
  assign memoryStage_reset = reset;
  assign memoryStage_io_fromExecute_aluop = execute_io_memoryStage_aluop; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_hi = execute_io_memoryStage_hi; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_lo = execute_io_memoryStage_lo; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_reg2 = execute_io_memoryStage_reg2; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_reg_waddr = execute_io_memoryStage_reg_waddr; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_reg_wdata = execute_io_memoryStage_reg_wdata; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_whilo = execute_io_memoryStage_whilo; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_reg_wen = execute_io_memoryStage_reg_wen; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_pc = execute_io_memoryStage_pc; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_valid = execute_io_memoryStage_valid; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_mem_addr = execute_io_memoryStage_mem_addr; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_bd = execute_io_memoryStage_bd; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_badvaddr = execute_io_memoryStage_badvaddr; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_cp0_addr = execute_io_memoryStage_cp0_addr; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_excode = execute_io_memoryStage_excode; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_ex = execute_io_memoryStage_ex; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_data_ok = execute_io_memoryStage_data_ok; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_wait_mem = execute_io_memoryStage_wait_mem; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_res_from_mem = execute_io_memoryStage_res_from_mem; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_tlb_refill = execute_io_memoryStage_tlb_refill; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_after_tlb = execute_io_memoryStage_after_tlb; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_s1_found = execute_io_memoryStage_s1_found; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromExecute_s1_index = execute_io_memoryStage_s1_index; // @[PuaMips.scala 103:26]
  assign memoryStage_io_fromMemory_allowin = memory_io_memoryStage_allowin; // @[PuaMips.scala 121:25]
  assign memoryStage_io_fromCtrl_do_flush = ctrl_io_memoryStage_do_flush; // @[PuaMips.scala 155:23]
  assign memory_reset = reset;
  assign memory_io_fromMemoryStage_do_flush = memoryStage_io_memory_do_flush; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_aluop = memoryStage_io_memory_aluop; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_hi = memoryStage_io_memory_hi; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_lo = memoryStage_io_memory_lo; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_whilo = memoryStage_io_memory_whilo; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_mem_addr = memoryStage_io_memory_mem_addr; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_reg2 = memoryStage_io_memory_reg2; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_reg_waddr = memoryStage_io_memory_reg_waddr; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_reg_wen = memoryStage_io_memory_reg_wen; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_reg_wdata = memoryStage_io_memory_reg_wdata; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_pc = memoryStage_io_memory_pc; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_valid = memoryStage_io_memory_valid; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_bd = memoryStage_io_memory_bd; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_badvaddr = memoryStage_io_memory_badvaddr; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_cp0_addr = memoryStage_io_memory_cp0_addr; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_excode = memoryStage_io_memory_excode; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_ex = memoryStage_io_memory_ex; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_data_ok = memoryStage_io_memory_data_ok; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_wait_mem = memoryStage_io_memory_wait_mem; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_res_from_mem = memoryStage_io_memory_res_from_mem; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_tlb_refill = memoryStage_io_memory_tlb_refill; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_after_tlb = memoryStage_io_memory_after_tlb; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_s1_found = memoryStage_io_memory_s1_found; // @[PuaMips.scala 111:25]
  assign memory_io_fromMemoryStage_s1_index = memoryStage_io_memory_s1_index; // @[PuaMips.scala 111:25]
  assign memory_io_fromDataMemory_data_ok = dataMemory_io_memory_data_ok; // @[PuaMips.scala 114:24]
  assign memory_io_fromDataMemory_rdata = dataMemory_io_memory_rdata; // @[PuaMips.scala 114:24]
  assign writeBackStage_clock = clock;
  assign writeBackStage_reset = reset;
  assign writeBackStage_io_fromMemory_pc = memory_io_writeBackStage_pc; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_reg_wdata = memory_io_writeBackStage_reg_wdata; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_reg_waddr = memory_io_writeBackStage_reg_waddr; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_reg_wen = memory_io_writeBackStage_reg_wen; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_whilo = memory_io_writeBackStage_whilo; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_hi = memory_io_writeBackStage_hi; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_lo = memory_io_writeBackStage_lo; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_valid = memory_io_writeBackStage_valid; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_inst_is_mfc0 = memory_io_writeBackStage_inst_is_mfc0; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_inst_is_mtc0 = memory_io_writeBackStage_inst_is_mtc0; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_inst_is_eret = memory_io_writeBackStage_inst_is_eret; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_bd = memory_io_writeBackStage_bd; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_badvaddr = memory_io_writeBackStage_badvaddr; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_cp0_addr = memory_io_writeBackStage_cp0_addr; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_excode = memory_io_writeBackStage_excode; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_ex = memory_io_writeBackStage_ex; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_inst_is_tlbp = memory_io_writeBackStage_inst_is_tlbp; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_inst_is_tlbr = memory_io_writeBackStage_inst_is_tlbr; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_inst_is_tlbwi = memory_io_writeBackStage_inst_is_tlbwi; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_tlb_refill = memory_io_writeBackStage_tlb_refill; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_after_tlb = memory_io_writeBackStage_after_tlb; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_s1_found = memory_io_writeBackStage_s1_found; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromMemory_s1_index = memory_io_writeBackStage_s1_index; // @[PuaMips.scala 124:28]
  assign writeBackStage_io_fromCP0_cp0_rdata = cp0_io_writeBackStage_cp0_rdata; // @[PuaMips.scala 142:25]
  assign writeBackStage_io_fromCP0_cp0_status = cp0_io_writeBackStage_cp0_status; // @[PuaMips.scala 142:25]
  assign writeBackStage_io_fromCP0_cp0_cause = cp0_io_writeBackStage_cp0_cause; // @[PuaMips.scala 142:25]
  assign writeBackStage_io_fromCP0_cp0_epc = cp0_io_writeBackStage_cp0_epc; // @[PuaMips.scala 142:25]
  assign writeBackStage_io_fromCP0_cp0_entryhi = cp0_io_writeBackStage_cp0_entryhi; // @[PuaMips.scala 142:25]
  assign writeBackStage_io_fromCP0_cp0_entrylo0 = cp0_io_writeBackStage_cp0_entrylo0; // @[PuaMips.scala 142:25]
  assign writeBackStage_io_fromCP0_cp0_entrylo1 = cp0_io_writeBackStage_cp0_entrylo1; // @[PuaMips.scala 142:25]
  assign writeBackStage_io_fromCP0_cp0_index = cp0_io_writeBackStage_cp0_index; // @[PuaMips.scala 142:25]
  assign writeBackStage_io_fromTLB_r_vpn2 = tlb_io_writeBackStage_r_vpn2; // @[PuaMips.scala 169:25]
  assign writeBackStage_io_fromTLB_r_asid = tlb_io_writeBackStage_r_asid; // @[PuaMips.scala 169:25]
  assign writeBackStage_io_fromTLB_r_g = tlb_io_writeBackStage_r_g; // @[PuaMips.scala 169:25]
  assign writeBackStage_io_fromTLB_r_pfn0 = tlb_io_writeBackStage_r_pfn0; // @[PuaMips.scala 169:25]
  assign writeBackStage_io_fromTLB_r_c0 = tlb_io_writeBackStage_r_c0; // @[PuaMips.scala 169:25]
  assign writeBackStage_io_fromTLB_r_d0 = tlb_io_writeBackStage_r_d0; // @[PuaMips.scala 169:25]
  assign writeBackStage_io_fromTLB_r_v0 = tlb_io_writeBackStage_r_v0; // @[PuaMips.scala 169:25]
  assign writeBackStage_io_fromTLB_r_pfn1 = tlb_io_writeBackStage_r_pfn1; // @[PuaMips.scala 169:25]
  assign writeBackStage_io_fromTLB_r_c1 = tlb_io_writeBackStage_r_c1; // @[PuaMips.scala 169:25]
  assign writeBackStage_io_fromTLB_r_d1 = tlb_io_writeBackStage_r_d1; // @[PuaMips.scala 169:25]
  assign writeBackStage_io_fromTLB_r_v1 = tlb_io_writeBackStage_r_v1; // @[PuaMips.scala 169:25]
  assign writeBackStage_io_ext_int = io_ext_int; // @[PuaMips.scala 135:29]
  assign regfile_clock = clock;
  assign regfile_reset = reset;
  assign regfile_io_fromDecoder_reg1_raddr = decoder_io_regfile_reg1_raddr; // @[PuaMips.scala 84:22]
  assign regfile_io_fromDecoder_reg2_raddr = decoder_io_regfile_reg2_raddr; // @[PuaMips.scala 84:22]
  assign regfile_io_fromWriteBackStage_reg_wdata = writeBackStage_io_regFile_reg_wdata; // @[PuaMips.scala 131:29]
  assign regfile_io_fromWriteBackStage_reg_waddr = writeBackStage_io_regFile_reg_waddr; // @[PuaMips.scala 131:29]
  assign regfile_io_fromWriteBackStage_reg_wen = writeBackStage_io_regFile_reg_wen; // @[PuaMips.scala 131:29]
  assign hilo_clock = clock;
  assign hilo_reset = reset;
  assign hilo_io_fromWriteBackStage_whilo = writeBackStage_io_hilo_whilo; // @[PuaMips.scala 133:26]
  assign hilo_io_fromWriteBackStage_hi = writeBackStage_io_hilo_hi; // @[PuaMips.scala 133:26]
  assign hilo_io_fromWriteBackStage_lo = writeBackStage_io_hilo_lo; // @[PuaMips.scala 133:26]
  assign cp0_clock = clock;
  assign cp0_reset = reset;
  assign cp0_io_fromWriteBackStage_wb_ex = writeBackStage_io_cp0_wb_ex; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_wb_bd = writeBackStage_io_cp0_wb_bd; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_eret_flush = writeBackStage_io_cp0_eret_flush; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_wb_excode = writeBackStage_io_cp0_wb_excode; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_wb_pc = writeBackStage_io_cp0_wb_pc; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_wb_badvaddr = writeBackStage_io_cp0_wb_badvaddr; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_ext_int_in = writeBackStage_io_cp0_ext_int_in; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_cp0_addr = writeBackStage_io_cp0_cp0_addr; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_mtc0_we = writeBackStage_io_cp0_mtc0_we; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_cp0_wdata = writeBackStage_io_cp0_cp0_wdata; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_tlbp = writeBackStage_io_cp0_tlbp; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_tlbr = writeBackStage_io_cp0_tlbr; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_s1_found = writeBackStage_io_cp0_s1_found; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_s1_index = writeBackStage_io_cp0_s1_index; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_r_vpn2 = writeBackStage_io_cp0_r_vpn2; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_r_asid = writeBackStage_io_cp0_r_asid; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_r_g = writeBackStage_io_cp0_r_g; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_r_pfn0 = writeBackStage_io_cp0_r_pfn0; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_r_c0 = writeBackStage_io_cp0_r_c0; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_r_d0 = writeBackStage_io_cp0_r_d0; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_r_v0 = writeBackStage_io_cp0_r_v0; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_r_pfn1 = writeBackStage_io_cp0_r_pfn1; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_r_c1 = writeBackStage_io_cp0_r_c1; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_r_d1 = writeBackStage_io_cp0_r_d1; // @[PuaMips.scala 134:25]
  assign cp0_io_fromWriteBackStage_r_v1 = writeBackStage_io_cp0_r_v1; // @[PuaMips.scala 134:25]
  assign instMMU_io_fromPreFetchStage_vaddr = preFetchStage_io_instMMU_vaddr; // @[PuaMips.scala 69:28]
  assign instMMU_io_fromWriteBackStage_cp0_entryhi = writeBackStage_io_instMMU_cp0_entryhi; // @[PuaMips.scala 138:29]
  assign instMMU_io_fromTLB_tlb_found = tlb_io_instMMU_tlb_found; // @[PuaMips.scala 170:18]
  assign instMMU_io_fromTLB_tlb_pfn = tlb_io_instMMU_tlb_pfn; // @[PuaMips.scala 170:18]
  assign instMMU_io_fromTLB_tlb_v = tlb_io_instMMU_tlb_v; // @[PuaMips.scala 170:18]
  assign dataMMU_io_fromWriteBackStage_cp0_entryhi = writeBackStage_io_dataMMU_cp0_entryhi; // @[PuaMips.scala 139:29]
  assign dataMMU_io_fromTLB_tlb_found = tlb_io_dataMMU_tlb_found; // @[PuaMips.scala 171:18]
  assign dataMMU_io_fromTLB_tlb_pfn = tlb_io_dataMMU_tlb_pfn; // @[PuaMips.scala 171:18]
  assign dataMMU_io_fromTLB_tlb_d = tlb_io_dataMMU_tlb_d; // @[PuaMips.scala 171:18]
  assign dataMMU_io_fromTLB_tlb_v = tlb_io_dataMMU_tlb_v; // @[PuaMips.scala 171:18]
  assign dataMMU_io_fromExecute_vaddr = execute_io_dataMMU_vaddr; // @[PuaMips.scala 107:22]
  assign dataMMU_io_fromExecute_inst_is_tlbp = execute_io_dataMMU_inst_is_tlbp; // @[PuaMips.scala 107:22]
  assign ctrl_io_fromInstMemory_inst_sram_discard = instMemory_io_ctrl_inst_sram_discard; // @[PuaMips.scala 60:22]
  assign ctrl_io_fromDataMemory_data_sram_discard = dataMemory_io_ctrl_data_sram_discard; // @[PuaMips.scala 116:22]
  assign ctrl_io_fromFetchStage_ex = fetchStage_io_ctrl_ex; // @[PuaMips.scala 75:22]
  assign ctrl_io_fromDecoder_ex = decoder_io_ctrl_ex; // @[PuaMips.scala 86:19]
  assign ctrl_io_fromExecute_ex = execute_io_ctrl_ex; // @[PuaMips.scala 106:19]
  assign ctrl_io_fromMemory_ex = memory_io_ctrl_ex; // @[PuaMips.scala 125:18]
  assign ctrl_io_fromWriteBackStage_ex = writeBackStage_io_ctrl_ex; // @[PuaMips.scala 137:26]
  assign ctrl_io_fromWriteBackStage_do_flush = writeBackStage_io_ctrl_do_flush; // @[PuaMips.scala 137:26]
  assign ctrl_io_fromWriteBackStage_flush_pc = writeBackStage_io_ctrl_flush_pc; // @[PuaMips.scala 137:26]
  assign tlb_clock = clock;
  assign tlb_reset = reset;
  assign tlb_io_fromInstMMU_tlb_vpn2 = instMMU_io_tlb_tlb_vpn2; // @[PuaMips.scala 165:18]
  assign tlb_io_fromInstMMU_tlb_odd_page = instMMU_io_tlb_tlb_odd_page; // @[PuaMips.scala 165:18]
  assign tlb_io_fromInstMMU_tlb_asid = instMMU_io_tlb_tlb_asid; // @[PuaMips.scala 165:18]
  assign tlb_io_fromDataMMU_tlb_vpn2 = dataMMU_io_tlb_tlb_vpn2; // @[PuaMips.scala 161:18]
  assign tlb_io_fromDataMMU_tlb_odd_page = dataMMU_io_tlb_tlb_odd_page; // @[PuaMips.scala 161:18]
  assign tlb_io_fromDataMMU_tlb_asid = dataMMU_io_tlb_tlb_asid; // @[PuaMips.scala 161:18]
  assign tlb_io_fromWriteBackStage_we = writeBackStage_io_tlb_we; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_index = writeBackStage_io_tlb_w_index; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_vpn2 = writeBackStage_io_tlb_w_vpn2; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_asid = writeBackStage_io_tlb_w_asid; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_g = writeBackStage_io_tlb_w_g; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_pfn0 = writeBackStage_io_tlb_w_pfn0; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_c0 = writeBackStage_io_tlb_w_c0; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_d0 = writeBackStage_io_tlb_w_d0; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_v0 = writeBackStage_io_tlb_w_v0; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_pfn1 = writeBackStage_io_tlb_w_pfn1; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_c1 = writeBackStage_io_tlb_w_c1; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_d1 = writeBackStage_io_tlb_w_d1; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_w_v1 = writeBackStage_io_tlb_w_v1; // @[PuaMips.scala 136:25]
  assign tlb_io_fromWriteBackStage_r_index = writeBackStage_io_tlb_r_index; // @[PuaMips.scala 136:25]
endmodule
