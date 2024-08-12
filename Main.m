% Set-up
init
ad2device0('reset');
ad2device1('reset');

ad2device0('supply', [5 0]);
ad2device0('digital', 0:15);
ad2device0('digital', 0:15,'output','low');
ad2device1('digital', 0:7);
ad2device1('digital', 0:3,'output','low');
ad2device1('digital', 4:7,'input');

X1out = 0;
X2out = 1;
X3out = 2;
X4out = 3;
X1inHam = 4;
X2inHam = 5;
X3inHam = 6;
X4inHam = 7;

StagesHam = 16;
WrongHam = 0;
RightHam = 0;
ArrayHam = {};
ArrayHam{1, 1} = 'Signal';
ArrayHam{1, 2} = 'Gate';
ArrayHam{1, 3} = 'Transistor';
ArrayHam{1, 4} = 'Device';
ArrayHam{1, 5} = 'Pin';
ArrayHam{1, 6} = 'Received';
total = 0;
Row = 2;


% Encode
for i = 0:15
    ad2device0('digital',0:3, 'output','low');
	Signal = dec2bin(i, 4);
    if (Signal(4)) == '1'
		ad2device0('digital', X1out, 'output', 'high');
    end
	if (Signal(3)) == '1'
		ad2device0('digital', X2out, 'output', 'high');
	end
	if (Signal(2)) == '1'
		ad2device0('digital', X3out, 'output', 'high');
	end
	if (Signal(1)) == '1'
		ad2device0('digital', X4out, 'output', 'high');
    end
    % Error Injection - Hamming
    for CLK = 1:1000
		ad2device0('digital', 4:15, 'output', 'low');
		ad2device1('digital', 0:3, 'output', 'low');
        [Pin, Device, Transistor, EGate] = Simulation(Signal);
		ArrayHam{Row, 1} = Signal;
        ArrayHam{Row, 2} = EGate;
        ArrayHam{Row, 3} = Transistor;
        ArrayHam{Row, 4} = Device;
        ArrayHam{Row, 5} = Pin;
        if Pin ~= 'No'
            if Device == 0
                ad2device0('digital', Pin, 'output', 'high');
            elseif Device == 1
                ad2device1('digital', Pin, 'output', 'high');
            end
        end
        
    
    % Checking
        %pause(.1);
        SignalHam = '0000';
        d = ad2device1('digital', 7, 'input');
        c = ad2device1('digital', 6, 'input');
        b = ad2device1('digital', 5, 'input');
        a = ad2device1('digital', 4, 'input');
        SignalHam(1) = int2str(d);
        SignalHam(2) = int2str(c);
        SignalHam(3) = int2str(b);
        SignalHam(4) = int2str(a);
		ArrayHam{Row, 6} = SignalHam;
        Row = Row + 1;
        if SignalHam == Signal
            RightHam = RightHam + 1;
        else
            WrongHam = WrongHam + 1;  
        end
        total = total+1;
    end
    PercentHam = (RightHam / total) * 100;
    disp(PercentHam);
end

% Output
PercentHam = (RightHam / total) * 100;
disp(ArrayHam);  
disp(PercentHam);
writecell(ArrayHam, 'ArrayHam.csv');
