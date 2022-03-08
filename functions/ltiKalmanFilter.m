function dataPoints = ltiKalmanFilter(y, x0, P0, A, C, Q, R, Pinf, Kinf)
    %in notation X k|k the index i in dataPoints is related to the right k
    N = length(y);
    for i = 1:N
        %position
        dataPoints(i).y = y(i);
        if i == 1
            dataPoints(i).xf_k_k = x0;
        else
            prevPoint = dataPoints(i-1);
            dataPoints(i).xf_k_k = A*prevPoint.xf_k_k+Kinf*(dataPoints(i).y-C*A*prevPoint.xf_k_k);
        end
    end
end

