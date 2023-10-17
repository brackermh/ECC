function [ErPin, AnalogDevice, ETransistor, Gate] = Simulation(Sig)
	X1 = str2num(Sig(4));
	X2 = str2num(Sig(3));
	X3 = str2num(Sig(2));
	X4 = str2num(Sig(1));
	GateArray = [];
    ErPin = 'No'; 
    AnalogDevice = 'No';

% Encode

%	C5 = Gate2
	GateArray(1, 1) = X1;
	GateArray(2, 1) = X2;
	Gate1 = xor(X1, X2);
	GateArray(1, 2) = Gate1;
	GateArray(2, 2) = X4;
	Gate2 = xor(Gate1, X4);


%	C6 = Gate4
	GateArray(1, 3) = X1;
	GateArray(2, 3) = X3;
	Gate3 = xor(X1, X3);
	GateArray(1, 4) = Gate3;
	GateArray(2, 4) = X4;
	Gate4 = xor(Gate3, X4);

%	C7 = Gate6
	GateArray(1, 5) = X2;
	GateArray(2, 5) = X3;
	Gate5 = xor(X2, X3);
    GateArray(1, 6) = Gate5;
    GateArray(2, 6) = X4;
	Gate6 = xor(Gate5, X4);

%	C8 = Gate8
	GateArray(1, 7) = X1;
	GateArray(2, 7) = X2;
	Gate7 = xor(X1, X2);
    GateArray(1, 8) = Gate7;
    GateArray(2, 8) = X3;
    Gate8 = xor(Gate7, X3);



% Syndrome Decoding

%    1
% 	 S1 = Gate11
	GateArray(1, 9) = X1;
	GateArray(2, 9) = X2;
	Gate9 = xor(X1, X2);
	GateArray(1, 10) = X4;
	GateArray(2, 10) = Gate3;
	Gate10 = xor(X4, Gate3);
    GateArray(1, 11) = Gate9;
    GateArray(2, 11) = Gate10;
    Gate11 = xor(Gate9, Gate10);


%	 2
%	  S2 = Gate14
	GateArray(1, 12) = X1;
	GateArray(2, 12) = X3;
	Gate12 = xor(X1, X3);
    GateArray(1, 13) = X4;
    GateArray(2, 13) = Gate4;
    Gate13 = xor(X4, Gate4);
    GateArray(1, 14) = Gate12;
    GateArray(2,14) = Gate13;
    Gate14 = xor(Gate12, Gate13);


%	 3
%	  S3 = Gate17
	GateArray(1, 15) = X2;
	GateArray(2, 15) = X3;
	Gate15 = xor(X2, X3);
    GateArray(1, 16) = X4;
    GateArray(2, 16) = Gate6;
    Gate16 = xor(X4, Gate6);
    GateArray(1, 17) = Gate15;
    GateArray(2, 17) = Gate16;
    Gate17 = xor(Gate15, Gate16);



%	 4
%	  S4 = Gate20
	GateArray(1, 18) = X1;
	GateArray(2, 18) = X2;
	Gate18 = xor(X1, X2);
    GateArray(1, 19) = X3;
    GateArray(2, 19) = Gate8;
    Gate19 = xor(X3, Gate8);
    GateArray(1, 20) = Gate18;
    GateArray(2,20) = Gate19;
    Gate20 = xor(Gate18, Gate19);



% Error Gen (Decoding)

%Inverter
%invert S3
GateArray(1, 25) = Gate17;
Gate25 = ~Gate17;
%Invert S2
GateArray(1, 26) = Gate14;
Gate26 = ~Gate14;
%Invert S1
GateArray(1, 27) = Gate11;
Gate27 = ~Gate11;
%Invert S4
GateArray(1, 28) = Gate20;
Gate28 = ~Gate20;

