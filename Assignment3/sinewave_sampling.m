% Original sine wave
f1 = 10; % Frequency of the sine wave (10 Hz)
f2 = 20;
t = linspace(0, 0.2, 100000);     % High-resolution time vector (100,000 points)
y = sin(2 * pi * f1 * t) +  sin(2 * pi * f2 * t);         % Original sine wave

% Plot the original sine wave
figure;
plot(t, y);
title('Original Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Step 1: Choose a sampling rate (e.g., 50 Hz)
fs = 100;                          % Sampling rate (50 samples per second)

% Step 2: Create the new time vector with fewer samples
t_sampled = 0:1/fs:0.2;           % New time vector with sampling rate fs
y_sampled = sin(2 * pi * f1 * t_sampled) +  sin(2 * pi * f2 * t_sampled);  % Sampled sine wave

% Step 3: Plot the sampled sine wave
figure;
stem(t_sampled, y_sampled, 'r', 'filled');  % Use stem to show discrete samples
title('Sampled Sine Wave at 50 Hz');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;


figure;
plot(t, y, 'b', 'LineWidth', 1.5);           % Plot the original sine wave in blue
hold on;                                     % Keep the current plot
stem(t_sampled, y_sampled, 'r', 'filled');   % Plot the sampled sine wave in red
title('Original and Sampled Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original Sine Wave', 'Sampled Sine Wave');
grid on;
