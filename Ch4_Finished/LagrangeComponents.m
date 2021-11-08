%% Inertia matrix, M
clc; clear all; close all;

% import symbolic model of two link robot manipulator
mdl_twolink_sym;

% get the inertia matrix at angles of q1 and q2
% Detect:
%         Symmetry
%         Square matrix
%         inertia of joint i depends on configuration of joints i+1...n,
%         except the last joint
M = twolink.inertia([q1 q2]);

clc;clear all; close all;
% Detect:
%        Positive definiteness
%        Intiution in components of the matrix
mdl_puma560;
M = p560.inertia(qn);

%% Cariolis matrix, C
clc; clear all; close all;

% import symbolic model of two link robot manipulator
mdl_twolink_sym;

C = twolink.coriolis([q1 q2], [q1d q2d]);
C_torque = C * [q1d; q2d];

subs(C_torque, q1d, 0)
subs(C_torque, q2d, 0)

clc;clear all; close all;
% Detect:
%        Positive definiteness
%        Intiution in components of the matrix
mdl_puma560;
qd = [0, 0, 0, 0, 0, 1];
C = p560.coriolis(qn, qd);
C_torque = C * qd';

%% Gravity term, g
clc; clear all; close all;

mdl_puma560;
g_torque = p560.gravload(qn)
p560.plot3d(qn)