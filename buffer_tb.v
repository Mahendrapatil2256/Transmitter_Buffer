module tx_buff_tb;

  // Define signals for the testbench
  reg clk;
  reg reset;
  reg [7:0] data_in;
  reg tx_buff_ld;
  //reg tx_success;
  wire frame_gen_intl;
  wire tx_buff_busy;
  wire [7:0] tx_buff_1;
  wire [7:0] tx_buff_2;
  wire [7:0] tx_buff_3;
  wire [7:0] tx_buff_4;
  wire [7:0] tx_buff_5;
  wire [7:0] tx_buff_6;
  wire [7:0] tx_buff_7;
  wire [7:0] tx_buff_8;
  wire [7:0] tx_buff_9;
  wire [7:0] tx_buff_10;
  wire rtr;
  wire [3:0] dlc;

  // Instantiate the tx_buff module
  tx_buff uut (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .tx_buff_ld(tx_buff_ld),
    //.tx_success(tx_success),
    .frame_gen_intl(frame_gen_intl),
    .tx_buff_busy(tx_buff_busy),
    .tx_buff_1(tx_buff_1),
    .tx_buff_2(tx_buff_2),
    .tx_buff_3(tx_buff_3),
    .tx_buff_4(tx_buff_4),
    .tx_buff_5(tx_buff_5),
    .tx_buff_6(tx_buff_6),
    .tx_buff_7(tx_buff_7),
    .tx_buff_8(tx_buff_8),
    .tx_buff_9(tx_buff_9),
    .tx_buff_10(tx_buff_10),
    .rtr(rtr),
    .dlc(dlc)
  );

  // Clock generation
  always begin
    #20 clk = ~clk;
  end

  // Initialize signals
  initial begin
    clk = 0;
    reset = 0;
    data_in = 8'b0;
    tx_buff_ld = 0;
    //tx_success = 0;

    // Reset the module
    reset = 1;
    #10 reset = 0;


    // Test Scenario 2: Check frame_gen_intl and tx_buff_busy
    $display("frame_gen_intl = %b", frame_gen_intl);
    $display("tx_buff_busy = %b", tx_buff_busy);

    // Test Scenario 3: Load more data and trigger another transmission
    data_in = 8'b10101010;
    tx_buff_ld = 1;
    #150 tx_buff_ld = 0;

    data_in = 8'b10101010;
    tx_buff_ld = 1;
    #100 tx_buff_ld = 0;
    
    data_in = 8'b11101011;
    tx_buff_ld = 1;
    //tx_success = 1;
    #150 tx_buff_ld = 0;
    
    data_in = 8'b10111010;
    tx_buff_ld = 1;
    #200 tx_buff_ld = 0;
    
    data_in = 8'b10101111;
    tx_buff_ld = 1;
    #250 tx_buff_ld = 0;
         
    // Test Scenario 4: Check frame_gen_intl and tx_buff_busy again
    $display("frame_gen_intl = %b", frame_gen_intl);
    $display("tx_buff_busy = %b", tx_buff_busy);

    // Add more test scenarios as needed

    // Finish the simulation
    $finish;
  end

endmodule
