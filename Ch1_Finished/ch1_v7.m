clc; clear;

%% Animating homogenous transformation matrix
% transl(1, 0, 0) * trotx(pi/2) * transl(0, 1, 0)
% translate 1 unit in x direction
% rotate about x direction
% translate 1 unit in the current y direction
T1 = transl(1, 0, 0) * trotx(pi/2) * transl(0, 1, 0);
% animate transformation
tranimate(T1);

%% Transforming vector
clc; clear;
v1 = [1;2;1];

% draw reference frame
T0 = eye(3);
%trplot(T0, 'frame', '0');

T1 = transl(1, 0, 0) * trotx(pi/2) * transl(0, 1, 0);
% make homogenous coordinate
v1_h = [v1; 1];
v2_h = T1 * v1_h;
v2 = v2_h(1:3);

% plot vectors
plot3([0 v1(1)], [0 v1(2)], [0 v1(3)]);
xlim([-5, 5])
ylim([-5, 5])
zlim([-5, 5])
hold on
plot3([0 v2(1)], [0 v2(2)], [0 v2(3)]);

%% Composition of transformation matrices
clc; clear;
T0 = transl(1, 0, 0) * troty(pi/2) * transl(0, -1, 0);

trplot(T0, 'frame', '0');
xlim([-3, 3])
ylim([-3, 3])
zlim([-3, 3])
hold on
% create one more homogenous transformation matrix (rigid motion)
T1 = transl(1, 0, 0) * trotx(pi/2) * transl(0, 1, 0);

% rigid motion about current axis
T2 = T0 * T1;
trplot(T2, 'frame', '1');

% rigid motion about fixed axis
T3 = T1 * T0;
trplot(T3, 'frame', '2');