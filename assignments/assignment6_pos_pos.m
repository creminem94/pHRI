% assignment 6 delay
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 0.1; %5

%master robot controller
Bm = 80;%0.8;
Km = 100;%1;

%slave robot impedance
Ms = 2;
Ds = 0; %10

%slave robot controller (four time the mass of master, so we multiply the controller)
Bs = 80*4;%100;
Ks = 100*4;%0;

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

%env params
Be = 0;%100;
Ke = 200;
xe = 1.5;

%input force
A = 1;
Fc = 0.5;
Ts = 0.001;

delayT = 5;
b = 1;
% low pass filter
Fip = 10;

open('simulink_models/delay_pos_pos.slx');
out = sim('simulink_models/delay_pos_pos.slx', 10);