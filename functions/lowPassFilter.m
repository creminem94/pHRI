function data = lowPassFilter(data, Fc, Ts)
    beta = exp(-2*pi*Fc*Ts);
    for i = 2:length(data)
        data(i) = beta*data(i-1)+(1-beta)*data(i);
    end
end