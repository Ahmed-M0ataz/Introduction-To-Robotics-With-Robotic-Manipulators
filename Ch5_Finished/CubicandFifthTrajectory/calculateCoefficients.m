% function a = calculateCoefficients(qc,dqc, tc)
% 
% qi = qc(1);
% qf = qc(2);
% 
% dqi = dqc(1);
% dqf = dqc(2);
% 
% ti = tc(1);
% tf = tc(2);
% 
% b = [qi dqi qf dqf]';
% 
% M = [1 ti ti^2 ti^3; 0 1 2*ti 3*ti^2; 1 tf tf^2 tf^3; 0 1 2*tf 3*tf^2];
% 
% a = M^(-1) * b;
% 
% end

function a = calculateCoefficients(qc,dqc, ddqc, tc)

qi = qc(1);
qf = qc(2);

dqi = dqc(1);
dqf = dqc(2);

ddqi = ddqc(1);
ddqf = ddqc(2);

ti = tc(1);
tf = tc(2);

b = [qi dqi ddqi qf dqf ddqf]';

M = [1 ti ti^2 ti^3 ti^4 ti^5; 
    0 1 2*ti 3*ti^2 4*ti^3 5*ti^4; 
    0 0 2 6*ti 12*ti^2 20*ti^3;
    1 tf tf^2 tf^3 tf^4 tf^5; 
    0 1 2*tf 3*tf^2 4*tf^3 5*tf^4; 
    0 0 2 6*tf 12*tf^2 20*tf^3];

a = M^(-1) * b;

end

