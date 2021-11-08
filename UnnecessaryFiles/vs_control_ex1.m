function vs_control()
clc; close all;

global psi a1 a2

a1 = 2;
a2 = 0.5;
psi = a1^2;
tspan = [0 20];
init_cond = [-2 2];

figure()
hold on

xinitial = init_cond;
[tout, stateout] = ode45(@(tout, stateout) Derivatives(tout, stateout), tspan, xinitial);

xout = stateout(:,1);
xdotout = stateout(:,2);

plot(xout, xdotout);
hold on
plot(xinitial(1), xinitial(2), 'r*');
hold on

xlim([-3 2]);
ylim([-2 3]);
xlabel('x'); 
hLeg = ylabel('$$\dot{x}$$');
set(hLeg,'Interpreter','latex');

xLimits = get(gca,'XLim');
yLimits = get(gca,'YLim');

p11 = [0 0];
p12 = [yLimits(1) yLimits(2)];
line(p11, p12, 'Color', 'black');
hold on
p21 = [xLimits(1) xLimits(2)];
p22 = [0 0];
line(p21, p22, 'Color', 'black');
hold on
circle([0, 0], 0.05, 'Color', 'green');
hold off

legend('phase portrait', 'initial cond');

function dstatedt = Derivatives(t, state)
x = state(1);
xdot = state(2);

global psi a1 a2

if x * xdot > 0
    psi = a1^2;
elseif x * xdot < 0
    psi = a2^2;
end

A = [0 1; -psi 0];

dstatedt = A * state;