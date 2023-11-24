module tb_top;

  // Signals
  reg clk;
  reg reset;
  reg [7:0] data_in;
  reg tx_buff_ld;
  reg frame_gen_intl;
  reg tx_buff_busy;
  reg rtr;
  reg [3:0] dlc;

  // Instantiate DUT
  tx_buff tx_buff_inst (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .tx_buff_ld(tx_buff_ld),
    .frame_gen_intl(frame_gen_intl),
    .tx_buff_busy(tx_buff_busy),
    .tx_buff_1(),  // No need to declare tx_buff outputs here
    .tx_buff_2(),
    .tx_buff_3(),
    .tx_buff_4(),
    .tx_buff_5(),
    .tx_buff_6(),
    .tx_buff_7(),
    .tx_buff_8(),
    .tx_buff_9(),
    .tx_buff_10(),
    .rtr(rtr),
    .dlc(dlc)
  );
// Instantiate Environment

  // Instantiate Environment, Monitor, Driver
  // ... (Other instantiations)

  // Clock Generation
  always #5 clk = ~clk;

  // Initial Begin
  initial begin
    // Initialize clock
    clk = 0;

    // Apply reset
    reset = 1;
    #10 reset = 0;
    data_in = 8'b00000000;
    tx_buff_ld = 1'b0;
    #20;

  // Test Case 2
    data_in = 8'b10101010;
    tx_buff_ld = 1'b1;
    #20;

  // Test Case 3
    data_in = 8'b01010101;
    tx_buff_ld = 1'b1;
    #20;

  // Additional Test Cases for Coverage
  // Test Case 4
    data_in = 8'b11110000;
    tx_buff_ld = 1'b1;
    #20;

  // Test Case 5
    data_in = 8'b00001111;
    tx_buff_ld = 1'b0;
    #20;

  // Test Case 6
    data_in = 8'b11001100;
    tx_buff_ld = 1'b1;
    #20;

  // Test Case 7
    data_in = 8'b01011010;
    tx_buff_ld = 1'b0;
    #20;

  // Test Case 8
    data_in = 8'b00110011;
    tx_buff_ld = 1'b1;
    #20;

  // Additional Test Cases for Coverage
  // Test Case 9
    data_in = 8'b11111111;
    tx_buff_ld = 1'b1;
    #20;

  // Test Case 10
    data_in = 8'b00000000;
    tx_buff_ld = 1'b1;
    #20;



    // Run simulation for a certain period
    #1000 $finish;
  end

endmodule


