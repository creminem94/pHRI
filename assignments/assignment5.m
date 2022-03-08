% assignment 5
% Identify the parameters k and  (i.e. J and D) using the LS and the RLS on the DC
% motors data.
addpath assignments;
assignment3_4; %kalman filter
close all;
% LS
X = [estimate_s(3,:)',estimate_s(2,:)']; % X=[W_dot, W]
Y = lowPassFilter(volt_m, 1, Ts);
beta_est = inv(X'*X)*X'*Y;
k_est = 1/beta_est(2);
tau_est = k_est*beta_est(1);
pred_y = X*beta_est;
fprintf("LS: k=%.4f,tau=%.4f\n", k_est, tau_est);

% RLS
p0 = eye(2)*0.01;
lambda = 0.95;
[pred_y_rls, betaRLS] = RLS(X,Y, p0, lambda);
% betaRLS is actually useless as it only the refers to the last iteration
% kRLS = 1/betaRLS(2);
% tauRLS = kRLS*betaRLS(1);
% fprintf("RLS: k=%.4f,tau=%.4f\n", kRLS, tauRLS);

%ADAPTIVE
beta_adaptive = adaptiveAlgorithm(X,Y, Ts, 0.05);
pred_y_adaptive = X*beta_adaptive;
k_adaptive = 1/beta_adaptive(2);
tau_adaptive = k_adaptive*beta_adaptive(1);
fprintf("Adaptive: k=%.4f,tau=%.4f\n", k_adaptive, tau_adaptive);

%all together
figure;
plot(time,Y, 'LineWidth',2);
hold on;
plot(time,pred_y, 'LineWidth',2);
plot(time,pred_y_rls,'--', 'LineWidth',2);
plot(time,pred_y_adaptive, 'LineWidth',2);
title('Torque');
legend("real", "LS", "RLS", "Adaptive");