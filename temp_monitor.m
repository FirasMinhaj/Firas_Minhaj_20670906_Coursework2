a = arduino("COM3","Uno");

function controlLED()

while temp>=18 && temp <=24
    writeDigitalPin(a,"D4",1)
end

while temp < 18
    writeDigitalPin(a,"D2",1)
    pause(0.5)
    writeDigitalPin(a,"D2",0)
    pause(0.5)
end

while temp > 24
    writeDigitalPin(a,"D3",1)
    pause(0.25)
    writeDigitalPin(a,"D3",0)
    pause(0.25)
end
end