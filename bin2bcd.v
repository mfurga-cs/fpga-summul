`timescale 1ns / 1ps

module bin2bcd
#(parameter BUS_WIDTH = 11)(
  input wire [BUS_WIDTH:0] bin,
  output reg [15:0] bcd
);

  integer i;

  always @ (bin) begin
    bcd = 0;
    for (i = 0; i <= BUS_WIDTH; i = i + 1) begin
      if (bcd[3:0] >= 5)   bcd[3:0] = bcd[3:0] + 3;
      if (bcd[7:4] >= 5)   bcd[7:4] = bcd[7:4] + 3;
      if (bcd[11:8] >= 5)  bcd[11:8] = bcd[11:8] + 3;
      if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3;
      bcd = { bcd[14:0], bin[BUS_WIDTH - i] };
    end
  end

endmodule
