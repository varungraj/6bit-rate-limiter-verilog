//-----------------------------------------------------------------------------
// Module     : rate_limiter_tb
// Description: Testbench for rate_limiter module. Tests reset, increment, 
//		decrement, steady state, zero step size, and wrap-around 
//		conditions. Generates waveforms using SHM probing.
//-----------------------------------------------------------------------------

module rate_limiter_tb ();

reg          clk;
reg          rst;
reg  [5:0]   d_in;
reg  [2:0]   step_size;
wire [5:0]   d_out;

//-----------------------------------------------------------------------------
// Design Under Test (DUT) Instantiation
//-----------------------------------------------------------------------------

rate_limiter dut (
    .clk(clk),
    .rst(rst),
    .d_in(d_in),
    .step_size(step_size),
    .d_out(d_out)
);

//-----------------------------------------------------------------------------
// Input Initialization
//-----------------------------------------------------------------------------

initial begin
    clk = 0;
    rst = 1;
    d_in = 6'd0;
    step_size = 3'd0;
end

//-----------------------------------------------------------------------------
// Clock Generation
//-----------------------------------------------------------------------------

initial begin
    forever #5 clk = ~clk;  // 10ns period
end

//-----------------------------------------------------------------------------
// Test Stimulus
//-----------------------------------------------------------------------------

initial begin
    #10 rst = 0;  // Reset case
    #10 d_in = 6'd30; step_size = 3'd7;  // Basic increment
    #80;  
    #10 d_in = 6'd15;  // Basic decrement
    #80;  
    #10 d_in = 6'd15;  // Steady state
    #20; 
    #10 d_in = 6'd17;  // Small increment
    #20;  
    #10 d_in = 6'd10; step_size = 3'd0;  // Zero step size
    #20; 
    #10 d_in = 6'd2; step_size = 3'd6;  // Decrement wrap
    #50;  
    #10 d_in = 6'd63; step_size = 3'd7;  // Increment wrap
    #100;    
    rst = 1;  // Reset
end

//-----------------------------------------------------------------------------
// Waveform Generation
//-----------------------------------------------------------------------------

initial begin 
    $shm_open("wave.shm");
    $shm_probe("ACTMF");
    #500;
    $finish;
end

endmodule