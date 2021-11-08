% show stability in each case by eigenvalues
% a=8, b=15, c=10, yd=2, psi=0 (stable) 
% ** explain input required to make it to reach desired value
% ** (2) increase K to show amplitude increase in oscillations at output
% ** (2) change samping time and show oscillation amplitude increase
% ** explain input before and after eaching sliding surface
% same values, psi = -40 at t=1s K = 150
% ** explain input before and after eaching sliding surface
% ** show robustness against disturbance
% same values, psi = -40 at t=1s  K = 50
% ** expain pahse plot (deviation)
% ** explain reason of deviation (correct K value)
% a=-8, b=15, c=10, yd=2 (unstable) K=150
% makes unstable system asymptotically stable

clc; clear; close all;

% ydd + a*yd + b*y = u(t)
% s^2*Y(s) + s*a*Y(s) + b*Y(s) = U(s)
% G(s) = Y(s) / U(s)
% G(s) = 1 / (s^2 + a*s + b)
% G(0) = 1 / b  ===> DC gain
% 1 / b = yd / u
% 1 / 15 = 2 / u   ===> u = 30

%% Define parameters
% t1_ = [0:0.0001:1.0];
% t2_ = [1.0:0.0001:2.0];
% s1_ = zeros(1, length(t1_));
% s2_ = ones(1, length(t1_))*-40;
% s_ = [s1_, s2_]';
% disturb = timeseries(s_, [t1_, t2_]');

a = 8;
b = 15;
c = 10;
K = 4;%150;
lambda = 20;
h = 300;
yd = 2;
ydd = 0;
dist = 1;
t = 1; % when disturbance will be applied
T = 2.0; % time of simulation
f_st = 0.0001; % controller sampling time
ss_st = 0.0001; % sampling time for input block

%% Run the simulation and get outputs
sim('DIC_control.slx', T);

%% Plot the outputs
tout = ans.tout;
% Plot phase portrait
e = ans.error.Data(:, 1);
ed = ans.error.Data(:, 2);
figure();
plot(e, ed);
xlabel('e');
ylabel('e_dot');
xlim([-1, 3]);
hold on
plot(0, 0, 'o', 'MarkerSize', 10);
hold off

% % Plot sliding surface
figure();
ss = ans.ss.Data;
plot(tout, ss);
xlabel('time');
ylabel('ss');

% % Plot input u
figure();
u = ans.input.Data;
plot(tout, u);
xlabel('time');
ylabel('u');
ylim([-200, 200]);

% Plot y
figure();
y = ans.y.Data;
plot(tout, y);
xlabel('time');
ylabel('y');

% Plot i_term
% figure();
% i_term = ans.i_term.Data;
% plot(tout, i_term);
% xlabel('time');
% ylabel('i_term');

% % Plot e
figure();
plot(tout, e);
xlabel('time');
ylabel('e');
% 
% % Plot disturbance
% figure();
% psi = ans.disturbance.Data;
% plot(tout, psi);
% xlabel('time');
% ylabel('psi');
% ylim([-45, 5]);