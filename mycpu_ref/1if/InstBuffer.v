module InstBuffer(
  input         clock,
  input         reset,
  input         io_fifo_rst,
  input         io_flush_delay_slot,
  input         io_delay_sel_rst,
  input         io_D_delay_rst,
  input         io_E_delay_rst,
  input         io_D_ena,
  input         io_i_stall,
  input         io_master_is_branch,
  output        io_master_is_in_delayslot_o,
  input         io_read_en_0,
  input         io_read_en_1,
  output        io_read_0_tlb_refill,
  output        io_read_0_tlb_invalid,
  output [31:0] io_read_0_data,
  output [31:0] io_read_0_addr,
  output        io_read_1_tlb_refill,
  output        io_read_1_tlb_invalid,
  output [31:0] io_read_1_data,
  output [31:0] io_read_1_addr,
  input         io_write_en_0,
  input         io_write_en_1,
  input         io_write_0_tlb_refill,
  input         io_write_0_tlb_invalid,
  input  [31:0] io_write_0_data,
  input  [31:0] io_write_0_addr,
  input         io_write_1_tlb_refill,
  input         io_write_1_tlb_invalid,
  input  [31:0] io_write_1_data,
  input  [31:0] io_write_1_addr,
  output        io_empty,
  output        io_almost_empty,
  output        io_full
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
`endif // RANDOMIZE_REG_INIT
  reg  buffer_0_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_0_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_0_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_0_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_1_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_1_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_1_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_1_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_2_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_2_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_2_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_2_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_3_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_3_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_3_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_3_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_4_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_4_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_4_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_4_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_5_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_5_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_5_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_5_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_6_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_6_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_6_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_6_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_7_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_7_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_7_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_7_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_8_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_8_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_8_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_8_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_9_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_9_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_9_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_9_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_10_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_10_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_10_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_10_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_11_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_11_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_11_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_11_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_12_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_12_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_12_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_12_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_13_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_13_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_13_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_13_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_14_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_14_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_14_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_14_addr; // @[InstBuffer.scala 41:23]
  reg  buffer_15_tlb_refill; // @[InstBuffer.scala 41:23]
  reg  buffer_15_tlb_invalid; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_15_data; // @[InstBuffer.scala 41:23]
  reg [31:0] buffer_15_addr; // @[InstBuffer.scala 41:23]
  reg [3:0] enq_ptr; // @[InstBuffer.scala 44:24]
  reg [3:0] deq_ptr; // @[InstBuffer.scala 45:24]
  wire [3:0] _count_T_1 = enq_ptr - deq_ptr; // @[InstBuffer.scala 46:29]
  wire [4:0] _GEN_477 = {{1'd0}, _count_T_1}; // @[InstBuffer.scala 46:64]
  reg  master_is_in_delayslot; // @[InstBuffer.scala 54:39]
  wire  _master_is_in_delayslot_T = ~io_read_en_0; // @[InstBuffer.scala 60:7]
  wire  _master_is_in_delayslot_T_2 = io_master_is_branch & ~io_read_en_1; // @[InstBuffer.scala 61:28]
  reg  delayslot_stall; // @[InstBuffer.scala 65:33]
  reg  delayslot_enable; // @[InstBuffer.scala 66:33]
  reg  delayslot_line_tlb_refill; // @[InstBuffer.scala 67:33]
  reg  delayslot_line_tlb_invalid; // @[InstBuffer.scala 67:33]
  reg [31:0] delayslot_line_data; // @[InstBuffer.scala 67:33]
  reg [31:0] delayslot_line_addr; // @[InstBuffer.scala 67:33]
  wire  _T_1 = ~io_flush_delay_slot; // @[InstBuffer.scala 69:40]
  wire [3:0] _T_5 = deq_ptr + 4'h1; // @[InstBuffer.scala 69:87]
  wire  _T_6 = _T_5 == enq_ptr; // @[InstBuffer.scala 69:93]
  wire  _T_7 = deq_ptr == enq_ptr; // @[InstBuffer.scala 69:116]
  wire  _T_9 = io_fifo_rst & io_delay_sel_rst & ~io_flush_delay_slot & io_i_stall & (_T_5 == enq_ptr | deq_ptr ==
    enq_ptr); // @[InstBuffer.scala 69:75]
  wire  _GEN_0 = delayslot_stall & io_write_en_0 ? 1'h0 : delayslot_stall; // @[InstBuffer.scala 72:49 73:21 65:33]
  wire  _GEN_1 = _T_9 | _GEN_0; // @[InstBuffer.scala 70:5 71:21]
  wire  _GEN_6 = 4'h1 == deq_ptr ? buffer_1_tlb_refill : buffer_0_tlb_refill; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_7 = 4'h1 == deq_ptr ? buffer_1_tlb_invalid : buffer_0_tlb_invalid; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_8 = 4'h1 == deq_ptr ? buffer_1_data : buffer_0_data; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_9 = 4'h1 == deq_ptr ? buffer_1_addr : buffer_0_addr; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_10 = 4'h2 == deq_ptr ? buffer_2_tlb_refill : _GEN_6; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_11 = 4'h2 == deq_ptr ? buffer_2_tlb_invalid : _GEN_7; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_12 = 4'h2 == deq_ptr ? buffer_2_data : _GEN_8; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_13 = 4'h2 == deq_ptr ? buffer_2_addr : _GEN_9; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_14 = 4'h3 == deq_ptr ? buffer_3_tlb_refill : _GEN_10; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_15 = 4'h3 == deq_ptr ? buffer_3_tlb_invalid : _GEN_11; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_16 = 4'h3 == deq_ptr ? buffer_3_data : _GEN_12; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_17 = 4'h3 == deq_ptr ? buffer_3_addr : _GEN_13; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_18 = 4'h4 == deq_ptr ? buffer_4_tlb_refill : _GEN_14; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_19 = 4'h4 == deq_ptr ? buffer_4_tlb_invalid : _GEN_15; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_20 = 4'h4 == deq_ptr ? buffer_4_data : _GEN_16; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_21 = 4'h4 == deq_ptr ? buffer_4_addr : _GEN_17; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_22 = 4'h5 == deq_ptr ? buffer_5_tlb_refill : _GEN_18; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_23 = 4'h5 == deq_ptr ? buffer_5_tlb_invalid : _GEN_19; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_24 = 4'h5 == deq_ptr ? buffer_5_data : _GEN_20; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_25 = 4'h5 == deq_ptr ? buffer_5_addr : _GEN_21; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_26 = 4'h6 == deq_ptr ? buffer_6_tlb_refill : _GEN_22; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_27 = 4'h6 == deq_ptr ? buffer_6_tlb_invalid : _GEN_23; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_28 = 4'h6 == deq_ptr ? buffer_6_data : _GEN_24; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_29 = 4'h6 == deq_ptr ? buffer_6_addr : _GEN_25; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_30 = 4'h7 == deq_ptr ? buffer_7_tlb_refill : _GEN_26; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_31 = 4'h7 == deq_ptr ? buffer_7_tlb_invalid : _GEN_27; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_32 = 4'h7 == deq_ptr ? buffer_7_data : _GEN_28; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_33 = 4'h7 == deq_ptr ? buffer_7_addr : _GEN_29; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_34 = 4'h8 == deq_ptr ? buffer_8_tlb_refill : _GEN_30; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_35 = 4'h8 == deq_ptr ? buffer_8_tlb_invalid : _GEN_31; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_36 = 4'h8 == deq_ptr ? buffer_8_data : _GEN_32; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_37 = 4'h8 == deq_ptr ? buffer_8_addr : _GEN_33; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_38 = 4'h9 == deq_ptr ? buffer_9_tlb_refill : _GEN_34; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_39 = 4'h9 == deq_ptr ? buffer_9_tlb_invalid : _GEN_35; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_40 = 4'h9 == deq_ptr ? buffer_9_data : _GEN_36; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_41 = 4'h9 == deq_ptr ? buffer_9_addr : _GEN_37; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_42 = 4'ha == deq_ptr ? buffer_10_tlb_refill : _GEN_38; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_43 = 4'ha == deq_ptr ? buffer_10_tlb_invalid : _GEN_39; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_44 = 4'ha == deq_ptr ? buffer_10_data : _GEN_40; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_45 = 4'ha == deq_ptr ? buffer_10_addr : _GEN_41; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_46 = 4'hb == deq_ptr ? buffer_11_tlb_refill : _GEN_42; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_47 = 4'hb == deq_ptr ? buffer_11_tlb_invalid : _GEN_43; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_48 = 4'hb == deq_ptr ? buffer_11_data : _GEN_44; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_49 = 4'hb == deq_ptr ? buffer_11_addr : _GEN_45; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_50 = 4'hc == deq_ptr ? buffer_12_tlb_refill : _GEN_46; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_51 = 4'hc == deq_ptr ? buffer_12_tlb_invalid : _GEN_47; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_52 = 4'hc == deq_ptr ? buffer_12_data : _GEN_48; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_53 = 4'hc == deq_ptr ? buffer_12_addr : _GEN_49; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_54 = 4'hd == deq_ptr ? buffer_13_tlb_refill : _GEN_50; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_55 = 4'hd == deq_ptr ? buffer_13_tlb_invalid : _GEN_51; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_56 = 4'hd == deq_ptr ? buffer_13_data : _GEN_52; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_57 = 4'hd == deq_ptr ? buffer_13_addr : _GEN_53; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_58 = 4'he == deq_ptr ? buffer_14_tlb_refill : _GEN_54; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_59 = 4'he == deq_ptr ? buffer_14_tlb_invalid : _GEN_55; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_60 = 4'he == deq_ptr ? buffer_14_data : _GEN_56; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_61 = 4'he == deq_ptr ? buffer_14_addr : _GEN_57; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_62 = 4'hf == deq_ptr ? buffer_15_tlb_refill : _GEN_58; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_63 = 4'hf == deq_ptr ? buffer_15_tlb_invalid : _GEN_59; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_64 = 4'hf == deq_ptr ? buffer_15_data : _GEN_60; // @[InstBuffer.scala 79:{30,30}]
  wire [31:0] _GEN_65 = 4'hf == deq_ptr ? buffer_15_addr : _GEN_61; // @[InstBuffer.scala 79:{30,30}]
  wire  _GEN_70 = 4'h1 == _T_5 ? buffer_1_tlb_refill : buffer_0_tlb_refill; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_71 = 4'h1 == _T_5 ? buffer_1_tlb_invalid : buffer_0_tlb_invalid; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_72 = 4'h1 == _T_5 ? buffer_1_data : buffer_0_data; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_73 = 4'h1 == _T_5 ? buffer_1_addr : buffer_0_addr; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_74 = 4'h2 == _T_5 ? buffer_2_tlb_refill : _GEN_70; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_75 = 4'h2 == _T_5 ? buffer_2_tlb_invalid : _GEN_71; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_76 = 4'h2 == _T_5 ? buffer_2_data : _GEN_72; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_77 = 4'h2 == _T_5 ? buffer_2_addr : _GEN_73; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_78 = 4'h3 == _T_5 ? buffer_3_tlb_refill : _GEN_74; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_79 = 4'h3 == _T_5 ? buffer_3_tlb_invalid : _GEN_75; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_80 = 4'h3 == _T_5 ? buffer_3_data : _GEN_76; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_81 = 4'h3 == _T_5 ? buffer_3_addr : _GEN_77; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_82 = 4'h4 == _T_5 ? buffer_4_tlb_refill : _GEN_78; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_83 = 4'h4 == _T_5 ? buffer_4_tlb_invalid : _GEN_79; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_84 = 4'h4 == _T_5 ? buffer_4_data : _GEN_80; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_85 = 4'h4 == _T_5 ? buffer_4_addr : _GEN_81; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_86 = 4'h5 == _T_5 ? buffer_5_tlb_refill : _GEN_82; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_87 = 4'h5 == _T_5 ? buffer_5_tlb_invalid : _GEN_83; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_88 = 4'h5 == _T_5 ? buffer_5_data : _GEN_84; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_89 = 4'h5 == _T_5 ? buffer_5_addr : _GEN_85; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_90 = 4'h6 == _T_5 ? buffer_6_tlb_refill : _GEN_86; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_91 = 4'h6 == _T_5 ? buffer_6_tlb_invalid : _GEN_87; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_92 = 4'h6 == _T_5 ? buffer_6_data : _GEN_88; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_93 = 4'h6 == _T_5 ? buffer_6_addr : _GEN_89; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_94 = 4'h7 == _T_5 ? buffer_7_tlb_refill : _GEN_90; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_95 = 4'h7 == _T_5 ? buffer_7_tlb_invalid : _GEN_91; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_96 = 4'h7 == _T_5 ? buffer_7_data : _GEN_92; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_97 = 4'h7 == _T_5 ? buffer_7_addr : _GEN_93; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_98 = 4'h8 == _T_5 ? buffer_8_tlb_refill : _GEN_94; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_99 = 4'h8 == _T_5 ? buffer_8_tlb_invalid : _GEN_95; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_100 = 4'h8 == _T_5 ? buffer_8_data : _GEN_96; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_101 = 4'h8 == _T_5 ? buffer_8_addr : _GEN_97; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_102 = 4'h9 == _T_5 ? buffer_9_tlb_refill : _GEN_98; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_103 = 4'h9 == _T_5 ? buffer_9_tlb_invalid : _GEN_99; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_104 = 4'h9 == _T_5 ? buffer_9_data : _GEN_100; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_105 = 4'h9 == _T_5 ? buffer_9_addr : _GEN_101; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_106 = 4'ha == _T_5 ? buffer_10_tlb_refill : _GEN_102; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_107 = 4'ha == _T_5 ? buffer_10_tlb_invalid : _GEN_103; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_108 = 4'ha == _T_5 ? buffer_10_data : _GEN_104; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_109 = 4'ha == _T_5 ? buffer_10_addr : _GEN_105; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_110 = 4'hb == _T_5 ? buffer_11_tlb_refill : _GEN_106; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_111 = 4'hb == _T_5 ? buffer_11_tlb_invalid : _GEN_107; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_112 = 4'hb == _T_5 ? buffer_11_data : _GEN_108; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_113 = 4'hb == _T_5 ? buffer_11_addr : _GEN_109; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_114 = 4'hc == _T_5 ? buffer_12_tlb_refill : _GEN_110; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_115 = 4'hc == _T_5 ? buffer_12_tlb_invalid : _GEN_111; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_116 = 4'hc == _T_5 ? buffer_12_data : _GEN_112; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_117 = 4'hc == _T_5 ? buffer_12_addr : _GEN_113; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_118 = 4'hd == _T_5 ? buffer_13_tlb_refill : _GEN_114; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_119 = 4'hd == _T_5 ? buffer_13_tlb_invalid : _GEN_115; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_120 = 4'hd == _T_5 ? buffer_13_data : _GEN_116; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_121 = 4'hd == _T_5 ? buffer_13_addr : _GEN_117; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_122 = 4'he == _T_5 ? buffer_14_tlb_refill : _GEN_118; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_123 = 4'he == _T_5 ? buffer_14_tlb_invalid : _GEN_119; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_124 = 4'he == _T_5 ? buffer_14_data : _GEN_120; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_125 = 4'he == _T_5 ? buffer_14_addr : _GEN_121; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_126 = 4'hf == _T_5 ? buffer_15_tlb_refill : _GEN_122; // @[InstBuffer.scala 82:{28,28}]
  wire  _GEN_127 = 4'hf == _T_5 ? buffer_15_tlb_invalid : _GEN_123; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_128 = 4'hf == _T_5 ? buffer_15_data : _GEN_124; // @[InstBuffer.scala 82:{28,28}]
  wire [31:0] _GEN_129 = 4'hf == _T_5 ? buffer_15_addr : _GEN_125; // @[InstBuffer.scala 82:{28,28}]
  wire  _delayslot_line_T_7_tlb_refill = _T_6 ? io_write_0_tlb_refill : _GEN_126; // @[InstBuffer.scala 82:28]
  wire  _delayslot_line_T_7_tlb_invalid = _T_6 ? io_write_0_tlb_invalid : _GEN_127; // @[InstBuffer.scala 82:28]
  wire [31:0] _delayslot_line_T_7_data = _T_6 ? io_write_0_data : _GEN_128; // @[InstBuffer.scala 82:28]
  wire [31:0] _delayslot_line_T_7_addr = _T_6 ? io_write_0_addr : _GEN_129; // @[InstBuffer.scala 82:28]
  wire  _GEN_131 = io_D_delay_rst & _delayslot_line_T_7_tlb_refill; // @[InstBuffer.scala 80:32 82:22 89:24]
  wire  _GEN_132 = io_D_delay_rst & _delayslot_line_T_7_tlb_invalid; // @[InstBuffer.scala 80:32 82:22 89:24]
  wire  _GEN_135 = io_E_delay_rst | io_D_delay_rst; // @[InstBuffer.scala 77:26 78:24]
  wire  _io_read_0_T_1_tlb_refill = io_empty ? 1'h0 : _GEN_62; // @[Mux.scala 101:16]
  wire  _io_read_0_T_1_tlb_invalid = io_empty ? 1'h0 : _GEN_63; // @[Mux.scala 101:16]
  wire [31:0] _io_read_0_T_1_data = io_empty ? 32'h0 : _GEN_64; // @[Mux.scala 101:16]
  wire [31:0] _io_read_0_T_1_addr = io_empty ? 32'h0 : _GEN_65; // @[Mux.scala 101:16]
  wire  _io_read_1_T_2_tlb_refill = io_almost_empty ? 1'h0 : _GEN_126; // @[Mux.scala 101:16]
  wire  _io_read_1_T_2_tlb_invalid = io_almost_empty ? 1'h0 : _GEN_127; // @[Mux.scala 101:16]
  wire [31:0] _io_read_1_T_2_data = io_almost_empty ? 32'h0 : _GEN_128; // @[Mux.scala 101:16]
  wire [31:0] _io_read_1_T_2_addr = io_almost_empty ? 32'h0 : _GEN_129; // @[Mux.scala 101:16]
  wire  _io_read_1_T_3_tlb_refill = io_empty ? 1'h0 : _io_read_1_T_2_tlb_refill; // @[Mux.scala 101:16]
  wire  _io_read_1_T_3_tlb_invalid = io_empty ? 1'h0 : _io_read_1_T_2_tlb_invalid; // @[Mux.scala 101:16]
  wire [31:0] _io_read_1_T_3_data = io_empty ? 32'h0 : _io_read_1_T_2_data; // @[Mux.scala 101:16]
  wire [31:0] _io_read_1_T_3_addr = io_empty ? 32'h0 : _io_read_1_T_2_addr; // @[Mux.scala 101:16]
  wire [3:0] _deq_ptr_T_1 = deq_ptr + 4'h2; // @[InstBuffer.scala 118:24]
  wire [3:0] _GEN_214 = io_read_en_0 ? _T_5 : deq_ptr; // @[InstBuffer.scala 119:29 120:13 45:24]
  wire [4:0] _T_18 = {{1'd0}, enq_ptr}; // @[InstBuffer.scala 124:70]
  wire  _GEN_218 = 4'h0 == _T_18[3:0] ? io_write_0_tlb_refill : buffer_0_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_219 = 4'h1 == _T_18[3:0] ? io_write_0_tlb_refill : buffer_1_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_220 = 4'h2 == _T_18[3:0] ? io_write_0_tlb_refill : buffer_2_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_221 = 4'h3 == _T_18[3:0] ? io_write_0_tlb_refill : buffer_3_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_222 = 4'h4 == _T_18[3:0] ? io_write_0_tlb_refill : buffer_4_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_223 = 4'h5 == _T_18[3:0] ? io_write_0_tlb_refill : buffer_5_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_224 = 4'h6 == _T_18[3:0] ? io_write_0_tlb_refill : buffer_6_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_225 = 4'h7 == _T_18[3:0] ? io_write_0_tlb_refill : buffer_7_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_226 = 4'h8 == _T_18[3:0] ? io_write_0_tlb_refill : buffer_8_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_227 = 4'h9 == _T_18[3:0] ? io_write_0_tlb_refill : buffer_9_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_228 = 4'ha == _T_18[3:0] ? io_write_0_tlb_refill : buffer_10_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_229 = 4'hb == _T_18[3:0] ? io_write_0_tlb_refill : buffer_11_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_230 = 4'hc == _T_18[3:0] ? io_write_0_tlb_refill : buffer_12_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_231 = 4'hd == _T_18[3:0] ? io_write_0_tlb_refill : buffer_13_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_232 = 4'he == _T_18[3:0] ? io_write_0_tlb_refill : buffer_14_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_233 = 4'hf == _T_18[3:0] ? io_write_0_tlb_refill : buffer_15_tlb_refill; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_234 = 4'h0 == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_0_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_235 = 4'h1 == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_1_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_236 = 4'h2 == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_2_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_237 = 4'h3 == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_3_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_238 = 4'h4 == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_4_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_239 = 4'h5 == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_5_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_240 = 4'h6 == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_6_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_241 = 4'h7 == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_7_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_242 = 4'h8 == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_8_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_243 = 4'h9 == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_9_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_244 = 4'ha == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_10_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_245 = 4'hb == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_11_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_246 = 4'hc == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_12_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_247 = 4'hd == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_13_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_248 = 4'he == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_14_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_249 = 4'hf == _T_18[3:0] ? io_write_0_tlb_invalid : buffer_15_tlb_invalid; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_250 = 4'h0 == _T_18[3:0] ? io_write_0_data : buffer_0_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_251 = 4'h1 == _T_18[3:0] ? io_write_0_data : buffer_1_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_252 = 4'h2 == _T_18[3:0] ? io_write_0_data : buffer_2_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_253 = 4'h3 == _T_18[3:0] ? io_write_0_data : buffer_3_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_254 = 4'h4 == _T_18[3:0] ? io_write_0_data : buffer_4_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_255 = 4'h5 == _T_18[3:0] ? io_write_0_data : buffer_5_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_256 = 4'h6 == _T_18[3:0] ? io_write_0_data : buffer_6_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_257 = 4'h7 == _T_18[3:0] ? io_write_0_data : buffer_7_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_258 = 4'h8 == _T_18[3:0] ? io_write_0_data : buffer_8_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_259 = 4'h9 == _T_18[3:0] ? io_write_0_data : buffer_9_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_260 = 4'ha == _T_18[3:0] ? io_write_0_data : buffer_10_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_261 = 4'hb == _T_18[3:0] ? io_write_0_data : buffer_11_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_262 = 4'hc == _T_18[3:0] ? io_write_0_data : buffer_12_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_263 = 4'hd == _T_18[3:0] ? io_write_0_data : buffer_13_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_264 = 4'he == _T_18[3:0] ? io_write_0_data : buffer_14_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_265 = 4'hf == _T_18[3:0] ? io_write_0_data : buffer_15_data; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_266 = 4'h0 == _T_18[3:0] ? io_write_0_addr : buffer_0_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_267 = 4'h1 == _T_18[3:0] ? io_write_0_addr : buffer_1_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_268 = 4'h2 == _T_18[3:0] ? io_write_0_addr : buffer_2_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_269 = 4'h3 == _T_18[3:0] ? io_write_0_addr : buffer_3_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_270 = 4'h4 == _T_18[3:0] ? io_write_0_addr : buffer_4_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_271 = 4'h5 == _T_18[3:0] ? io_write_0_addr : buffer_5_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_272 = 4'h6 == _T_18[3:0] ? io_write_0_addr : buffer_6_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_273 = 4'h7 == _T_18[3:0] ? io_write_0_addr : buffer_7_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_274 = 4'h8 == _T_18[3:0] ? io_write_0_addr : buffer_8_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_275 = 4'h9 == _T_18[3:0] ? io_write_0_addr : buffer_9_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_276 = 4'ha == _T_18[3:0] ? io_write_0_addr : buffer_10_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_277 = 4'hb == _T_18[3:0] ? io_write_0_addr : buffer_11_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_278 = 4'hc == _T_18[3:0] ? io_write_0_addr : buffer_12_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_279 = 4'hd == _T_18[3:0] ? io_write_0_addr : buffer_13_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_280 = 4'he == _T_18[3:0] ? io_write_0_addr : buffer_14_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire [31:0] _GEN_281 = 4'hf == _T_18[3:0] ? io_write_0_addr : buffer_15_addr; // @[InstBuffer.scala 124:{77,77} 41:23]
  wire  _GEN_282 = io_write_en_0 ? _GEN_218 : buffer_0_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_283 = io_write_en_0 ? _GEN_219 : buffer_1_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_284 = io_write_en_0 ? _GEN_220 : buffer_2_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_285 = io_write_en_0 ? _GEN_221 : buffer_3_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_286 = io_write_en_0 ? _GEN_222 : buffer_4_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_287 = io_write_en_0 ? _GEN_223 : buffer_5_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_288 = io_write_en_0 ? _GEN_224 : buffer_6_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_289 = io_write_en_0 ? _GEN_225 : buffer_7_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_290 = io_write_en_0 ? _GEN_226 : buffer_8_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_291 = io_write_en_0 ? _GEN_227 : buffer_9_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_292 = io_write_en_0 ? _GEN_228 : buffer_10_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_293 = io_write_en_0 ? _GEN_229 : buffer_11_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_294 = io_write_en_0 ? _GEN_230 : buffer_12_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_295 = io_write_en_0 ? _GEN_231 : buffer_13_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_296 = io_write_en_0 ? _GEN_232 : buffer_14_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_297 = io_write_en_0 ? _GEN_233 : buffer_15_tlb_refill; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_298 = io_write_en_0 ? _GEN_234 : buffer_0_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_299 = io_write_en_0 ? _GEN_235 : buffer_1_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_300 = io_write_en_0 ? _GEN_236 : buffer_2_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_301 = io_write_en_0 ? _GEN_237 : buffer_3_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_302 = io_write_en_0 ? _GEN_238 : buffer_4_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_303 = io_write_en_0 ? _GEN_239 : buffer_5_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_304 = io_write_en_0 ? _GEN_240 : buffer_6_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_305 = io_write_en_0 ? _GEN_241 : buffer_7_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_306 = io_write_en_0 ? _GEN_242 : buffer_8_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_307 = io_write_en_0 ? _GEN_243 : buffer_9_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_308 = io_write_en_0 ? _GEN_244 : buffer_10_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_309 = io_write_en_0 ? _GEN_245 : buffer_11_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_310 = io_write_en_0 ? _GEN_246 : buffer_12_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_311 = io_write_en_0 ? _GEN_247 : buffer_13_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_312 = io_write_en_0 ? _GEN_248 : buffer_14_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire  _GEN_313 = io_write_en_0 ? _GEN_249 : buffer_15_tlb_invalid; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_314 = io_write_en_0 ? _GEN_250 : buffer_0_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_315 = io_write_en_0 ? _GEN_251 : buffer_1_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_316 = io_write_en_0 ? _GEN_252 : buffer_2_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_317 = io_write_en_0 ? _GEN_253 : buffer_3_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_318 = io_write_en_0 ? _GEN_254 : buffer_4_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_319 = io_write_en_0 ? _GEN_255 : buffer_5_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_320 = io_write_en_0 ? _GEN_256 : buffer_6_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_321 = io_write_en_0 ? _GEN_257 : buffer_7_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_322 = io_write_en_0 ? _GEN_258 : buffer_8_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_323 = io_write_en_0 ? _GEN_259 : buffer_9_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_324 = io_write_en_0 ? _GEN_260 : buffer_10_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_325 = io_write_en_0 ? _GEN_261 : buffer_11_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_326 = io_write_en_0 ? _GEN_262 : buffer_12_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_327 = io_write_en_0 ? _GEN_263 : buffer_13_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_328 = io_write_en_0 ? _GEN_264 : buffer_14_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_329 = io_write_en_0 ? _GEN_265 : buffer_15_data; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_330 = io_write_en_0 ? _GEN_266 : buffer_0_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_331 = io_write_en_0 ? _GEN_267 : buffer_1_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_332 = io_write_en_0 ? _GEN_268 : buffer_2_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_333 = io_write_en_0 ? _GEN_269 : buffer_3_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_334 = io_write_en_0 ? _GEN_270 : buffer_4_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_335 = io_write_en_0 ? _GEN_271 : buffer_5_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_336 = io_write_en_0 ? _GEN_272 : buffer_6_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_337 = io_write_en_0 ? _GEN_273 : buffer_7_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_338 = io_write_en_0 ? _GEN_274 : buffer_8_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_339 = io_write_en_0 ? _GEN_275 : buffer_9_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_340 = io_write_en_0 ? _GEN_276 : buffer_10_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_341 = io_write_en_0 ? _GEN_277 : buffer_11_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_342 = io_write_en_0 ? _GEN_278 : buffer_12_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_343 = io_write_en_0 ? _GEN_279 : buffer_13_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_344 = io_write_en_0 ? _GEN_280 : buffer_14_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [31:0] _GEN_345 = io_write_en_0 ? _GEN_281 : buffer_15_addr; // @[InstBuffer.scala 124:53 41:23]
  wire [3:0] _T_21 = enq_ptr + 4'h1; // @[InstBuffer.scala 124:70]
  wire [3:0] _enq_ptr_T_1 = enq_ptr + 4'h2; // @[InstBuffer.scala 129:24]
  assign io_master_is_in_delayslot_o = master_is_in_delayslot; // @[InstBuffer.scala 55:31]
  assign io_read_0_tlb_refill = delayslot_enable ? delayslot_line_tlb_refill : _io_read_0_T_1_tlb_refill; // @[Mux.scala 101:16]
  assign io_read_0_tlb_invalid = delayslot_enable ? delayslot_line_tlb_invalid : _io_read_0_T_1_tlb_invalid; // @[Mux.scala 101:16]
  assign io_read_0_data = delayslot_enable ? delayslot_line_data : _io_read_0_T_1_data; // @[Mux.scala 101:16]
  assign io_read_0_addr = delayslot_enable ? delayslot_line_addr : _io_read_0_T_1_addr; // @[Mux.scala 101:16]
  assign io_read_1_tlb_refill = delayslot_enable ? 1'h0 : _io_read_1_T_3_tlb_refill; // @[Mux.scala 101:16]
  assign io_read_1_tlb_invalid = delayslot_enable ? 1'h0 : _io_read_1_T_3_tlb_invalid; // @[Mux.scala 101:16]
  assign io_read_1_data = delayslot_enable ? 32'h0 : _io_read_1_T_3_data; // @[Mux.scala 101:16]
  assign io_read_1_addr = delayslot_enable ? 32'h0 : _io_read_1_T_3_addr; // @[Mux.scala 101:16]
  assign io_empty = _GEN_477 == 5'h0; // @[InstBuffer.scala 51:28]
  assign io_almost_empty = _GEN_477 == 5'h1; // @[InstBuffer.scala 52:28]
  assign io_full = _GEN_477 >= 5'he; // @[InstBuffer.scala 50:28]
  always @(posedge clock) begin
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_0_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h0 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_0_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_0_tlb_refill <= _GEN_282;
      end
    end else begin
      buffer_0_tlb_refill <= _GEN_282;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_0_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h0 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_0_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_0_tlb_invalid <= _GEN_298;
      end
    end else begin
      buffer_0_tlb_invalid <= _GEN_298;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_0_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h0 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_0_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_0_data <= _GEN_314;
      end
    end else begin
      buffer_0_data <= _GEN_314;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_0_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h0 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_0_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_0_addr <= _GEN_330;
      end
    end else begin
      buffer_0_addr <= _GEN_330;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_1_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h1 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_1_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_1_tlb_refill <= _GEN_283;
      end
    end else begin
      buffer_1_tlb_refill <= _GEN_283;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_1_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h1 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_1_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_1_tlb_invalid <= _GEN_299;
      end
    end else begin
      buffer_1_tlb_invalid <= _GEN_299;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_1_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h1 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_1_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_1_data <= _GEN_315;
      end
    end else begin
      buffer_1_data <= _GEN_315;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_1_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h1 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_1_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_1_addr <= _GEN_331;
      end
    end else begin
      buffer_1_addr <= _GEN_331;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_2_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h2 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_2_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_2_tlb_refill <= _GEN_284;
      end
    end else begin
      buffer_2_tlb_refill <= _GEN_284;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_2_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h2 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_2_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_2_tlb_invalid <= _GEN_300;
      end
    end else begin
      buffer_2_tlb_invalid <= _GEN_300;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_2_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h2 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_2_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_2_data <= _GEN_316;
      end
    end else begin
      buffer_2_data <= _GEN_316;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_2_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h2 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_2_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_2_addr <= _GEN_332;
      end
    end else begin
      buffer_2_addr <= _GEN_332;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_3_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h3 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_3_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_3_tlb_refill <= _GEN_285;
      end
    end else begin
      buffer_3_tlb_refill <= _GEN_285;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_3_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h3 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_3_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_3_tlb_invalid <= _GEN_301;
      end
    end else begin
      buffer_3_tlb_invalid <= _GEN_301;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_3_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h3 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_3_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_3_data <= _GEN_317;
      end
    end else begin
      buffer_3_data <= _GEN_317;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_3_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h3 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_3_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_3_addr <= _GEN_333;
      end
    end else begin
      buffer_3_addr <= _GEN_333;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_4_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h4 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_4_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_4_tlb_refill <= _GEN_286;
      end
    end else begin
      buffer_4_tlb_refill <= _GEN_286;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_4_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h4 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_4_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_4_tlb_invalid <= _GEN_302;
      end
    end else begin
      buffer_4_tlb_invalid <= _GEN_302;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_4_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h4 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_4_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_4_data <= _GEN_318;
      end
    end else begin
      buffer_4_data <= _GEN_318;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_4_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h4 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_4_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_4_addr <= _GEN_334;
      end
    end else begin
      buffer_4_addr <= _GEN_334;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_5_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h5 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_5_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_5_tlb_refill <= _GEN_287;
      end
    end else begin
      buffer_5_tlb_refill <= _GEN_287;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_5_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h5 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_5_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_5_tlb_invalid <= _GEN_303;
      end
    end else begin
      buffer_5_tlb_invalid <= _GEN_303;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_5_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h5 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_5_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_5_data <= _GEN_319;
      end
    end else begin
      buffer_5_data <= _GEN_319;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_5_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h5 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_5_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_5_addr <= _GEN_335;
      end
    end else begin
      buffer_5_addr <= _GEN_335;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_6_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h6 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_6_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_6_tlb_refill <= _GEN_288;
      end
    end else begin
      buffer_6_tlb_refill <= _GEN_288;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_6_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h6 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_6_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_6_tlb_invalid <= _GEN_304;
      end
    end else begin
      buffer_6_tlb_invalid <= _GEN_304;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_6_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h6 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_6_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_6_data <= _GEN_320;
      end
    end else begin
      buffer_6_data <= _GEN_320;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_6_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h6 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_6_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_6_addr <= _GEN_336;
      end
    end else begin
      buffer_6_addr <= _GEN_336;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_7_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h7 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_7_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_7_tlb_refill <= _GEN_289;
      end
    end else begin
      buffer_7_tlb_refill <= _GEN_289;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_7_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h7 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_7_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_7_tlb_invalid <= _GEN_305;
      end
    end else begin
      buffer_7_tlb_invalid <= _GEN_305;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_7_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h7 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_7_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_7_data <= _GEN_321;
      end
    end else begin
      buffer_7_data <= _GEN_321;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_7_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h7 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_7_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_7_addr <= _GEN_337;
      end
    end else begin
      buffer_7_addr <= _GEN_337;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_8_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h8 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_8_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_8_tlb_refill <= _GEN_290;
      end
    end else begin
      buffer_8_tlb_refill <= _GEN_290;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_8_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h8 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_8_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_8_tlb_invalid <= _GEN_306;
      end
    end else begin
      buffer_8_tlb_invalid <= _GEN_306;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_8_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h8 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_8_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_8_data <= _GEN_322;
      end
    end else begin
      buffer_8_data <= _GEN_322;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_8_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h8 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_8_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_8_addr <= _GEN_338;
      end
    end else begin
      buffer_8_addr <= _GEN_338;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_9_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h9 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_9_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_9_tlb_refill <= _GEN_291;
      end
    end else begin
      buffer_9_tlb_refill <= _GEN_291;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_9_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h9 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_9_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_9_tlb_invalid <= _GEN_307;
      end
    end else begin
      buffer_9_tlb_invalid <= _GEN_307;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_9_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h9 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_9_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_9_data <= _GEN_323;
      end
    end else begin
      buffer_9_data <= _GEN_323;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_9_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'h9 == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_9_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_9_addr <= _GEN_339;
      end
    end else begin
      buffer_9_addr <= _GEN_339;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_10_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'ha == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_10_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_10_tlb_refill <= _GEN_292;
      end
    end else begin
      buffer_10_tlb_refill <= _GEN_292;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_10_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'ha == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_10_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_10_tlb_invalid <= _GEN_308;
      end
    end else begin
      buffer_10_tlb_invalid <= _GEN_308;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_10_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'ha == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_10_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_10_data <= _GEN_324;
      end
    end else begin
      buffer_10_data <= _GEN_324;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_10_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'ha == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_10_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_10_addr <= _GEN_340;
      end
    end else begin
      buffer_10_addr <= _GEN_340;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_11_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hb == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_11_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_11_tlb_refill <= _GEN_293;
      end
    end else begin
      buffer_11_tlb_refill <= _GEN_293;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_11_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hb == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_11_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_11_tlb_invalid <= _GEN_309;
      end
    end else begin
      buffer_11_tlb_invalid <= _GEN_309;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_11_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hb == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_11_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_11_data <= _GEN_325;
      end
    end else begin
      buffer_11_data <= _GEN_325;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_11_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hb == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_11_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_11_addr <= _GEN_341;
      end
    end else begin
      buffer_11_addr <= _GEN_341;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_12_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hc == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_12_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_12_tlb_refill <= _GEN_294;
      end
    end else begin
      buffer_12_tlb_refill <= _GEN_294;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_12_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hc == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_12_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_12_tlb_invalid <= _GEN_310;
      end
    end else begin
      buffer_12_tlb_invalid <= _GEN_310;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_12_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hc == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_12_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_12_data <= _GEN_326;
      end
    end else begin
      buffer_12_data <= _GEN_326;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_12_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hc == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_12_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_12_addr <= _GEN_342;
      end
    end else begin
      buffer_12_addr <= _GEN_342;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_13_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hd == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_13_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_13_tlb_refill <= _GEN_295;
      end
    end else begin
      buffer_13_tlb_refill <= _GEN_295;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_13_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hd == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_13_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_13_tlb_invalid <= _GEN_311;
      end
    end else begin
      buffer_13_tlb_invalid <= _GEN_311;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_13_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hd == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_13_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_13_data <= _GEN_327;
      end
    end else begin
      buffer_13_data <= _GEN_327;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_13_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hd == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_13_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_13_addr <= _GEN_343;
      end
    end else begin
      buffer_13_addr <= _GEN_343;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_14_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'he == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_14_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_14_tlb_refill <= _GEN_296;
      end
    end else begin
      buffer_14_tlb_refill <= _GEN_296;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_14_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'he == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_14_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_14_tlb_invalid <= _GEN_312;
      end
    end else begin
      buffer_14_tlb_invalid <= _GEN_312;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_14_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'he == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_14_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_14_data <= _GEN_328;
      end
    end else begin
      buffer_14_data <= _GEN_328;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_14_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'he == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_14_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_14_addr <= _GEN_344;
      end
    end else begin
      buffer_14_addr <= _GEN_344;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_15_tlb_refill <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hf == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_15_tlb_refill <= io_write_1_tlb_refill; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_15_tlb_refill <= _GEN_297;
      end
    end else begin
      buffer_15_tlb_refill <= _GEN_297;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_15_tlb_invalid <= 1'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hf == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_15_tlb_invalid <= io_write_1_tlb_invalid; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_15_tlb_invalid <= _GEN_313;
      end
    end else begin
      buffer_15_tlb_invalid <= _GEN_313;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_15_data <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hf == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_15_data <= io_write_1_data; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_15_data <= _GEN_329;
      end
    end else begin
      buffer_15_data <= _GEN_329;
    end
    if (reset) begin // @[InstBuffer.scala 41:23]
      buffer_15_addr <= 32'h0; // @[InstBuffer.scala 41:23]
    end else if (io_write_en_1) begin // @[InstBuffer.scala 124:53]
      if (4'hf == _T_21) begin // @[InstBuffer.scala 124:77]
        buffer_15_addr <= io_write_1_addr; // @[InstBuffer.scala 124:77]
      end else begin
        buffer_15_addr <= _GEN_345;
      end
    end else begin
      buffer_15_addr <= _GEN_345;
    end
    if (reset) begin // @[InstBuffer.scala 44:24]
      enq_ptr <= 4'h0; // @[InstBuffer.scala 44:24]
    end else if (io_fifo_rst) begin // @[InstBuffer.scala 126:21]
      enq_ptr <= 4'h0; // @[InstBuffer.scala 127:13]
    end else if (io_write_en_0 & io_write_en_1) begin // @[InstBuffer.scala 128:48]
      enq_ptr <= _enq_ptr_T_1; // @[InstBuffer.scala 129:13]
    end else if (io_write_en_0) begin // @[InstBuffer.scala 130:30]
      enq_ptr <= _T_21; // @[InstBuffer.scala 131:13]
    end
    if (reset) begin // @[InstBuffer.scala 45:24]
      deq_ptr <= 4'h0; // @[InstBuffer.scala 45:24]
    end else if (io_fifo_rst) begin // @[InstBuffer.scala 113:21]
      deq_ptr <= 4'h0; // @[InstBuffer.scala 114:13]
    end else if (!(io_empty | delayslot_enable)) begin // @[InstBuffer.scala 115:44]
      if (io_read_en_0 & io_read_en_1) begin // @[InstBuffer.scala 117:46]
        deq_ptr <= _deq_ptr_T_1; // @[InstBuffer.scala 118:13]
      end else begin
        deq_ptr <= _GEN_214;
      end
    end
    if (reset) begin // @[InstBuffer.scala 54:39]
      master_is_in_delayslot <= 1'h0; // @[InstBuffer.scala 54:39]
    end else if (io_flush_delay_slot) begin // @[Mux.scala 101:16]
      master_is_in_delayslot <= 1'h0;
    end else if (!(_master_is_in_delayslot_T)) begin // @[Mux.scala 101:16]
      master_is_in_delayslot <= _master_is_in_delayslot_T_2;
    end
    if (reset) begin // @[InstBuffer.scala 65:33]
      delayslot_stall <= 1'h0; // @[InstBuffer.scala 65:33]
    end else begin
      delayslot_stall <= _GEN_1;
    end
    if (reset) begin // @[InstBuffer.scala 66:33]
      delayslot_enable <= 1'h0; // @[InstBuffer.scala 66:33]
    end else if (io_fifo_rst & _T_1 & io_delay_sel_rst) begin // @[InstBuffer.scala 76:65]
      delayslot_enable <= _GEN_135;
    end else if (~delayslot_stall & io_read_en_0) begin // @[InstBuffer.scala 91:49]
      delayslot_enable <= 1'h0; // @[InstBuffer.scala 92:22]
    end
    if (reset) begin // @[InstBuffer.scala 67:33]
      delayslot_line_tlb_refill <= 1'h0; // @[InstBuffer.scala 67:33]
    end else if (io_fifo_rst & _T_1 & io_delay_sel_rst) begin // @[InstBuffer.scala 76:65]
      if (io_E_delay_rst) begin // @[InstBuffer.scala 77:26]
        if (_T_7) begin // @[InstBuffer.scala 79:30]
          delayslot_line_tlb_refill <= io_write_0_tlb_refill;
        end else begin
          delayslot_line_tlb_refill <= _GEN_62;
        end
      end else begin
        delayslot_line_tlb_refill <= _GEN_131;
      end
    end else if (~delayslot_stall & io_read_en_0) begin // @[InstBuffer.scala 91:49]
      delayslot_line_tlb_refill <= 1'h0; // @[InstBuffer.scala 93:22]
    end
    if (reset) begin // @[InstBuffer.scala 67:33]
      delayslot_line_tlb_invalid <= 1'h0; // @[InstBuffer.scala 67:33]
    end else if (io_fifo_rst & _T_1 & io_delay_sel_rst) begin // @[InstBuffer.scala 76:65]
      if (io_E_delay_rst) begin // @[InstBuffer.scala 77:26]
        if (_T_7) begin // @[InstBuffer.scala 79:30]
          delayslot_line_tlb_invalid <= io_write_0_tlb_invalid;
        end else begin
          delayslot_line_tlb_invalid <= _GEN_63;
        end
      end else begin
        delayslot_line_tlb_invalid <= _GEN_132;
      end
    end else if (~delayslot_stall & io_read_en_0) begin // @[InstBuffer.scala 91:49]
      delayslot_line_tlb_invalid <= 1'h0; // @[InstBuffer.scala 93:22]
    end
    if (reset) begin // @[InstBuffer.scala 67:33]
      delayslot_line_data <= 32'h0; // @[InstBuffer.scala 67:33]
    end else if (io_fifo_rst & _T_1 & io_delay_sel_rst) begin // @[InstBuffer.scala 76:65]
      if (io_E_delay_rst) begin // @[InstBuffer.scala 77:26]
        if (_T_7) begin // @[InstBuffer.scala 79:30]
          delayslot_line_data <= io_write_0_data;
        end else begin
          delayslot_line_data <= _GEN_64;
        end
      end else if (io_D_delay_rst) begin // @[InstBuffer.scala 80:32]
        delayslot_line_data <= _delayslot_line_T_7_data; // @[InstBuffer.scala 82:22]
      end else begin
        delayslot_line_data <= 32'h0; // @[InstBuffer.scala 89:24]
      end
    end else if (~delayslot_stall & io_read_en_0) begin // @[InstBuffer.scala 91:49]
      delayslot_line_data <= 32'h0; // @[InstBuffer.scala 93:22]
    end
    if (reset) begin // @[InstBuffer.scala 67:33]
      delayslot_line_addr <= 32'h0; // @[InstBuffer.scala 67:33]
    end else if (io_fifo_rst & _T_1 & io_delay_sel_rst) begin // @[InstBuffer.scala 76:65]
      if (io_E_delay_rst) begin // @[InstBuffer.scala 77:26]
        if (_T_7) begin // @[InstBuffer.scala 79:30]
          delayslot_line_addr <= io_write_0_addr;
        end else begin
          delayslot_line_addr <= _GEN_65;
        end
      end else if (io_D_delay_rst) begin // @[InstBuffer.scala 80:32]
        delayslot_line_addr <= _delayslot_line_T_7_addr; // @[InstBuffer.scala 82:22]
      end else begin
        delayslot_line_addr <= 32'h0; // @[InstBuffer.scala 89:24]
      end
    end else if (~delayslot_stall & io_read_en_0) begin // @[InstBuffer.scala 91:49]
      delayslot_line_addr <= 32'h0; // @[InstBuffer.scala 93:22]
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
  buffer_0_tlb_refill = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  buffer_0_tlb_invalid = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  buffer_0_data = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  buffer_0_addr = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  buffer_1_tlb_refill = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  buffer_1_tlb_invalid = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  buffer_1_data = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  buffer_1_addr = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  buffer_2_tlb_refill = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  buffer_2_tlb_invalid = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  buffer_2_data = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  buffer_2_addr = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  buffer_3_tlb_refill = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  buffer_3_tlb_invalid = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  buffer_3_data = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  buffer_3_addr = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  buffer_4_tlb_refill = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  buffer_4_tlb_invalid = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  buffer_4_data = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  buffer_4_addr = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  buffer_5_tlb_refill = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  buffer_5_tlb_invalid = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  buffer_5_data = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  buffer_5_addr = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  buffer_6_tlb_refill = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  buffer_6_tlb_invalid = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  buffer_6_data = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  buffer_6_addr = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  buffer_7_tlb_refill = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  buffer_7_tlb_invalid = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  buffer_7_data = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  buffer_7_addr = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  buffer_8_tlb_refill = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  buffer_8_tlb_invalid = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  buffer_8_data = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  buffer_8_addr = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  buffer_9_tlb_refill = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  buffer_9_tlb_invalid = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  buffer_9_data = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  buffer_9_addr = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  buffer_10_tlb_refill = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  buffer_10_tlb_invalid = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  buffer_10_data = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  buffer_10_addr = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  buffer_11_tlb_refill = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  buffer_11_tlb_invalid = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  buffer_11_data = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  buffer_11_addr = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  buffer_12_tlb_refill = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  buffer_12_tlb_invalid = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  buffer_12_data = _RAND_50[31:0];
  _RAND_51 = {1{`RANDOM}};
  buffer_12_addr = _RAND_51[31:0];
  _RAND_52 = {1{`RANDOM}};
  buffer_13_tlb_refill = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  buffer_13_tlb_invalid = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  buffer_13_data = _RAND_54[31:0];
  _RAND_55 = {1{`RANDOM}};
  buffer_13_addr = _RAND_55[31:0];
  _RAND_56 = {1{`RANDOM}};
  buffer_14_tlb_refill = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  buffer_14_tlb_invalid = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  buffer_14_data = _RAND_58[31:0];
  _RAND_59 = {1{`RANDOM}};
  buffer_14_addr = _RAND_59[31:0];
  _RAND_60 = {1{`RANDOM}};
  buffer_15_tlb_refill = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  buffer_15_tlb_invalid = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  buffer_15_data = _RAND_62[31:0];
  _RAND_63 = {1{`RANDOM}};
  buffer_15_addr = _RAND_63[31:0];
  _RAND_64 = {1{`RANDOM}};
  enq_ptr = _RAND_64[3:0];
  _RAND_65 = {1{`RANDOM}};
  deq_ptr = _RAND_65[3:0];
  _RAND_66 = {1{`RANDOM}};
  master_is_in_delayslot = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  delayslot_stall = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  delayslot_enable = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  delayslot_line_tlb_refill = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  delayslot_line_tlb_invalid = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  delayslot_line_data = _RAND_71[31:0];
  _RAND_72 = {1{`RANDOM}};
  delayslot_line_addr = _RAND_72[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
