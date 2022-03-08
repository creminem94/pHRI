function dataPoints = kalmanFilter(y, x0, P0, A, C, Q, R)
    %in notation X k|k the index i in dataPoints is related to the right k
    N = length(y);
    for i = 1:N
        %position
        dataPoints(i).y = y(i);
        if i == 1
            dataPoints(i).xf_k_k = x0;
            dataPoints(i).Pf_k_k = P0;
        else
            prevPoint = dataPoints(i-1);
            prevP = prevPoint.Pf_kp1_k;
            K = prevP*C'*inv(C*prevP*C'+R);
            dataPoints(i).xf_k_k = prevPoint.xf_kp1_k+K*(dataPoints(i).y-C*prevPoint.xf_kp1_k);
            dataPoints(i).Pf_k_k = prevP-K*C*prevP;
        end
        dataPoints(i).xf_kp1_k = A*dataPoints(i).xf_k_k;
        dataPoints(i).Pf_kp1_k = A*dataPoints(i).Pf_k_k*A' + Q;
    end
end

