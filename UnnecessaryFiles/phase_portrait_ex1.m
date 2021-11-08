function phase_portraits()
clc; close all;

global psi a1 a2

a1 = 2;
a2 = 0.5;
psi_vals = [a1^2 a2^2];

tspan = [0 20];
init_cond = [-5 5];

figure()
hold on

xinitial = init_cond;
for i=1:2
    psi = psi_vals(i);
    [tout, stateout] = ode45(@(tout, stateout) Derivatives(tout, stateout), tspan, xinitial);
    xout = stateout(:,1);
    xdotout = stateout(:,2);
    plot(xout, xdotout);
    hold on
end

plot(xinitial(1), xinitial(2), 'r*');

hold on

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
plot(0 , 0, 'o', 'Color', 'green');
hold off

legend('\psi={a_1}^2', '\psi={a_2}^2', 'initial cond')
xlabel('x'); 
ylabel('xdot');

function dstatedt = Derivatives(t, state)
global psi

A = [0 1; -psi 0];

dstatedt = A * state;