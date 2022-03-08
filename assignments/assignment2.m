% Assignment 2
% Implement the Four-Channel bilateral teleoperation architecture with local force
% feedback.
% Same parameters as in the HW #1. Cmf and Csf can be chosen as constants.
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 0;

%master robot controller
Bm = 8;%0.8;
Km = 10;%1;

%slave robot impedance
Ms = 2;
Ds = 0;

%slave robot controller
Bs = 8*4;
Ks = 10*4;

%inner controllers
Cmf = -0.67;
Csf = -0.67;
C3 = 1+Csf;
C2 = 1+Cmf;

%operator impedance params
Jh_i = 0;
Bh_i = 1.5;
Kh_i = 1;

%operator controller
Dh = 50;
Kh = 50;

%env params
Be = 0;%100;
Ke = 200;
xe = 1.5;

%input force
Fip = 10;
A = 1;
Fc = 0.5;
Ts = 0.001;

% Kalman
Ak = [ 1 Ts 
      0  1 ];
Ck = [1 0 ];
Bk = [Ts^2/2; Ts];

x0k = [0 0];

qk = 0.01;
Rk = qk*0.0001;
Qk = qk*Bk*Bk';
open('simulink_models/four_channel_bilateral_teleoperation.slx');
sim('simulink_models/four_channel_bilateral_teleoperation.slx', 10);


%% in contact
xe = 0.7;
sim('simulink_models/four_channel_bilateral_teleoperation.slx', 10);
