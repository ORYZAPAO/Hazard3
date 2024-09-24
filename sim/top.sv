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
     

    repeat(100) @(posedge clk);
    $finish;
   end


 hazard3_cpu_1port u_hazard3_cpu_1port 
   (
	// Global signals
    .clk(clk),
    .clk_always_on(1),
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
    .haddr(),   //output reg  [W_ADDR-1:0]  haddr,
    .hwrite(), //output reg                hwrite,
    .htrans(),//output reg  [1:0]         htrans,
    .hsize(),//output reg  [2:0]         hsize,
    .hburst(),//output wire [2:0]         hburst,
    .hprot(),//output reg  [3:0]         hprot,
    .hmastlock(),//output wire               hmastlock,
    .hmaster(),//output reg  [7:0]         hmaster,
    .hexcl(),//output reg                hexcl,
    .hready(1'b1),//input  wire               hready,
    .hresp(1'b0),//input  wire               hresp,
    .hexokay(1'b0), //input  wire               hexokay,
    .hwdata(),//output wire [W_DATA-1:0]  hwdata,
    .hrdata(32'h0),//input  wire [W_DATA-1:0]  hrdata,
    
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
