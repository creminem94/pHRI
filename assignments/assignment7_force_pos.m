% assignment 7 tank
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 0; %5

%master robot controller
Bm = 80;%0.8;
Km = 100;%1;

%slave robot impedance
Ms = 2;
Ds = 0; %10

%slave robot controller 
Bs = 80;%100;
Ks = 100;%0;

%inner controllers
C3 = 1;
C2 = 1;

%operator impedance params
Jh_i = 0;
Bh_i = 1.5;%70;
Kh_i = 1;%2000;

%operator controller
Dh = 5;
Kh = 2;

%env params
Be = 10;%100;
Ke = 200;
xe = 1.5;

%input force
A_int = 1;
Fc = 0.5;
Ts = 0.001;

delayT = 10;
b = 1;
tlcAlpha = 0.1;
Hd = 1;
beta = 0.01;
Fip = 100;
Hm_init = 1;
Hs_init = 0;

A = [1 Ts
    0 1];
B = [Ts^2/2;Ts];
x0 = [0 0];
C = [1 0];
q_m = 1000000000;
R = 1;
Q_m = q_m*B*B';
q_s = 1000000000;
Q_s = q_s*B*B';
posNoiseVariance = 0;
forceNoiseVariance = 0;

open('simulink_models/tank_based_force_pos.slx');
out = sim('simulink_models/tank_based_force_pos.slx', 30);

%% in contact
xe = 0.7;
sim('simulink_models/tank_based_force_pos.slx', 30);

%% with noise
posNoiseVariance = 0.0000001;
forceNoiseVariance = 0.000001;
xe = 0.7;

sim('simulink_models/tank_based_force_pos.slx', 30);

%% with no initial energy
Hm_init = 0;
posNoiseVariance = 0;
forceNoiseVariance = 0;
sim('simulink_models/tank_based_force_pos.slx', 30);