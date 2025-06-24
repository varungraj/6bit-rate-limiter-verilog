6-Bit Rate Limiter Verilog 

A Verilog implementation of a 6-bit rate limiter with adjustable step size and synchronous reset, designed for smooth output transitions. Includes a testbench for functional verification and documentation with schematic and waveform outputs.

Overview 

The rate_limiter module adjusts a 6-bit output (d_out) towards a 6-bit input (d_in) using a 3-bit step size (step_size), preventing abrupt changes. It operates on the positive clock edge with a synchronous active-high reset, constraining the output to the range 0 to 63. The testbench verifies key scenarios, and documentation includes a schematic and waveform results from SimVision.

Repository Contents

1. src/ratelimiter.v: Core Verilog module implementing the rate limiter.
2. testbench/ratelimiter_tb.v: Testbench for simulation and verification.
3. docs/Ratelimiter_schematic.pdf: Schematic diagram of the rate limiter.
4. docs/Ratelimiter_waveform.pdf: Waveform results from SimVision.
5. .gitignore: Excludes simulation outputs and temporary files.
6. LICENSE: MIT License for permissive use.
7. README.md: This file, providing project details.

Features

6-bit input and output (0 to 63).
Adjustable 3-bit step size (0 to 7).
Synchronous reset to initialize output to 0.
Prevents output overflow/underflow.
Supports gradual or immediate output updates based on step size.
Testbench generates waveforms viewable in SimVision.
PDF documentation for schematic and waveforms.

Usage

Prerequisites:
Cadence Xcelium Logic Simulator (for Xrun compilation).
SimVision for waveform analysis.
Git for cloning the repository.
Basic knowledge of Verilog and simulation workflows.

Setup

Clone the repository:
 https://github.com/varungraj/6bit-rate-limiter-verilog.git

Ensure Cadence Xcelium and SimVision are installed and configured.


Compilation and Simulation:

1. Compile the design and testbench using                 

    | xrun -sv -access +rwc ratelimiter.v ratelimiter_tb.v

2. Run the simulation using 

    | simvision wave.shm

This generates a waveform database (wave.shm) and opens SimVision.

In SimVision:

Open wave.shm to analyze waveforms.
Inspect signals (clk, rst, d_in, step_size, d_out) to verify behavior.

Testbench Details:

The testbench verifies the following scenarios:

1. Reset: Initializes output to 0.
2. Basic Increment: Steps output towards 30 with step size 7.
3. Basic Decrement: Steps output towards 15.
4. Steady State: Verifies no change when input equals output.
5. Small Increment: Immediate update for small input changes.
6. Zero Step Size: No output change when step size is 0.
7. Decrement Wrap: Handles low-end transitions.
8. Increment Wrap: Handles high-end transitions (up to 63).

License

This project is licensed under the MIT License, allowing free use, modification, and distribution with proper attribution.

Author | Varun G Raj

Created | June 24, 2025



Contributions are welcomed! Submit issues or pull requests on GitHub.
