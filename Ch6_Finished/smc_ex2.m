clc; clear; close all;

%% Define parameters
init_conds = [2, 5];

ksi = 2;
a = ksi * ksi * 0.25 * 2;
c = 0.5 * ksi - (0.25 * ksi * ksi + a)^0.5;

%init_conds = [2, 2*c];

T = 10;

%% Run the simulation and get outputs
sim('SMC_ex2.slx', T);

%% Plot the outputs
tout = ans.tout;
% Plot phase portrait
x = ans.states.Data(:, 1);
xd = ans.states.Data(:, 2);
figure();
plot(x, xd);
xlabel('x');
ylabel('x_dot');
hold on
plot(0, 0, 'or', 'MarkerSize', 10);
hold on
plot(init_conds(1), init_conds(2), 'og', 'MarkerSize', 10);
hold off
xlim([-5, 5]);
ylim([-5, 5]);