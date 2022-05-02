`timescale 1ns / 1ps

module seg7(
  input wire clk_25mhz,
  input wire [15:0] bcd,

  output reg [3:0] an_led,
  output reg [6:0] seg_led
);

  function [6:0] num_to_seg (
    input [3:0] num
  );
    case (num)
      4'h0: num_to_seg = 7'b1000000;
      4'h1: num_to_seg = 7'b1111001;
      4'h2: num_to_seg = 7'b0100100;
      4'h3: num_to_seg = 7'b0110000;
      4'h4: num_to_seg = 7'b0011001;
      4'h5: num_to_seg = 7'b0010010;
      4'h6: num_to_seg = 7'b0000010;
      4'h7: num_to_seg = 7'b1111000;
      4'h8: num_to_seg = 7'b0000000;
      4'h9: num_to_seg = 7'b0010000;
      4'ha: num_to_seg = 7'b0001000;
      4'hb: num_to_seg = 7'b0000011;
      4'hc: num_to_seg = 7'b1000110;
      4'hd: num_to_seg = 7'b0100001;
      4'he: num_to_seg = 7'b0000110;
      4'hf: num_to_seg = 7'b0001110;
    endcase
  endfunction

  reg [16:0] counter;
  wire [1:0] selector;

  // Switch each segment at frequency 25Mhz / 2^15 ~ 763Hz.
  assign selector = counter[16:15];

  always @ (posedge clk_25mhz) begin
    counter <= counter + 1;

    case (selector)
      2'b00: begin
        an_led <= 4'b0111;
        seg_led <= num_to_seg(bcd[15:12]);
      end
      2'b01: begin
        an_led <= 4'b1011;
        seg_led <= num_to_seg(bcd[11:8]);
      end
      2'b10: begin
        an_led <= 4'b1101;
        seg_led <= num_to_seg(bcd[7:4]);
      end
      2'b11: begin
        seg_led <= num_to_seg(bcd[3:0]);
        an_led <= 4'b1110;
      end
    endcase
  end
endmodule
