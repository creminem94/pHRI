% assignment 7 tank
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 0; %5

%master robot controller
Bm = 20;%0.8;
Km = 100;%1;

%slave robot impedance
Ms = 2;
Ds = 0; %10

%slave robot controller 
Bs = 50*4;%100;
Ks = 100*4;%0;

%inner controllers
C3 = 1;
C2 = 1;

%operator impedance params
Jh_i = 0;
Bh_i = 1.5;%70;
Kh_i = 1;%2000;

%operator controller
Dh = 50;
Kh = 50;

%env params
Be = 10;%100;
Ke = 200;
xe = 1.5;

%input force
A = 1;
Fc = 0.5;
Ts = 0.001;

delayT = 5;
b = 1;
tlcAlpha = 0.9;
Hd = 1;
beta = 0.9;
Fip = 10;
Hm_init = 100;
Hs_init = 0;

open('simulink_models/tank_based_pos_pos.slx');
out = sim('simulink_models/tank_based_pos_pos.slx', 10);
