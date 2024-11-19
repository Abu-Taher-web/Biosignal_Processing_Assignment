% Load problem2.mat to have access to variables abd_sig1 and mhb_ahead
load('problem2.mat');

% The sampling rate is 1000 Hz
FS = 1000;

% Calculate sample timing vector in seconds starting from 0
N = length(abd_sig1);
t = (0:N-1) / FS;

% Estimate the time lag using cross correlation
% Calculate cross correlation using the xcorr function and then
% use the max function to find the lag giving maximal correlation
[correlation, lags] = xcorr(abd_sig1, mhb_ahead, 'normalized');
[~, d] = max(abs(correlation));  % Find the index of maximum correlation
d = lags(d);  % The time shift (lag) that gives maximum correlation

% Shift the chest ECG mhb_ahead back in time d samples, padding with nearest value
mhb = [repmat(mhb_ahead(1), d, 1); mhb_ahead(1:end-d)];


% Estimate the mixing coefficient c2 using the scalar projection formula
c2 = (mhb' * abd_sig1) / (mhb' * mhb);

% Calculate the fetal ECG by cancelling out the scaled mother's ECG using projection-based estimation coefficient
fetus = abd_sig1 - c2 * mhb;

% Plotting the results for visualization
figure;
subplot(3,1,1);
plot(t, abd_sig1);
title('Abdominal Signal (Mixed)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t, mhb_ahead);
title('Maternal ECG (Chest, Original)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t, fetus);
title('Estimated Fetal ECG');
xlabel('Time (s)');
ylabel('Amplitude');
