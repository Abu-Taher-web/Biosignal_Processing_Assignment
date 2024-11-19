% Step 1: Generate a 100 Hz Sine Wave
f = 100;                % Frequency of sine wave (100 Hz)
t_end = 0.1;            % Duration (0.1 seconds)
fs_high = 10000;        % High sampling rate to represent continuous signal
t_high = 0:1/fs_high:t_end;  % Time vector

% Generate the sine wave
x = sin(2 * pi * f * t_high);

% Step 2: Sample the sine wave at 500 Hz
fs_low = 500;           % Sampling rate for lower resolution
t_low = 0:1/fs_low:t_end;    % Time vector for sampling at 500 Hz
x_sampled = sin(2 * pi * f * t_low); % Sampled sine wave

% Step 3: Visualization
figure;

% Plot the original sine wave
subplot(2, 1, 1);
plot(t_high, x, 'b'); 
title('Original 100 Hz Sine Wave (High Sampling Rate)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Plot the sampled sine wave at 500 Hz
subplot(2, 1, 2);
stem(t_low, x_sampled, 'r', 'filled'); 
title('Sampled 100 Hz Sine Wave (500 Hz Sampling Rate)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
