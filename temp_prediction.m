% temp_prediction is a function which predicts the temperature after 5
% minutes of each temperature recorded depending on the rate of change of
% temperature. Depending on whether the rate is in the safe range, the
% LEDs are turned on and off. If rate is over 4 degrees per minute, a
% warning is shown. 



%function temp_prediction. Takes variables a, Vzero, Tc, and
%NumberofReadings from main script.
function temp_prediction(a,Vzero,Tc,NumberofReadings)

%creating arrays for recorded temperature and time
recordedtemp = zeros(1,NumberofReadings);
recordedtime = zeros(1,NumberofReadings);
% starts timer
tic;

% creates loop to check rate of change after every temperature calculation.
while true
    % reading voltage and calculating current temperature. 
    volt = readVoltage(a,"A0");
    currenttemp =(volt-Vzero) ./ -Tc;
    currenttime = toc;
    % adding this data to the arrays.
    recordedtemp = [recordedtemp(2:end), currenttemp];
    recordedtime = [recordedtime(2:end), currenttime];
    
    % calculating rate of temperature change.
    diffTime = diff(recordedtime);
    diffTemp = diff(recordedtemp);
    if all(diffTime>0)
        rate = (diffTemp(end) ./ diffTime(end)) *60;
    else
        rate = 0;
    end
    
    % calculating predicted temperature after 5 minutes
    predictedtemp = currenttemp + rate * 5;
    % outputting predicted temperature
    fprintf('The predicted temperature after 5 minutes is... %.2f C\n\n' , predictedtemp)

    % LED conditions based on rate of change. 
    % if rate is above 4 degrees per minute, a constant red light is shown.
    if rate > 4
        writeDigitalPin(a,"D4",1)
        writeDigitalPin(a,"D3",0)
        writeDigitalPin(a,"D5",0)
        fprintf('Warning: Temperature is varying too quickly \n\n')
    % if rate is below 4 degrees per minute, a constant yellow light is
    % shown. 
    elseif rate < -4
        writeDigitalPin(a,"D4",0)
        writeDigitalPin(a,"D3",1)
        writeDigitalPin(a,"D5",0)
    % if rate is in safe range, a constant green light is shown. 
    else 
        writeDigitalPin(a,"D4",0)
        writeDigitalPin(a,"D3",0)
        writeDigitalPin(a,"D5",1)
    end
end
end