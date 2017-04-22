module PWM(clk,enable,PWM_Out); 
	parameter HIGH = 1'b1,
		  LOW  = 1'b0,
		  ZEROS = 8'b0,
		  FULL = 8'b11111111;

	input enable, clk;
	reg[7:0] counter = ZEROS;
	output reg PWM_Out=1;

	parameter speed = 8'h0f;
	
	always@(posedge clk) begin
		
		if(enable == HIGH) begin
			if(counter == FULL) begin
				counter <= ZEROS;
			end
			else if(counter < speed) begin
				PWM_Out <= HIGH;
			end
			else if(counter >= speed) begin
				PWM_Out <= LOW;
			end
			else ;
			counter <= counter + 1;
		end
		else counter <= ZEROS;
	end
endmodule 