%	ANDs
	%Gate31 - E1
    GateArray(1, 29) = Gate11;
	GateArray(2, 29) = Gate14;
	Gate29 = and(Gate11, Gate14);
	GateArray(1, 30) = Gate25;
	GateArray(2, 30) = Gate20;
	Gate30 = and(Gate25, Gate20);
    GateArray(1, 31) = Gate29;
    GateArray(2, 31) = Gate30;
    Gate31 = and(Gate29, Gate30);

    %Gate34 - E2
	GateArray(1, 32) = Gate11;
	GateArray(2, 32) = Gate26;
	Gate32 = and(Gate11, Gate26);
	GateArray(1, 33) = Gate17;
	GateArray(2, 33) = Gate20;
	Gate33 = and(Gate17, Gate20);
    GateArray(1, 34) = Gate32;
    GateArray(2, 34) = Gate33;
    Gate34 = and(Gate32, Gate33);

	%Gate37 - E3 
    GateArray(1, 35) = Gate27;
	GateArray(2, 35) = Gate14;
	Gate35 = and(Gate27, Gate14);
	GateArray(1, 36) = Gate17;
	GateArray(2, 36) = Gate20;
	Gate36 = and(Gate17, Gate20);
    GateArray(1, 37) = Gate32;
    GateArray(2, 37) = Gate33;
    Gate37 = and(Gate35, Gate36);

    %Gate40 - E4
    GateArray(1, 38) = Gate11;
	GateArray(2, 38) = Gate14;
	Gate38 = and(Gate11, Gate14);
	GateArray(1, 39) = Gate17;
	GateArray(2, 39) = Gate28;
	Gate39 = and(Gate17, Gate28);
    GateArray(1, 40) = Gate38;
    GateArray(2, 40) = Gate39;
    Gate40 = and(Gate38, Gate39);

%	XORs - Output signal post error 
%		X1out = Gate21
	GateArray(1, 21) = Gate31;
	GateArray(2, 21) = X1;
	Gate21 = xor(Gate31, X1);

%		X2out = Gate22
	GateArray(1, 22) = Gate34;
	GateArray(2, 22) = X2;
	Gate22 = xor(Gate34, X2);

%		X3out = Gatte23
	GateArray(1, 23) = Gate37;
	GateArray(2, 23) = X3;
	Gate23 = xor(Gate37, X3);

%		X4out = Gate24
	GateArray(1, 24) = Gate40;
	GateArray(2, 24) = X4;
	Gate24 = xor(Gate40, X4);

	IndGate = [Gate1, Gate2, Gate3, Gate4, Gate5, Gate6, Gate7, Gate8, Gate9, Gate10, Gate11, Gate12, Gate13, Gate14, Gate15, Gate16, Gate17, Gate18, Gate19, Gate20, Gate21, Gate22, Gate23, Gate24, Gate25, Gate26, Gate27, Gate28, Gate29, Gate30, Gate31, Gate32, Gate33, Gate34, Gate35, Gate36, Gate37, Gate38, Gate39, Gate40];
	
	Gate = randi(40);
    if Gate < 24
% XOR
		ETransistor = randi(12);
        if (ETransistor == 3) && (GateArray(2, Gate) == 1) && (IndGate(1, Gate) == 1)
            [ErPin, AnalogDevice] = ErrorPin(Gate);
        elseif (ETransistor == 4) && (GateArray(1, Gate) == 1) && (IndGate(1, Gate) == 1)
            [ErPin, AnalogDevice] = ErrorPin(Gate);
        elseif (ETransistor == 7) && (GateArray(1, Gate) == 1) && (IndGate(1, Gate) == 1)
            [ErPin, AnalogDevice] = ErrorPin(Gate);
        elseif (ETransistor == 8) && (GateArray(2, Gate) == 1) && (IndGate(1, Gate) == 1)
            [ErPin, AnalogDevice] = ErrorPin(Gate);
        elseif (ETransistor == 10) && (GateArray(1, Gate) == 0) && (IndGate(1, Gate) == 1)
            [ErPin, AnalogDevice] = ErrorPin(Gate);
        elseif (ETransistor == 12) && (GateArray(2, Gate) == 0) && (IndGate(1, Gate) == 1)
            [ErPin, AnalogDevice] = ErrorPin(Gate);
        end
	elseif Gate <= 40
% AND
		ETransistor = randi(2);
        if (ETransistor == 1) && (GateArray(2, Gate) == 1) && (IndGate(1, Gate) == 0)
					[ErPin, AnalogDevice] = ErrorPin(Gate);
        elseif (ETransistor == 2) && (GateArray(1, Gate) == 1) && (IndGate(1, Gate) == 0)
					[ErPin, AnalogDevice] = ErrorPin(Gate);
        end 

    end
end
	
