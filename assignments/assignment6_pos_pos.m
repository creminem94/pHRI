% assignment 6 delay
s = tf('s');

%master robot impedance
Mm = 0.5;
Dm = 0.1; %5

%master robot controller
Bm = 80;
Km = 100;

%slave robot impedance
Ms = 2;
Ds = 0;

%slave robot controller (four time the mass of master, so we multiply the controller)
Bs = 80*4;
Ks = 100*4;

%operator impedance params
Jh_i = 0;
Bh_i = 1.5;
Kh_i = 1;

%operator controller
Dh = 5;
Kh = 2;

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
% low pass filter
Fip = 10;
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

open('simulink_models/delay_pos_pos.slx');
sim('simulink_models/delay_pos_pos.slx', 30);

%% in contact
xe = 0.7;
sim('simulink_models/delay_pos_pos.slx', 30);

%% with noise
posNoiseVariance = 0.0000001;
forceNoiseVariance = 0.0000001;
xe = 0.7;

out = sim('simulink_models/delay_pos_pos.slx', 30);