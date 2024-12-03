% The sampling rate is 2000 Hz
FS = 2000;

% Load the signals from data.mat into the struct 'data'
load('data.mat');

% Number of segments
N = numel(data);

% Preallocate arrays
AF = zeros(1, N);
DR = zeros(1, N);
MS = zeros(1, N);
ZCR = zeros(1, N);
TCR = zeros(1, N);

% Loop through all segments
for i = 1:N
    % Calculate Average Force (AF)
    AF(i) = mean(data(i).force);

    % Calculate Dynamic Range (DR)
    DR(i) = max(data(i).EMG) - min(data(i).EMG);

    % Calculate Mean-Squared Value (MS)
    signal_length = length(data(i).EMG);
    MS(i) = sum((data(i).EMG).^2) / signal_length;

    % Calculate Zero-Crossing Rate (ZCR)
    time_duration = data(i).t(end) - data(i).t(1);
    zero_crossings = sum(abs(diff(sign(data(i).EMG)))) / 2;
    ZCR(i) = zero_crossings / time_duration;

    % Calculate Turns Count Rate (TCR)
    derivative = diff(data(i).EMG);
    signs = sign(derivative);
    turns = signs(1:end-1) .* signs(2:end);
    turn_indices = find(turns <= 0) + 1;
    extremes = data(i).EMG(turn_indices);
    extreme_diff = diff(extremes);
    valid_turns = find(abs(extreme_diff) > 0.1);
    turn_count = length(valid_turns);
    TCR(i) = turn_count / time_duration;
end

% Calculate linear model coefficients using polyfit
p_DR = polyfit(AF, DR, 1);
p_MS = polyfit(AF, MS, 1);
p_ZCR = polyfit(AF, ZCR, 1);
p_TCR = polyfit(AF, TCR, 1);

% Calculate correlation coefficients between AF and other parameters
c_DR = corr(AF', DR');
c_MS = corr(AF', MS');
c_ZCR = corr(AF', ZCR');
c_TCR = corr(AF', TCR');
