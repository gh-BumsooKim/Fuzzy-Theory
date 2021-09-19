%% Using Max-Min Operation & Sugenos Simplified FIE

f1 = figure; % for fuzzy membership function
f2 = figure; % for final union 'U' output value

%% Fuzzy I/O Variable Settings

figure(f1);

% input variable / Room Temperature ~ x (ºC)
x = [20 22.5 25 27.5 30 32.5 35];

% input variable / Outside Temperature ~ y (ºC)
y = [20 22.5 25 27.5 30 32.5 35];

% input variable membership value
LOW     = [1.0 0.8 0.6 0.4 0.2 0   0];
HIGH    = [0   0   0.2 0.4 0.6 0.8 1.0];


% output variable / Motor Speed for Compressor ~ z (rpm)
z = [0 500 1000 1500 2000];

% output variable membership value
STOP    = [1.0 0.6 0.2 0   0];
SLOW    = [0.6 1.0 0.6 0.2 0];
MEDIUM  = [0   0.5 1.0 0.5 0];
FAST    = [0   0.2 0.6 1.0 0.6];


% Draw I/O variable membership function
subplot(3, 1, 1);
plot(x, LOW, x, HIGH);
title('Membership Function about Input Variable ~ X');
legend('LOW','HIGH');
xlabel('Room Temperature ~ X (ºC)');
ylabel('Membership Value');

subplot(3, 1, 2);
plot(y, LOW, y, HIGH);
title('Membership Function about Input Variable ~ Y');
legend('LOW','HIGH');
xlabel('Outside Temperature ~ Y (ºC)');
ylabel('Membership Value');

subplot(3, 1, 3);
plot(z, STOP, z, SLOW, z, MEDIUM, z, FAST);
title('Membership Function about Action Variable ~ Z');
legend('STOP', 'SLOW','MEDIUM', 'FAST');
xlabel('Motor Speed for Compressor ~ Z (rpm)');
ylabel('Membership Value');


%% Fuzzy Rule Settings

% Rule No.1
% IF x in LOW   AND y is HIGH,  THEN z is SLOW
z1 = 500;

% Rule No.2
% IF x in HIGH  AND y is LOW,   THEN z is MEDIUM
z2 = 1000;

% Rule No.3
% IF x in HIGH  AND y is HIGH,  THEN z is FAST
z3 = 1500;

% Rule No.4
% IF x in LOW   AND y is LOW,   THEN z is STOP
z4 = 0;


%% Draw 3D Plot

[X, Y] = meshgrid(x, y);

%F = (min(X, Y).*Z)./min(X, Y);

U = zeros(7, 7);

for ii = 1:length(x)
    for jj = 1:length(y)
        w1 = min(LOW(ii),  HIGH(jj));   % base on Rule No.1
        w2 = min(HIGH(ii), LOW(jj));    % base on Rule No.2
        w3 = min(HIGH(ii), HIGH(jj));   % base on Rule No.3
        w4 = min(LOW(ii),  LOW(jj));    % base on Rule No.4
        
        U(ii, jj) = (w1*z1 + w2*z2 + w3*z3 + w4*z4)/(w1 + w2 + w3 +w4);        
    end
end

figure(f2);
s = surf(x, y, U);
%s.EdgeColor = 'none';
title('Final Output Value along Input Variable x and y');
xlabel('Room Temperature ~ X (ºC)');
ylabel('Outside Temperature ~ Y (ºC)');
