module top  #(
`include "hazard3_config.vh"
) ();
  
   
  reg clk=0;
   reg rst=1;


   always clk = #10 ~clk;


  initial begin     
     $dumpvars(0);
     repeat(10) @(posedge clk) rst <= 1'b0;
     repeat(5) @(posedge clk) rst <= 1'b1;
     

    repeat(1000) @(posedge clk);
     $display("END");
     
    $finish;
   end


 hazard3_cpu_1port 
   #(
	// These must have the values given here for you to end up with a useful SoC:
	.RESET_VECTOR    (32'h0000_0040),
	.MTVEC_INIT      (32'h0000_0000),
	.CSR_M_MANDATORY (1),
	.CSR_M_TRAP      (1),
	.DEBUG_SUPPORT   (1),
	.NUM_IRQS        (1),
	.RESET_REGFILE   (0),
	// Can be overridden from the defaults in hazard3_config.vh during
	// instantiation of example_soc():
	.EXTENSION_A         (EXTENSION_A),
	.EXTENSION_C         (EXTENSION_C),
	.EXTENSION_M         (EXTENSION_M),
	.EXTENSION_ZBA       (EXTENSION_ZBA),
	.EXTENSION_ZBB       (EXTENSION_ZBB),
	.EXTENSION_ZBC       (EXTENSION_ZBC),
	.EXTENSION_ZBS       (EXTENSION_ZBS),
	.EXTENSION_ZBKB      (EXTENSION_ZBKB),
	.EXTENSION_ZIFENCEI  (EXTENSION_ZIFENCEI),
	.EXTENSION_XH3BEXTM  (EXTENSION_XH3BEXTM),
	.EXTENSION_XH3IRQ    (EXTENSION_XH3IRQ),
	.EXTENSION_XH3PMPM   (EXTENSION_XH3PMPM),
	.EXTENSION_XH3POWER  (EXTENSION_XH3POWER),
	.CSR_COUNTER         (CSR_COUNTER),
	.U_MODE              (U_MODE),
	.PMP_REGIONS         (PMP_REGIONS),
	.PMP_GRAIN           (PMP_GRAIN),
	.PMP_HARDWIRED       (PMP_HARDWIRED),
	.PMP_HARDWIRED_ADDR  (PMP_HARDWIRED_ADDR),
	.PMP_HARDWIRED_CFG   (PMP_HARDWIRED_CFG),
	.MVENDORID_VAL       (MVENDORID_VAL),
	.BREAKPOINT_TRIGGERS (BREAKPOINT_TRIGGERS),
	.IRQ_PRIORITY_BITS   (IRQ_PRIORITY_BITS),
	.MIMPID_VAL          (MIMPID_VAL),
	.MHARTID_VAL         (MHARTID_VAL),
	.REDUCED_BYPASS      (REDUCED_BYPASS),
	.MULDIV_UNROLL       (MULDIV_UNROLL),
	.MUL_FAST            (MUL_FAST),
	.MUL_FASTER          (MUL_FASTER),
	.MULH_FAST           (MULH_FAST),
	.FAST_BRANCHCMP      (FAST_BRANCHCMP),
	.BRANCH_PREDICTOR    (BRANCH_PREDICTOR),
	.MTVEC_WMASK         (MTVEC_WMASK)
     )
   u_hazard3_cpu_1port 
  (
	// Global signals
    .clk(clk),
    .clk_always_on(clk),
    .rst_n(rst),

	`ifdef RISCV_FORMAL
	`RVFI_OUTPUTS ,
	`endif

    // Power control signals
    .pwrup_req(),
    .pwrup_ack(1'b1),
    .clk_en(),
    .unblock_out(),
    .unblock_in(),
    
    // AHB5 Master port
    .haddr           (),//output reg  [W_ADDR-1:0]  haddr,
    .hwrite          (),//output reg                hwrite,
    .htrans          (),//output reg  [1:0]         htrans,
    .hsize           (),//output reg  [2:0]         hsize,
    .hburst          (),//output wire [2:0]         hburst,
    .hprot           (),//output reg  [3:0]         hprot,
    .hmastlock       (),//output wire               hmastlock,
    .hmaster         (),//output reg  [7:0]         hmaster,
    .hexcl           (),//output reg                hexcl,
    .hready          (1'b1),//input  wire               hready,
    .hresp           (1'b0),//input  wire               hresp,
    .hexokay         (1'b1), //input  wire               hexokay,
    .hwdata          (),//output wire [W_DATA-1:0]  hwdata,
    .hrdata          (32'h0),//input  wire [W_DATA-1:0]  hrdata,
    
    // Debugger run/halt control
    .dbg_req_halt( 1'b0  ), //input  wire               dbg_req_halt,
    .dbg_req_halt_on_reset( rst  ), //input  wire               dbg_req_halt_on_reset,/
    .dbg_req_resume( 1'b0 ),//input  wire               dbg_req_resume,
    .dbg_halted(), //output wire               dbg_halted,
    .dbg_running(  ), //output wire               dbg_running,
    // Debugger access to data0 CSR
    .dbg_data0_rdata( {W_DATA{1'b0}} ), //input  wire [W_DATA-1:0]  dbg_data0_rdata,
    .dbg_data0_wdata(),//output wire [W_DATA-1:0]  dbg_data0_wdata,
    .dbg_data0_wen(), //output wire               dbg_data0_wen,
    // Debugger instruction injection
    .dbg_instr_data( {W_DATA{1'b0}} ),//input  wire [W_DATA-1:0]  dbg_instr_data,
    .dbg_instr_data_vld( 1'b0 ),//input  wire               dbg_instr_data_vld,
    .dbg_instr_data_rdy( ),//output wire               dbg_instr_data_rdy,
    .dbg_instr_caught_exception(),//output wire               dbg_instr_caught_exception,
    .dbg_instr_caught_ebreak(),//output wire               dbg_instr_caught_ebreak,
    
    // Optional debug system bus access patch-through
    .dbg_sbus_addr( {W_ADDR{1'b0}} ),//input  wire [W_ADDR-1:0]  dbg_sbus_addr,
    .dbg_sbus_write( 1'b0 ),//input  wire               dbg_sbus_write,
    .dbg_sbus_size( 2'b00 ),//input  wire [1:0]         dbg_sbus_size,
    .dbg_sbus_vld( 1'b0 ),//input  wire               dbg_sbus_vld,
    .dbg_sbus_rdy(),//output wire               dbg_sbus_rdy,
    .dbg_sbus_err(),//output wire               dbg_sbus_err,
    .dbg_sbus_wdata( {W_DATA{1'b0}} ),//input  wire [W_DATA-1:0]  dbg_sbus_wdata,
    .dbg_sbus_rdata( ),//output wire [W_DATA-1:0]  dbg_sbus_rdata,
    
    // Level-sensitive interrupt sources
    .irq(1'b0),//input wire [NUM_IRQS-1:0] irq,       // -> mip.meip
    .soft_irq(1'b0),//input wire                soft_irq,  // -> mip.msip
    .timer_irq(1'b0)//input wire                timer_irq  // -> mip.mtip
    );
   
endmodule
