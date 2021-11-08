function vs_control()
clc; close all;

global psi a b c A B K x_d xd_d
global counter ss u

counter = 1;
dim_ = 124885;
ss = zeros(dim_, 1);
u = zeros(dim_, 1);

x_d = 2;
xd_d = 0;
a = 8;
b = 15;
A = [0 1; -b -a];
B = [0; 1];
c = 10;
K = 150;
psi = 0;

tspan = [0 2];
init_cond = [0 0];

figure()
hold on

options = odeset('Events', @terminate);
xinitial = init_cond;
[tout, stateout] = ode45(@(tout, stateout) Derivatives(tout, stateout), tspan, xinitial, options);

xout = stateout(:,1);
xdotout = stateout(:,2);

e = ones(size(xout)) * x_d - xout;
ed = ones(size(xdotout)) * xd_d - xdotout;

plot(e, ed);
hold on
plot(x_d - xinitial(1), xd_d - xinitial(2), 'r*');
hold on

xlim([-1, 3]);
ylim([-15, 2]);

xLimits = get(gca,'XLim');
yLimits = get(gca,'YLim');

% [V, D] = eig(A);
% e1 = V(:, 1);
% e2 = V(:, 2);
% 
% m = (0 - e1(2)) / (0 - e1(1));
% b_ = e1(2) - m * e1(1);
% y1 = m * xLimits(2) + b_;
% y2 = m * xLimits(1) + b_;
% hold on
% line([xLimits(2) xLimits(1)], [y1 y2], 'Color', 'blue', 'LineStyle', '--');

m = -c;
b_ = 0;
y1 = m * xLimits(2) + b_;
y2 = m * xLimits(1) + b_;
hold on
line([xLimits(2) xLimits(1)], [y1 y2], 'Color', 'red', 'LineStyle', '--');

hold on
plot(0 , 0, 'o', 'Color', 'green');
hold off
xlabel('e'); 
hLeg = ylabel('$$\dot{e}$$');
set(hLeg,'Interpreter','latex');

figure()
plot(tout, ss(1:dim_, 1));

tout


function dstatedt = Derivatives(t, state)
x = state(1);
xdot = state(2);

global A B K x_d xd_d c counter u ss

e = x_d - x;
ed = xd_d - xdot;

ss(counter) = ed + c * e;

u(counter) = K * sign(ss(counter));
counter = counter + 1;
dstatedt = A * state + B * u(counter - 1);

function [val, isterminal, dir] = terminate(~, state)
global x_d xd_d
val = ( ( abs(x_d - state(1)) <= 0.05) & ( abs(xd_d - state(2)) <= 0.05 ) );
isterminal = 1;
dir = 0;