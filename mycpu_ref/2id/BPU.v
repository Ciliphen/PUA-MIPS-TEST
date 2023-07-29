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
  reg [5:0] BHT_0; // @[BPU.scala 31:26]
  reg [5:0] BHT_1; // @[BPU.scala 31:26]
  reg [5:0] BHT_2; // @[BPU.scala 31:26]
  reg [5:0] BHT_3; // @[BPU.scala 31:26]
  reg [5:0] BHT_4; // @[BPU.scala 31:26]
  reg [5:0] BHT_5; // @[BPU.scala 31:26]
  reg [5:0] BHT_6; // @[BPU.scala 31:26]
  reg [5:0] BHT_7; // @[BPU.scala 31:26]
  reg [5:0] BHT_8; // @[BPU.scala 31:26]
  reg [5:0] BHT_9; // @[BPU.scala 31:26]
  reg [5:0] BHT_10; // @[BPU.scala 31:26]
  reg [5:0] BHT_11; // @[BPU.scala 31:26]
  reg [5:0] BHT_12; // @[BPU.scala 31:26]
  reg [5:0] BHT_13; // @[BPU.scala 31:26]
  reg [5:0] BHT_14; // @[BPU.scala 31:26]
  reg [5:0] BHT_15; // @[BPU.scala 31:26]
  reg [1:0] PHT_0; // @[BPU.scala 32:26]
  reg [1:0] PHT_1; // @[BPU.scala 32:26]
  reg [1:0] PHT_2; // @[BPU.scala 32:26]
  reg [1:0] PHT_3; // @[BPU.scala 32:26]
  reg [1:0] PHT_4; // @[BPU.scala 32:26]
  reg [1:0] PHT_5; // @[BPU.scala 32:26]
  reg [1:0] PHT_6; // @[BPU.scala 32:26]
  reg [1:0] PHT_7; // @[BPU.scala 32:26]
  reg [1:0] PHT_8; // @[BPU.scala 32:26]
  reg [1:0] PHT_9; // @[BPU.scala 32:26]
  reg [1:0] PHT_10; // @[BPU.scala 32:26]
  reg [1:0] PHT_11; // @[BPU.scala 32:26]
  reg [1:0] PHT_12; // @[BPU.scala 32:26]
  reg [1:0] PHT_13; // @[BPU.scala 32:26]
  reg [1:0] PHT_14; // @[BPU.scala 32:26]
  reg [1:0] PHT_15; // @[BPU.scala 32:26]
  reg [1:0] PHT_16; // @[BPU.scala 32:26]
  reg [1:0] PHT_17; // @[BPU.scala 32:26]
  reg [1:0] PHT_18; // @[BPU.scala 32:26]
  reg [1:0] PHT_19; // @[BPU.scala 32:26]
  reg [1:0] PHT_20; // @[BPU.scala 32:26]
  reg [1:0] PHT_21; // @[BPU.scala 32:26]
  reg [1:0] PHT_22; // @[BPU.scala 32:26]
  reg [1:0] PHT_23; // @[BPU.scala 32:26]
  reg [1:0] PHT_24; // @[BPU.scala 32:26]
  reg [1:0] PHT_25; // @[BPU.scala 32:26]
  reg [1:0] PHT_26; // @[BPU.scala 32:26]
  reg [1:0] PHT_27; // @[BPU.scala 32:26]
  reg [1:0] PHT_28; // @[BPU.scala 32:26]
  reg [1:0] PHT_29; // @[BPU.scala 32:26]
  reg [1:0] PHT_30; // @[BPU.scala 32:26]
  reg [1:0] PHT_31; // @[BPU.scala 32:26]
  reg [1:0] PHT_32; // @[BPU.scala 32:26]
  reg [1:0] PHT_33; // @[BPU.scala 32:26]
  reg [1:0] PHT_34; // @[BPU.scala 32:26]
  reg [1:0] PHT_35; // @[BPU.scala 32:26]
  reg [1:0] PHT_36; // @[BPU.scala 32:26]
  reg [1:0] PHT_37; // @[BPU.scala 32:26]
  reg [1:0] PHT_38; // @[BPU.scala 32:26]
  reg [1:0] PHT_39; // @[BPU.scala 32:26]
  reg [1:0] PHT_40; // @[BPU.scala 32:26]
  reg [1:0] PHT_41; // @[BPU.scala 32:26]
  reg [1:0] PHT_42; // @[BPU.scala 32:26]
  reg [1:0] PHT_43; // @[BPU.scala 32:26]
  reg [1:0] PHT_44; // @[BPU.scala 32:26]
  reg [1:0] PHT_45; // @[BPU.scala 32:26]
  reg [1:0] PHT_46; // @[BPU.scala 32:26]
  reg [1:0] PHT_47; // @[BPU.scala 32:26]
  reg [1:0] PHT_48; // @[BPU.scala 32:26]
  reg [1:0] PHT_49; // @[BPU.scala 32:26]
  reg [1:0] PHT_50; // @[BPU.scala 32:26]
  reg [1:0] PHT_51; // @[BPU.scala 32:26]
  reg [1:0] PHT_52; // @[BPU.scala 32:26]
  reg [1:0] PHT_53; // @[BPU.scala 32:26]
  reg [1:0] PHT_54; // @[BPU.scala 32:26]
  reg [1:0] PHT_55; // @[BPU.scala 32:26]
  reg [1:0] PHT_56; // @[BPU.scala 32:26]
  reg [1:0] PHT_57; // @[BPU.scala 32:26]
  reg [1:0] PHT_58; // @[BPU.scala 32:26]
  reg [1:0] PHT_59; // @[BPU.scala 32:26]
  reg [1:0] PHT_60; // @[BPU.scala 32:26]
  reg [1:0] PHT_61; // @[BPU.scala 32:26]
  reg [1:0] PHT_62; // @[BPU.scala 32:26]
  reg [1:0] PHT_63; // @[BPU.scala 32:26]
  wire [3:0] BHT_index = io_pcD[5:2]; // @[BPU.scala 33:25]
  wire [5:0] _GEN_1 = 4'h1 == BHT_index ? BHT_1 : BHT_0; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_2 = 4'h2 == BHT_index ? BHT_2 : _GEN_1; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_3 = 4'h3 == BHT_index ? BHT_3 : _GEN_2; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_4 = 4'h4 == BHT_index ? BHT_4 : _GEN_3; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_5 = 4'h5 == BHT_index ? BHT_5 : _GEN_4; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_6 = 4'h6 == BHT_index ? BHT_6 : _GEN_5; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_7 = 4'h7 == BHT_index ? BHT_7 : _GEN_6; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_8 = 4'h8 == BHT_index ? BHT_8 : _GEN_7; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_9 = 4'h9 == BHT_index ? BHT_9 : _GEN_8; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_10 = 4'ha == BHT_index ? BHT_10 : _GEN_9; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_11 = 4'hb == BHT_index ? BHT_11 : _GEN_10; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_12 = 4'hc == BHT_index ? BHT_12 : _GEN_11; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_13 = 4'hd == BHT_index ? BHT_13 : _GEN_12; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_14 = 4'he == BHT_index ? BHT_14 : _GEN_13; // @[BPU.scala 37:{61,61}]
  wire [5:0] _GEN_15 = 4'hf == BHT_index ? BHT_15 : _GEN_14; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_17 = 6'h1 == _GEN_15 ? PHT_1 : PHT_0; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_18 = 6'h2 == _GEN_15 ? PHT_2 : _GEN_17; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_19 = 6'h3 == _GEN_15 ? PHT_3 : _GEN_18; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_20 = 6'h4 == _GEN_15 ? PHT_4 : _GEN_19; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_21 = 6'h5 == _GEN_15 ? PHT_5 : _GEN_20; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_22 = 6'h6 == _GEN_15 ? PHT_6 : _GEN_21; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_23 = 6'h7 == _GEN_15 ? PHT_7 : _GEN_22; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_24 = 6'h8 == _GEN_15 ? PHT_8 : _GEN_23; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_25 = 6'h9 == _GEN_15 ? PHT_9 : _GEN_24; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_26 = 6'ha == _GEN_15 ? PHT_10 : _GEN_25; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_27 = 6'hb == _GEN_15 ? PHT_11 : _GEN_26; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_28 = 6'hc == _GEN_15 ? PHT_12 : _GEN_27; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_29 = 6'hd == _GEN_15 ? PHT_13 : _GEN_28; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_30 = 6'he == _GEN_15 ? PHT_14 : _GEN_29; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_31 = 6'hf == _GEN_15 ? PHT_15 : _GEN_30; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_32 = 6'h10 == _GEN_15 ? PHT_16 : _GEN_31; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_33 = 6'h11 == _GEN_15 ? PHT_17 : _GEN_32; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_34 = 6'h12 == _GEN_15 ? PHT_18 : _GEN_33; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_35 = 6'h13 == _GEN_15 ? PHT_19 : _GEN_34; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_36 = 6'h14 == _GEN_15 ? PHT_20 : _GEN_35; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_37 = 6'h15 == _GEN_15 ? PHT_21 : _GEN_36; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_38 = 6'h16 == _GEN_15 ? PHT_22 : _GEN_37; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_39 = 6'h17 == _GEN_15 ? PHT_23 : _GEN_38; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_40 = 6'h18 == _GEN_15 ? PHT_24 : _GEN_39; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_41 = 6'h19 == _GEN_15 ? PHT_25 : _GEN_40; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_42 = 6'h1a == _GEN_15 ? PHT_26 : _GEN_41; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_43 = 6'h1b == _GEN_15 ? PHT_27 : _GEN_42; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_44 = 6'h1c == _GEN_15 ? PHT_28 : _GEN_43; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_45 = 6'h1d == _GEN_15 ? PHT_29 : _GEN_44; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_46 = 6'h1e == _GEN_15 ? PHT_30 : _GEN_45; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_47 = 6'h1f == _GEN_15 ? PHT_31 : _GEN_46; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_48 = 6'h20 == _GEN_15 ? PHT_32 : _GEN_47; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_49 = 6'h21 == _GEN_15 ? PHT_33 : _GEN_48; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_50 = 6'h22 == _GEN_15 ? PHT_34 : _GEN_49; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_51 = 6'h23 == _GEN_15 ? PHT_35 : _GEN_50; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_52 = 6'h24 == _GEN_15 ? PHT_36 : _GEN_51; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_53 = 6'h25 == _GEN_15 ? PHT_37 : _GEN_52; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_54 = 6'h26 == _GEN_15 ? PHT_38 : _GEN_53; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_55 = 6'h27 == _GEN_15 ? PHT_39 : _GEN_54; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_56 = 6'h28 == _GEN_15 ? PHT_40 : _GEN_55; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_57 = 6'h29 == _GEN_15 ? PHT_41 : _GEN_56; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_58 = 6'h2a == _GEN_15 ? PHT_42 : _GEN_57; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_59 = 6'h2b == _GEN_15 ? PHT_43 : _GEN_58; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_60 = 6'h2c == _GEN_15 ? PHT_44 : _GEN_59; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_61 = 6'h2d == _GEN_15 ? PHT_45 : _GEN_60; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_62 = 6'h2e == _GEN_15 ? PHT_46 : _GEN_61; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_63 = 6'h2f == _GEN_15 ? PHT_47 : _GEN_62; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_64 = 6'h30 == _GEN_15 ? PHT_48 : _GEN_63; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_65 = 6'h31 == _GEN_15 ? PHT_49 : _GEN_64; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_66 = 6'h32 == _GEN_15 ? PHT_50 : _GEN_65; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_67 = 6'h33 == _GEN_15 ? PHT_51 : _GEN_66; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_68 = 6'h34 == _GEN_15 ? PHT_52 : _GEN_67; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_69 = 6'h35 == _GEN_15 ? PHT_53 : _GEN_68; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_70 = 6'h36 == _GEN_15 ? PHT_54 : _GEN_69; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_71 = 6'h37 == _GEN_15 ? PHT_55 : _GEN_70; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_72 = 6'h38 == _GEN_15 ? PHT_56 : _GEN_71; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_73 = 6'h39 == _GEN_15 ? PHT_57 : _GEN_72; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_74 = 6'h3a == _GEN_15 ? PHT_58 : _GEN_73; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_75 = 6'h3b == _GEN_15 ? PHT_59 : _GEN_74; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_76 = 6'h3c == _GEN_15 ? PHT_60 : _GEN_75; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_77 = 6'h3d == _GEN_15 ? PHT_61 : _GEN_76; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_78 = 6'h3e == _GEN_15 ? PHT_62 : _GEN_77; // @[BPU.scala 37:{61,61}]
  wire [1:0] _GEN_79 = 6'h3f == _GEN_15 ? PHT_63 : _GEN_78; // @[BPU.scala 37:{61,61}]
  wire [3:0] update_BHT_index = io_pcE[5:2]; // @[BPU.scala 39:32]
  wire [5:0] _GEN_145 = 4'h1 == update_BHT_index ? BHT_1 : BHT_0; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_146 = 4'h2 == update_BHT_index ? BHT_2 : _GEN_145; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_147 = 4'h3 == update_BHT_index ? BHT_3 : _GEN_146; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_148 = 4'h4 == update_BHT_index ? BHT_4 : _GEN_147; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_149 = 4'h5 == update_BHT_index ? BHT_5 : _GEN_148; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_150 = 4'h6 == update_BHT_index ? BHT_6 : _GEN_149; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_151 = 4'h7 == update_BHT_index ? BHT_7 : _GEN_150; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_152 = 4'h8 == update_BHT_index ? BHT_8 : _GEN_151; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_153 = 4'h9 == update_BHT_index ? BHT_9 : _GEN_152; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_154 = 4'ha == update_BHT_index ? BHT_10 : _GEN_153; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_155 = 4'hb == update_BHT_index ? BHT_11 : _GEN_154; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_156 = 4'hc == update_BHT_index ? BHT_12 : _GEN_155; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_157 = 4'hd == update_BHT_index ? BHT_13 : _GEN_156; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_158 = 4'he == update_BHT_index ? BHT_14 : _GEN_157; // @[BPU.scala 44:{55,55}]
  wire [5:0] _GEN_159 = 4'hf == update_BHT_index ? BHT_15 : _GEN_158; // @[BPU.scala 44:{55,55}]
  wire [5:0] _BHT_T_1 = {_GEN_159[5:1],io_actual_takeE}; // @[Cat.scala 33:92]
  wire [1:0] _GEN_177 = 6'h1 == _GEN_159 ? PHT_1 : PHT_0; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_178 = 6'h2 == _GEN_159 ? PHT_2 : _GEN_177; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_179 = 6'h3 == _GEN_159 ? PHT_3 : _GEN_178; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_180 = 6'h4 == _GEN_159 ? PHT_4 : _GEN_179; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_181 = 6'h5 == _GEN_159 ? PHT_5 : _GEN_180; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_182 = 6'h6 == _GEN_159 ? PHT_6 : _GEN_181; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_183 = 6'h7 == _GEN_159 ? PHT_7 : _GEN_182; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_184 = 6'h8 == _GEN_159 ? PHT_8 : _GEN_183; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_185 = 6'h9 == _GEN_159 ? PHT_9 : _GEN_184; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_186 = 6'ha == _GEN_159 ? PHT_10 : _GEN_185; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_187 = 6'hb == _GEN_159 ? PHT_11 : _GEN_186; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_188 = 6'hc == _GEN_159 ? PHT_12 : _GEN_187; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_189 = 6'hd == _GEN_159 ? PHT_13 : _GEN_188; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_190 = 6'he == _GEN_159 ? PHT_14 : _GEN_189; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_191 = 6'hf == _GEN_159 ? PHT_15 : _GEN_190; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_192 = 6'h10 == _GEN_159 ? PHT_16 : _GEN_191; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_193 = 6'h11 == _GEN_159 ? PHT_17 : _GEN_192; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_194 = 6'h12 == _GEN_159 ? PHT_18 : _GEN_193; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_195 = 6'h13 == _GEN_159 ? PHT_19 : _GEN_194; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_196 = 6'h14 == _GEN_159 ? PHT_20 : _GEN_195; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_197 = 6'h15 == _GEN_159 ? PHT_21 : _GEN_196; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_198 = 6'h16 == _GEN_159 ? PHT_22 : _GEN_197; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_199 = 6'h17 == _GEN_159 ? PHT_23 : _GEN_198; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_200 = 6'h18 == _GEN_159 ? PHT_24 : _GEN_199; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_201 = 6'h19 == _GEN_159 ? PHT_25 : _GEN_200; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_202 = 6'h1a == _GEN_159 ? PHT_26 : _GEN_201; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_203 = 6'h1b == _GEN_159 ? PHT_27 : _GEN_202; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_204 = 6'h1c == _GEN_159 ? PHT_28 : _GEN_203; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_205 = 6'h1d == _GEN_159 ? PHT_29 : _GEN_204; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_206 = 6'h1e == _GEN_159 ? PHT_30 : _GEN_205; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_207 = 6'h1f == _GEN_159 ? PHT_31 : _GEN_206; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_208 = 6'h20 == _GEN_159 ? PHT_32 : _GEN_207; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_209 = 6'h21 == _GEN_159 ? PHT_33 : _GEN_208; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_210 = 6'h22 == _GEN_159 ? PHT_34 : _GEN_209; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_211 = 6'h23 == _GEN_159 ? PHT_35 : _GEN_210; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_212 = 6'h24 == _GEN_159 ? PHT_36 : _GEN_211; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_213 = 6'h25 == _GEN_159 ? PHT_37 : _GEN_212; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_214 = 6'h26 == _GEN_159 ? PHT_38 : _GEN_213; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_215 = 6'h27 == _GEN_159 ? PHT_39 : _GEN_214; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_216 = 6'h28 == _GEN_159 ? PHT_40 : _GEN_215; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_217 = 6'h29 == _GEN_159 ? PHT_41 : _GEN_216; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_218 = 6'h2a == _GEN_159 ? PHT_42 : _GEN_217; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_219 = 6'h2b == _GEN_159 ? PHT_43 : _GEN_218; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_220 = 6'h2c == _GEN_159 ? PHT_44 : _GEN_219; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_221 = 6'h2d == _GEN_159 ? PHT_45 : _GEN_220; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_222 = 6'h2e == _GEN_159 ? PHT_46 : _GEN_221; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_223 = 6'h2f == _GEN_159 ? PHT_47 : _GEN_222; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_224 = 6'h30 == _GEN_159 ? PHT_48 : _GEN_223; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_225 = 6'h31 == _GEN_159 ? PHT_49 : _GEN_224; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_226 = 6'h32 == _GEN_159 ? PHT_50 : _GEN_225; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_227 = 6'h33 == _GEN_159 ? PHT_51 : _GEN_226; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_228 = 6'h34 == _GEN_159 ? PHT_52 : _GEN_227; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_229 = 6'h35 == _GEN_159 ? PHT_53 : _GEN_228; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_230 = 6'h36 == _GEN_159 ? PHT_54 : _GEN_229; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_231 = 6'h37 == _GEN_159 ? PHT_55 : _GEN_230; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_232 = 6'h38 == _GEN_159 ? PHT_56 : _GEN_231; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_233 = 6'h39 == _GEN_159 ? PHT_57 : _GEN_232; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_234 = 6'h3a == _GEN_159 ? PHT_58 : _GEN_233; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_235 = 6'h3b == _GEN_159 ? PHT_59 : _GEN_234; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_236 = 6'h3c == _GEN_159 ? PHT_60 : _GEN_235; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_237 = 6'h3d == _GEN_159 ? PHT_61 : _GEN_236; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_238 = 6'h3e == _GEN_159 ? PHT_62 : _GEN_237; // @[BPU.scala 45:{35,35}]
  wire [1:0] _GEN_239 = 6'h3f == _GEN_159 ? PHT_63 : _GEN_238; // @[BPU.scala 45:{35,35}]
  wire [1:0] _PHT_T = io_actual_takeE ? 2'h1 : 2'h0; // @[BPU.scala 47:37]
  wire [1:0] _PHT_T_1 = io_actual_takeE ? 2'h2 : 2'h0; // @[BPU.scala 50:37]
  wire [1:0] _GEN_368 = 6'h0 == _GEN_159 ? _PHT_T_1 : PHT_0; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_369 = 6'h1 == _GEN_159 ? _PHT_T_1 : PHT_1; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_370 = 6'h2 == _GEN_159 ? _PHT_T_1 : PHT_2; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_371 = 6'h3 == _GEN_159 ? _PHT_T_1 : PHT_3; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_372 = 6'h4 == _GEN_159 ? _PHT_T_1 : PHT_4; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_373 = 6'h5 == _GEN_159 ? _PHT_T_1 : PHT_5; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_374 = 6'h6 == _GEN_159 ? _PHT_T_1 : PHT_6; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_375 = 6'h7 == _GEN_159 ? _PHT_T_1 : PHT_7; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_376 = 6'h8 == _GEN_159 ? _PHT_T_1 : PHT_8; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_377 = 6'h9 == _GEN_159 ? _PHT_T_1 : PHT_9; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_378 = 6'ha == _GEN_159 ? _PHT_T_1 : PHT_10; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_379 = 6'hb == _GEN_159 ? _PHT_T_1 : PHT_11; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_380 = 6'hc == _GEN_159 ? _PHT_T_1 : PHT_12; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_381 = 6'hd == _GEN_159 ? _PHT_T_1 : PHT_13; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_382 = 6'he == _GEN_159 ? _PHT_T_1 : PHT_14; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_383 = 6'hf == _GEN_159 ? _PHT_T_1 : PHT_15; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_384 = 6'h10 == _GEN_159 ? _PHT_T_1 : PHT_16; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_385 = 6'h11 == _GEN_159 ? _PHT_T_1 : PHT_17; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_386 = 6'h12 == _GEN_159 ? _PHT_T_1 : PHT_18; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_387 = 6'h13 == _GEN_159 ? _PHT_T_1 : PHT_19; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_388 = 6'h14 == _GEN_159 ? _PHT_T_1 : PHT_20; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_389 = 6'h15 == _GEN_159 ? _PHT_T_1 : PHT_21; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_390 = 6'h16 == _GEN_159 ? _PHT_T_1 : PHT_22; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_391 = 6'h17 == _GEN_159 ? _PHT_T_1 : PHT_23; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_392 = 6'h18 == _GEN_159 ? _PHT_T_1 : PHT_24; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_393 = 6'h19 == _GEN_159 ? _PHT_T_1 : PHT_25; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_394 = 6'h1a == _GEN_159 ? _PHT_T_1 : PHT_26; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_395 = 6'h1b == _GEN_159 ? _PHT_T_1 : PHT_27; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_396 = 6'h1c == _GEN_159 ? _PHT_T_1 : PHT_28; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_397 = 6'h1d == _GEN_159 ? _PHT_T_1 : PHT_29; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_398 = 6'h1e == _GEN_159 ? _PHT_T_1 : PHT_30; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_399 = 6'h1f == _GEN_159 ? _PHT_T_1 : PHT_31; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_400 = 6'h20 == _GEN_159 ? _PHT_T_1 : PHT_32; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_401 = 6'h21 == _GEN_159 ? _PHT_T_1 : PHT_33; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_402 = 6'h22 == _GEN_159 ? _PHT_T_1 : PHT_34; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_403 = 6'h23 == _GEN_159 ? _PHT_T_1 : PHT_35; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_404 = 6'h24 == _GEN_159 ? _PHT_T_1 : PHT_36; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_405 = 6'h25 == _GEN_159 ? _PHT_T_1 : PHT_37; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_406 = 6'h26 == _GEN_159 ? _PHT_T_1 : PHT_38; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_407 = 6'h27 == _GEN_159 ? _PHT_T_1 : PHT_39; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_408 = 6'h28 == _GEN_159 ? _PHT_T_1 : PHT_40; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_409 = 6'h29 == _GEN_159 ? _PHT_T_1 : PHT_41; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_410 = 6'h2a == _GEN_159 ? _PHT_T_1 : PHT_42; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_411 = 6'h2b == _GEN_159 ? _PHT_T_1 : PHT_43; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_412 = 6'h2c == _GEN_159 ? _PHT_T_1 : PHT_44; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_413 = 6'h2d == _GEN_159 ? _PHT_T_1 : PHT_45; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_414 = 6'h2e == _GEN_159 ? _PHT_T_1 : PHT_46; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_415 = 6'h2f == _GEN_159 ? _PHT_T_1 : PHT_47; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_416 = 6'h30 == _GEN_159 ? _PHT_T_1 : PHT_48; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_417 = 6'h31 == _GEN_159 ? _PHT_T_1 : PHT_49; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_418 = 6'h32 == _GEN_159 ? _PHT_T_1 : PHT_50; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_419 = 6'h33 == _GEN_159 ? _PHT_T_1 : PHT_51; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_420 = 6'h34 == _GEN_159 ? _PHT_T_1 : PHT_52; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_421 = 6'h35 == _GEN_159 ? _PHT_T_1 : PHT_53; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_422 = 6'h36 == _GEN_159 ? _PHT_T_1 : PHT_54; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_423 = 6'h37 == _GEN_159 ? _PHT_T_1 : PHT_55; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_424 = 6'h38 == _GEN_159 ? _PHT_T_1 : PHT_56; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_425 = 6'h39 == _GEN_159 ? _PHT_T_1 : PHT_57; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_426 = 6'h3a == _GEN_159 ? _PHT_T_1 : PHT_58; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_427 = 6'h3b == _GEN_159 ? _PHT_T_1 : PHT_59; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_428 = 6'h3c == _GEN_159 ? _PHT_T_1 : PHT_60; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_429 = 6'h3d == _GEN_159 ? _PHT_T_1 : PHT_61; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_430 = 6'h3e == _GEN_159 ? _PHT_T_1 : PHT_62; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _GEN_431 = 6'h3f == _GEN_159 ? _PHT_T_1 : PHT_63; // @[BPU.scala 32:26 50:{31,31}]
  wire [1:0] _PHT_T_2 = io_actual_takeE ? 2'h3 : 2'h1; // @[BPU.scala 53:37]
  wire [1:0] _GEN_496 = 6'h0 == _GEN_159 ? _PHT_T_2 : PHT_0; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_497 = 6'h1 == _GEN_159 ? _PHT_T_2 : PHT_1; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_498 = 6'h2 == _GEN_159 ? _PHT_T_2 : PHT_2; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_499 = 6'h3 == _GEN_159 ? _PHT_T_2 : PHT_3; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_500 = 6'h4 == _GEN_159 ? _PHT_T_2 : PHT_4; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_501 = 6'h5 == _GEN_159 ? _PHT_T_2 : PHT_5; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_502 = 6'h6 == _GEN_159 ? _PHT_T_2 : PHT_6; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_503 = 6'h7 == _GEN_159 ? _PHT_T_2 : PHT_7; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_504 = 6'h8 == _GEN_159 ? _PHT_T_2 : PHT_8; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_505 = 6'h9 == _GEN_159 ? _PHT_T_2 : PHT_9; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_506 = 6'ha == _GEN_159 ? _PHT_T_2 : PHT_10; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_507 = 6'hb == _GEN_159 ? _PHT_T_2 : PHT_11; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_508 = 6'hc == _GEN_159 ? _PHT_T_2 : PHT_12; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_509 = 6'hd == _GEN_159 ? _PHT_T_2 : PHT_13; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_510 = 6'he == _GEN_159 ? _PHT_T_2 : PHT_14; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_511 = 6'hf == _GEN_159 ? _PHT_T_2 : PHT_15; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_512 = 6'h10 == _GEN_159 ? _PHT_T_2 : PHT_16; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_513 = 6'h11 == _GEN_159 ? _PHT_T_2 : PHT_17; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_514 = 6'h12 == _GEN_159 ? _PHT_T_2 : PHT_18; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_515 = 6'h13 == _GEN_159 ? _PHT_T_2 : PHT_19; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_516 = 6'h14 == _GEN_159 ? _PHT_T_2 : PHT_20; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_517 = 6'h15 == _GEN_159 ? _PHT_T_2 : PHT_21; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_518 = 6'h16 == _GEN_159 ? _PHT_T_2 : PHT_22; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_519 = 6'h17 == _GEN_159 ? _PHT_T_2 : PHT_23; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_520 = 6'h18 == _GEN_159 ? _PHT_T_2 : PHT_24; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_521 = 6'h19 == _GEN_159 ? _PHT_T_2 : PHT_25; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_522 = 6'h1a == _GEN_159 ? _PHT_T_2 : PHT_26; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_523 = 6'h1b == _GEN_159 ? _PHT_T_2 : PHT_27; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_524 = 6'h1c == _GEN_159 ? _PHT_T_2 : PHT_28; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_525 = 6'h1d == _GEN_159 ? _PHT_T_2 : PHT_29; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_526 = 6'h1e == _GEN_159 ? _PHT_T_2 : PHT_30; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_527 = 6'h1f == _GEN_159 ? _PHT_T_2 : PHT_31; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_528 = 6'h20 == _GEN_159 ? _PHT_T_2 : PHT_32; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_529 = 6'h21 == _GEN_159 ? _PHT_T_2 : PHT_33; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_530 = 6'h22 == _GEN_159 ? _PHT_T_2 : PHT_34; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_531 = 6'h23 == _GEN_159 ? _PHT_T_2 : PHT_35; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_532 = 6'h24 == _GEN_159 ? _PHT_T_2 : PHT_36; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_533 = 6'h25 == _GEN_159 ? _PHT_T_2 : PHT_37; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_534 = 6'h26 == _GEN_159 ? _PHT_T_2 : PHT_38; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_535 = 6'h27 == _GEN_159 ? _PHT_T_2 : PHT_39; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_536 = 6'h28 == _GEN_159 ? _PHT_T_2 : PHT_40; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_537 = 6'h29 == _GEN_159 ? _PHT_T_2 : PHT_41; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_538 = 6'h2a == _GEN_159 ? _PHT_T_2 : PHT_42; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_539 = 6'h2b == _GEN_159 ? _PHT_T_2 : PHT_43; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_540 = 6'h2c == _GEN_159 ? _PHT_T_2 : PHT_44; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_541 = 6'h2d == _GEN_159 ? _PHT_T_2 : PHT_45; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_542 = 6'h2e == _GEN_159 ? _PHT_T_2 : PHT_46; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_543 = 6'h2f == _GEN_159 ? _PHT_T_2 : PHT_47; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_544 = 6'h30 == _GEN_159 ? _PHT_T_2 : PHT_48; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_545 = 6'h31 == _GEN_159 ? _PHT_T_2 : PHT_49; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_546 = 6'h32 == _GEN_159 ? _PHT_T_2 : PHT_50; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_547 = 6'h33 == _GEN_159 ? _PHT_T_2 : PHT_51; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_548 = 6'h34 == _GEN_159 ? _PHT_T_2 : PHT_52; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_549 = 6'h35 == _GEN_159 ? _PHT_T_2 : PHT_53; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_550 = 6'h36 == _GEN_159 ? _PHT_T_2 : PHT_54; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_551 = 6'h37 == _GEN_159 ? _PHT_T_2 : PHT_55; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_552 = 6'h38 == _GEN_159 ? _PHT_T_2 : PHT_56; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_553 = 6'h39 == _GEN_159 ? _PHT_T_2 : PHT_57; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_554 = 6'h3a == _GEN_159 ? _PHT_T_2 : PHT_58; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_555 = 6'h3b == _GEN_159 ? _PHT_T_2 : PHT_59; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_556 = 6'h3c == _GEN_159 ? _PHT_T_2 : PHT_60; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_557 = 6'h3d == _GEN_159 ? _PHT_T_2 : PHT_61; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_558 = 6'h3e == _GEN_159 ? _PHT_T_2 : PHT_62; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _GEN_559 = 6'h3f == _GEN_159 ? _PHT_T_2 : PHT_63; // @[BPU.scala 32:26 53:{31,31}]
  wire [1:0] _PHT_T_3 = io_actual_takeE ? 2'h3 : 2'h2; // @[BPU.scala 56:37]
  wire [1:0] _GEN_624 = 6'h0 == _GEN_159 ? _PHT_T_3 : PHT_0; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_625 = 6'h1 == _GEN_159 ? _PHT_T_3 : PHT_1; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_626 = 6'h2 == _GEN_159 ? _PHT_T_3 : PHT_2; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_627 = 6'h3 == _GEN_159 ? _PHT_T_3 : PHT_3; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_628 = 6'h4 == _GEN_159 ? _PHT_T_3 : PHT_4; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_629 = 6'h5 == _GEN_159 ? _PHT_T_3 : PHT_5; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_630 = 6'h6 == _GEN_159 ? _PHT_T_3 : PHT_6; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_631 = 6'h7 == _GEN_159 ? _PHT_T_3 : PHT_7; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_632 = 6'h8 == _GEN_159 ? _PHT_T_3 : PHT_8; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_633 = 6'h9 == _GEN_159 ? _PHT_T_3 : PHT_9; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_634 = 6'ha == _GEN_159 ? _PHT_T_3 : PHT_10; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_635 = 6'hb == _GEN_159 ? _PHT_T_3 : PHT_11; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_636 = 6'hc == _GEN_159 ? _PHT_T_3 : PHT_12; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_637 = 6'hd == _GEN_159 ? _PHT_T_3 : PHT_13; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_638 = 6'he == _GEN_159 ? _PHT_T_3 : PHT_14; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_639 = 6'hf == _GEN_159 ? _PHT_T_3 : PHT_15; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_640 = 6'h10 == _GEN_159 ? _PHT_T_3 : PHT_16; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_641 = 6'h11 == _GEN_159 ? _PHT_T_3 : PHT_17; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_642 = 6'h12 == _GEN_159 ? _PHT_T_3 : PHT_18; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_643 = 6'h13 == _GEN_159 ? _PHT_T_3 : PHT_19; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_644 = 6'h14 == _GEN_159 ? _PHT_T_3 : PHT_20; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_645 = 6'h15 == _GEN_159 ? _PHT_T_3 : PHT_21; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_646 = 6'h16 == _GEN_159 ? _PHT_T_3 : PHT_22; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_647 = 6'h17 == _GEN_159 ? _PHT_T_3 : PHT_23; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_648 = 6'h18 == _GEN_159 ? _PHT_T_3 : PHT_24; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_649 = 6'h19 == _GEN_159 ? _PHT_T_3 : PHT_25; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_650 = 6'h1a == _GEN_159 ? _PHT_T_3 : PHT_26; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_651 = 6'h1b == _GEN_159 ? _PHT_T_3 : PHT_27; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_652 = 6'h1c == _GEN_159 ? _PHT_T_3 : PHT_28; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_653 = 6'h1d == _GEN_159 ? _PHT_T_3 : PHT_29; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_654 = 6'h1e == _GEN_159 ? _PHT_T_3 : PHT_30; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_655 = 6'h1f == _GEN_159 ? _PHT_T_3 : PHT_31; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_656 = 6'h20 == _GEN_159 ? _PHT_T_3 : PHT_32; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_657 = 6'h21 == _GEN_159 ? _PHT_T_3 : PHT_33; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_658 = 6'h22 == _GEN_159 ? _PHT_T_3 : PHT_34; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_659 = 6'h23 == _GEN_159 ? _PHT_T_3 : PHT_35; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_660 = 6'h24 == _GEN_159 ? _PHT_T_3 : PHT_36; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_661 = 6'h25 == _GEN_159 ? _PHT_T_3 : PHT_37; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_662 = 6'h26 == _GEN_159 ? _PHT_T_3 : PHT_38; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_663 = 6'h27 == _GEN_159 ? _PHT_T_3 : PHT_39; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_664 = 6'h28 == _GEN_159 ? _PHT_T_3 : PHT_40; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_665 = 6'h29 == _GEN_159 ? _PHT_T_3 : PHT_41; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_666 = 6'h2a == _GEN_159 ? _PHT_T_3 : PHT_42; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_667 = 6'h2b == _GEN_159 ? _PHT_T_3 : PHT_43; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_668 = 6'h2c == _GEN_159 ? _PHT_T_3 : PHT_44; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_669 = 6'h2d == _GEN_159 ? _PHT_T_3 : PHT_45; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_670 = 6'h2e == _GEN_159 ? _PHT_T_3 : PHT_46; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_671 = 6'h2f == _GEN_159 ? _PHT_T_3 : PHT_47; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_672 = 6'h30 == _GEN_159 ? _PHT_T_3 : PHT_48; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_673 = 6'h31 == _GEN_159 ? _PHT_T_3 : PHT_49; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_674 = 6'h32 == _GEN_159 ? _PHT_T_3 : PHT_50; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_675 = 6'h33 == _GEN_159 ? _PHT_T_3 : PHT_51; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_676 = 6'h34 == _GEN_159 ? _PHT_T_3 : PHT_52; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_677 = 6'h35 == _GEN_159 ? _PHT_T_3 : PHT_53; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_678 = 6'h36 == _GEN_159 ? _PHT_T_3 : PHT_54; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_679 = 6'h37 == _GEN_159 ? _PHT_T_3 : PHT_55; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_680 = 6'h38 == _GEN_159 ? _PHT_T_3 : PHT_56; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_681 = 6'h39 == _GEN_159 ? _PHT_T_3 : PHT_57; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_682 = 6'h3a == _GEN_159 ? _PHT_T_3 : PHT_58; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_683 = 6'h3b == _GEN_159 ? _PHT_T_3 : PHT_59; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_684 = 6'h3c == _GEN_159 ? _PHT_T_3 : PHT_60; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_685 = 6'h3d == _GEN_159 ? _PHT_T_3 : PHT_61; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_686 = 6'h3e == _GEN_159 ? _PHT_T_3 : PHT_62; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_687 = 6'h3f == _GEN_159 ? _PHT_T_3 : PHT_63; // @[BPU.scala 32:26 56:{31,31}]
  wire [1:0] _GEN_688 = 2'h3 == _GEN_239 ? _GEN_624 : PHT_0; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_689 = 2'h3 == _GEN_239 ? _GEN_625 : PHT_1; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_690 = 2'h3 == _GEN_239 ? _GEN_626 : PHT_2; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_691 = 2'h3 == _GEN_239 ? _GEN_627 : PHT_3; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_692 = 2'h3 == _GEN_239 ? _GEN_628 : PHT_4; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_693 = 2'h3 == _GEN_239 ? _GEN_629 : PHT_5; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_694 = 2'h3 == _GEN_239 ? _GEN_630 : PHT_6; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_695 = 2'h3 == _GEN_239 ? _GEN_631 : PHT_7; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_696 = 2'h3 == _GEN_239 ? _GEN_632 : PHT_8; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_697 = 2'h3 == _GEN_239 ? _GEN_633 : PHT_9; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_698 = 2'h3 == _GEN_239 ? _GEN_634 : PHT_10; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_699 = 2'h3 == _GEN_239 ? _GEN_635 : PHT_11; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_700 = 2'h3 == _GEN_239 ? _GEN_636 : PHT_12; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_701 = 2'h3 == _GEN_239 ? _GEN_637 : PHT_13; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_702 = 2'h3 == _GEN_239 ? _GEN_638 : PHT_14; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_703 = 2'h3 == _GEN_239 ? _GEN_639 : PHT_15; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_704 = 2'h3 == _GEN_239 ? _GEN_640 : PHT_16; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_705 = 2'h3 == _GEN_239 ? _GEN_641 : PHT_17; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_706 = 2'h3 == _GEN_239 ? _GEN_642 : PHT_18; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_707 = 2'h3 == _GEN_239 ? _GEN_643 : PHT_19; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_708 = 2'h3 == _GEN_239 ? _GEN_644 : PHT_20; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_709 = 2'h3 == _GEN_239 ? _GEN_645 : PHT_21; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_710 = 2'h3 == _GEN_239 ? _GEN_646 : PHT_22; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_711 = 2'h3 == _GEN_239 ? _GEN_647 : PHT_23; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_712 = 2'h3 == _GEN_239 ? _GEN_648 : PHT_24; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_713 = 2'h3 == _GEN_239 ? _GEN_649 : PHT_25; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_714 = 2'h3 == _GEN_239 ? _GEN_650 : PHT_26; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_715 = 2'h3 == _GEN_239 ? _GEN_651 : PHT_27; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_716 = 2'h3 == _GEN_239 ? _GEN_652 : PHT_28; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_717 = 2'h3 == _GEN_239 ? _GEN_653 : PHT_29; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_718 = 2'h3 == _GEN_239 ? _GEN_654 : PHT_30; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_719 = 2'h3 == _GEN_239 ? _GEN_655 : PHT_31; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_720 = 2'h3 == _GEN_239 ? _GEN_656 : PHT_32; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_721 = 2'h3 == _GEN_239 ? _GEN_657 : PHT_33; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_722 = 2'h3 == _GEN_239 ? _GEN_658 : PHT_34; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_723 = 2'h3 == _GEN_239 ? _GEN_659 : PHT_35; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_724 = 2'h3 == _GEN_239 ? _GEN_660 : PHT_36; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_725 = 2'h3 == _GEN_239 ? _GEN_661 : PHT_37; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_726 = 2'h3 == _GEN_239 ? _GEN_662 : PHT_38; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_727 = 2'h3 == _GEN_239 ? _GEN_663 : PHT_39; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_728 = 2'h3 == _GEN_239 ? _GEN_664 : PHT_40; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_729 = 2'h3 == _GEN_239 ? _GEN_665 : PHT_41; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_730 = 2'h3 == _GEN_239 ? _GEN_666 : PHT_42; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_731 = 2'h3 == _GEN_239 ? _GEN_667 : PHT_43; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_732 = 2'h3 == _GEN_239 ? _GEN_668 : PHT_44; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_733 = 2'h3 == _GEN_239 ? _GEN_669 : PHT_45; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_734 = 2'h3 == _GEN_239 ? _GEN_670 : PHT_46; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_735 = 2'h3 == _GEN_239 ? _GEN_671 : PHT_47; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_736 = 2'h3 == _GEN_239 ? _GEN_672 : PHT_48; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_737 = 2'h3 == _GEN_239 ? _GEN_673 : PHT_49; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_738 = 2'h3 == _GEN_239 ? _GEN_674 : PHT_50; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_739 = 2'h3 == _GEN_239 ? _GEN_675 : PHT_51; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_740 = 2'h3 == _GEN_239 ? _GEN_676 : PHT_52; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_741 = 2'h3 == _GEN_239 ? _GEN_677 : PHT_53; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_742 = 2'h3 == _GEN_239 ? _GEN_678 : PHT_54; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_743 = 2'h3 == _GEN_239 ? _GEN_679 : PHT_55; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_744 = 2'h3 == _GEN_239 ? _GEN_680 : PHT_56; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_745 = 2'h3 == _GEN_239 ? _GEN_681 : PHT_57; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_746 = 2'h3 == _GEN_239 ? _GEN_682 : PHT_58; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_747 = 2'h3 == _GEN_239 ? _GEN_683 : PHT_59; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_748 = 2'h3 == _GEN_239 ? _GEN_684 : PHT_60; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_749 = 2'h3 == _GEN_239 ? _GEN_685 : PHT_61; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_750 = 2'h3 == _GEN_239 ? _GEN_686 : PHT_62; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_751 = 2'h3 == _GEN_239 ? _GEN_687 : PHT_63; // @[BPU.scala 32:26 45:35]
  wire [1:0] _GEN_752 = 2'h2 == _GEN_239 ? _GEN_496 : _GEN_688; // @[BPU.scala 45:35]
  wire [1:0] _GEN_753 = 2'h2 == _GEN_239 ? _GEN_497 : _GEN_689; // @[BPU.scala 45:35]
  wire [1:0] _GEN_754 = 2'h2 == _GEN_239 ? _GEN_498 : _GEN_690; // @[BPU.scala 45:35]
  wire [1:0] _GEN_755 = 2'h2 == _GEN_239 ? _GEN_499 : _GEN_691; // @[BPU.scala 45:35]
  wire [1:0] _GEN_756 = 2'h2 == _GEN_239 ? _GEN_500 : _GEN_692; // @[BPU.scala 45:35]
  wire [1:0] _GEN_757 = 2'h2 == _GEN_239 ? _GEN_501 : _GEN_693; // @[BPU.scala 45:35]
  wire [1:0] _GEN_758 = 2'h2 == _GEN_239 ? _GEN_502 : _GEN_694; // @[BPU.scala 45:35]
  wire [1:0] _GEN_759 = 2'h2 == _GEN_239 ? _GEN_503 : _GEN_695; // @[BPU.scala 45:35]
  wire [1:0] _GEN_760 = 2'h2 == _GEN_239 ? _GEN_504 : _GEN_696; // @[BPU.scala 45:35]
  wire [1:0] _GEN_761 = 2'h2 == _GEN_239 ? _GEN_505 : _GEN_697; // @[BPU.scala 45:35]
  wire [1:0] _GEN_762 = 2'h2 == _GEN_239 ? _GEN_506 : _GEN_698; // @[BPU.scala 45:35]
  wire [1:0] _GEN_763 = 2'h2 == _GEN_239 ? _GEN_507 : _GEN_699; // @[BPU.scala 45:35]
  wire [1:0] _GEN_764 = 2'h2 == _GEN_239 ? _GEN_508 : _GEN_700; // @[BPU.scala 45:35]
  wire [1:0] _GEN_765 = 2'h2 == _GEN_239 ? _GEN_509 : _GEN_701; // @[BPU.scala 45:35]
  wire [1:0] _GEN_766 = 2'h2 == _GEN_239 ? _GEN_510 : _GEN_702; // @[BPU.scala 45:35]
  wire [1:0] _GEN_767 = 2'h2 == _GEN_239 ? _GEN_511 : _GEN_703; // @[BPU.scala 45:35]
  wire [1:0] _GEN_768 = 2'h2 == _GEN_239 ? _GEN_512 : _GEN_704; // @[BPU.scala 45:35]
  wire [1:0] _GEN_769 = 2'h2 == _GEN_239 ? _GEN_513 : _GEN_705; // @[BPU.scala 45:35]
  wire [1:0] _GEN_770 = 2'h2 == _GEN_239 ? _GEN_514 : _GEN_706; // @[BPU.scala 45:35]
  wire [1:0] _GEN_771 = 2'h2 == _GEN_239 ? _GEN_515 : _GEN_707; // @[BPU.scala 45:35]
  wire [1:0] _GEN_772 = 2'h2 == _GEN_239 ? _GEN_516 : _GEN_708; // @[BPU.scala 45:35]
  wire [1:0] _GEN_773 = 2'h2 == _GEN_239 ? _GEN_517 : _GEN_709; // @[BPU.scala 45:35]
  wire [1:0] _GEN_774 = 2'h2 == _GEN_239 ? _GEN_518 : _GEN_710; // @[BPU.scala 45:35]
  wire [1:0] _GEN_775 = 2'h2 == _GEN_239 ? _GEN_519 : _GEN_711; // @[BPU.scala 45:35]
  wire [1:0] _GEN_776 = 2'h2 == _GEN_239 ? _GEN_520 : _GEN_712; // @[BPU.scala 45:35]
  wire [1:0] _GEN_777 = 2'h2 == _GEN_239 ? _GEN_521 : _GEN_713; // @[BPU.scala 45:35]
  wire [1:0] _GEN_778 = 2'h2 == _GEN_239 ? _GEN_522 : _GEN_714; // @[BPU.scala 45:35]
  wire [1:0] _GEN_779 = 2'h2 == _GEN_239 ? _GEN_523 : _GEN_715; // @[BPU.scala 45:35]
  wire [1:0] _GEN_780 = 2'h2 == _GEN_239 ? _GEN_524 : _GEN_716; // @[BPU.scala 45:35]
  wire [1:0] _GEN_781 = 2'h2 == _GEN_239 ? _GEN_525 : _GEN_717; // @[BPU.scala 45:35]
  wire [1:0] _GEN_782 = 2'h2 == _GEN_239 ? _GEN_526 : _GEN_718; // @[BPU.scala 45:35]
  wire [1:0] _GEN_783 = 2'h2 == _GEN_239 ? _GEN_527 : _GEN_719; // @[BPU.scala 45:35]
  wire [1:0] _GEN_784 = 2'h2 == _GEN_239 ? _GEN_528 : _GEN_720; // @[BPU.scala 45:35]
  wire [1:0] _GEN_785 = 2'h2 == _GEN_239 ? _GEN_529 : _GEN_721; // @[BPU.scala 45:35]
  wire [1:0] _GEN_786 = 2'h2 == _GEN_239 ? _GEN_530 : _GEN_722; // @[BPU.scala 45:35]
  wire [1:0] _GEN_787 = 2'h2 == _GEN_239 ? _GEN_531 : _GEN_723; // @[BPU.scala 45:35]
  wire [1:0] _GEN_788 = 2'h2 == _GEN_239 ? _GEN_532 : _GEN_724; // @[BPU.scala 45:35]
  wire [1:0] _GEN_789 = 2'h2 == _GEN_239 ? _GEN_533 : _GEN_725; // @[BPU.scala 45:35]
  wire [1:0] _GEN_790 = 2'h2 == _GEN_239 ? _GEN_534 : _GEN_726; // @[BPU.scala 45:35]
  wire [1:0] _GEN_791 = 2'h2 == _GEN_239 ? _GEN_535 : _GEN_727; // @[BPU.scala 45:35]
  wire [1:0] _GEN_792 = 2'h2 == _GEN_239 ? _GEN_536 : _GEN_728; // @[BPU.scala 45:35]
  wire [1:0] _GEN_793 = 2'h2 == _GEN_239 ? _GEN_537 : _GEN_729; // @[BPU.scala 45:35]
  wire [1:0] _GEN_794 = 2'h2 == _GEN_239 ? _GEN_538 : _GEN_730; // @[BPU.scala 45:35]
  wire [1:0] _GEN_795 = 2'h2 == _GEN_239 ? _GEN_539 : _GEN_731; // @[BPU.scala 45:35]
  wire [1:0] _GEN_796 = 2'h2 == _GEN_239 ? _GEN_540 : _GEN_732; // @[BPU.scala 45:35]
  wire [1:0] _GEN_797 = 2'h2 == _GEN_239 ? _GEN_541 : _GEN_733; // @[BPU.scala 45:35]
  wire [1:0] _GEN_798 = 2'h2 == _GEN_239 ? _GEN_542 : _GEN_734; // @[BPU.scala 45:35]
  wire [1:0] _GEN_799 = 2'h2 == _GEN_239 ? _GEN_543 : _GEN_735; // @[BPU.scala 45:35]
  wire [1:0] _GEN_800 = 2'h2 == _GEN_239 ? _GEN_544 : _GEN_736; // @[BPU.scala 45:35]
  wire [1:0] _GEN_801 = 2'h2 == _GEN_239 ? _GEN_545 : _GEN_737; // @[BPU.scala 45:35]
  wire [1:0] _GEN_802 = 2'h2 == _GEN_239 ? _GEN_546 : _GEN_738; // @[BPU.scala 45:35]
  wire [1:0] _GEN_803 = 2'h2 == _GEN_239 ? _GEN_547 : _GEN_739; // @[BPU.scala 45:35]
  wire [1:0] _GEN_804 = 2'h2 == _GEN_239 ? _GEN_548 : _GEN_740; // @[BPU.scala 45:35]
  wire [1:0] _GEN_805 = 2'h2 == _GEN_239 ? _GEN_549 : _GEN_741; // @[BPU.scala 45:35]
  wire [1:0] _GEN_806 = 2'h2 == _GEN_239 ? _GEN_550 : _GEN_742; // @[BPU.scala 45:35]
  wire [1:0] _GEN_807 = 2'h2 == _GEN_239 ? _GEN_551 : _GEN_743; // @[BPU.scala 45:35]
  wire [1:0] _GEN_808 = 2'h2 == _GEN_239 ? _GEN_552 : _GEN_744; // @[BPU.scala 45:35]
  wire [1:0] _GEN_809 = 2'h2 == _GEN_239 ? _GEN_553 : _GEN_745; // @[BPU.scala 45:35]
  wire [1:0] _GEN_810 = 2'h2 == _GEN_239 ? _GEN_554 : _GEN_746; // @[BPU.scala 45:35]
  wire [1:0] _GEN_811 = 2'h2 == _GEN_239 ? _GEN_555 : _GEN_747; // @[BPU.scala 45:35]
  wire [1:0] _GEN_812 = 2'h2 == _GEN_239 ? _GEN_556 : _GEN_748; // @[BPU.scala 45:35]
  wire [1:0] _GEN_813 = 2'h2 == _GEN_239 ? _GEN_557 : _GEN_749; // @[BPU.scala 45:35]
  wire [1:0] _GEN_814 = 2'h2 == _GEN_239 ? _GEN_558 : _GEN_750; // @[BPU.scala 45:35]
  wire [1:0] _GEN_815 = 2'h2 == _GEN_239 ? _GEN_559 : _GEN_751; // @[BPU.scala 45:35]
  assign io_branchD = io_instrD[31:26] == 6'h1 & io_instrD[19:17] == 3'h0 | io_instrD[31:28] == 4'h1; // @[BPU.scala 22:74]
  assign io_pred_takeD = io_enaD & io_branchD & (_GEN_79 == 2'h2 | _GEN_79 == 2'h3); // @[BPU.scala 37:42]
  assign io_branch_targetD = io_pc_plus4D + _io_branch_targetD_T_4; // @[BPU.scala 23:37]
  always @(posedge clock) begin
    if (reset) begin // @[BPU.scala 31:26]
      BHT_0 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'h0 == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_0 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_1 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'h1 == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_1 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_2 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'h2 == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_2 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_3 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'h3 == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_3 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_4 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'h4 == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_4 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_5 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'h5 == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_5 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_6 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'h6 == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_6 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_7 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'h7 == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_7 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_8 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'h8 == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_8 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_9 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'h9 == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_9 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_10 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'ha == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_10 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_11 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'hb == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_11 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_12 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'hc == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_12 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_13 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'hd == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_13 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_14 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'he == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_14 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 31:26]
      BHT_15 <= 6'h0; // @[BPU.scala 31:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (4'hf == update_BHT_index) begin // @[BPU.scala 44:27]
        BHT_15 <= _BHT_T_1; // @[BPU.scala 44:27]
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_0 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h0 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_0 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_0 <= _GEN_368;
      end else begin
        PHT_0 <= _GEN_752;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_1 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h1 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_1 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_1 <= _GEN_369;
      end else begin
        PHT_1 <= _GEN_753;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_2 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h2 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_2 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_2 <= _GEN_370;
      end else begin
        PHT_2 <= _GEN_754;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_3 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h3 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_3 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_3 <= _GEN_371;
      end else begin
        PHT_3 <= _GEN_755;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_4 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h4 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_4 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_4 <= _GEN_372;
      end else begin
        PHT_4 <= _GEN_756;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_5 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h5 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_5 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_5 <= _GEN_373;
      end else begin
        PHT_5 <= _GEN_757;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_6 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h6 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_6 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_6 <= _GEN_374;
      end else begin
        PHT_6 <= _GEN_758;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_7 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h7 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_7 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_7 <= _GEN_375;
      end else begin
        PHT_7 <= _GEN_759;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_8 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h8 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_8 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_8 <= _GEN_376;
      end else begin
        PHT_8 <= _GEN_760;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_9 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h9 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_9 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_9 <= _GEN_377;
      end else begin
        PHT_9 <= _GEN_761;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_10 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'ha == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_10 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_10 <= _GEN_378;
      end else begin
        PHT_10 <= _GEN_762;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_11 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'hb == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_11 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_11 <= _GEN_379;
      end else begin
        PHT_11 <= _GEN_763;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_12 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'hc == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_12 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_12 <= _GEN_380;
      end else begin
        PHT_12 <= _GEN_764;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_13 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'hd == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_13 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_13 <= _GEN_381;
      end else begin
        PHT_13 <= _GEN_765;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_14 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'he == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_14 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_14 <= _GEN_382;
      end else begin
        PHT_14 <= _GEN_766;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_15 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'hf == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_15 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_15 <= _GEN_383;
      end else begin
        PHT_15 <= _GEN_767;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_16 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h10 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_16 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_16 <= _GEN_384;
      end else begin
        PHT_16 <= _GEN_768;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_17 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h11 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_17 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_17 <= _GEN_385;
      end else begin
        PHT_17 <= _GEN_769;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_18 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h12 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_18 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_18 <= _GEN_386;
      end else begin
        PHT_18 <= _GEN_770;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_19 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h13 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_19 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_19 <= _GEN_387;
      end else begin
        PHT_19 <= _GEN_771;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_20 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h14 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_20 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_20 <= _GEN_388;
      end else begin
        PHT_20 <= _GEN_772;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_21 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h15 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_21 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_21 <= _GEN_389;
      end else begin
        PHT_21 <= _GEN_773;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_22 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h16 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_22 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_22 <= _GEN_390;
      end else begin
        PHT_22 <= _GEN_774;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_23 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h17 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_23 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_23 <= _GEN_391;
      end else begin
        PHT_23 <= _GEN_775;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_24 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h18 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_24 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_24 <= _GEN_392;
      end else begin
        PHT_24 <= _GEN_776;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_25 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h19 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_25 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_25 <= _GEN_393;
      end else begin
        PHT_25 <= _GEN_777;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_26 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h1a == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_26 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_26 <= _GEN_394;
      end else begin
        PHT_26 <= _GEN_778;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_27 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h1b == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_27 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_27 <= _GEN_395;
      end else begin
        PHT_27 <= _GEN_779;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_28 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h1c == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_28 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_28 <= _GEN_396;
      end else begin
        PHT_28 <= _GEN_780;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_29 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h1d == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_29 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_29 <= _GEN_397;
      end else begin
        PHT_29 <= _GEN_781;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_30 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h1e == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_30 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_30 <= _GEN_398;
      end else begin
        PHT_30 <= _GEN_782;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_31 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h1f == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_31 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_31 <= _GEN_399;
      end else begin
        PHT_31 <= _GEN_783;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_32 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h20 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_32 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_32 <= _GEN_400;
      end else begin
        PHT_32 <= _GEN_784;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_33 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h21 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_33 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_33 <= _GEN_401;
      end else begin
        PHT_33 <= _GEN_785;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_34 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h22 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_34 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_34 <= _GEN_402;
      end else begin
        PHT_34 <= _GEN_786;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_35 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h23 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_35 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_35 <= _GEN_403;
      end else begin
        PHT_35 <= _GEN_787;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_36 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h24 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_36 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_36 <= _GEN_404;
      end else begin
        PHT_36 <= _GEN_788;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_37 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h25 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_37 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_37 <= _GEN_405;
      end else begin
        PHT_37 <= _GEN_789;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_38 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h26 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_38 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_38 <= _GEN_406;
      end else begin
        PHT_38 <= _GEN_790;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_39 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h27 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_39 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_39 <= _GEN_407;
      end else begin
        PHT_39 <= _GEN_791;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_40 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h28 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_40 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_40 <= _GEN_408;
      end else begin
        PHT_40 <= _GEN_792;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_41 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h29 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_41 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_41 <= _GEN_409;
      end else begin
        PHT_41 <= _GEN_793;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_42 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h2a == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_42 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_42 <= _GEN_410;
      end else begin
        PHT_42 <= _GEN_794;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_43 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h2b == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_43 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_43 <= _GEN_411;
      end else begin
        PHT_43 <= _GEN_795;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_44 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h2c == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_44 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_44 <= _GEN_412;
      end else begin
        PHT_44 <= _GEN_796;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_45 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h2d == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_45 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_45 <= _GEN_413;
      end else begin
        PHT_45 <= _GEN_797;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_46 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h2e == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_46 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_46 <= _GEN_414;
      end else begin
        PHT_46 <= _GEN_798;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_47 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h2f == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_47 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_47 <= _GEN_415;
      end else begin
        PHT_47 <= _GEN_799;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_48 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h30 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_48 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_48 <= _GEN_416;
      end else begin
        PHT_48 <= _GEN_800;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_49 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h31 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_49 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_49 <= _GEN_417;
      end else begin
        PHT_49 <= _GEN_801;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_50 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h32 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_50 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_50 <= _GEN_418;
      end else begin
        PHT_50 <= _GEN_802;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_51 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h33 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_51 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_51 <= _GEN_419;
      end else begin
        PHT_51 <= _GEN_803;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_52 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h34 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_52 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_52 <= _GEN_420;
      end else begin
        PHT_52 <= _GEN_804;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_53 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h35 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_53 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_53 <= _GEN_421;
      end else begin
        PHT_53 <= _GEN_805;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_54 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h36 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_54 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_54 <= _GEN_422;
      end else begin
        PHT_54 <= _GEN_806;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_55 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h37 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_55 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_55 <= _GEN_423;
      end else begin
        PHT_55 <= _GEN_807;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_56 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h38 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_56 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_56 <= _GEN_424;
      end else begin
        PHT_56 <= _GEN_808;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_57 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h39 == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_57 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_57 <= _GEN_425;
      end else begin
        PHT_57 <= _GEN_809;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_58 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h3a == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_58 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_58 <= _GEN_426;
      end else begin
        PHT_58 <= _GEN_810;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_59 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h3b == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_59 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_59 <= _GEN_427;
      end else begin
        PHT_59 <= _GEN_811;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_60 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h3c == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_60 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_60 <= _GEN_428;
      end else begin
        PHT_60 <= _GEN_812;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_61 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h3d == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_61 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_61 <= _GEN_429;
      end else begin
        PHT_61 <= _GEN_813;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_62 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h3e == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_62 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_62 <= _GEN_430;
      end else begin
        PHT_62 <= _GEN_814;
      end
    end
    if (reset) begin // @[BPU.scala 32:26]
      PHT_63 <= 2'h0; // @[BPU.scala 32:26]
    end else if (io_branchE) begin // @[BPU.scala 43:20]
      if (2'h0 == _GEN_239) begin // @[BPU.scala 45:35]
        if (6'h3f == _GEN_159) begin // @[BPU.scala 47:31]
          PHT_63 <= _PHT_T; // @[BPU.scala 47:31]
        end
      end else if (2'h1 == _GEN_239) begin // @[BPU.scala 45:35]
        PHT_63 <= _GEN_431;
      end else begin
        PHT_63 <= _GEN_815;
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
