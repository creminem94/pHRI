% assignment 7 tank
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 0;

%master robot controller
Bm = 10;
Km = 8;

%slave robot impedance
Ms = 2;
Ds = 0;

%slave robot controller 
Bs = 70;
Ks = 30;

%operator impedance params
Jh_i = 0;
Bh_i = 1.5;
Kh_i = 1;

%operator controller
Dh = 5;%P
Kh = 2;%I

%env params
Be = 10;
Ke = 200;
xe = 1.5;

%input force
A_int = 1;
Fc = 0.5;
Ts = 0.001;

delayT = 10;
b = 1;
tlcAlpha = 0.6;
Hd = 1;
beta = 0.3;
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

open('simulink_models/tank_based_pos_pos.slx');
out = sim('simulink_models/tank_based_pos_pos.slx', 30);

%% in contact
xe = 0.7;
sim('simulink_models/tank_based_pos_pos.slx', 30);

%% with noise
posNoiseVariance = 0.0000001;
forceNoiseVariance = 0.0000001;
xe = 0.7;

sim('simulink_models/tank_based_pos_pos.slx', 30);

%% no initial energy
Hm_init = 0;
posNoiseVariance = 0;
forceNoiseVariance = 0;
sim('simulink_models/tank_based_pos_pos.slx', 30);