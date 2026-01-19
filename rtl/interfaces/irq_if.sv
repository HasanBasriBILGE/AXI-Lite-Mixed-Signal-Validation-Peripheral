interface irq_if #(
    parameter int NUM_IRQS = 4;
)(
    input logic clk, 
    input logic rst_n
    );
    
    logic [NUM_IRQS-1:0]    irq_sources; // UART=0, Timer=1, Meas=2, GPIO=3
    logic [NUM_IRQS-1:0]    irq_mask;
    logic                   irq_out;
    logic [         2:0]    active_id;

    modport SRC (
    input  clk, rst_n,
    output irq_sources
    );

    modport CTRL (
    input  clk, rst_n, 
    input  irq_sources,
    input  irq_mask,
    output irq_out,
    output active_id
    );

endinterface //irq_if