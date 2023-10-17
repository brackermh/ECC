function [EPin, EDevice] = ErrorPin(Gate)
% XOR  
    % C5-C8
    if Gate < 3
        EPin = 4;
        EDevice = 0;
    elseif Gate < 4
        EPin = 5;
        EDevice = 0;
    elseif Gate < 7
        EPin = 6;
        EDevice = 0;
    elseif Gate < 9
        EPin = 7;
        EDevice = 0;
  
    
    % Syndrome
    elseif Gate < 12
        EPin = 8;
        EDevice = 0;
    elseif Gate < 15
        EPin = 0;
        EDevice = 9;
    elseif Gate < 18
        EPin = 10;
        EDevice = 0;
    elseif Gate < 21
        EPin = 11;
        EDevice = 0;
   %Error Decoder
    elseif Gate < 22
        EPin = 0;
        EDevice = 1;
    elseif Gate < 23
        EPin = 1;
        EDevice = 1;
    elseif Gate < 24
        EPin = 2;
        EDevice = 1;
    elseif Gate < 25
        EPin = 3;
        EDevice = 1;
   %Inverter - Error Detector
    elseif Gate < 26
        EPin = 12;
        EDevice = 0;
    elseif Gate < 27
        EPin = 13;
        EDevice = 0;
    elseif Gate < 28
        EPin = 14;
        EDevice = 0;
    elseif Gate < 29
        EPin = 15;
        EDevice = 0;
    %AND - Error Detector
    elseif Gate < 32
        EPin = 12;
        EDevice = 0;
    elseif Gate < 35
        EPin = 13;
        EDevice = 0;
    elseif Gate < 38
        EPin = 14;
        EDevice = 0;
    elseif Gate < 41
        EPin = 15;
        EDevice = 0;
    end
end