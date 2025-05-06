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
NumberofReadings = Duration ./ ReadingInterval; 
% Array for Temperature Data
Tdata = zeros(1 , NumberofReadings);
% Time from 0 to 600 seconds. 
time = 0:ReadingInterval:(Duration - 1);

% reading voltage data from sensors, calculating temperature and recording in array every second.
for i = 1:NumberofReadings
    voltage = readVoltage(a,"A0");
    temp = (voltage - Vzero)./-Tc;
    Tdata(i) = temp;
end

% Plotting graph of temperature over time with x axis and y axis labels and
% title.
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
% Calling function from temp_monitor.m file. 
temp_monitor(a,Vzero,Tc,NumberofReadings);

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]
temp_prediction(a,Vzero,Tc,NumberofReadings);
% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]
% Overall, I found this coursework a challenge. I had to learn many new
% skills to be able to complete the questions but at the same time I got to
% learn a lot about coding in matlab. Some challenges I faced were: -
% Connecting the arduino circuit to get correct temperature readings. - It
% took me a while to understand how github works. - Errors would take a
% very long time to fix. However, my main strength while completing this
% coursework was my knowledge of coding and understanding computer
% language. I studied python for gcse and a levels and these skills deemed
% qquite useful when coding in matlab due to the shared similarities of the
% language with python. A limitation for completing this coursework was the vague nature of the brief document. Some tasks could have been explained in more detail to make it easier to understand.  
% Insert reflective statement here (400 words max)


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.


% - Hand the Arduino project kit back to the lecturer with all parts and in working order.