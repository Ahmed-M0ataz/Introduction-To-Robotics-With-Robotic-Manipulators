%% What to analyse:
% Inspect eigenvalues
% Inspect eigenvectors
% Convergence and Divergence
% Sliding surface
% why variable structure controller
% inspect from unstable system to asymptotically stable system

%% Analyse eigenvalues of system
% xdd - ksi xd + psi x = 0
clc; clear all; close all;
syms ksi psi;
A = [0 1; -psi ksi];
[V, D] = eig(A);
%D = subs(D, 'psi', 'a');
%D(1, 1)  % ksi/2 - (ksi^2 / 4 - a)^0.5     > 0 (complex) : unstable eigval
%oscillatory
%D(2,2)   % ksi/2 + (ksi^2 / 4 - a)^0.5     > 0 (complex) : unstable eigval
%oscillatory

% psi = -a    1 stable root, 1 unstable root    unstable system
% psi = a     1 unstable root, 1 unstable root  unstable system   a < ksi *
% ksi / 4
% psi = a     1 unstable root, 1 unstable root  unstable system   a > ksi *
% ksi / 4 (oscillatory)

%% Analyse phase plot of the system
clc; clear all; close all;

global A

ksi = 2;
a = ksi * ksi * 0.25 * 2;
psi = a;

A = [0 1; -psi ksi];

tspan = [0 5];

figure()
hold on

for x = -2:1:2
    for xdot = -2:1:2
        xinitial = [x, xdot];
        [tout, stateout] = ode45(@(tout, stateout) Derivatives(tout, stateout), tspan, xinitial);
        xout = stateout(:,1);
        xdotout = stateout(:,2);
        plot(xout, xdotout, 'k');
        hold on
        plot(xinitial(1), xinitial(2), 'g*');
    end
end

hold on
plot(0, 0, 'r*');

[V, D] = eigs(A);

v1 = V(:, 1);
v2 = V(:, 2);

xlims = get(gca,'XLim');
ylims = get(gca,'YLim');

m = (v1(2) - 0) / (v1(1) - 0);
b = v1(2) - m * v1(1);
y1 = m*xlims(1) + b;
y2 = m*xlims(2) + b;
hold on
line([xlims(1) xlims(2)],[y1 y2], 'color', 'b');

m = (v2(2) - 0) / (v2(1) - 0);
b = v2(2) - m * v2(1);
y1 = m*xlims(1) + b;
y2 = m*xlims(2) + b;
hold on
line([xlims(1) xlims(2)],[y1 y2], 'color', 'r');

function dstatedt = Derivatives(t, state)
global A

dstatedt = A * state;
end