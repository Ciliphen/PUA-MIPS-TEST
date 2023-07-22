module BPU(
  input         clock,
  input         reset,
  input  [31:0] io_instrD,
  input         io_enaD,
  input  [31:0] io_pcD,
  input  [31:0] io_pc_plus4D,
  input  [31:0] io_pcE,
  input         io_branchE,
  input         io_actual_takeE,
  output        io_branchD,
  output        io_pred_takeD,
  output [31:0] io_branch_targetD
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
`endif // RANDOMIZE_REG_INIT
  wire [13:0] _io_branch_targetD_T_2 = io_instrD[15] ? 14'h3fff : 14'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_branch_targetD_T_4 = {_io_branch_targetD_T_2,io_instrD[15:0],2'h0}; // @[Cat.scala 33:92]
  reg [5:0] BHT_0; // @[BPU.scala 27:26]
  reg [5:0] BHT_1; // @[BPU.scala 27:26]
  reg [5:0] BHT_2; // @[BPU.scala 27:26]
  reg [5:0] BHT_3; // @[BPU.scala 27:26]
  reg [5:0] BHT_4; // @[BPU.scala 27:26]
  reg [5:0] BHT_5; // @[BPU.scala 27:26]
  reg [5:0] BHT_6; // @[BPU.scala 27:26]
  reg [5:0] BHT_7; // @[BPU.scala 27:26]
  reg [5:0] BHT_8; // @[BPU.scala 27:26]
  reg [5:0] BHT_9; // @[BPU.scala 27:26]
  reg [5:0] BHT_10; // @[BPU.scala 27:26]
  reg [5:0] BHT_11; // @[BPU.scala 27:26]
  reg [5:0] BHT_12; // @[BPU.scala 27:26]
  reg [5:0] BHT_13; // @[BPU.scala 27:26]
  reg [5:0] BHT_14; // @[BPU.scala 27:26]
  reg [5:0] BHT_15; // @[BPU.scala 27:26]
  reg [1:0] PHT_0; // @[BPU.scala 28:26]
  reg [1:0] PHT_1; // @[BPU.scala 28:26]
  reg [1:0] PHT_2; // @[BPU.scala 28:26]
  reg [1:0] PHT_3; // @[BPU.scala 28:26]
  reg [1:0] PHT_4; // @[BPU.scala 28:26]
  reg [1:0] PHT_5; // @[BPU.scala 28:26]
  reg [1:0] PHT_6; // @[BPU.scala 28:26]
  reg [1:0] PHT_7; // @[BPU.scala 28:26]
  reg [1:0] PHT_8; // @[BPU.scala 28:26]
  reg [1:0] PHT_9; // @[BPU.scala 28:26]
  reg [1:0] PHT_10; // @[BPU.scala 28:26]
  reg [1:0] PHT_11; // @[BPU.scala 28:26]
  reg [1:0] PHT_12; // @[BPU.scala 28:26]
  reg [1:0] PHT_13; // @[BPU.scala 28:26]
  reg [1:0] PHT_14; // @[BPU.scala 28:26]
  reg [1:0] PHT_15; // @[BPU.scala 28:26]
  reg [1:0] PHT_16; // @[BPU.scala 28:26]
  reg [1:0] PHT_17; // @[BPU.scala 28:26]
  reg [1:0] PHT_18; // @[BPU.scala 28:26]
  reg [1:0] PHT_19; // @[BPU.scala 28:26]
  reg [1:0] PHT_20; // @[BPU.scala 28:26]
  reg [1:0] PHT_21; // @[BPU.scala 28:26]
  reg [1:0] PHT_22; // @[BPU.scala 28:26]
  reg [1:0] PHT_23; // @[BPU.scala 28:26]
  reg [1:0] PHT_24; // @[BPU.scala 28:26]
  reg [1:0] PHT_25; // @[BPU.scala 28:26]
  reg [1:0] PHT_26; // @[BPU.scala 28:26]
  reg [1:0] PHT_27; // @[BPU.scala 28:26]
  reg [1:0] PHT_28; // @[BPU.scala 28:26]
  reg [1:0] PHT_29; // @[BPU.scala 28:26]
  reg [1:0] PHT_30; // @[BPU.scala 28:26]
  reg [1:0] PHT_31; // @[BPU.scala 28:26]
  reg [1:0] PHT_32; // @[BPU.scala 28:26]
  reg [1:0] PHT_33; // @[BPU.scala 28:26]
  reg [1:0] PHT_34; // @[BPU.scala 28:26]
  reg [1:0] PHT_35; // @[BPU.scala 28:26]
  reg [1:0] PHT_36; // @[BPU.scala 28:26]
  reg [1:0] PHT_37; // @[BPU.scala 28:26]
  reg [1:0] PHT_38; // @[BPU.scala 28:26]
  reg [1:0] PHT_39; // @[BPU.scala 28:26]
  reg [1:0] PHT_40; // @[BPU.scala 28:26]
  reg [1:0] PHT_41; // @[BPU.scala 28:26]
  reg [1:0] PHT_42; // @[BPU.scala 28:26]
  reg [1:0] PHT_43; // @[BPU.scala 28:26]
  reg [1:0] PHT_44; // @[BPU.scala 28:26]
  reg [1:0] PHT_45; // @[BPU.scala 28:26]
  reg [1:0] PHT_46; // @[BPU.scala 28:26]
  reg [1:0] PHT_47; // @[BPU.scala 28:26]
  reg [1:0] PHT_48; // @[BPU.scala 28:26]
  reg [1:0] PHT_49; // @[BPU.scala 28:26]
  reg [1:0] PHT_50; // @[BPU.scala 28:26]
  reg [1:0] PHT_51; // @[BPU.scala 28:26]
  reg [1:0] PHT_52; // @[BPU.scala 28:26]
  reg [1:0] PHT_53; // @[BPU.scala 28:26]
  reg [1:0] PHT_54; // @[BPU.scala 28:26]
  reg [1:0] PHT_55; // @[BPU.scala 28:26]
  reg [1:0] PHT_56; // @[BPU.scala 28:26]
  reg [1:0] PHT_57; // @[BPU.scala 28:26]
  reg [1:0] PHT_58; // @[BPU.scala 28:26]
  reg [1:0] PHT_59; // @[BPU.scala 28:26]
  reg [1:0] PHT_60; // @[BPU.scala 28:26]
  reg [1:0] PHT_61; // @[BPU.scala 28:26]
  reg [1:0] PHT_62; // @[BPU.scala 28:26]
  reg [1:0] PHT_63; // @[BPU.scala 28:26]
  wire [3:0] BHT_index = io_pcD[5:2]; // @[BPU.scala 29:25]
  wire [5:0] _GEN_1 = 4'h1 == BHT_index ? BHT_1 : BHT_0; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_2 = 4'h2 == BHT_index ? BHT_2 : _GEN_1; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_3 = 4'h3 == BHT_index ? BHT_3 : _GEN_2; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_4 = 4'h4 == BHT_index ? BHT_4 : _GEN_3; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_5 = 4'h5 == BHT_index ? BHT_5 : _GEN_4; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_6 = 4'h6 == BHT_index ? BHT_6 : _GEN_5; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_7 = 4'h7 == BHT_index ? BHT_7 : _GEN_6; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_8 = 4'h8 == BHT_index ? BHT_8 : _GEN_7; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_9 = 4'h9 == BHT_index ? BHT_9 : _GEN_8; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_10 = 4'ha == BHT_index ? BHT_10 : _GEN_9; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_11 = 4'hb == BHT_index ? BHT_11 : _GEN_10; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_12 = 4'hc == BHT_index ? BHT_12 : _GEN_11; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_13 = 4'hd == BHT_index ? BHT_13 : _GEN_12; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_14 = 4'he == BHT_index ? BHT_14 : _GEN_13; // @[BPU.scala 33:{57,57}]
  wire [5:0] _GEN_15 = 4'hf == BHT_index ? BHT_15 : _GEN_14; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_17 = 6'h1 == _GEN_15 ? PHT_1 : PHT_0; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_18 = 6'h2 == _GEN_15 ? PHT_2 : _GEN_17; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_19 = 6'h3 == _GEN_15 ? PHT_3 : _GEN_18; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_20 = 6'h4 == _GEN_15 ? PHT_4 : _GEN_19; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_21 = 6'h5 == _GEN_15 ? PHT_5 : _GEN_20; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_22 = 6'h6 == _GEN_15 ? PHT_6 : _GEN_21; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_23 = 6'h7 == _GEN_15 ? PHT_7 : _GEN_22; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_24 = 6'h8 == _GEN_15 ? PHT_8 : _GEN_23; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_25 = 6'h9 == _GEN_15 ? PHT_9 : _GEN_24; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_26 = 6'ha == _GEN_15 ? PHT_10 : _GEN_25; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_27 = 6'hb == _GEN_15 ? PHT_11 : _GEN_26; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_28 = 6'hc == _GEN_15 ? PHT_12 : _GEN_27; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_29 = 6'hd == _GEN_15 ? PHT_13 : _GEN_28; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_30 = 6'he == _GEN_15 ? PHT_14 : _GEN_29; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_31 = 6'hf == _GEN_15 ? PHT_15 : _GEN_30; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_32 = 6'h10 == _GEN_15 ? PHT_16 : _GEN_31; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_33 = 6'h11 == _GEN_15 ? PHT_17 : _GEN_32; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_34 = 6'h12 == _GEN_15 ? PHT_18 : _GEN_33; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_35 = 6'h13 == _GEN_15 ? PHT_19 : _GEN_34; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_36 = 6'h14 == _GEN_15 ? PHT_20 : _GEN_35; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_37 = 6'h15 == _GEN_15 ? PHT_21 : _GEN_36; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_38 = 6'h16 == _GEN_15 ? PHT_22 : _GEN_37; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_39 = 6'h17 == _GEN_15 ? PHT_23 : _GEN_38; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_40 = 6'h18 == _GEN_15 ? PHT_24 : _GEN_39; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_41 = 6'h19 == _GEN_15 ? PHT_25 : _GEN_40; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_42 = 6'h1a == _GEN_15 ? PHT_26 : _GEN_41; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_43 = 6'h1b == _GEN_15 ? PHT_27 : _GEN_42; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_44 = 6'h1c == _GEN_15 ? PHT_28 : _GEN_43; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_45 = 6'h1d == _GEN_15 ? PHT_29 : _GEN_44; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_46 = 6'h1e == _GEN_15 ? PHT_30 : _GEN_45; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_47 = 6'h1f == _GEN_15 ? PHT_31 : _GEN_46; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_48 = 6'h20 == _GEN_15 ? PHT_32 : _GEN_47; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_49 = 6'h21 == _GEN_15 ? PHT_33 : _GEN_48; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_50 = 6'h22 == _GEN_15 ? PHT_34 : _GEN_49; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_51 = 6'h23 == _GEN_15 ? PHT_35 : _GEN_50; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_52 = 6'h24 == _GEN_15 ? PHT_36 : _GEN_51; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_53 = 6'h25 == _GEN_15 ? PHT_37 : _GEN_52; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_54 = 6'h26 == _GEN_15 ? PHT_38 : _GEN_53; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_55 = 6'h27 == _GEN_15 ? PHT_39 : _GEN_54; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_56 = 6'h28 == _GEN_15 ? PHT_40 : _GEN_55; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_57 = 6'h29 == _GEN_15 ? PHT_41 : _GEN_56; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_58 = 6'h2a == _GEN_15 ? PHT_42 : _GEN_57; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_59 = 6'h2b == _GEN_15 ? PHT_43 : _GEN_58; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_60 = 6'h2c == _GEN_15 ? PHT_44 : _GEN_59; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_61 = 6'h2d == _GEN_15 ? PHT_45 : _GEN_60; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_62 = 6'h2e == _GEN_15 ? PHT_46 : _GEN_61; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_63 = 6'h2f == _GEN_15 ? PHT_47 : _GEN_62; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_64 = 6'h30 == _GEN_15 ? PHT_48 : _GEN_63; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_65 = 6'h31 == _GEN_15 ? PHT_49 : _GEN_64; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_66 = 6'h32 == _GEN_15 ? PHT_50 : _GEN_65; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_67 = 6'h33 == _GEN_15 ? PHT_51 : _GEN_66; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_68 = 6'h34 == _GEN_15 ? PHT_52 : _GEN_67; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_69 = 6'h35 == _GEN_15 ? PHT_53 : _GEN_68; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_70 = 6'h36 == _GEN_15 ? PHT_54 : _GEN_69; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_71 = 6'h37 == _GEN_15 ? PHT_55 : _GEN_70; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_72 = 6'h38 == _GEN_15 ? PHT_56 : _GEN_71; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_73 = 6'h39 == _GEN_15 ? PHT_57 : _GEN_72; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_74 = 6'h3a == _GEN_15 ? PHT_58 : _GEN_73; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_75 = 6'h3b == _GEN_15 ? PHT_59 : _GEN_74; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_76 = 6'h3c == _GEN_15 ? PHT_60 : _GEN_75; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_77 = 6'h3d == _GEN_15 ? PHT_61 : _GEN_76; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_78 = 6'h3e == _GEN_15 ? PHT_62 : _GEN_77; // @[BPU.scala 33:{57,57}]
  wire [1:0] _GEN_79 = 6'h3f == _GEN_15 ? PHT_63 : _GEN_78; // @[BPU.scala 33:{57,57}]
  wire [3:0] update_BHT_index = io_pcE[5:2]; // @[BPU.scala 35:32]
  wire [5:0] _GEN_81 = 4'h1 == update_BHT_index ? BHT_1 : BHT_0; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_82 = 4'h2 == update_BHT_index ? BHT_2 : _GEN_81; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_83 = 4'h3 == update_BHT_index ? BHT_3 : _GEN_82; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_84 = 4'h4 == update_BHT_index ? BHT_4 : _GEN_83; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_85 = 4'h5 == update_BHT_index ? BHT_5 : _GEN_84; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_86 = 4'h6 == update_BHT_index ? BHT_6 : _GEN_85; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_87 = 4'h7 == update_BHT_index ? BHT_7 : _GEN_86; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_88 = 4'h8 == update_BHT_index ? BHT_8 : _GEN_87; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_89 = 4'h9 == update_BHT_index ? BHT_9 : _GEN_88; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_90 = 4'ha == update_BHT_index ? BHT_10 : _GEN_89; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_91 = 4'hb == update_BHT_index ? BHT_11 : _GEN_90; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_92 = 4'hc == update_BHT_index ? BHT_12 : _GEN_91; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_93 = 4'hd == update_BHT_index ? BHT_13 : _GEN_92; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_94 = 4'he == update_BHT_index ? BHT_14 : _GEN_93; // @[BPU.scala 40:{55,55}]
  wire [5:0] _GEN_95 = 4'hf == update_BHT_index ? BHT_15 : _GEN_94; // @[BPU.scala 40:{55,55}]
  wire [5:0] _BHT_T_1 = {_GEN_95[5:1],io_actual_takeE}; // @[Cat.scala 33:92]
  wire [1:0] _GEN_113 = 6'h1 == _GEN_95 ? PHT_1 : PHT_0; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_114 = 6'h2 == _GEN_95 ? PHT_2 : _GEN_113; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_115 = 6'h3 == _GEN_95 ? PHT_3 : _GEN_114; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_116 = 6'h4 == _GEN_95 ? PHT_4 : _GEN_115; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_117 = 6'h5 == _GEN_95 ? PHT_5 : _GEN_116; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_118 = 6'h6 == _GEN_95 ? PHT_6 : _GEN_117; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_119 = 6'h7 == _GEN_95 ? PHT_7 : _GEN_118; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_120 = 6'h8 == _GEN_95 ? PHT_8 : _GEN_119; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_121 = 6'h9 == _GEN_95 ? PHT_9 : _GEN_120; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_122 = 6'ha == _GEN_95 ? PHT_10 : _GEN_121; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_123 = 6'hb == _GEN_95 ? PHT_11 : _GEN_122; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_124 = 6'hc == _GEN_95 ? PHT_12 : _GEN_123; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_125 = 6'hd == _GEN_95 ? PHT_13 : _GEN_124; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_126 = 6'he == _GEN_95 ? PHT_14 : _GEN_125; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_127 = 6'hf == _GEN_95 ? PHT_15 : _GEN_126; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_128 = 6'h10 == _GEN_95 ? PHT_16 : _GEN_127; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_129 = 6'h11 == _GEN_95 ? PHT_17 : _GEN_128; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_130 = 6'h12 == _GEN_95 ? PHT_18 : _GEN_129; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_131 = 6'h13 == _GEN_95 ? PHT_19 : _GEN_130; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_132 = 6'h14 == _GEN_95 ? PHT_20 : _GEN_131; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_133 = 6'h15 == _GEN_95 ? PHT_21 : _GEN_132; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_134 = 6'h16 == _GEN_95 ? PHT_22 : _GEN_133; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_135 = 6'h17 == _GEN_95 ? PHT_23 : _GEN_134; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_136 = 6'h18 == _GEN_95 ? PHT_24 : _GEN_135; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_137 = 6'h19 == _GEN_95 ? PHT_25 : _GEN_136; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_138 = 6'h1a == _GEN_95 ? PHT_26 : _GEN_137; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_139 = 6'h1b == _GEN_95 ? PHT_27 : _GEN_138; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_140 = 6'h1c == _GEN_95 ? PHT_28 : _GEN_139; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_141 = 6'h1d == _GEN_95 ? PHT_29 : _GEN_140; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_142 = 6'h1e == _GEN_95 ? PHT_30 : _GEN_141; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_143 = 6'h1f == _GEN_95 ? PHT_31 : _GEN_142; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_144 = 6'h20 == _GEN_95 ? PHT_32 : _GEN_143; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_145 = 6'h21 == _GEN_95 ? PHT_33 : _GEN_144; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_146 = 6'h22 == _GEN_95 ? PHT_34 : _GEN_145; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_147 = 6'h23 == _GEN_95 ? PHT_35 : _GEN_146; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_148 = 6'h24 == _GEN_95 ? PHT_36 : _GEN_147; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_149 = 6'h25 == _GEN_95 ? PHT_37 : _GEN_148; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_150 = 6'h26 == _GEN_95 ? PHT_38 : _GEN_149; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_151 = 6'h27 == _GEN_95 ? PHT_39 : _GEN_150; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_152 = 6'h28 == _GEN_95 ? PHT_40 : _GEN_151; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_153 = 6'h29 == _GEN_95 ? PHT_41 : _GEN_152; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_154 = 6'h2a == _GEN_95 ? PHT_42 : _GEN_153; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_155 = 6'h2b == _GEN_95 ? PHT_43 : _GEN_154; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_156 = 6'h2c == _GEN_95 ? PHT_44 : _GEN_155; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_157 = 6'h2d == _GEN_95 ? PHT_45 : _GEN_156; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_158 = 6'h2e == _GEN_95 ? PHT_46 : _GEN_157; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_159 = 6'h2f == _GEN_95 ? PHT_47 : _GEN_158; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_160 = 6'h30 == _GEN_95 ? PHT_48 : _GEN_159; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_161 = 6'h31 == _GEN_95 ? PHT_49 : _GEN_160; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_162 = 6'h32 == _GEN_95 ? PHT_50 : _GEN_161; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_163 = 6'h33 == _GEN_95 ? PHT_51 : _GEN_162; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_164 = 6'h34 == _GEN_95 ? PHT_52 : _GEN_163; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_165 = 6'h35 == _GEN_95 ? PHT_53 : _GEN_164; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_166 = 6'h36 == _GEN_95 ? PHT_54 : _GEN_165; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_167 = 6'h37 == _GEN_95 ? PHT_55 : _GEN_166; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_168 = 6'h38 == _GEN_95 ? PHT_56 : _GEN_167; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_169 = 6'h39 == _GEN_95 ? PHT_57 : _GEN_168; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_170 = 6'h3a == _GEN_95 ? PHT_58 : _GEN_169; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_171 = 6'h3b == _GEN_95 ? PHT_59 : _GEN_170; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_172 = 6'h3c == _GEN_95 ? PHT_60 : _GEN_171; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_173 = 6'h3d == _GEN_95 ? PHT_61 : _GEN_172; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_174 = 6'h3e == _GEN_95 ? PHT_62 : _GEN_173; // @[BPU.scala 41:{35,35}]
  wire [1:0] _GEN_175 = 6'h3f == _GEN_95 ? PHT_63 : _GEN_174; // @[BPU.scala 41:{35,35}]
  wire [1:0] _PHT_T = io_actual_takeE ? 2'h1 : 2'h0; // @[BPU.scala 42:60]
  wire [1:0] _PHT_T_1 = io_actual_takeE ? 2'h2 : 2'h0; // @[BPU.scala 43:58]
  wire [1:0] _GEN_304 = 6'h0 == _GEN_95 ? _PHT_T_1 : PHT_0; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_305 = 6'h1 == _GEN_95 ? _PHT_T_1 : PHT_1; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_306 = 6'h2 == _GEN_95 ? _PHT_T_1 : PHT_2; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_307 = 6'h3 == _GEN_95 ? _PHT_T_1 : PHT_3; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_308 = 6'h4 == _GEN_95 ? _PHT_T_1 : PHT_4; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_309 = 6'h5 == _GEN_95 ? _PHT_T_1 : PHT_5; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_310 = 6'h6 == _GEN_95 ? _PHT_T_1 : PHT_6; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_311 = 6'h7 == _GEN_95 ? _PHT_T_1 : PHT_7; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_312 = 6'h8 == _GEN_95 ? _PHT_T_1 : PHT_8; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_313 = 6'h9 == _GEN_95 ? _PHT_T_1 : PHT_9; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_314 = 6'ha == _GEN_95 ? _PHT_T_1 : PHT_10; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_315 = 6'hb == _GEN_95 ? _PHT_T_1 : PHT_11; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_316 = 6'hc == _GEN_95 ? _PHT_T_1 : PHT_12; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_317 = 6'hd == _GEN_95 ? _PHT_T_1 : PHT_13; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_318 = 6'he == _GEN_95 ? _PHT_T_1 : PHT_14; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_319 = 6'hf == _GEN_95 ? _PHT_T_1 : PHT_15; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_320 = 6'h10 == _GEN_95 ? _PHT_T_1 : PHT_16; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_321 = 6'h11 == _GEN_95 ? _PHT_T_1 : PHT_17; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_322 = 6'h12 == _GEN_95 ? _PHT_T_1 : PHT_18; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_323 = 6'h13 == _GEN_95 ? _PHT_T_1 : PHT_19; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_324 = 6'h14 == _GEN_95 ? _PHT_T_1 : PHT_20; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_325 = 6'h15 == _GEN_95 ? _PHT_T_1 : PHT_21; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_326 = 6'h16 == _GEN_95 ? _PHT_T_1 : PHT_22; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_327 = 6'h17 == _GEN_95 ? _PHT_T_1 : PHT_23; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_328 = 6'h18 == _GEN_95 ? _PHT_T_1 : PHT_24; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_329 = 6'h19 == _GEN_95 ? _PHT_T_1 : PHT_25; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_330 = 6'h1a == _GEN_95 ? _PHT_T_1 : PHT_26; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_331 = 6'h1b == _GEN_95 ? _PHT_T_1 : PHT_27; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_332 = 6'h1c == _GEN_95 ? _PHT_T_1 : PHT_28; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_333 = 6'h1d == _GEN_95 ? _PHT_T_1 : PHT_29; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_334 = 6'h1e == _GEN_95 ? _PHT_T_1 : PHT_30; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_335 = 6'h1f == _GEN_95 ? _PHT_T_1 : PHT_31; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_336 = 6'h20 == _GEN_95 ? _PHT_T_1 : PHT_32; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_337 = 6'h21 == _GEN_95 ? _PHT_T_1 : PHT_33; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_338 = 6'h22 == _GEN_95 ? _PHT_T_1 : PHT_34; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_339 = 6'h23 == _GEN_95 ? _PHT_T_1 : PHT_35; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_340 = 6'h24 == _GEN_95 ? _PHT_T_1 : PHT_36; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_341 = 6'h25 == _GEN_95 ? _PHT_T_1 : PHT_37; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_342 = 6'h26 == _GEN_95 ? _PHT_T_1 : PHT_38; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_343 = 6'h27 == _GEN_95 ? _PHT_T_1 : PHT_39; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_344 = 6'h28 == _GEN_95 ? _PHT_T_1 : PHT_40; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_345 = 6'h29 == _GEN_95 ? _PHT_T_1 : PHT_41; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_346 = 6'h2a == _GEN_95 ? _PHT_T_1 : PHT_42; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_347 = 6'h2b == _GEN_95 ? _PHT_T_1 : PHT_43; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_348 = 6'h2c == _GEN_95 ? _PHT_T_1 : PHT_44; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_349 = 6'h2d == _GEN_95 ? _PHT_T_1 : PHT_45; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_350 = 6'h2e == _GEN_95 ? _PHT_T_1 : PHT_46; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_351 = 6'h2f == _GEN_95 ? _PHT_T_1 : PHT_47; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_352 = 6'h30 == _GEN_95 ? _PHT_T_1 : PHT_48; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_353 = 6'h31 == _GEN_95 ? _PHT_T_1 : PHT_49; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_354 = 6'h32 == _GEN_95 ? _PHT_T_1 : PHT_50; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_355 = 6'h33 == _GEN_95 ? _PHT_T_1 : PHT_51; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_356 = 6'h34 == _GEN_95 ? _PHT_T_1 : PHT_52; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_357 = 6'h35 == _GEN_95 ? _PHT_T_1 : PHT_53; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_358 = 6'h36 == _GEN_95 ? _PHT_T_1 : PHT_54; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_359 = 6'h37 == _GEN_95 ? _PHT_T_1 : PHT_55; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_360 = 6'h38 == _GEN_95 ? _PHT_T_1 : PHT_56; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_361 = 6'h39 == _GEN_95 ? _PHT_T_1 : PHT_57; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_362 = 6'h3a == _GEN_95 ? _PHT_T_1 : PHT_58; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_363 = 6'h3b == _GEN_95 ? _PHT_T_1 : PHT_59; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_364 = 6'h3c == _GEN_95 ? _PHT_T_1 : PHT_60; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_365 = 6'h3d == _GEN_95 ? _PHT_T_1 : PHT_61; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_366 = 6'h3e == _GEN_95 ? _PHT_T_1 : PHT_62; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _GEN_367 = 6'h3f == _GEN_95 ? _PHT_T_1 : PHT_63; // @[BPU.scala 28:26 43:{52,52}]
  wire [1:0] _PHT_T_2 = io_actual_takeE ? 2'h3 : 2'h1; // @[BPU.scala 44:54]
  wire [1:0] _GEN_432 = 6'h0 == _GEN_95 ? _PHT_T_2 : PHT_0; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_433 = 6'h1 == _GEN_95 ? _PHT_T_2 : PHT_1; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_434 = 6'h2 == _GEN_95 ? _PHT_T_2 : PHT_2; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_435 = 6'h3 == _GEN_95 ? _PHT_T_2 : PHT_3; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_436 = 6'h4 == _GEN_95 ? _PHT_T_2 : PHT_4; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_437 = 6'h5 == _GEN_95 ? _PHT_T_2 : PHT_5; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_438 = 6'h6 == _GEN_95 ? _PHT_T_2 : PHT_6; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_439 = 6'h7 == _GEN_95 ? _PHT_T_2 : PHT_7; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_440 = 6'h8 == _GEN_95 ? _PHT_T_2 : PHT_8; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_441 = 6'h9 == _GEN_95 ? _PHT_T_2 : PHT_9; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_442 = 6'ha == _GEN_95 ? _PHT_T_2 : PHT_10; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_443 = 6'hb == _GEN_95 ? _PHT_T_2 : PHT_11; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_444 = 6'hc == _GEN_95 ? _PHT_T_2 : PHT_12; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_445 = 6'hd == _GEN_95 ? _PHT_T_2 : PHT_13; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_446 = 6'he == _GEN_95 ? _PHT_T_2 : PHT_14; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_447 = 6'hf == _GEN_95 ? _PHT_T_2 : PHT_15; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_448 = 6'h10 == _GEN_95 ? _PHT_T_2 : PHT_16; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_449 = 6'h11 == _GEN_95 ? _PHT_T_2 : PHT_17; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_450 = 6'h12 == _GEN_95 ? _PHT_T_2 : PHT_18; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_451 = 6'h13 == _GEN_95 ? _PHT_T_2 : PHT_19; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_452 = 6'h14 == _GEN_95 ? _PHT_T_2 : PHT_20; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_453 = 6'h15 == _GEN_95 ? _PHT_T_2 : PHT_21; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_454 = 6'h16 == _GEN_95 ? _PHT_T_2 : PHT_22; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_455 = 6'h17 == _GEN_95 ? _PHT_T_2 : PHT_23; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_456 = 6'h18 == _GEN_95 ? _PHT_T_2 : PHT_24; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_457 = 6'h19 == _GEN_95 ? _PHT_T_2 : PHT_25; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_458 = 6'h1a == _GEN_95 ? _PHT_T_2 : PHT_26; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_459 = 6'h1b == _GEN_95 ? _PHT_T_2 : PHT_27; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_460 = 6'h1c == _GEN_95 ? _PHT_T_2 : PHT_28; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_461 = 6'h1d == _GEN_95 ? _PHT_T_2 : PHT_29; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_462 = 6'h1e == _GEN_95 ? _PHT_T_2 : PHT_30; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_463 = 6'h1f == _GEN_95 ? _PHT_T_2 : PHT_31; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_464 = 6'h20 == _GEN_95 ? _PHT_T_2 : PHT_32; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_465 = 6'h21 == _GEN_95 ? _PHT_T_2 : PHT_33; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_466 = 6'h22 == _GEN_95 ? _PHT_T_2 : PHT_34; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_467 = 6'h23 == _GEN_95 ? _PHT_T_2 : PHT_35; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_468 = 6'h24 == _GEN_95 ? _PHT_T_2 : PHT_36; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_469 = 6'h25 == _GEN_95 ? _PHT_T_2 : PHT_37; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_470 = 6'h26 == _GEN_95 ? _PHT_T_2 : PHT_38; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_471 = 6'h27 == _GEN_95 ? _PHT_T_2 : PHT_39; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_472 = 6'h28 == _GEN_95 ? _PHT_T_2 : PHT_40; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_473 = 6'h29 == _GEN_95 ? _PHT_T_2 : PHT_41; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_474 = 6'h2a == _GEN_95 ? _PHT_T_2 : PHT_42; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_475 = 6'h2b == _GEN_95 ? _PHT_T_2 : PHT_43; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_476 = 6'h2c == _GEN_95 ? _PHT_T_2 : PHT_44; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_477 = 6'h2d == _GEN_95 ? _PHT_T_2 : PHT_45; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_478 = 6'h2e == _GEN_95 ? _PHT_T_2 : PHT_46; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_479 = 6'h2f == _GEN_95 ? _PHT_T_2 : PHT_47; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_480 = 6'h30 == _GEN_95 ? _PHT_T_2 : PHT_48; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_481 = 6'h31 == _GEN_95 ? _PHT_T_2 : PHT_49; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_482 = 6'h32 == _GEN_95 ? _PHT_T_2 : PHT_50; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_483 = 6'h33 == _GEN_95 ? _PHT_T_2 : PHT_51; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_484 = 6'h34 == _GEN_95 ? _PHT_T_2 : PHT_52; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_485 = 6'h35 == _GEN_95 ? _PHT_T_2 : PHT_53; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_486 = 6'h36 == _GEN_95 ? _PHT_T_2 : PHT_54; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_487 = 6'h37 == _GEN_95 ? _PHT_T_2 : PHT_55; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_488 = 6'h38 == _GEN_95 ? _PHT_T_2 : PHT_56; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_489 = 6'h39 == _GEN_95 ? _PHT_T_2 : PHT_57; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_490 = 6'h3a == _GEN_95 ? _PHT_T_2 : PHT_58; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_491 = 6'h3b == _GEN_95 ? _PHT_T_2 : PHT_59; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_492 = 6'h3c == _GEN_95 ? _PHT_T_2 : PHT_60; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_493 = 6'h3d == _GEN_95 ? _PHT_T_2 : PHT_61; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_494 = 6'h3e == _GEN_95 ? _PHT_T_2 : PHT_62; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _GEN_495 = 6'h3f == _GEN_95 ? _PHT_T_2 : PHT_63; // @[BPU.scala 28:26 44:{48,48}]
  wire [1:0] _PHT_T_3 = io_actual_takeE ? 2'h3 : 2'h2; // @[BPU.scala 45:56]
  wire [1:0] _GEN_560 = 6'h0 == _GEN_95 ? _PHT_T_3 : PHT_0; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_561 = 6'h1 == _GEN_95 ? _PHT_T_3 : PHT_1; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_562 = 6'h2 == _GEN_95 ? _PHT_T_3 : PHT_2; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_563 = 6'h3 == _GEN_95 ? _PHT_T_3 : PHT_3; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_564 = 6'h4 == _GEN_95 ? _PHT_T_3 : PHT_4; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_565 = 6'h5 == _GEN_95 ? _PHT_T_3 : PHT_5; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_566 = 6'h6 == _GEN_95 ? _PHT_T_3 : PHT_6; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_567 = 6'h7 == _GEN_95 ? _PHT_T_3 : PHT_7; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_568 = 6'h8 == _GEN_95 ? _PHT_T_3 : PHT_8; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_569 = 6'h9 == _GEN_95 ? _PHT_T_3 : PHT_9; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_570 = 6'ha == _GEN_95 ? _PHT_T_3 : PHT_10; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_571 = 6'hb == _GEN_95 ? _PHT_T_3 : PHT_11; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_572 = 6'hc == _GEN_95 ? _PHT_T_3 : PHT_12; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_573 = 6'hd == _GEN_95 ? _PHT_T_3 : PHT_13; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_574 = 6'he == _GEN_95 ? _PHT_T_3 : PHT_14; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_575 = 6'hf == _GEN_95 ? _PHT_T_3 : PHT_15; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_576 = 6'h10 == _GEN_95 ? _PHT_T_3 : PHT_16; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_577 = 6'h11 == _GEN_95 ? _PHT_T_3 : PHT_17; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_578 = 6'h12 == _GEN_95 ? _PHT_T_3 : PHT_18; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_579 = 6'h13 == _GEN_95 ? _PHT_T_3 : PHT_19; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_580 = 6'h14 == _GEN_95 ? _PHT_T_3 : PHT_20; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_581 = 6'h15 == _GEN_95 ? _PHT_T_3 : PHT_21; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_582 = 6'h16 == _GEN_95 ? _PHT_T_3 : PHT_22; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_583 = 6'h17 == _GEN_95 ? _PHT_T_3 : PHT_23; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_584 = 6'h18 == _GEN_95 ? _PHT_T_3 : PHT_24; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_585 = 6'h19 == _GEN_95 ? _PHT_T_3 : PHT_25; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_586 = 6'h1a == _GEN_95 ? _PHT_T_3 : PHT_26; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_587 = 6'h1b == _GEN_95 ? _PHT_T_3 : PHT_27; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_588 = 6'h1c == _GEN_95 ? _PHT_T_3 : PHT_28; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_589 = 6'h1d == _GEN_95 ? _PHT_T_3 : PHT_29; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_590 = 6'h1e == _GEN_95 ? _PHT_T_3 : PHT_30; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_591 = 6'h1f == _GEN_95 ? _PHT_T_3 : PHT_31; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_592 = 6'h20 == _GEN_95 ? _PHT_T_3 : PHT_32; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_593 = 6'h21 == _GEN_95 ? _PHT_T_3 : PHT_33; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_594 = 6'h22 == _GEN_95 ? _PHT_T_3 : PHT_34; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_595 = 6'h23 == _GEN_95 ? _PHT_T_3 : PHT_35; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_596 = 6'h24 == _GEN_95 ? _PHT_T_3 : PHT_36; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_597 = 6'h25 == _GEN_95 ? _PHT_T_3 : PHT_37; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_598 = 6'h26 == _GEN_95 ? _PHT_T_3 : PHT_38; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_599 = 6'h27 == _GEN_95 ? _PHT_T_3 : PHT_39; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_600 = 6'h28 == _GEN_95 ? _PHT_T_3 : PHT_40; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_601 = 6'h29 == _GEN_95 ? _PHT_T_3 : PHT_41; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_602 = 6'h2a == _GEN_95 ? _PHT_T_3 : PHT_42; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_603 = 6'h2b == _GEN_95 ? _PHT_T_3 : PHT_43; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_604 = 6'h2c == _GEN_95 ? _PHT_T_3 : PHT_44; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_605 = 6'h2d == _GEN_95 ? _PHT_T_3 : PHT_45; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_606 = 6'h2e == _GEN_95 ? _PHT_T_3 : PHT_46; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_607 = 6'h2f == _GEN_95 ? _PHT_T_3 : PHT_47; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_608 = 6'h30 == _GEN_95 ? _PHT_T_3 : PHT_48; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_609 = 6'h31 == _GEN_95 ? _PHT_T_3 : PHT_49; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_610 = 6'h32 == _GEN_95 ? _PHT_T_3 : PHT_50; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_611 = 6'h33 == _GEN_95 ? _PHT_T_3 : PHT_51; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_612 = 6'h34 == _GEN_95 ? _PHT_T_3 : PHT_52; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_613 = 6'h35 == _GEN_95 ? _PHT_T_3 : PHT_53; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_614 = 6'h36 == _GEN_95 ? _PHT_T_3 : PHT_54; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_615 = 6'h37 == _GEN_95 ? _PHT_T_3 : PHT_55; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_616 = 6'h38 == _GEN_95 ? _PHT_T_3 : PHT_56; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_617 = 6'h39 == _GEN_95 ? _PHT_T_3 : PHT_57; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_618 = 6'h3a == _GEN_95 ? _PHT_T_3 : PHT_58; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_619 = 6'h3b == _GEN_95 ? _PHT_T_3 : PHT_59; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_620 = 6'h3c == _GEN_95 ? _PHT_T_3 : PHT_60; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_621 = 6'h3d == _GEN_95 ? _PHT_T_3 : PHT_61; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_622 = 6'h3e == _GEN_95 ? _PHT_T_3 : PHT_62; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_623 = 6'h3f == _GEN_95 ? _PHT_T_3 : PHT_63; // @[BPU.scala 28:26 45:{50,50}]
  wire [1:0] _GEN_624 = 2'h3 == _GEN_175 ? _GEN_560 : PHT_0; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_625 = 2'h3 == _GEN_175 ? _GEN_561 : PHT_1; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_626 = 2'h3 == _GEN_175 ? _GEN_562 : PHT_2; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_627 = 2'h3 == _GEN_175 ? _GEN_563 : PHT_3; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_628 = 2'h3 == _GEN_175 ? _GEN_564 : PHT_4; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_629 = 2'h3 == _GEN_175 ? _GEN_565 : PHT_5; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_630 = 2'h3 == _GEN_175 ? _GEN_566 : PHT_6; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_631 = 2'h3 == _GEN_175 ? _GEN_567 : PHT_7; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_632 = 2'h3 == _GEN_175 ? _GEN_568 : PHT_8; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_633 = 2'h3 == _GEN_175 ? _GEN_569 : PHT_9; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_634 = 2'h3 == _GEN_175 ? _GEN_570 : PHT_10; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_635 = 2'h3 == _GEN_175 ? _GEN_571 : PHT_11; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_636 = 2'h3 == _GEN_175 ? _GEN_572 : PHT_12; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_637 = 2'h3 == _GEN_175 ? _GEN_573 : PHT_13; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_638 = 2'h3 == _GEN_175 ? _GEN_574 : PHT_14; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_639 = 2'h3 == _GEN_175 ? _GEN_575 : PHT_15; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_640 = 2'h3 == _GEN_175 ? _GEN_576 : PHT_16; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_641 = 2'h3 == _GEN_175 ? _GEN_577 : PHT_17; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_642 = 2'h3 == _GEN_175 ? _GEN_578 : PHT_18; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_643 = 2'h3 == _GEN_175 ? _GEN_579 : PHT_19; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_644 = 2'h3 == _GEN_175 ? _GEN_580 : PHT_20; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_645 = 2'h3 == _GEN_175 ? _GEN_581 : PHT_21; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_646 = 2'h3 == _GEN_175 ? _GEN_582 : PHT_22; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_647 = 2'h3 == _GEN_175 ? _GEN_583 : PHT_23; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_648 = 2'h3 == _GEN_175 ? _GEN_584 : PHT_24; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_649 = 2'h3 == _GEN_175 ? _GEN_585 : PHT_25; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_650 = 2'h3 == _GEN_175 ? _GEN_586 : PHT_26; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_651 = 2'h3 == _GEN_175 ? _GEN_587 : PHT_27; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_652 = 2'h3 == _GEN_175 ? _GEN_588 : PHT_28; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_653 = 2'h3 == _GEN_175 ? _GEN_589 : PHT_29; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_654 = 2'h3 == _GEN_175 ? _GEN_590 : PHT_30; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_655 = 2'h3 == _GEN_175 ? _GEN_591 : PHT_31; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_656 = 2'h3 == _GEN_175 ? _GEN_592 : PHT_32; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_657 = 2'h3 == _GEN_175 ? _GEN_593 : PHT_33; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_658 = 2'h3 == _GEN_175 ? _GEN_594 : PHT_34; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_659 = 2'h3 == _GEN_175 ? _GEN_595 : PHT_35; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_660 = 2'h3 == _GEN_175 ? _GEN_596 : PHT_36; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_661 = 2'h3 == _GEN_175 ? _GEN_597 : PHT_37; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_662 = 2'h3 == _GEN_175 ? _GEN_598 : PHT_38; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_663 = 2'h3 == _GEN_175 ? _GEN_599 : PHT_39; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_664 = 2'h3 == _GEN_175 ? _GEN_600 : PHT_40; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_665 = 2'h3 == _GEN_175 ? _GEN_601 : PHT_41; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_666 = 2'h3 == _GEN_175 ? _GEN_602 : PHT_42; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_667 = 2'h3 == _GEN_175 ? _GEN_603 : PHT_43; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_668 = 2'h3 == _GEN_175 ? _GEN_604 : PHT_44; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_669 = 2'h3 == _GEN_175 ? _GEN_605 : PHT_45; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_670 = 2'h3 == _GEN_175 ? _GEN_606 : PHT_46; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_671 = 2'h3 == _GEN_175 ? _GEN_607 : PHT_47; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_672 = 2'h3 == _GEN_175 ? _GEN_608 : PHT_48; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_673 = 2'h3 == _GEN_175 ? _GEN_609 : PHT_49; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_674 = 2'h3 == _GEN_175 ? _GEN_610 : PHT_50; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_675 = 2'h3 == _GEN_175 ? _GEN_611 : PHT_51; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_676 = 2'h3 == _GEN_175 ? _GEN_612 : PHT_52; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_677 = 2'h3 == _GEN_175 ? _GEN_613 : PHT_53; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_678 = 2'h3 == _GEN_175 ? _GEN_614 : PHT_54; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_679 = 2'h3 == _GEN_175 ? _GEN_615 : PHT_55; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_680 = 2'h3 == _GEN_175 ? _GEN_616 : PHT_56; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_681 = 2'h3 == _GEN_175 ? _GEN_617 : PHT_57; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_682 = 2'h3 == _GEN_175 ? _GEN_618 : PHT_58; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_683 = 2'h3 == _GEN_175 ? _GEN_619 : PHT_59; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_684 = 2'h3 == _GEN_175 ? _GEN_620 : PHT_60; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_685 = 2'h3 == _GEN_175 ? _GEN_621 : PHT_61; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_686 = 2'h3 == _GEN_175 ? _GEN_622 : PHT_62; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_687 = 2'h3 == _GEN_175 ? _GEN_623 : PHT_63; // @[BPU.scala 28:26 41:35]
  wire [1:0] _GEN_688 = 2'h2 == _GEN_175 ? _GEN_432 : _GEN_624; // @[BPU.scala 41:35]
  wire [1:0] _GEN_689 = 2'h2 == _GEN_175 ? _GEN_433 : _GEN_625; // @[BPU.scala 41:35]
  wire [1:0] _GEN_690 = 2'h2 == _GEN_175 ? _GEN_434 : _GEN_626; // @[BPU.scala 41:35]
  wire [1:0] _GEN_691 = 2'h2 == _GEN_175 ? _GEN_435 : _GEN_627; // @[BPU.scala 41:35]
  wire [1:0] _GEN_692 = 2'h2 == _GEN_175 ? _GEN_436 : _GEN_628; // @[BPU.scala 41:35]
  wire [1:0] _GEN_693 = 2'h2 == _GEN_175 ? _GEN_437 : _GEN_629; // @[BPU.scala 41:35]
  wire [1:0] _GEN_694 = 2'h2 == _GEN_175 ? _GEN_438 : _GEN_630; // @[BPU.scala 41:35]
  wire [1:0] _GEN_695 = 2'h2 == _GEN_175 ? _GEN_439 : _GEN_631; // @[BPU.scala 41:35]
  wire [1:0] _GEN_696 = 2'h2 == _GEN_175 ? _GEN_440 : _GEN_632; // @[BPU.scala 41:35]
  wire [1:0] _GEN_697 = 2'h2 == _GEN_175 ? _GEN_441 : _GEN_633; // @[BPU.scala 41:35]
  wire [1:0] _GEN_698 = 2'h2 == _GEN_175 ? _GEN_442 : _GEN_634; // @[BPU.scala 41:35]
  wire [1:0] _GEN_699 = 2'h2 == _GEN_175 ? _GEN_443 : _GEN_635; // @[BPU.scala 41:35]
  wire [1:0] _GEN_700 = 2'h2 == _GEN_175 ? _GEN_444 : _GEN_636; // @[BPU.scala 41:35]
  wire [1:0] _GEN_701 = 2'h2 == _GEN_175 ? _GEN_445 : _GEN_637; // @[BPU.scala 41:35]
  wire [1:0] _GEN_702 = 2'h2 == _GEN_175 ? _GEN_446 : _GEN_638; // @[BPU.scala 41:35]
  wire [1:0] _GEN_703 = 2'h2 == _GEN_175 ? _GEN_447 : _GEN_639; // @[BPU.scala 41:35]
  wire [1:0] _GEN_704 = 2'h2 == _GEN_175 ? _GEN_448 : _GEN_640; // @[BPU.scala 41:35]
  wire [1:0] _GEN_705 = 2'h2 == _GEN_175 ? _GEN_449 : _GEN_641; // @[BPU.scala 41:35]
  wire [1:0] _GEN_706 = 2'h2 == _GEN_175 ? _GEN_450 : _GEN_642; // @[BPU.scala 41:35]
  wire [1:0] _GEN_707 = 2'h2 == _GEN_175 ? _GEN_451 : _GEN_643; // @[BPU.scala 41:35]
  wire [1:0] _GEN_708 = 2'h2 == _GEN_175 ? _GEN_452 : _GEN_644; // @[BPU.scala 41:35]
  wire [1:0] _GEN_709 = 2'h2 == _GEN_175 ? _GEN_453 : _GEN_645; // @[BPU.scala 41:35]
  wire [1:0] _GEN_710 = 2'h2 == _GEN_175 ? _GEN_454 : _GEN_646; // @[BPU.scala 41:35]
  wire [1:0] _GEN_711 = 2'h2 == _GEN_175 ? _GEN_455 : _GEN_647; // @[BPU.scala 41:35]
  wire [1:0] _GEN_712 = 2'h2 == _GEN_175 ? _GEN_456 : _GEN_648; // @[BPU.scala 41:35]
  wire [1:0] _GEN_713 = 2'h2 == _GEN_175 ? _GEN_457 : _GEN_649; // @[BPU.scala 41:35]
  wire [1:0] _GEN_714 = 2'h2 == _GEN_175 ? _GEN_458 : _GEN_650; // @[BPU.scala 41:35]
  wire [1:0] _GEN_715 = 2'h2 == _GEN_175 ? _GEN_459 : _GEN_651; // @[BPU.scala 41:35]
  wire [1:0] _GEN_716 = 2'h2 == _GEN_175 ? _GEN_460 : _GEN_652; // @[BPU.scala 41:35]
  wire [1:0] _GEN_717 = 2'h2 == _GEN_175 ? _GEN_461 : _GEN_653; // @[BPU.scala 41:35]
  wire [1:0] _GEN_718 = 2'h2 == _GEN_175 ? _GEN_462 : _GEN_654; // @[BPU.scala 41:35]
  wire [1:0] _GEN_719 = 2'h2 == _GEN_175 ? _GEN_463 : _GEN_655; // @[BPU.scala 41:35]
  wire [1:0] _GEN_720 = 2'h2 == _GEN_175 ? _GEN_464 : _GEN_656; // @[BPU.scala 41:35]
  wire [1:0] _GEN_721 = 2'h2 == _GEN_175 ? _GEN_465 : _GEN_657; // @[BPU.scala 41:35]
  wire [1:0] _GEN_722 = 2'h2 == _GEN_175 ? _GEN_466 : _GEN_658; // @[BPU.scala 41:35]
  wire [1:0] _GEN_723 = 2'h2 == _GEN_175 ? _GEN_467 : _GEN_659; // @[BPU.scala 41:35]
  wire [1:0] _GEN_724 = 2'h2 == _GEN_175 ? _GEN_468 : _GEN_660; // @[BPU.scala 41:35]
  wire [1:0] _GEN_725 = 2'h2 == _GEN_175 ? _GEN_469 : _GEN_661; // @[BPU.scala 41:35]
  wire [1:0] _GEN_726 = 2'h2 == _GEN_175 ? _GEN_470 : _GEN_662; // @[BPU.scala 41:35]
  wire [1:0] _GEN_727 = 2'h2 == _GEN_175 ? _GEN_471 : _GEN_663; // @[BPU.scala 41:35]
  wire [1:0] _GEN_728 = 2'h2 == _GEN_175 ? _GEN_472 : _GEN_664; // @[BPU.scala 41:35]
  wire [1:0] _GEN_729 = 2'h2 == _GEN_175 ? _GEN_473 : _GEN_665; // @[BPU.scala 41:35]
  wire [1:0] _GEN_730 = 2'h2 == _GEN_175 ? _GEN_474 : _GEN_666; // @[BPU.scala 41:35]
  wire [1:0] _GEN_731 = 2'h2 == _GEN_175 ? _GEN_475 : _GEN_667; // @[BPU.scala 41:35]
  wire [1:0] _GEN_732 = 2'h2 == _GEN_175 ? _GEN_476 : _GEN_668; // @[BPU.scala 41:35]
  wire [1:0] _GEN_733 = 2'h2 == _GEN_175 ? _GEN_477 : _GEN_669; // @[BPU.scala 41:35]
  wire [1:0] _GEN_734 = 2'h2 == _GEN_175 ? _GEN_478 : _GEN_670; // @[BPU.scala 41:35]
  wire [1:0] _GEN_735 = 2'h2 == _GEN_175 ? _GEN_479 : _GEN_671; // @[BPU.scala 41:35]
  wire [1:0] _GEN_736 = 2'h2 == _GEN_175 ? _GEN_480 : _GEN_672; // @[BPU.scala 41:35]
  wire [1:0] _GEN_737 = 2'h2 == _GEN_175 ? _GEN_481 : _GEN_673; // @[BPU.scala 41:35]
  wire [1:0] _GEN_738 = 2'h2 == _GEN_175 ? _GEN_482 : _GEN_674; // @[BPU.scala 41:35]
  wire [1:0] _GEN_739 = 2'h2 == _GEN_175 ? _GEN_483 : _GEN_675; // @[BPU.scala 41:35]
  wire [1:0] _GEN_740 = 2'h2 == _GEN_175 ? _GEN_484 : _GEN_676; // @[BPU.scala 41:35]
  wire [1:0] _GEN_741 = 2'h2 == _GEN_175 ? _GEN_485 : _GEN_677; // @[BPU.scala 41:35]
  wire [1:0] _GEN_742 = 2'h2 == _GEN_175 ? _GEN_486 : _GEN_678; // @[BPU.scala 41:35]
  wire [1:0] _GEN_743 = 2'h2 == _GEN_175 ? _GEN_487 : _GEN_679; // @[BPU.scala 41:35]
  wire [1:0] _GEN_744 = 2'h2 == _GEN_175 ? _GEN_488 : _GEN_680; // @[BPU.scala 41:35]
  wire [1:0] _GEN_745 = 2'h2 == _GEN_175 ? _GEN_489 : _GEN_681; // @[BPU.scala 41:35]
  wire [1:0] _GEN_746 = 2'h2 == _GEN_175 ? _GEN_490 : _GEN_682; // @[BPU.scala 41:35]
  wire [1:0] _GEN_747 = 2'h2 == _GEN_175 ? _GEN_491 : _GEN_683; // @[BPU.scala 41:35]
  wire [1:0] _GEN_748 = 2'h2 == _GEN_175 ? _GEN_492 : _GEN_684; // @[BPU.scala 41:35]
  wire [1:0] _GEN_749 = 2'h2 == _GEN_175 ? _GEN_493 : _GEN_685; // @[BPU.scala 41:35]
  wire [1:0] _GEN_750 = 2'h2 == _GEN_175 ? _GEN_494 : _GEN_686; // @[BPU.scala 41:35]
  wire [1:0] _GEN_751 = 2'h2 == _GEN_175 ? _GEN_495 : _GEN_687; // @[BPU.scala 41:35]
  assign io_branchD = io_instrD[31:26] == 6'h1 & io_instrD[19:17] == 3'h0 | io_instrD[31:28] == 4'h1; // @[BPU.scala 22:72]
  assign io_pred_takeD = io_enaD & io_branchD & _GEN_79[1]; // @[BPU.scala 33:41]
  assign io_branch_targetD = io_pc_plus4D + _io_branch_targetD_T_4; // @[BPU.scala 23:37]
  always @(posedge clock) begin
    if (reset) begin // @[BPU.scala 27:26]
      BHT_0 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'h0 == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_0 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_1 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'h1 == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_1 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_2 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'h2 == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_2 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_3 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'h3 == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_3 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_4 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'h4 == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_4 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_5 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'h5 == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_5 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_6 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'h6 == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_6 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_7 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'h7 == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_7 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_8 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'h8 == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_8 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_9 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'h9 == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_9 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_10 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'ha == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_10 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_11 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'hb == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_11 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_12 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'hc == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_12 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_13 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'hd == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_13 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_14 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'he == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_14 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 27:26]
      BHT_15 <= 6'h0; // @[BPU.scala 27:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (4'hf == update_BHT_index) begin // @[BPU.scala 40:27]
        BHT_15 <= _BHT_T_1; // @[BPU.scala 40:27]
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_0 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h0 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_0 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_0 <= _GEN_304;
      end else begin
        PHT_0 <= _GEN_688;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_1 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h1 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_1 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_1 <= _GEN_305;
      end else begin
        PHT_1 <= _GEN_689;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_2 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h2 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_2 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_2 <= _GEN_306;
      end else begin
        PHT_2 <= _GEN_690;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_3 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h3 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_3 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_3 <= _GEN_307;
      end else begin
        PHT_3 <= _GEN_691;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_4 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h4 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_4 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_4 <= _GEN_308;
      end else begin
        PHT_4 <= _GEN_692;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_5 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h5 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_5 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_5 <= _GEN_309;
      end else begin
        PHT_5 <= _GEN_693;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_6 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h6 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_6 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_6 <= _GEN_310;
      end else begin
        PHT_6 <= _GEN_694;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_7 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h7 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_7 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_7 <= _GEN_311;
      end else begin
        PHT_7 <= _GEN_695;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_8 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h8 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_8 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_8 <= _GEN_312;
      end else begin
        PHT_8 <= _GEN_696;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_9 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h9 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_9 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_9 <= _GEN_313;
      end else begin
        PHT_9 <= _GEN_697;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_10 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'ha == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_10 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_10 <= _GEN_314;
      end else begin
        PHT_10 <= _GEN_698;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_11 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'hb == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_11 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_11 <= _GEN_315;
      end else begin
        PHT_11 <= _GEN_699;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_12 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'hc == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_12 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_12 <= _GEN_316;
      end else begin
        PHT_12 <= _GEN_700;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_13 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'hd == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_13 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_13 <= _GEN_317;
      end else begin
        PHT_13 <= _GEN_701;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_14 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'he == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_14 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_14 <= _GEN_318;
      end else begin
        PHT_14 <= _GEN_702;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_15 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'hf == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_15 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_15 <= _GEN_319;
      end else begin
        PHT_15 <= _GEN_703;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_16 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h10 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_16 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_16 <= _GEN_320;
      end else begin
        PHT_16 <= _GEN_704;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_17 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h11 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_17 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_17 <= _GEN_321;
      end else begin
        PHT_17 <= _GEN_705;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_18 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h12 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_18 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_18 <= _GEN_322;
      end else begin
        PHT_18 <= _GEN_706;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_19 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h13 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_19 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_19 <= _GEN_323;
      end else begin
        PHT_19 <= _GEN_707;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_20 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h14 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_20 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_20 <= _GEN_324;
      end else begin
        PHT_20 <= _GEN_708;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_21 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h15 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_21 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_21 <= _GEN_325;
      end else begin
        PHT_21 <= _GEN_709;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_22 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h16 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_22 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_22 <= _GEN_326;
      end else begin
        PHT_22 <= _GEN_710;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_23 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h17 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_23 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_23 <= _GEN_327;
      end else begin
        PHT_23 <= _GEN_711;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_24 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h18 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_24 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_24 <= _GEN_328;
      end else begin
        PHT_24 <= _GEN_712;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_25 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h19 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_25 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_25 <= _GEN_329;
      end else begin
        PHT_25 <= _GEN_713;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_26 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h1a == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_26 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_26 <= _GEN_330;
      end else begin
        PHT_26 <= _GEN_714;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_27 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h1b == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_27 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_27 <= _GEN_331;
      end else begin
        PHT_27 <= _GEN_715;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_28 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h1c == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_28 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_28 <= _GEN_332;
      end else begin
        PHT_28 <= _GEN_716;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_29 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h1d == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_29 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_29 <= _GEN_333;
      end else begin
        PHT_29 <= _GEN_717;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_30 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h1e == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_30 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_30 <= _GEN_334;
      end else begin
        PHT_30 <= _GEN_718;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_31 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h1f == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_31 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_31 <= _GEN_335;
      end else begin
        PHT_31 <= _GEN_719;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_32 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h20 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_32 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_32 <= _GEN_336;
      end else begin
        PHT_32 <= _GEN_720;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_33 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h21 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_33 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_33 <= _GEN_337;
      end else begin
        PHT_33 <= _GEN_721;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_34 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h22 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_34 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_34 <= _GEN_338;
      end else begin
        PHT_34 <= _GEN_722;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_35 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h23 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_35 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_35 <= _GEN_339;
      end else begin
        PHT_35 <= _GEN_723;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_36 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h24 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_36 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_36 <= _GEN_340;
      end else begin
        PHT_36 <= _GEN_724;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_37 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h25 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_37 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_37 <= _GEN_341;
      end else begin
        PHT_37 <= _GEN_725;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_38 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h26 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_38 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_38 <= _GEN_342;
      end else begin
        PHT_38 <= _GEN_726;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_39 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h27 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_39 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_39 <= _GEN_343;
      end else begin
        PHT_39 <= _GEN_727;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_40 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h28 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_40 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_40 <= _GEN_344;
      end else begin
        PHT_40 <= _GEN_728;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_41 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h29 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_41 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_41 <= _GEN_345;
      end else begin
        PHT_41 <= _GEN_729;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_42 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h2a == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_42 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_42 <= _GEN_346;
      end else begin
        PHT_42 <= _GEN_730;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_43 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h2b == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_43 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_43 <= _GEN_347;
      end else begin
        PHT_43 <= _GEN_731;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_44 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h2c == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_44 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_44 <= _GEN_348;
      end else begin
        PHT_44 <= _GEN_732;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_45 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h2d == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_45 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_45 <= _GEN_349;
      end else begin
        PHT_45 <= _GEN_733;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_46 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h2e == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_46 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_46 <= _GEN_350;
      end else begin
        PHT_46 <= _GEN_734;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_47 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h2f == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_47 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_47 <= _GEN_351;
      end else begin
        PHT_47 <= _GEN_735;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_48 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h30 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_48 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_48 <= _GEN_352;
      end else begin
        PHT_48 <= _GEN_736;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_49 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h31 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_49 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_49 <= _GEN_353;
      end else begin
        PHT_49 <= _GEN_737;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_50 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h32 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_50 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_50 <= _GEN_354;
      end else begin
        PHT_50 <= _GEN_738;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_51 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h33 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_51 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_51 <= _GEN_355;
      end else begin
        PHT_51 <= _GEN_739;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_52 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h34 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_52 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_52 <= _GEN_356;
      end else begin
        PHT_52 <= _GEN_740;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_53 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h35 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_53 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_53 <= _GEN_357;
      end else begin
        PHT_53 <= _GEN_741;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_54 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h36 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_54 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_54 <= _GEN_358;
      end else begin
        PHT_54 <= _GEN_742;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_55 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h37 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_55 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_55 <= _GEN_359;
      end else begin
        PHT_55 <= _GEN_743;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_56 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h38 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_56 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_56 <= _GEN_360;
      end else begin
        PHT_56 <= _GEN_744;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_57 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h39 == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_57 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_57 <= _GEN_361;
      end else begin
        PHT_57 <= _GEN_745;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_58 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h3a == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_58 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_58 <= _GEN_362;
      end else begin
        PHT_58 <= _GEN_746;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_59 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h3b == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_59 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_59 <= _GEN_363;
      end else begin
        PHT_59 <= _GEN_747;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_60 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h3c == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_60 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_60 <= _GEN_364;
      end else begin
        PHT_60 <= _GEN_748;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_61 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h3d == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_61 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_61 <= _GEN_365;
      end else begin
        PHT_61 <= _GEN_749;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_62 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h3e == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_62 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_62 <= _GEN_366;
      end else begin
        PHT_62 <= _GEN_750;
      end
    end
    if (reset) begin // @[BPU.scala 28:26]
      PHT_63 <= 2'h2; // @[BPU.scala 28:26]
    end else if (io_branchE) begin // @[BPU.scala 39:20]
      if (2'h0 == _GEN_175) begin // @[BPU.scala 41:35]
        if (6'h3f == _GEN_95) begin // @[BPU.scala 42:54]
          PHT_63 <= _PHT_T; // @[BPU.scala 42:54]
        end
      end else if (2'h1 == _GEN_175) begin // @[BPU.scala 41:35]
        PHT_63 <= _GEN_367;
      end else begin
        PHT_63 <= _GEN_751;
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
  BHT_0 = _RAND_0[5:0];
  _RAND_1 = {1{`RANDOM}};
  BHT_1 = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  BHT_2 = _RAND_2[5:0];
  _RAND_3 = {1{`RANDOM}};
  BHT_3 = _RAND_3[5:0];
  _RAND_4 = {1{`RANDOM}};
  BHT_4 = _RAND_4[5:0];
  _RAND_5 = {1{`RANDOM}};
  BHT_5 = _RAND_5[5:0];
  _RAND_6 = {1{`RANDOM}};
  BHT_6 = _RAND_6[5:0];
  _RAND_7 = {1{`RANDOM}};
  BHT_7 = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  BHT_8 = _RAND_8[5:0];
  _RAND_9 = {1{`RANDOM}};
  BHT_9 = _RAND_9[5:0];
  _RAND_10 = {1{`RANDOM}};
  BHT_10 = _RAND_10[5:0];
  _RAND_11 = {1{`RANDOM}};
  BHT_11 = _RAND_11[5:0];
  _RAND_12 = {1{`RANDOM}};
  BHT_12 = _RAND_12[5:0];
  _RAND_13 = {1{`RANDOM}};
  BHT_13 = _RAND_13[5:0];
  _RAND_14 = {1{`RANDOM}};
  BHT_14 = _RAND_14[5:0];
  _RAND_15 = {1{`RANDOM}};
  BHT_15 = _RAND_15[5:0];
  _RAND_16 = {1{`RANDOM}};
  PHT_0 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  PHT_1 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  PHT_2 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  PHT_3 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  PHT_4 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  PHT_5 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  PHT_6 = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  PHT_7 = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  PHT_8 = _RAND_24[1:0];
  _RAND_25 = {1{`RANDOM}};
  PHT_9 = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  PHT_10 = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  PHT_11 = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  PHT_12 = _RAND_28[1:0];
  _RAND_29 = {1{`RANDOM}};
  PHT_13 = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  PHT_14 = _RAND_30[1:0];
  _RAND_31 = {1{`RANDOM}};
  PHT_15 = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  PHT_16 = _RAND_32[1:0];
  _RAND_33 = {1{`RANDOM}};
  PHT_17 = _RAND_33[1:0];
  _RAND_34 = {1{`RANDOM}};
  PHT_18 = _RAND_34[1:0];
  _RAND_35 = {1{`RANDOM}};
  PHT_19 = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  PHT_20 = _RAND_36[1:0];
  _RAND_37 = {1{`RANDOM}};
  PHT_21 = _RAND_37[1:0];
  _RAND_38 = {1{`RANDOM}};
  PHT_22 = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  PHT_23 = _RAND_39[1:0];
  _RAND_40 = {1{`RANDOM}};
  PHT_24 = _RAND_40[1:0];
  _RAND_41 = {1{`RANDOM}};
  PHT_25 = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  PHT_26 = _RAND_42[1:0];
  _RAND_43 = {1{`RANDOM}};
  PHT_27 = _RAND_43[1:0];
  _RAND_44 = {1{`RANDOM}};
  PHT_28 = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  PHT_29 = _RAND_45[1:0];
  _RAND_46 = {1{`RANDOM}};
  PHT_30 = _RAND_46[1:0];
  _RAND_47 = {1{`RANDOM}};
  PHT_31 = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  PHT_32 = _RAND_48[1:0];
  _RAND_49 = {1{`RANDOM}};
  PHT_33 = _RAND_49[1:0];
  _RAND_50 = {1{`RANDOM}};
  PHT_34 = _RAND_50[1:0];
  _RAND_51 = {1{`RANDOM}};
  PHT_35 = _RAND_51[1:0];
  _RAND_52 = {1{`RANDOM}};
  PHT_36 = _RAND_52[1:0];
  _RAND_53 = {1{`RANDOM}};
  PHT_37 = _RAND_53[1:0];
  _RAND_54 = {1{`RANDOM}};
  PHT_38 = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  PHT_39 = _RAND_55[1:0];
  _RAND_56 = {1{`RANDOM}};
  PHT_40 = _RAND_56[1:0];
  _RAND_57 = {1{`RANDOM}};
  PHT_41 = _RAND_57[1:0];
  _RAND_58 = {1{`RANDOM}};
  PHT_42 = _RAND_58[1:0];
  _RAND_59 = {1{`RANDOM}};
  PHT_43 = _RAND_59[1:0];
  _RAND_60 = {1{`RANDOM}};
  PHT_44 = _RAND_60[1:0];
  _RAND_61 = {1{`RANDOM}};
  PHT_45 = _RAND_61[1:0];
  _RAND_62 = {1{`RANDOM}};
  PHT_46 = _RAND_62[1:0];
  _RAND_63 = {1{`RANDOM}};
  PHT_47 = _RAND_63[1:0];
  _RAND_64 = {1{`RANDOM}};
  PHT_48 = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  PHT_49 = _RAND_65[1:0];
  _RAND_66 = {1{`RANDOM}};
  PHT_50 = _RAND_66[1:0];
  _RAND_67 = {1{`RANDOM}};
  PHT_51 = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  PHT_52 = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  PHT_53 = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  PHT_54 = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  PHT_55 = _RAND_71[1:0];
  _RAND_72 = {1{`RANDOM}};
  PHT_56 = _RAND_72[1:0];
  _RAND_73 = {1{`RANDOM}};
  PHT_57 = _RAND_73[1:0];
  _RAND_74 = {1{`RANDOM}};
  PHT_58 = _RAND_74[1:0];
  _RAND_75 = {1{`RANDOM}};
  PHT_59 = _RAND_75[1:0];
  _RAND_76 = {1{`RANDOM}};
  PHT_60 = _RAND_76[1:0];
  _RAND_77 = {1{`RANDOM}};
  PHT_61 = _RAND_77[1:0];
  _RAND_78 = {1{`RANDOM}};
  PHT_62 = _RAND_78[1:0];
  _RAND_79 = {1{`RANDOM}};
  PHT_63 = _RAND_79[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
