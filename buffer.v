module tx_buff (
  input wire clk, reset,
  input wire [7:0] data_in,
  input wire tx_buff_ld,
  output reg frame_gen_intl,
  output reg tx_buff_busy,
  output wire [7:0] tx_buff_1,
  output wire [7:0] tx_buff_2,
  output wire [7:0] tx_buff_3,
  output wire [7:0] tx_buff_4,
  output wire [7:0] tx_buff_5,
  output wire [7:0] tx_buff_6,
  output wire [7:0] tx_buff_7,
  output wire [7:0] tx_buff_8,
  output wire [7:0] tx_buff_9,
  output wire [7:0] tx_buff_10,
  output reg rtr,
  output reg [3:0] dlc
);

  parameter IDLE = 4'b0000;
  parameter BUF0 = 4'b0001;
  parameter BUF1 = 4'b0010;
  parameter BUF2 = 4'b0011;
  parameter BUF3 = 4'b0100;
  parameter BUF4 = 4'b0101;
  parameter BUF5 = 4'b0110;
  parameter BUF6 = 4'b0111;
  parameter BUF7 = 4'b1000;
  parameter BUF8 = 4'b1001;
  parameter BUF9 = 4'b1010;
  parameter BUF_LD_COMP = 4'b1011;
  parameter DEFAULT = 4'b1100;

  reg [3:0] state, next_state;
  reg [7:0] tx_buffers [0:9];
  integer i;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      frame_gen_intl <= 1'b0;
      tx_buff_busy <= 1'b0;
      for (i = 0; i < 10; i = i + 1) begin
        tx_buffers[i] <= 8'b0;
      end
      rtr <= 1'b0;
      dlc <= 4'b0;
    end
    else begin
      state <= next_state;
    end
  end

  always @(posedge clk) begin
    case (state)
      IDLE: begin
        frame_gen_intl <= 1'b0;
        tx_buff_busy <= 1'b0;
        rtr <= 1'b0;
        dlc <= 4'b0;
        if (tx_buff_ld) next_state <= BUF0;
      end

      BUF0: begin
        tx_buffers[0] <= data_in;
        next_state <= BUF1;
      end

       BUF1: begin
        tx_buffers[1] <= tx_buffers[0];
        tx_buffers[0] <= data_in;
        rtr <= data_in[4];
        dlc <= data_in[3:0];
        next_state <= BUF2;
      end

      BUF2: begin
        tx_buffers[2] <= tx_buffers[1];
        tx_buffers[1] <= tx_buffers[0];
        tx_buffers[0] <= data_in;       
        next_state <= BUF3;
      end

      BUF3: begin
        tx_buffers[3] <= tx_buffers[2];
        tx_buffers[2] <= tx_buffers[1];
        tx_buffers[1] <= tx_buffers[0];
        tx_buffers[0] <= data_in;
        next_state <= BUF4;
      end

      BUF4: begin
        tx_buffers[4] <= tx_buffers[3];
        tx_buffers[3] <= tx_buffers[2];
        tx_buffers[2] <= tx_buffers[1];
        tx_buffers[1] <= tx_buffers[0];
        tx_buffers[0] <= data_in;
        next_state <= BUF5;
      end

      BUF5: begin
        tx_buffers[5] <= tx_buffers[4];
        tx_buffers[4] <= tx_buffers[3];
        tx_buffers[3] <= tx_buffers[2];
        tx_buffers[2] <= tx_buffers[1];
        tx_buffers[1] <= tx_buffers[0];
        tx_buffers[0] <= data_in;
        next_state <= BUF6;
      end

      BUF6: begin
        tx_buffers[6] <= tx_buffers[5];
        tx_buffers[5] <= tx_buffers[4];
        tx_buffers[4] <= tx_buffers[3];
        tx_buffers[3] <= tx_buffers[2];
        tx_buffers[2] <= tx_buffers[1];
        tx_buffers[1] <= tx_buffers[0];
        tx_buffers[0] <= data_in;
        next_state <= BUF7;
      end

      BUF7: begin
        tx_buffers[7] <= tx_buffers[6];
        tx_buffers[6] <= tx_buffers[5];
        tx_buffers[5] <= tx_buffers[4];
        tx_buffers[4] <= tx_buffers[3];
        tx_buffers[3] <= tx_buffers[2];
        tx_buffers[2] <= tx_buffers[1];
        tx_buffers[1] <= tx_buffers[0];
        tx_buffers[0] <= data_in;
        next_state <= BUF8;
      end

      BUF8: begin
        tx_buffers[8] <= tx_buffers[7];
        tx_buffers[7] <= tx_buffers[6];
        tx_buffers[6] <= tx_buffers[5];
        tx_buffers[5] <= tx_buffers[4];
        tx_buffers[4] <= tx_buffers[3];
        tx_buffers[3] <= tx_buffers[2];
        tx_buffers[2] <= tx_buffers[1];
        tx_buffers[1] <= tx_buffers[0];
        tx_buffers[0] <= data_in;
        next_state <= BUF9;
      end

      BUF9: begin
        tx_buffers[9] <= tx_buffers[8];
        tx_buffers[8] <= tx_buffers[7];
        tx_buffers[7] <= tx_buffers[6];
        tx_buffers[6] <= tx_buffers[5];
        tx_buffers[5] <= tx_buffers[4];
        tx_buffers[4] <= tx_buffers[3];
        tx_buffers[3] <= tx_buffers[2];
        tx_buffers[2] <= tx_buffers[1];
        tx_buffers[1] <= tx_buffers[0];
        tx_buffers[0] <= data_in;
        next_state <= BUF_LD_COMP;
      end

      BUF_LD_COMP: begin
        tx_buff_busy <= 1'b1;
        frame_gen_intl <= 1'b0;
        next_state <= IDLE;
      end

      DEFAULT: begin
        frame_gen_intl <= 1'b0;
        tx_buff_busy <= 1'b0;
        rtr <= 1'b0;
        dlc <= 4'b0;
        next_state <= IDLE;
      end
    endcase
  end

  assign tx_buff_1 = tx_buffers[0];
  assign tx_buff_2 = tx_buffers[1];
  assign tx_buff_3 = tx_buffers[2];
  assign tx_buff_4 = tx_buffers[3];
  assign tx_buff_5 = tx_buffers[4];
  assign tx_buff_6 = tx_buffers[5];
  assign tx_buff_7 = tx_buffers[6];
  assign tx_buff_8 = tx_buffers[7];
  assign tx_buff_9 = tx_buffers[8];
  assign tx_buff_10 = tx_buffers[9];

endmodule
