% Load problem1.mat to have access to variables abd_sig1 and mhb
x = load('problem1.mat');

% The sampling rates are 1000 Hz
FS = 1000;

% Calculate sample timing vector in seconds starting from 0
N = length(abd_sig1);
t = (0:N-1) / FS;

% 1. Estimate c2 using the scalar projection formula
c2_projection = (mhb' * abd_sig1) / (mhb' * mhb);

% 2. Estimate c2 using the pseudoinverse function (pinv)
c2_pinv = pinv(mhb) * abd_sig1;

% 3. Estimate c2 using the backslash operator (\)
c2_operator = mhb \ abd_sig1;

% 4. Calculate the fetal ECG by cancelling out the scaled mother's ECG
fetus = abd_sig1 - c2_projection * mhb;

% Plotting the signals for visualization
figure;
subplot(3,1,1);
plot(t, abd_sig1);
title('Abdominal Signal (Mixed)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t, mhb);
title('Maternal ECG (Reference)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t, fetus);
title('Estimated Fetal ECG');
xlabel('Time (s)');
ylabel('Amplitude');
