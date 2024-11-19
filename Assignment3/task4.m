x = load('problem4.mat');

MU_MAX = 0.05;
FILTER_LENGHTS = [1 5 11 15 21 31 51 101]'; %m_list
ADAPTATION_RATES = (0.1:0.1:1)'; %c_list
%mhb_ahead_PI = chest_ecg
%abdomenECG= abd_sig1
%fetalECG = fhb

[best_m, best_c, best_w, best_mse] = findBestFilterParameters(mhb_ahead_PI, abd_sig1, fhb, FILTER_LENGHTS, ADAPTATION_RATES, MU_MAX);