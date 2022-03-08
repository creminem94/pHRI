function beta = adaptiveAlgorithm(X, Y, Ts, g)
    [rows cols] = size(X);
    beta = zeros(cols, 1);
    for i=1:length(Y)
        x = X(i,:);
        y = Y(i);
        e = y - x*beta;
        beta = beta + Ts*g*x'*e;
    end
end

