% assignment 6 delay
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 5; %5

%master robot controller
Bm = 0;%80;%0.8;
Km = 0;%100;%1;

%slave robot impedance
Ms = 2;
Ds = 0; %10

%slave robot controller 
%for position-force channel the input of the controller is the error, not
%the real velocity
Bs = 80;%100;
Ks = 100;%0;

%inner controllers
C3 = 1;
C2 = 1;

%operator impedance params
Jh_i = 0;
Bh_i = 1.5;
Kh_i = 1;

%operator controller
Dh = 50;
Kh = 50;

%input force
A_int = 1;

%env params
Be = 0;%100;
Ke = 200;
xe = 1.5;

Ts = 0.001;

delayT = 1;
b = 1;
Fip = 10;
Fc = 0.5;

open('simulink_models/delay_force_pos.slx');
out = sim('simulink_models/delay_force_pos.slx', 10);

%%
A = [1 Ts
    0 1];
B = [Ts^2/2;Ts];
x0 = [0 0];
C = [1 0];
q_m = 10000000;
R = 1;
Q_m = q_m*B*B';
q_s = 10000000;
Q_s = q_s*B*B';
xe = 1.5;

open('simulink_models/delay_force_pos_kalman.slx');
out = sim('simulink_models/delay_force_pos_kalman.slx', 10);