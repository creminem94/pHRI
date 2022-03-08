function dataPoints = kalmanSmoother(dataPoints,A)
    %in notation X k|N the index i in dataPoints is related to the left k
    N = length(dataPoints);
    for i=N:-1:1
        if i == N
            dataPoints(i).xs_k_N = dataPoints(i).xf_k_k;
            dataPoints(i).Ps_k_N = dataPoints(i).Pf_k_k;
        else
            K = dataPoints(i).Pf_k_k*A'*inv(dataPoints(i).Pf_kp1_k);
            dataPoints(i).xs_k_N = dataPoints(i).xf_k_k+K*(dataPoints(i+1).xs_k_N-dataPoints(i).xf_kp1_k);
            dataPoints(i).Ps_k_N = dataPoints(i).Pf_k_k+K*(dataPoints(i+1).Ps_k_N-dataPoints(i).Pf_kp1_k);
        end
    end
end

