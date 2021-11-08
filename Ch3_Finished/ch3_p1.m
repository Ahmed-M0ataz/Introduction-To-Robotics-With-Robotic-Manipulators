clc; clear; close all;

% the derivative of joint variables
syms q1_d q2_d q3_d q4_d q5_d q6_d

% [xd; yd; zd; wx; wy; wz] = J * [q1_d; q2_d; q3_d; q4_d; q5_d; q6_d]

mdl_puma560

J = p560.jacob0(qn);

res = J * [q1_d; q2_d; q3_d; q4_d; q5_d; q6_d];

vpa(res, 2)

p560.teach(qn)