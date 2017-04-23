//Steven Ventura 5:41 PM Saturday, April 22, 2017
module LineFollow (clk, 
			sensorLeftFiltered,sensorRightFiltered,sensorMiddleFiltered,
			PWM_OutL, PWM_OutR, dirR, dirL);

			
input sensorLeftFiltered,sensorMiddleFiltered,sensorRightFiltered;
input clk;
output PWM_OutL,PWM_OutR;
output reg dirR=1,dirL=1;

reg [7:0] leftMotorSpeed, rightMotorSpeed;

PWM pwmleft (clk, leftMotorSpeed, PWM_OutL);
PWM pwmright (clk, rightMotorSpeed, PWM_OutR);

//the filtered sensor data. [2]=left,[1]=middle,[0]=right
wire [2:0] sensors;

assign sensors = {sensorLeftFiltered,sensorMiddleFiltered,sensorRightFiltered};

parameter MAX = 8'b10000000,//50% duty
		  HALF= 8'b01000000,//25% duty
		  OFF = 8'b00000000;//0% duty

//now do the actual linefollowing
always @(posedge clk) begin
dirL <= 1;
dirR <= 1;

case(sensors)
3'b000: begin
//at a "T" intersection 
rightMotorSpeed <= MAX;
leftMotorSpeed <= MAX;
end
3'b001:begin
//drifting to the right
rightMotorSpeed <= MAX;
leftMotorSpeed <= HALF;
end
3'b010:begin
//ERROR (ignore)
rightMotorSpeed <= MAX;
leftMotorSpeed <= MAX;
end
3'b011:begin
//went too far to the right
rightMotorSpeed <= OFF;
leftMotorSpeed <= MAX;
end
3'b100:begin
//drifting to the left
rightMotorSpeed <= HALF;
leftMotorSpeed <= MAX;
end
3'b101:begin
//running in the middle
rightMotorSpeed <= MAX;
leftMotorSpeed <= MAX;
end
3'b110:begin
//went too far to the left
rightMotorSpeed <= OFF;
leftMotorSpeed <= MAX;
end
3'b111:begin
//end of the line
rightMotorSpeed <= OFF;
leftMotorSpeed <= OFF;
end

endcase
end





endmodule