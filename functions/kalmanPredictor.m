function dataPoints = kalmanPredictor(y, x0, P0, A, C, Q, R)
    %in notation X k|k the index i in dataPoints is related to the right k
    N = length(y);
    for i = 1:N
        %position
        dataPoints(i).y = y(i);
        
        if i == 1
            dataPoints(i).xf_kp1_k = x0;
            dataPoints(i).Pf_kp1_k = P0;
        else
            prevPoint = dataPoints(i-1);
            prevP = prevPoint.Pf_kp1_k;
            prevX = prevPoint.xf_kp1_k;
            K = A*prevP*C'*inv(C*prevP*C'+R);
            dataPoints(i).xf_kp1_k = A*prevX+K*(dataPoints(i).y-C*prevX);
            dataPoints(i).Pf_kp1_k = A*prevP*A'-K*C*prevP*A'+Q;
        end
    end
end

