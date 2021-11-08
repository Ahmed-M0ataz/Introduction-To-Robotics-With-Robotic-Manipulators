clc; clear; close all;

% define some variables
N = 6; % number of joints

syms th1 th4 th5 th6 d2 d3

H = sym(zeros(4, 4, N));
R = sym(zeros(3, 3, N));
d_ = sym(zeros(3, 1, N));
J = sym(zeros(6, 1, N));

l1 = 0.4;
l2 = 0.3;
l3 = 0.3;
l4 = 1.0;
l5 = 0.3;
l6 = 0.4;
type = ['r', 'p', 'p', 'r', 'r', 'r']; % type of joints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define DH parameters
theta = [th1 -pi/2 0 th4 th5 th6];
alpha = [0 -pi/2 0 pi/2 -pi/2 0];
r = zeros(1, 6);
d = [l1 l2+d2 l3+d3 l4 0 l5+l6];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate individual HTMs
for i=1:N
    % H_i  ====> HTM from frame i to frame i-1
    H(:,:,i) = [
        cos(theta(i)) -sin(theta(i))*cos(alpha(i)) sin(theta(i))*sin(alpha(i))  r(i)*cos(theta(i));...
        sin(theta(i)) cos(theta(i))*cos(alpha(i))  -cos(alpha(i))*sin(alpha(i)) r(i)*sin(theta(i));...
        0             sin(alpha(i))                cos(alpha(i))                d(i);...
        0             0                            0                            1;...
    ];
    %vpa(H(:,:,i), 4)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract rotational and translational transformation matrices from HTM
% H_1_0    ====> H_1_0
% H_2_0    ====> H_1_0 * H_2_1
% H_3_0    ====> H_1_0 * H_2_1 * H_3_2
for i=1:N
    H_cumulated = sym(eye(4,4));
    for j=1:i
        H_cumulated = H_cumulated * H(:,:,j);
    end
    R(:,:,i) = H_cumulated(1:3, 1:3);  % R_i_0
    d_(:,1,i) = H_cumulated(1:3, 4);   % d_i_0
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate Jacobian
for i=1:N
    if i == 1
        R_current = eye(3,3);
        d_current = zeros(3,1);
    else
        R_current = R(:,:,i-1);
        d_current = d_(:,:,i-1);
    end
    if type(i) == 'r'
        J(1:3,1,i) = cross( R_current * [0; 0; 1], d_(:,:,N) - d_current );
        J(4:6,1,i) = R_current * [0; 0; 1];
    elseif type(i) == 'p'
        J(1:3,1,i) = R_current * [0; 0; 1];
        J(4:6,1,i) = [0; 0; 0];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms th1_d d2_d d3_d th4_d th5_d th6_d

% [xd; yd; zd; wx; wy; wz] = J * [q1_d; q2_d; q3_d; q4_d; q5_d; q6_d]

J_tot = [J(:,:,1) J(:,:,2) J(:,:,3) J(:,:,4) J(:,:,5) J(:,:,6)];
res = J_tot * [th1_d;d2_d;d3_d;th4_d;th5_d;th6_d];
vpa(res, 2)
