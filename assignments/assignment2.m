% Assignment 2
% Implement the Four-Channel bilateral teleoperation architecture with local force
% feedback.
% Same parameters as in the HW #1. Cmf and Csf can be chosen as constants.
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 0;

%master robot controller
Bm = 100;%0.8;
Km = 0;%1;

%slave robot impedance
Ms = 2;
Ds = 0;

%slave robot controller (four time the mass of master, so we multiply the controller)
Bs = 100;
Ks = 0;

%inner controllers
C3 = 1;
C2 = 1;
Cmf = -0.67;
Csf = -0.67;

%operator impedance params
Jh_i = 1;
Bh_i = 70;
Kh_i = 2000;

%operator controller
Dh = 700;
Kh = 13000;

%env params
Be = 0;%100;
Ke = 200;
xe = 0.5;

% Kalman
Ak = [ 1 Ts Ts^2/2
      0  1  Ts
      0  0   1     ];

Ck = [1 0 0];
Bk = [Ts^3/6; Ts^2/2; Ts];
x0k = [0 0];

qk = 0.01;
Rk = qk*0.0001;
Qk = qk*Bk*Bk';

%input force
A = 1;
Fc = 1;
Ts = 0.001;
% open('simulink_models/four_channel_bilateral_teleoperation.slx');
out = sim('simulink_models/four_channel_bilateral_teleoperation.slx', 10);
figure;
plot(out.forces.time, out.forces.data(:,1), out.forces.time, out.forces.data(:,2));
legend('fm','fe');
title('Forces');
figure;
plot(out.velocities.time, out.velocities.data(:,1), out.velocities.time, ...
    out.velocities.data(:,2), out.velocities.time, out.velocities.data(:,3));
legend('xm_dot','xs_dot','des_x_dot');
title('Velocities');

