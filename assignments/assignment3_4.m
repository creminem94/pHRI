% assignment 3
% kalman filter/smoother
addpath 'functions' 'assignments';
loadData;

pos = pos_s;
vel = vel_s;

q = 0.01;
R = q*0.001;
% R = std(pos);
% q = R*10000;
A = [1 Ts
    0 1];
B = [Ts^2/2;Ts];
Q = q*B*B';
C = [1 0];

x0 = [0;0];
P0 = eye(2)*0.1;

Pinf = idare(A', C', Q, R);
Kinf = Pinf*C'*inv(C*Pinf*C'+R);

dataPoints = kalmanFilter(pos, x0, P0, A, C, Q, R);
dataPoints = kalmanSmoother(dataPoints, A);
% dataPointsPred = kalmanPredictor(pos, x0, P0, A, C, Q, R);
figure;
eulerV = (pos(2:N)-pos(1:N-1))/Ts;
plot(time(1:N-1),lowPassFilter(eulerV,1, Ts),'LineWidth',2);
hold on;
plot(time,vel,'LineWidth',2);
estimate_f = [dataPoints.xf_k_k];
plot(time,estimate_f(2,:), 'LineWidth',2);
estimate_s = [dataPoints.xs_k_N];
plot(time,estimate_s(2,:), 'LineWidth',2);

dataPoints = ltiKalmanFilter(pos, x0, P0, A, C, Q, R,Pinf,Kinf);
estimate_f = [dataPoints.xf_k_k];

plot(time,estimate_f(2,:), '--','LineWidth',2);
legend("euler velocity", "sensor velocity", "kalman filter","kalman smoother","lti kalman filter");
title("Velocity");

A = [1 Ts Ts^2/2
     0  1   Ts
     0  0   1];
C = [1 0 0];

B = [Ts^3/6;Ts^2/2;Ts];
% R = std(pos);
% q = R*10000;
Q = q*B*B';

x0 = [0;0;0];
P0 = eye(3)*0.1;

dataPoints = kalmanFilter(pos, x0, P0, A, C, Q, R);
dataPoints = kalmanSmoother(dataPoints, A);
figure;
estimate_f = [dataPoints.xf_k_k];
plot(time,estimate_f(3,:));
hold on;
estimate_s = [dataPoints.xs_k_N];
plot(time,estimate_s(3,:));
legend("kalman filter","kalman smoother");
title("Acceleration");