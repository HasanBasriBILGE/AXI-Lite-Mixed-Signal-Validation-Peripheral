interface uart_if (input logic clk, input logic rst_n);

    // UART TX Signals
    logic [ 7:0]    tx_data;
    logic           tx_start;
    logic           tx_out;
    logic           tx_done;

    // UART RX Signals
    logic [ 7:0]    rx_data;
    logic           rx_in;
    logic           rx_valid;
    logic           rx_error;

    // Control 
    logic [15:0]    baud_div;        

    modport TX (
    input  clk, rst_n,
    input  tx_start, tx_data, baud_div,
    output tx_out, tx_done
    );

    modport RX (
    input  clk, rst_n,
    input  rx_in, baud_div,
    output rx_data, rx_valid, rx_error
    );

endinterface //uart_if