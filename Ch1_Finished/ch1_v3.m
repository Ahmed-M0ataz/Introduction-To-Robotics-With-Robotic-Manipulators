%%
% animate rotation matrix around x
clc; clear;
Rx = rotx(-pi/3);
tranimate(Rx);
%% 
% animate rotation matrix around y
clc; clear;
Ry = roty(-pi/3);
tranimate(Ry);
%% 
% animate rotation matrix around z
Rz = rotz(-pi/3);
tranimate(Rz);
%% 
% check properties of rotation matrix
Rx = rotx(pi/3);
% columns are mutually orthogonal and unit length
dot(Rx(:,1), Rx(:,2))
dot(Rx(:,1), Rx(:,3))
% rows are mutually orthogonal and unit length
dot(Rx(1,:), Rx(2,:))
dot(Rx(1,:), Rx(3,:))
% determinant is one
det(Rx)

%%
% check noncommutavity of rotation matrices
Rx = rotx(pi/2);
Ry = roty(pi/3);

Rxy = Rx * Ry;
Ryx = Ry * Rx;

tranimate(Ryx);

%%
% check composition of rotation matrices
% rotation about current frame (postmultiplication)
Rx = rotx(pi/2);
Ry = roty(pi/3);
Rxy = Rx * Ry;

tranimate(Rxy)

% rotation about fixed fram (premultiplication)
Ryx = Ry * Rx;
tranimate(Ryx);