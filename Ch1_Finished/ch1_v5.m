%% Euler angles
R1 = rotz(0.5) * roty(0.1) * rotz(0.3); % ZYZ
R2 = eul2r(0.5, 0.1, 0.3); % from euler to rot matrix
R1 == R2

% find euler angles from rot matrix
clc;
R1

e_angles = tr2eul(R1);
R = eul2r(0.5, -0.1, 0.3);
e_angles = tr2eul(R);
eul2r(e_angles)

% case two. if theta is 0, r13 and r23 0f rot matrix becomes 0
R = eul2r(0.5, 0, 0.3)
% so when finding euler angles  there are infinitely many solutions
tr2eul(R) % by convention angle phi is zero

%% roll pitch yaw

% roll pitch yaw to rot matrix (default ZYX)
R = rpy2r(0.5, 0.1, 0.3)

% find angles from rot matrix
tr2rpy(R)

% to visualize rpy
tripleangle

%% axis angle representation
R = eul2r(0.5, 0.1, 0.3)
[theta, v] = tr2angvec(R)

% eigenvalues and eigenvectors of R
[x, e] = eig(R)

% eig = cos(theta)+-i*sin(theta)
theta = angle(e(1,1))

% from angle vector to rot matrix (Rodrigues formula)
R = angvec2r(pi/2, [1 0 0])
R = rotx(pi/2)

%% unit quaternions
q1 = UnitQuaternion(rpy2tr(0.5, 0.1, 0.3))
q2 = UnitQuaternion(rpy2tr(0.1, 0.2, 0.3))

q3 = q1+q2
q4 = q1*q2

R1 = rpy2tr(0.5, 0.1, 0.3);
R2 = rpy2tr(0.1, 0.2, 0.3);
R3 = R1 * R2
q5 = UnitQuaternion(R3)

q6 = inv(q1) % conjequate of unit quaternion
q7 = q1 * q6 % identity quaternion which represents null rotation

% convert from quaternion to rot matrxix
R = q1.R
q1.plot()
% obtain rotated vector by multiplying quaternion with vector
res = q1*[1 0 0]'

plot3([0 1], [0 0], [0 0]);
hold on
plot3([0 res(1)], [0 res(2)], [0 res(3)]);
legend('original', 'rotated')
