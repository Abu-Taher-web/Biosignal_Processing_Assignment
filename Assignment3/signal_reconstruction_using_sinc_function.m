% Step 1: Define parameters
f1 = 10;                          % Frequency of the sine wave (10 Hz)
t_continuous = linspace(0, 0.2, 100000);  % High-resolution time vector (for continuous signal)
y_continuous = sin(2 * pi * f1 * t_continuous);  % Continuous sine wave

% Step 2: Sample the continuous signal at a lower sampling rate
fs = 100;                           % Sampling rate (50 samples per second)
t_sampled = 0:1/fs:0.2;            % New time vector for sampled signal
y_sampled = sin(2 * pi * f1 * t_sampled);  % Sampled sine wave

% Step 3: Sinc Interpolation to reconstruct the continuous signal
t_reconstructed = linspace(0, 0.2, 100000);    % Time vector for reconstruction
y_reconstructed = zeros(size(t_reconstructed)); % Initialize the reconstructed signal


% Loop over the samples and apply the sinc interpolation
for k = 1:length(t_sampled)
    % Calculate the sinc function for each sample point and add it to the result
    y_reconstructed = y_reconstructed + y_sampled(k) * sinc((t_reconstructed - t_sampled(k)) * fs);
end

% Step 4: Plot the original and reconstructed signals
figure;
plot(t_continuous, y_continuous, 'b', 'LineWidth', 1.5);  % Original sine wave (blue)
hold on;
plot(t_reconstructed, y_reconstructed, 'r--', 'LineWidth', 1.5);  % Reconstructed signal (red dashed)
stem(t_sampled, y_sampled, 'r', 'filled');   % Sampled points (red markers)
title('Sinc Interpolation for Reconstructing a Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original Sine Wave', 'Reconstructed Sine Wave (Sinc Interpolation)', 'Sampled Points');
grid on;