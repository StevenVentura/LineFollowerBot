/*
Computer Archictecture project: Line following 2-wheeled robot
5:05 PM Saturday, April 22, 2017

Alamin Ahmed,
Luis Robles,
Vinh Vu,
Daniel Lopez,
and Steven Ventura

*/

module Top(clk,PWM_OutR, dirR,PWM_OutL, dirL,sensorLeftRaw, sensorMiddleRaw, sensorRightRaw);
	input clk;//50MHz??
	input sensorLeftRaw, sensorMiddleRaw, sensorRightRaw;
	output PWM_OutR, dirR, PWM_OutL, dirL;
	wire sensorLeftFiltered,sensorMiddleFiltered,sensorRightFiltered;
	//TODO: use a slower clock for filters?
	LightSensorFilter lsf1 (clk, sensorLeftRaw, sensorLeftFiltered);
	LightSensorFilter lsf2 (clk, sensorMiddleRaw, sensorMiddleFiltered);
	LightSensorFilter lsf3 (clk, sensorRightRaw, sensorRightFiltered);
	
	LineFollow lf1 (clk, 
			sensorLeftFiltered,sensorRightFiltered,sensorMiddleFiltered,
			PWM_OutL, PWM_OutR, dirR, dirL
			);
	
	/*
	this makes it go forward 3 seconds, backward 3 seconds, repeat.
	motor right(clk,PWM_OutR);
	motor left(clk,PWM_OutL);
	delay myDelay(clk,rst,3,dirL,dirR);*/
endmodule
