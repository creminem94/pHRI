function [pred, beta] = RLS(X, Y, p0, lambda)
    if nargin == 3 || lambda > 1 || lambda <= 0
        lambda = 1;
    end
    x = X(1,:);
    y = Y(1);
    p = p0;
    beta = p*x'*y;
    pred(1) = x*beta;
    for i=2:length(Y)
        x = X(i,:);
        y = Y(i);
        e = y - x*beta;
        p = (p-(p*x'*x*p)/(lambda+x*p*x'))/lambda;
        k = p*x';
        beta = beta + k*e;
        pred(i) = x*beta;
    end
end

