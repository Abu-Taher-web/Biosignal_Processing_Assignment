function [best_m, best_c, best_w, best_mse] = findBestFilterParameters(chestECG, abdomenECG, fetalECG, m_list, c_list, mu_max)
% Number of initial samples to skip during evaluation
INITIAL_REJECTION = 2000;

% Initialize variables to track the best results
best_mse = Inf; % Start with a very large MSE
best_m = 0;
best_c = 0;
best_w = [];

% Ensure m_list and c_list are column vectors
m_list = m_list(:);
c_list = c_list(:);

% Iterate over all combinations of filter lengths (m) and step size fractions (c)
for m = m_list'
    for c = c_list'
        % Calculate the step size for the current fraction c
        step = (2* c * mu_max)/m;

        % Perform LMS filtering using the current m and step size
        [y, e, w] = doLMSFiltering(m, step, chestECG, abdomenECG);

        % Evaluate the result using the known fetal ECG
        mse = evaluateResult(e);

        % Update the best parameters if the current MSE is lower
        if mse < best_mse
            best_mse = mse;
            best_m = m;
            best_c = c;
            best_w = w;
        end
    end
end

    function [y, e, w] = doLMSFiltering(m, step, r, x)
      

        % Create the LMS filter object
        lmsFilter = dsp.LMSFilter('Length', m, 'StepSize', step);

        % Apply the filter to the input signals
        [y, e, w] = lmsFilter(r, x); % y is the filtered signal, e is the error (signal of interest)
    end

    function mse = evaluateResult(v)
        % Skip initial samples to avoid transient effects
        v_eval = v(INITIAL_REJECTION+1:end);
        fetalECG_eval = fetalECG(INITIAL_REJECTION+1:end);

        % Compute the mean squared error
        mse = immse(v_eval, fetalECG_eval);
    end
end
