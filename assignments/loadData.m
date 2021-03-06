load DATA_motors_pHRI/master_slave_1kHz.txt;
Ts = 0.001;
emptyIndeces = find(master_slave_1kHz(:, 5) == 0);
lastIndex = emptyIndeces(end);
data = master_slave_1kHz(lastIndex+1:end,:);
N = length(data);
time = data(:,1);
pos_m = data(:,2);
vel_m = data(:,3);
volt_m = data(:,4);
pos_s = data(:,5);
vel_s = data(:,6);
volt_s = data(:,7);