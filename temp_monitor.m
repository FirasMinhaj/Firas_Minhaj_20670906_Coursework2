% temp_monitor is a function which controls 3 different LEDs according to
% the temperature measured on the thermistor. A live graph is also produced
% to allow the LEDs to be controlled according to live temperature
% readings. A red LED blinks every 0.25 seconds if the temperature is above
% 24 degrees. A yellow LED blinks every 0.5 seconds if the temperature is
% below 18 degrees. A green LED is constantly lit when the temperature is
% between 18 and 24 degrees. 


% type doc temp_monitor in command window to see the documentation.




% function for led temperature monitoring.
function temp_monitor(a,Vzero, Tc, NumberofReadings)
% Drawing live graph, setting x and y axis labels, graph title, and x and y
% axis limits. 
h = animatedline;
    xlabel('live time (s)');
    ylabel('live Temp ( deg C)');
    title ('Live Temperature Graph');
    grid on;
    xlim([0,NumberofReadings]);
    ylim([0,100]);
% creating loop
while true
    % as new temp data is measured, it is added to the graph. 
    livevolt = readVoltage(a,"A0");
    liveTempCalc = double((livevolt - Vzero)./-Tc) ;
    currentTime = toc;
    addpoints(h,currentTime,liveTempCalc);
    drawnow;
    % conditions for LEDs. 
    % if temp is between 18 and 24, constant green light shows, red and
    % yellow lights are turned off. 
    if liveTempCalc >=18 && liveTempCalc <=24
        writeDigitalPin(a,"D5",1)
        writeDigitalPin(a,"D3",0)
        writeDigitalPin(a,"D4",0)
    % if temp is below 18, yellow light blinks in 0.5s intervals, green and
    % red lights are turned off.
    elseif liveTempCalc<18
       writeDigitalPin(a,"D3",1)
       pause(0.5)
       writeDigitalPin(a,"D3",0)
       pause(0.5)
       writeDigitalPin(a,"D5",0)
       writeDigitalPin(a,"D4",0)
    % is temp is above 24 degrees, red light blinks in 0.25 second
    % intervals, green and yellow lights are turned off. 
    else
        writeDigitalPin(a,"D4",1)
        pause(0.25)
        writeDigitalPin(a,"D4",0)
        pause(0.25)
        writeDigitalPin(a,"D3",0)
        writeDigitalPin(a,"D5",0)
    end
end
end