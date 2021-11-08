clc; clear; close all;

%% Define state space parameters
a = 5.3;
b = 1.5;
A = [0 1; -b -a];
B = [0; 0];
C = eye(2);
D = zeros(2, 1);

%% Run simulation
for y0 = -2:1:2
    for yd0 = -2:1:2
        init_conds = [y0, yd0];
    end
end
y0 = -2:1:2;
yd0 = -2:1:2;