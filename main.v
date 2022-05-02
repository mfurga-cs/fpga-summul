`timescale 1ns / 1ps

module main (
  input wire CLK_25MHZ,
  input wire [7:0] SW,
  input wire [1:0] BTN,

  output wire [7:0] LED,
  output wire [3:0] AN_LED,
  output wire [6:0] SEG_LED
);

  reg [11:0] bin = 0;
  wire [15:0] bcd;
  
  assign LED = SW;

  bin2bcd bin2bcd(
    .bin(bin),
    .bcd(bcd)
  );

  seg7 seg7(
    .clk_25mhz(CLK_25MHZ),
    .an_led(AN_LED),
    .seg_led(SEG_LED),
    .bcd(bcd)
  );
  
  always @ (posedge CLK_25MHZ) begin
    if (BTN[0]) begin
      bin <= SW[7:4] + SW[3:0];
    end else if (BTN[1]) begin
      bin <= SW[7:4] * SW[3:0];
    end else begin
      bin <= SW[7:4] * 100 + SW[3:0];
    end
  end
endmodule
