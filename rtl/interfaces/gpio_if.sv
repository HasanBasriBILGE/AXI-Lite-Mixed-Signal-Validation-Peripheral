interface gpio_if #(
    parameter int WIDTH = 8
)(
    input logic clk,
    input logic rst_n
);

    // Physical Pins
    wire  [WIDTH-1:0]   gpio_pins;

    // Internal Logic Signals
    logic [WIDTH-1:0]   data_in;   // Data from outside
    logic [WIDTH-1:0]   data_out;  // Data to outside
    logic [WIDTH-1:0]   dir_ctrl;  // 1: Output, 0: Input (Tri-state control)
    logic [WIDTH-1:0]   irq_event; // Interrupt signal at edge detection

    // Tri-state Buffer Logic
    generate
        for (genvar i = 0; i < WIDTH; i++) begin
            assign gpio_pins[i] = dir_ctrl[i] ? data_out[i] : 1'bz;
            assign data_in[i] = gpio_pins[i];
        end
    endgenerate

    modport CTRL (
    input  clk, rst_n,
    input  data_in,
    output data_out, dir_ctrl,
    output irq_event
    );

    // For Simulation
    modport MONITOR (
    input  data_in, data_out, dir_ctrl, gpio_pins
    );

endinterface //gpio_if