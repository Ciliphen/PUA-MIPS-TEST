`timescale 1ns / 1ps

module mycpu_top (
    input wire aclk,
    input wire aresetn,

    input [5:0] ext_int,            //interrupt

    output wire[3:0] arid,
    output wire[31:0] araddr,
    output wire[7:0] arlen,
    output wire[2:0] arsize,
    output wire[1:0] arburst,
    output wire[1:0] arlock,
    output wire[3:0] arcache,
    output wire[2:0] arprot,
    output wire arvalid,
    input wire arready,
                
    input wire[3:0] rid,
    input wire[31:0] rdata,
    input wire[1:0] rresp,
    input wire rlast,
    input wire rvalid,
    output wire rready,
               
    output wire[3:0] awid,
    output wire[31:0] awaddr,
    output wire[7:0] awlen,
    output wire[2:0] awsize,
    output wire[1:0] awburst,
    output wire[1:0] awlock,
    output wire[3:0] awcache,
    output wire[2:0] awprot,
    output wire awvalid,
    input wire awready,
    
    output wire[3:0] wid,
    output wire[31:0] wdata,
    output wire[3:0] wstrb,
    output wire wlast,
    output wire wvalid,
    input wire wready,
    
    input wire[3:0] bid,
    input wire[1:0] bresp,
    input bvalid,
    output bready,

    //debug interface
    output wire[31:0] debug_wb_pc,
    output wire[3:0] debug_wb_rf_wen,
    output wire[4:0] debug_wb_rf_wnum,
    output wire[31:0] debug_wb_rf_wdata,
    // soc-simulator + cemu debug interface
    output wire [31:0] debug_cp0_count,
    output wire [31:0] debug_cp0_random,
    output wire [31:0] debug_cp0_cause,
    output wire debug_int,
    output wire debug_commit
);
    wire clk, rst;
    assign clk = aclk; // assign clk = aclk;
    assign rst = ~aresetn;

    //d_tlb - d_cache
    wire no_cache_d         ;   //数据
    wire no_cache_i         ;   //指令

    //datapath - cache
    wire inst_en            ;
    wire [31:0] pcF         ;
    wire [31:0] pcF_dp     ;
    wire [31:0] pc_next     ;
    wire [31:0] pc_next_dp ;
    wire i_cache_stall      ;
    wire stallF             ;
    wire stallM             ;
    wire inst_data_ok1      ;
    wire inst_data_ok2      ;
    wire inst_tlb_refill    ;
    wire inst_tlb_invalid   ;
    wire [31:0] inst_rdata1 ;
    wire [31:0] inst_rdata2 ;
    wire        fence_iE;
    wire [31:0] fence_addrE;
    wire        fence_dM;
    wire [31:0] fence_addrM;
    wire        fence_tlbE;
    wire [31:13]itlb_vpn2;
    wire        itlb_found;
    tlb_entry   itlb_entry;

    wire data_en            ;
    wire [31:0] data_addr   ;
    wire [31:0] data_addr_dp;
    wire [31:0] data_rdata  ;
    wire [ 1:0] data_rlen   ;
    wire [3:0] data_wen     ;
    wire [31:0] data_wdata  ;
    wire d_cache_stall      ;
    wire [31:0] mem_addrE   ;
    wire [31:0] mem_addrE_dp;
    wire mem_read_enE       ;
    wire mem_write_enE      ;

    //i_cache - arbitrater
    wire [31:0] i_araddr    ;
    wire [7:0] i_arlen      ;
    wire [2:0] i_arsize     ;
    wire i_arvalid          ;
    wire i_arready          ;

    wire [31:0] i_rdata     ;
    wire i_rlast            ;
    wire i_rvalid           ;
    wire i_rready           ;

    //d_cache - arbitrater
    wire [31:0] d_araddr    ;
    wire [7:0] d_arlen      ;
    wire [2:0] d_arsize     ;
    wire d_arvalid          ;
    wire d_arready          ;

    wire[31:0] d_rdata      ;
    wire d_rlast            ;
    wire d_rvalid           ;
    wire d_rready           ;

    wire [31:0] d_awaddr    ;
    wire [7:0] d_awlen      ;
    wire [2:0] d_awsize     ;
    wire d_awvalid          ;
    wire d_awready          ;

    wire [31:0] d_wdata     ;
    wire [3:0] d_wstrb      ;
    wire d_wlast            ;
    wire d_wvalid           ;
    wire d_wready           ;

    wire d_bvalid           ;
    wire d_bready           ;

    wire [31:13]    dtlb_vpn2;
    wire            dtlb_found;
    tlb_entry       dtlb_entry;
    wire            fence_tlbM;

    wire            data_tlb_refill;
    wire            data_tlb_invalid;
    wire            data_tlb_mod;

    wire no_cache_E         ;
    datapath u_datapath(
        //ports
        .clk               		( clk               		),
        .rst               		( rst               		),
        .ext_int           		( ext_int           		),
        // inst
        .i_stall           		( i_cache_stall        		),
        .stallF            		( stallF            		),
        .inst_sram_en      		( inst_en            		),
        .F_pc              		( pcF_dp              		),
        .F_pc_next         		( pc_next_dp         		),
        .inst_data_ok1     		( inst_data_ok1     		),
        .inst_data_ok2     		( inst_data_ok2     		),
        .inst_tlb_refill        ( inst_tlb_refill           ),
        .inst_tlb_invalid       ( inst_tlb_invalid          ),
        .inst_rdata1       		( inst_rdata1       		),
        .inst_rdata2       		( inst_rdata2       		),
        .fence_iE               ( fence_iE                  ),
        .fence_addrE            ( fence_addrE               ),
        .fence_dM               ( fence_dM                  ),
        .fence_addrM            ( fence_addrM               ),
        .fence_tlbE             ( fence_tlbE                ),
        .itlb_vpn2              ( itlb_vpn2                 ),
        .itlb_found             ( itlb_found                ),
        .itlb_entry             ( itlb_entry                ),
        // data
        .d_stall           		( d_cache_stall           	),
        .stallM            		( stallM            		),
        .mem_read_enE      		( mem_read_enE      		),
        .mem_write_enE     		( mem_write_enE     		),
        .E_mem_va               ( mem_addrE                 ),
        .mem_addrE         		( mem_addrE_dp      		), // TODO: delete
        .data_sram_enM     		( data_en           		),
        .data_sram_rdataM  		( data_rdata          		),
        .data_sram_rlenM   		( data_rlen           		),
        .data_sram_wenM    		( data_wen             		),
        .M_mem_va               ( data_addr                 ),
        .data_sram_addrM   		( data_addr_dp         		), // TODO: delete
        .data_sram_wdataM  		( data_wdata          		),
        .dtlb_vpn2              ( dtlb_vpn2                 ),
        .dtlb_found             ( dtlb_found                ),
        .dtlb_entry             ( dtlb_entry                ),
        .fence_tlbM             ( fence_tlbM                ),
        .data_tlb_refill        ( data_tlb_refill           ),
        .data_tlb_invalid       ( data_tlb_invalid          ),
        .data_tlb_mod           ( data_tlb_mod              ),
        // debug
        .debug_wb_pc       		( debug_wb_pc       		),
        .debug_wb_rf_wen   		( debug_wb_rf_wen   		),
        .debug_wb_rf_wnum  		( debug_wb_rf_wnum  		),
        .debug_wb_rf_wdata 		( debug_wb_rf_wdata 		),
        .debug_cp0_count        ( debug_cp0_count           ),
        .debug_cp0_random       ( debug_cp0_random          ),
        .debug_cp0_cause        ( debug_cp0_cause           ),
        .debug_int              ( debug_int                 ),
        .debug_commit           ( debug_commit              )
    );

    Cache u_cache (
        .clock                ( clk           ),
        .reset                ( rst           ),
        .io_inst_req            ( inst_en       ),
        .io_inst_addr_0            ( pcF_dp        ),
        .io_inst_addr_1       ( pc_next_dp    ),
        .io_inst_inst_0        ( inst_rdata1   ),
        .io_inst_inst_1        ( inst_rdata2   ),
        .io_inst_inst_valid_0           ( inst_data_ok1 ),
        .io_inst_inst_valid_1           ( inst_data_ok2 ),
        .io_inst_tlb1_refill    (inst_tlb_refill  ),
        .io_inst_tlb1_invalid   (inst_tlb_invalid ),
        .io_inst_cpu_stall             ( stallF        ),
        .io_inst_icache_stall             ( i_cache_stall ),
        .io_inst_fence_value            ( fence_iE      ),
        .io_inst_fence_addr         ( fence_addrE   ),
        .io_inst_fence_tlb          ( fence_tlbE    ),
        .io_inst_tlb2_vpn          ( itlb_vpn2     ),
        .io_inst_tlb2_found         ( itlb_found    ),
        .io_inst_tlb2_entry_G    (itlb_entry.G   ),
        .io_inst_tlb2_entry_V0   (itlb_entry.V0  ),
        .io_inst_tlb2_entry_V1   (itlb_entry.V1  ),
        .io_inst_tlb2_entry_D0   (itlb_entry.D0  ),
        .io_inst_tlb2_entry_D1   (itlb_entry.D1  ),
        .io_inst_tlb2_entry_C0   (itlb_entry.C0  ),
        .io_inst_tlb2_entry_C1   (itlb_entry.C1  ),
        .io_inst_tlb2_entry_PFN0 (itlb_entry.PFN0),
        .io_inst_tlb2_entry_PFN1 (itlb_entry.PFN1),
        .io_inst_tlb2_entry_VPN2 (itlb_entry.VPN2),
        .io_inst_tlb2_entry_ASID (itlb_entry.ASID),

        .io_data_stallM             ( stallM        ),
        .io_data_dstall             ( d_cache_stall ),
        .io_data_E_mem_va           ( mem_addrE     ), // only used for match bram
        .io_data_M_mem_va           ( data_addr     ),
        .io_data_M_fence_addr       ( fence_addrM   ), // used for fence
        .io_data_M_fence_d          ( fence_dM      ), // fence address reuse the M_memva. Note: we shouldn't raise M_fence_en with M_mem_en.
        .io_data_M_mem_en           ( data_en       ),
        .io_data_M_mem_write        ( |data_wen     ),
        .io_data_M_wmask            ( data_wen      ),
        .io_data_M_mem_size         ( data_rlen     ),
        .io_data_M_wdata            ( data_wdata    ),
        .io_data_M_rdata            ( data_rdata    ),
        .io_data_tlb_vpn2          ( dtlb_vpn2     ),
        .io_data_tlb_found         ( dtlb_found    ),
        .io_data_tlb_entry_G         (dtlb_entry.G   ),
        .io_data_tlb_entry_V0        (dtlb_entry.V0  ),
        .io_data_tlb_entry_V1        (dtlb_entry.V1  ),
        .io_data_tlb_entry_D0        (dtlb_entry.D0  ),
        .io_data_tlb_entry_D1        (dtlb_entry.D1  ),
        .io_data_tlb_entry_C0        (dtlb_entry.C0  ),
        .io_data_tlb_entry_C1        (dtlb_entry.C1  ),
        .io_data_tlb_entry_PFN0      (dtlb_entry.PFN0),
        .io_data_tlb_entry_PFN1      (dtlb_entry.PFN1),
        .io_data_tlb_entry_VPN2      (dtlb_entry.VPN2),
        .io_data_tlb_entry_ASID      (dtlb_entry.ASID),
        .io_data_fence_tlb          ( fence_tlbM    ),
        .io_data_data_tlb_refill    ( data_tlb_refill),
        .io_data_data_tlb_invalid   ( data_tlb_invalid),
        .io_data_data_tlb_mod       ( data_tlb_mod  ),
        
        .io_axi_ar_bits_id            (arid   ),
        .io_axi_ar_bits_addr          (araddr ),
        .io_axi_ar_bits_len           (arlen  ),
        .io_axi_ar_bits_size          (arsize ),
        .io_axi_ar_bits_burst         (arburst),
        .io_axi_ar_bits_lock          (arlock ),
        .io_axi_ar_bits_cache         (arcache),
        .io_axi_ar_bits_prot          (arprot ),
        .io_axi_ar_valid         (arvalid),
        .io_axi_ar_ready         (arready),

        .io_axi_r_bits_id             (rid   ),
        .io_axi_r_bits_data           (rdata ),
        .io_axi_r_bits_resp           (rresp ),
        .io_axi_r_bits_last           (rlast ),
        .io_axi_r_valid          (rvalid),
        .io_axi_r_ready          (rready),

        .io_axi_aw_bits_id            (awid   ),
        .io_axi_aw_bits_addr          (awaddr ),
        .io_axi_aw_bits_len           (awlen  ),
        .io_axi_aw_bits_size          (awsize ),
        .io_axi_aw_bits_burst         (awburst),
        .io_axi_aw_bits_lock          (awlock ),
        .io_axi_aw_bits_cache         (awcache),
        .io_axi_aw_bits_prot          (awprot ),
        .io_axi_aw_valid         (awvalid),
        .io_axi_aw_ready         (awready),
        
        .io_axi_w_bits_id             (wid   ),
        .io_axi_w_bits_data           (wdata ),
        .io_axi_w_bits_strb           (wstrb ),
        .io_axi_w_bits_last           (wlast ),
        .io_axi_w_valid          (wvalid),
        .io_axi_w_ready          (wready),

        .io_axi_b_bits_id             (bid   ),
        .io_axi_b_bits_resp           (bresp ),
        .io_axi_b_valid          (bvalid),
        .io_axi_b_ready          (bready)
    );
    
    // d_cache d_cache_inst (
    //     .clk                ( clk           ),
    //     .rst                ( rst           ),
    //     .stallM             ( stallM        ),
    //     .dstall             ( d_cache_stall ),
    //     .E_mem_va           ( mem_addrE     ), // only used for match bram
    //     .M_mem_va           ( data_addr     ),
    //     .M_fence_addr       ( fence_addrM   ), // used for fence
    //     .M_fence_d          ( fence_dM      ), // fence address reuse the M_memva. Note: we shouldn't raise M_fence_en with M_mem_en.
    //     .M_mem_en           ( data_en       ),
    //     .M_mem_write        ( |data_wen     ),
    //     .M_wmask            ( data_wen      ),
    //     .M_mem_size         ( data_rlen     ),
    //     .M_wdata            ( data_wdata    ),
    //     .M_rdata            ( data_rdata    ),
    //     .dtlb_vpn2          ( dtlb_vpn2     ),
    //     .dtlb_found         ( dtlb_found    ),
    //     .dtlb_entry         ( dtlb_entry    ),
    //     .fence_tlb          ( fence_tlbM    ),
    //     .data_tlb_refill    ( data_tlb_refill),
    //     .data_tlb_invalid   ( data_tlb_invalid),
    //     .data_tlb_mod       ( data_tlb_mod  ),
    //     .araddr             ( d_araddr      ),
    //     .arlen              ( d_arlen       ),
    //     .arsize             ( d_arsize      ),
    //     .arvalid            ( d_arvalid     ),
    //     .arready            ( d_arready     ),
    //     .rdata              ( d_rdata       ),
    //     .rlast              ( d_rlast       ),
    //     .rvalid             ( d_rvalid      ),
    //     .rready             ( d_rready      ),
    //     .awaddr             ( d_awaddr      ),
    //     .awlen              ( d_awlen       ),
    //     .awsize             ( d_awsize      ),
    //     .awvalid            ( d_awvalid     ),
    //     .awready            ( d_awready     ),
    //     .wdata              ( d_wdata       ),
    //     .wstrb              ( d_wstrb       ),
    //     .wlast              ( d_wlast       ),
    //     .wvalid             ( d_wvalid      ),
    //     .wready             ( d_wready      ),
    //     .bvalid             ( d_bvalid      ),
    //     .bready             ( d_bready      )
    // );

    // ICache i_cache_inst (
    //     .clock                ( clk           ),
    //     .reset                ( rst           ),
    //     .io_cpu_req            ( inst_en       ),
    //     .io_cpu_addr_0            ( pcF_dp        ),
    //     .io_cpu_addr_1       ( pc_next_dp    ),
    //     .io_cpu_inst_0        ( inst_rdata1   ),
    //     .io_cpu_inst_1        ( inst_rdata2   ),
    //     .io_cpu_inst_valid_0           ( inst_data_ok1 ),
    //     .io_cpu_inst_valid_1           ( inst_data_ok2 ),
    //     .io_cpu_tlb1_refill    (inst_tlb_refill  ),
    //     .io_cpu_tlb1_invalid   (inst_tlb_invalid ),
    //     .io_cpu_cpu_stall             ( stallF        ),
    //     .io_cpu_icache_stall             ( i_cache_stall ),
    //     .io_cpu_fence_value            ( fence_iE      ),
    //     .io_cpu_fence_addr         ( fence_addrE   ),
    //     .io_cpu_fence_tlb          ( fence_tlbE    ),
    //     .io_cpu_tlb2_vpn          ( itlb_vpn2     ),
    //     .io_cpu_tlb2_found         ( itlb_found    ),
    //     .io_cpu_tlb2_entry_G    (itlb_entry.G   ),
    //     .io_cpu_tlb2_entry_V0   (itlb_entry.V0  ),
    //     .io_cpu_tlb2_entry_V1   (itlb_entry.V1  ),
    //     .io_cpu_tlb2_entry_D0   (itlb_entry.D0  ),
    //     .io_cpu_tlb2_entry_D1   (itlb_entry.D1  ),
    //     .io_cpu_tlb2_entry_C0   (itlb_entry.C0  ),
    //     .io_cpu_tlb2_entry_C1   (itlb_entry.C1  ),
    //     .io_cpu_tlb2_entry_PFN0 (itlb_entry.PFN0),
    //     .io_cpu_tlb2_entry_PFN1 (itlb_entry.PFN1),
    //     .io_cpu_tlb2_entry_VPN2 (itlb_entry.VPN2),
    //     .io_cpu_tlb2_entry_ASID (itlb_entry.ASID),
    //     .io_axi_ar_bits_addr             ( i_araddr      ),
    //     .io_axi_ar_bits_len              ( i_arlen       ),
    //     .io_axi_ar_bits_size             ( i_arsize      ),
    //     .io_axi_ar_valid            ( i_arvalid     ),
    //     .io_axi_ar_ready            ( i_arready     ),
    //     .io_axi_r_bits_data              ( i_rdata       ),
    //     .io_axi_r_bits_last              ( i_rlast       ),
    //     .io_axi_r_valid             ( i_rvalid      ),
    //     .io_axi_r_ready             ( i_rready      )
    // );

    // CacheAXIInterface u_arbitrater(
    //     .clock(clk), 
    //     .reset(rst),
    // //I CACHE
    //     .io_icache_ar_bits_addr          (i_araddr ),
    //     .io_icache_ar_bits_len           (i_arlen  ),
    //     .io_icache_ar_bits_size          (i_arsize ),
    //     .io_icache_ar_valid         (i_arvalid),
    //     .io_icache_ar_ready         (i_arready),
                  
    //     .io_icache_r_bits_data           (i_rdata ),
    //     .io_icache_r_bits_last           (i_rlast ),
    //     .io_icache_r_valid          (i_rvalid),
    //     .io_icache_r_ready          (i_rready),
        
    // //D CACHE
    //     .io_dcache_ar_bits_addr          (d_araddr ),
    //     .io_dcache_ar_bits_len           (d_arlen  ),
    //     .io_dcache_ar_bits_size          (d_arsize ),
    //     .io_dcache_ar_valid         (d_arvalid),
    //     .io_dcache_ar_ready         (d_arready),

    //     .io_dcache_r_bits_data           (d_rdata ),
    //     .io_dcache_r_bits_last           (d_rlast ),
    //     .io_dcache_r_valid          (d_rvalid),
    //     .io_dcache_r_ready          (d_rready),

    //     .io_dcache_aw_bits_addr          (d_awaddr ),
    //     .io_dcache_aw_bits_len           (d_awlen  ),
    //     .io_dcache_aw_bits_size          (d_awsize ),
    //     .io_dcache_aw_valid         (d_awvalid),
    //     .io_dcache_aw_ready         (d_awready),

    //     .io_dcache_w_bits_data           (d_wdata ),
    //     .io_dcache_w_bits_strb           (d_wstrb ),
    //     .io_dcache_w_bits_last           (d_wlast ),
    //     .io_dcache_w_valid          (d_wvalid),
    //     .io_dcache_w_ready          (d_wready),

    //     .io_dcache_b_valid          (d_bvalid),
    //     .io_dcache_b_ready          (d_bready),
    // //Outer
    //     .io_axi_ar_bits_id            (arid   ),
    //     .io_axi_ar_bits_addr          (araddr ),
    //     .io_axi_ar_bits_len           (arlen  ),
    //     .io_axi_ar_bits_size          (arsize ),
    //     .io_axi_ar_bits_burst         (arburst),
    //     .io_axi_ar_bits_lock          (arlock ),
    //     .io_axi_ar_bits_cache         (arcache),
    //     .io_axi_ar_bits_prot          (arprot ),
    //     .io_axi_ar_valid         (arvalid),
    //     .io_axi_ar_ready         (arready),

    //     .io_axi_r_bits_id             (rid   ),
    //     .io_axi_r_bits_data           (rdata ),
    //     .io_axi_r_bits_resp           (rresp ),
    //     .io_axi_r_bits_last           (rlast ),
    //     .io_axi_r_valid          (rvalid),
    //     .io_axi_r_ready          (rready),

    //     .io_axi_aw_bits_id            (awid   ),
    //     .io_axi_aw_bits_addr          (awaddr ),
    //     .io_axi_aw_bits_len           (awlen  ),
    //     .io_axi_aw_bits_size          (awsize ),
    //     .io_axi_aw_bits_burst         (awburst),
    //     .io_axi_aw_bits_lock          (awlock ),
    //     .io_axi_aw_bits_cache         (awcache),
    //     .io_axi_aw_bits_prot          (awprot ),
    //     .io_axi_aw_valid         (awvalid),
    //     .io_axi_aw_ready         (awready),
        
    //     .io_axi_w_bits_id             (wid   ),
    //     .io_axi_w_bits_data           (wdata ),
    //     .io_axi_w_bits_strb           (wstrb ),
    //     .io_axi_w_bits_last           (wlast ),
    //     .io_axi_w_valid          (wvalid),
    //     .io_axi_w_ready          (wready),

    //     .io_axi_b_bits_id             (bid   ),
    //     .io_axi_b_bits_resp           (bresp ),
    //     .io_axi_b_valid          (bvalid),
    //     .io_axi_b_ready          (bready)
    // );
endmodule