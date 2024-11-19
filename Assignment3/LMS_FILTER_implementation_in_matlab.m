% Input signal (x), desired signal (d), and filter order (N)
x = randn(1, 1000);        % Example input signal (noise)
d = filter([1, -0.9], 1, x) + 0.1*randn(1, 1000);  % Desired signal (filtered version of x with noise)

N = 32;                    % Filter order
mu = 0.01;                 % Step size (learning rate)

% Initialize the filter coefficients
w = zeros(1, N);

% Preallocate error signal and output
y = zeros(1, length(x));   % Output of the filter
e = zeros(1, length(x));   % Error signal

% LMS Algorithm
for n = N+1:length(x)
    % Create input vector of length N (using past N values of x)
    x_n = x(n:-1:n-N+1);
    
    % Filter output
    y(n) = w * x_n';  % Compute the output y(n)
    
    % Error signal
    e(n) = d(n) - y(n);  % Compute the error
    
    % Update filter coefficients
    w = w + mu * e(n) * x_n;  % LMS update rule
end

% Plot results
subplot(3, 1, 1);
plot(x);
title('Input Signal (x)');

subplot(3, 1, 2);
plot(d);
title('Desired Signal (d)');

subplot(3, 1, 3);
plot(e);
title('Error Signal (e)');
