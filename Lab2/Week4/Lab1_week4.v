/*module Lab1_week4 (
    input  wire clk,
    input  wire key1,
    output wire led1,
	 output wire led2,
	 output wire led3,
	 output wwire led4
);
reg [25:0] counter = 0;
reg blink_enable = 0;
reg key_prev = 1;
reg led_state = 0;
always @(posedge clk) begin
    key_prev <= key1;
    // S1 is active-low: pressed = 0
    if (key_prev == 1 && key1 == 0)
        blink_enable <= ~blink_enable;
    if (blink_enable) begin
        if (counter == 12_250_000) begin
            counter <= 0;
            led_state <= ~led_state;
        end else begin
            counter <= counter + 1;
        end
    end else begin
        counter <= 0;
        led_state <= 0;
    end
end
// LED1 is active-low
assign led1 = ~led_state;
assign led2 = ~led_state;
assign led3 = ~led_state;
assign led4 = ~led_state;
endmodule */
module Lab1_week4(
    input clk, key1, ir_rx,
    output reg [7:0] seg,
    output [3:0] dig
);

reg [3:0] n = 0;
reg old = 1;
reg ir_old = 1;
assign dig = 4'b1110;

always @(posedge clk) begin
    old <= key1;
    ir_old <= ir_rx;

    if (ir_old & ~ir_rx)
        n <= (n == 9) ? 0 : n + 1;
end

always @*
    case(n)
        0: seg = 8'hC0; 1: seg = 8'hF9;
        2: seg = 8'hA4; 3: seg = 8'hB0;
        4: seg = 8'h99; 5: seg = 8'h92;
        6: seg = 8'h82; 7: seg = 8'hF8;
        8: seg = 8'h80; 9: seg = 8'h90;
        default: seg = 8'hC0;
    endcase

endmodule