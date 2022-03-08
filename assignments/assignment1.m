% Assignment 1
% Implement the Single-Input Single-Output Four-channel bilateral teleoperation
% architecture with Cm = Bm+Km/s, Cs=Bs+Ks/s, inv(Zm)=1/Mm*s,
% inv(Zs)=1/Ms*s with Mm = 0.5 and Ms = 2;
close all
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 0;

%master robot controller
Bm = 0.8;%0.8;
Km = 1;%1;

%slave robot impedance
Ms = 2;
Ds = 0;

%slave robot controller (four time the mass of master, so we multiply the controller)
Bs = 0.8*4;
Ks = 1*4;

%inner controllers
C3 = 1;
C2 = 1;
Cmf = 0;
Csf = 0;

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

Fip = 10;

%input force
A = 1;
Fc = 0.5;
Ts = 0.001;

% Kalman

Ak = [ 1 Ts 
      0  1 ];
Ck = [1 0 ];
Bk = [Ts^2/2; Ts];

x0k = [0 0];

qk = 10000;
Rk = 1;
Qk = qk*Bk*Bk';

open('simulink_models/four_channel_bilateral_teleoperation.slx');
out = sim('simulink_models/four_channel_bilateral_teleoperation.slx', 10);

%% in contact
xe = 0.7;
sim('simulink_models/four_channel_bilateral_teleoperation.slx', 10);

%% What happens if invZm =1/(Mm*s+Dm),invZs=1/(Ms*s+Ds) with Dm=5 and Ds=10
Dm = 5;
Ds = 10;
qk = 10000;
Rk = 1;
Qk = qk*Bk*Bk';
out = sim('simulink_models/four_channel_bilateral_teleoperation.slx',10);
