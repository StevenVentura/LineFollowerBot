//Steven Ventura 5:41 PM Saturday, April 22, 2017
//this module ignores "flicker" noise signals. you must have the same signal 
//an arbitrary number of times in a row to change the output of this.
module LightSensorFilter (clk, sensorRaw, sensorFiltered);
input clk;
input sensorRaw;
output reg sensorFiltered = 0;

parameter [16:0] arbitraryRepeats = 16'd5;

reg[16:0] repeatCount=0;
reg lastValue=0;




always @(posedge clk) begin
//sensorFiltered <= sensorRaw;

if (sensorRaw == lastValue) begin
repeatCount <= repeatCount + 1;
if (repeatCount > arbitraryRepeats) begin
repeatCount <= 0;
//accept the change!
sensorFiltered <= sensorRaw;
end//end if repeat>arb
end//end if sensorRaw==latestPolarity
else
	repeatCount <= 0;//it changed so restart the counter!

//save the last one
lastValue <= sensorRaw;

end//end always

endmodule