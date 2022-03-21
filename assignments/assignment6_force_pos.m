% assignment 6 delay
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 5;

%slave robot impedance
Ms = 2;
Ds = 0;

%slave robot controller 
Bs = 100;
Ks = 80;

%operator impedance params
Jh_i = 0;
Bh_i = 1.5;
Kh_i = 1;

%operator controller
Dh = 5;
Kh = 2;

%input force
A_int = 1;

%env params
Be = 10;
Ke = 200;
xe = 1.5;

Ts = 0.001;

delayT = 10;
b = 1;
Fip = 10;
Fc = 0.5;

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
posNoiseVariance = 0;
forceNoiseVariance = 0;

open('simulink_models/delay_force_pos.slx');
sim('simulink_models/delay_force_pos.slx', 30);

%% in contact
xe = 0.7;
sim('simulink_models/delay_force_pos.slx', 30);
%% with noise
posNoiseVariance = 0.00001;
forceNoiseVariance = 0.00001;
xe = 0.7;

out = sim('simulink_models/delay_force_pos.slx', 30);