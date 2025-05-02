% Firas Mohammed Minhaj
% egyfm6@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]
clear a
a = arduino("COM3","Uno");
for i = 1:10
    writeDigitalPin(a,"D2",1)
    pause(0.5)
    writeDigitalPin(a,"D2",0)
    pause(0.5)
end
% Insert answers here

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
% printing date and location
fprintf('Data Logging Initiated - %s\n' , datestr(now, 'dd/mm/yyyy'));
fprintf('Location - Nottingham \n\n')
% Setting up required parameters
% aquisition time in seconds
Duration = 600; 
% Sensor reading interval of 1 second
ReadingInterval = 1; 
% Temperature Coefficient in V/Deg Celcius
Tc = 0.01; 
% Zero Degree Voltage in V
Vzero = 0.5; 
% Number of Readings taken by sensors.
NumberofReadings = Duration / ReadingInterval; 
% Array for Temperature Data
Tdata = zeros(1 , NumberofReadings);
%Time from 0 to 600 seconds. 
time = 0:ReadingInterval:(Duration - 1);

%reading voltage data from sensors, calculating temperature and recording in array every second.
for i = 1:NumberofReadings
    voltage = readVoltage(a,"A0");
    temp = (voltage - Vzero)/Tc;
    Tdata(i) = temp;
end

%Plotting graph of temperature over time with x axis and y axis labels and
%title.
plot(time,Tdata)
xlabel('Time (s)')
ylabel('Temperature (Deg Celcius)')
title('temperature vs time')
grid on

% Outputting temperature data every minute. Displaying it in required
% format. 
for min = 0:(Duration/60 - 1)
    index = min * 60 + 1;  
    temperature = Tdata(index);
    fprintf('Minute\t\t%d\n', min);
    fprintf('Temperature\t%.2f C\n\n' , temperature);
end

fprintf('Data Logging Terminated \n\n')
% Creating txt file named cabin_temperature to store temperature data of
% every minute. 
% file open
fileID = fopen('cabin_temperature.txt' , 'w');
fprintf(fileID, 'Data Logging Initiated - %s\n' , datestr(now, 'dd/mm/yyyy'));
fprintf(fileID, 'Location - Nottingham: \n\n');

for min = 0:(Duration/60 - 1)
    index = min * 60 + 1;  
    temperature = Tdata(index);
    fprintf(fileID, 'Minute\t\t%d\n', min);
    fprintf(fileID, 'Temperature\t%.2f C\n\n' , temperature);
end

fprintf(fileID, 'Data Logging Terminated \n\n');
% file close
fclose(fileID);

% Insert answers here

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert reflective statement here (400 words max)


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.