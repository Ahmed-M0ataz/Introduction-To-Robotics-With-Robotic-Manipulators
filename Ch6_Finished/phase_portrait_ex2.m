clc; close all;

a = 8;
b = 15;
c = 10; % coefficiet of sliding surface

global A
A = [0 1; -b -a];

tspan = [0 10];
angles = 0:0.1*pi:2*pi;

init_conds = zeros(length(angles), 2);
r = 2;

for i = 1:1:length(angles)
    init_conds(i, :) = [r*sin(angles(i)), r*cos(angles(i))];
end

figure()
hold on

for i = 1:1:length(angles)
    [tout, stateout] = ode45(@(tout, stateout) Derivatives(tout, stateout), tspan, init_conds(i, :));
    xout = stateout(:,1);
    xdotout = stateout(:,2);
    plot(xout, xdotout, 'color', 'b');
    hold on
    plot(init_conds(i, 1), init_conds(i, 2), 'r*');
end

xlim([-2.5, 2.5]);
ylim([-2.5, 2.5]);

[V, D] = eig(A);
v1 = V(:, 1);
v2 = V(:, 2);

xlims = get(gca,'XLim');
ylims = get(gca,'YLim');

m = (v1(2) - 0) / (v1(1) - 0);
b = v1(2) - m * v1(1);
y1 = m*xlims(1) + b;
y2 = m*xlims(2) + b;
hold on
line([xlims(1) xlims(2)],[y1 y2], 'color', 'r');

m = (v2(2) - 0) / (v2(1) - 0);
b = v2(2) - m * v2(1);
y1 = m*xlims(1) + b;
y2 = m*xlims(2) + b;
hold on
line([xlims(1) xlims(2)],[y1 y2], 'color', 'r');

m = -c;
b = 0;
y1 = m*xlims(1) + b;
y2 = m*xlims(2) + b;
hold on
line([xlims(1) xlims(2)],[y1 y2], 'color', 'g');

function dstatedt = Derivatives(~, state)
global A

dstatedt = A * state;
end