% Load problem3.mat to have access to variables abd_sig1 and mhb_ahead
load('problem3.mat');

% The sampling rates are 1000 Hz
FS = 1000;

% Calculate sample timing vector in seconds starting from 0
t = (0:length(abd_sig1)-1) / FS;

% Estimate the time lag using cross correlation with the 'xcorr' function
% Fit a spline to the cross correlation using 'spline' function, and then find the delay with maximum correlation using 'fnmin'
% NOTE: to use minimization function for maximization, please invert the objective function!
[xcorr_vals, lags] = xcorr(abd_sig1, mhb_ahead, 'normalized');
xcorr_vals = xcorr_vals';
spl = spline(lags, xcorr_vals);
[maxval, maxlocation] = fnmin(fncmb(spl,-1));
d = maxlocation;


% Shift the chest ECG mhb_ahead back in time d samples
% Use linear interpolation with extrapolation with the function 'interp1'
data = mhb_ahead;
indices = 1: length(data);
delayed_indices = indices - d;
mhb = interp1(indices, data, delayed_indices, 'linear', 'extrap')';

% Estimate c2 from abd_sig1 and mhb
c2 = (mhb' * abd_sig1) / (mhb' * mhb);


% Calculate the fetal ECG by cancelling out the scaled mother's ECG using projection based estimation coefficient
fetus = abd_sig1 - c2 * mhb;
figure;
plot(lags, xcorr_vals);