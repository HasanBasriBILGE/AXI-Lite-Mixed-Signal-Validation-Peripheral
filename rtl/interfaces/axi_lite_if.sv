interface axi_lite_if;

    // AXI Write Address Channel Signals
    logic [31:0]  AWADDR;
    logic         AWVALID;
    logic         AWREADY;
    
    // AXI Write Data Channel Signals
    logic [31:0]  WDATA;
    logic [ 3:0]  WSTRB;
    logic         WVALID;
    logic         WREADY;

    // AXI Write Response Channel Signals
    logic [ 1:0]  BRESP;
    logic         BVALID;
    logic         BREADY;

    // AXI Read Address Channel Signals
    logic [31:0]  ARADDR;
    logic         ARVALID;
    logic         ARREADY;

    // AXI Read Data Channel Signals
    logic [31:0]  RDATA;
    logic [ 1:0]  RRESP;
    logic         RVALID;
    logic         RREADY;

    modport MASTER (
    input  AWREADY, WREADY, BVALID, RVALID,
    output AWVALID, AWADDR, WVALID, WDATA, WSTRB, BREADY,
    output ARVALID, ARADDR, RREADY,
    input  RDATA, RRESP, BRESP
    );

    modport SLAVE (
    input  AWVALID, AWADDR, WVALID, WDATA, WSTRB, BREADY,
    input  ARVALID, ARADDR, RREADY,
    output AWREADY, WREADY, BVALID, RVALID, RDATA, RRESP, BRESP
    );

endinterface //axi_lite_if