module top(
	input logic	mcu_blink_in,
    input logic [3:0] s,
	output logic mcu_echo_led,
    output logic [6:0] seg,
    output logic [2:0] led
);

	logic int_osc;
	logic pulse;
	logic led_state = 0;
	logic [23:0] counter = 0; /* changed from 24 to 10, should change freq from 1 to 2.4 Hz*/
	
	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	// Simple clock divider
	always_ff @(posedge int_osc)
		begin
			counter <= counter + 1;
		end
		

/*  switch inputs in binary to corresponding led outputs*/
    segmentlogic segmentlogic(s[3:0], seg[6:0]);
    leds leds(s[3:0], led[2:0]);

    assign led[2] = counter[23]; /* changed from 24 to 10*/
	assign mcu_echo_led = mcu_blink_in;

endmodule

module segmentlogic(
    input logic [3:0] s,
    output logic [6:0] seg
);
    always_comb begin
        case(s)
            4'b0000: seg=7'b0000001;
            4'b0001: seg=7'b1001111;
            4'b0010: seg=7'b0010010;
            4'b0011: seg=7'b0000110;
            4'b0100: seg=7'b1001100;
            4'b0101: seg=7'b0100100;
            4'b0110: seg=7'b0100000;
            4'b0111: seg=7'b0001111;
            4'b1000: seg=7'b0000000;
            4'b1001: seg=7'b0001100;
            4'b1010: seg=7'b0001000;
            4'b1011: seg=7'b1100000;
            4'b1100: seg=7'b0110001;
            4'b1101: seg=7'b1000010;
            4'b1110: seg=7'b0110000;
            4'b1111: seg=7'b0111000;
            default: seg=7'b1111111;
        endcase
    end

endmodule

module leds(
    input logic [3:0] s,
    output logic [2:0] led
);
    always_comb begin
        led[0]=(~s[1]&s[0])|(s[1]&~s[0]);
        led[1]=s[3]&s[2];
    end

endmodule