% assignment 7 tank
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 0; %5

%master robot controller
Bm = 50;%0.8;
Km = 100;%1;

%slave robot impedance
Ms = 2;
Ds = 0; %10

%slave robot controller 
Bs = 100;
Ks = 80;

%inner controllers
C3 = 1;
C2 = 1;

%operator impedance params
Jh_i = 0;
Bh_i = 1.5;%70;
Kh_i = 1;%2000;

%operator controller
Dh = 2;
Kh = 5;

%env params
Be = 10;%100;
Ke = 200;
xe = 2;

%input force
A = 1;
Fc = 0.5;
Ts = 0.001;

delayT = 1;
b = 1;
tlcAlpha = 0.1;
Hd = 1;
beta = 0.5;
Fip = 100;
Hm_init = 30;
Hs_init = 30;

open('simulink_models/tank_based_force_pos.slx');
out = sim('simulink_models/tank_based_force_pos.slx', 10);
