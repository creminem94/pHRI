% assignment 6 delay
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 0.1; %5

%master robot controller
Bm = 100;%80;%0.8;
Km = 0;%100;%1;

%slave robot impedance
Ms = 2;
Ds = 0; %10

%slave robot controller (four time the mass of master, so we multiply the controller)
Bs = 100;
Ks = 0;

%inner controllers
C3 = 1;
C2 = 1;

%operator impedance params
Jh_i = 1;
Bh_i = 70;
Kh_i = 2000;

%operator controller
Dh = 1;
Kh = 17000;

%env params
Be = 0;%100;
Ke = 200;
xe = 1;

%input force
A = 1;
Fc = 1;
Ts = 0.001;

delayT = 1;
b = 1;
% low pass filter
Fip = 10;

open('simulink_models/delay_pos_pos.slx');
out = sim('simulink_models/delay_pos_pos.slx', 10);