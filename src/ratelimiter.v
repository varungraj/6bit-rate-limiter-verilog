//-----------------------------------------------------------------------------
// Module     : rate_limiter
// Description: Adjusts 6-bit output (d_out) towards 6-bit input (d_in) by a 
//              3-bit step_size for smooth transitions. Operates on positive 
//		clock edge with synchronous reset. Output range is 0 to 63.
//-----------------------------------------------------------------------------

module rate_limiter (
    input  wire        clk,          // System clock
    input  wire        rst,          // Synchronous reset (active high)
    input  wire [5:0]  d_in,         // 6-bit input data
    input  wire [2:0]  step_size,    // 3-bit step size
    output reg  [5:0]  d_out         // 6-bit output data
);

initial begin 
    d_out = 0;  // Initialize output
end

//-----------------------------------------------------------------------------
// Rate Limiting Logic
//-----------------------------------------------------------------------------

always @(posedge clk) begin

    if (rst) begin
        d_out <= 0;  // Reset output
    end
	
    else if (step_size != 0) begin 
	
	// Case 1: Input slightly larger than output and within step_size
        if (d_in > d_out && d_in <= step_size) begin
            d_out <= d_in;  // Small input jump
        end
	
	// Case 2: Output is less than input
        else if (d_out < d_in) begin
            if ((d_out + step_size) > 63) begin
                d_out <= d_in;  // Cap at max
            end
            else if (d_out + step_size > d_in)
                d_out <= d_in;  // Avoid overshoot
            else 
                d_out <= d_out + step_size;  // Increment
        end
		
		// Case 3: Output equals input
        else if (d_out == d_in) begin
            d_out <= d_in;  // Steady state
        end
		
		// Case 4: Output is greater than input
        else if (d_out > d_in) begin
            if (d_out < step_size) begin
                d_out <= d_in;  // Small output jump
            end
            else if (d_out - step_size < d_in)
                d_out <= d_in;  // Avoid undershoot
            else
                d_out <= d_out - step_size;  // Decrement
        end
		
    end
end
endmodule