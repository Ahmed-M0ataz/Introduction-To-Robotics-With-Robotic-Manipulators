clc; clear all; close all;

% Boundary conditions

qi = 10;
qf = 30;
dqi = 0;
dqf = 0;
ddqi = 0;
ddqf = 0;
ti = 0;
tf = 1;

a = calculateCoefficients([qi qf], [dqi dqf], [ddqi ddqf], [ti, tf]);

ts = 0.001;
t = (ti-0.2):ts:(tf+0.2);

qt = zeros(1, length(t));
dqt = zeros(1, length(t));
ddqt = zeros(1, length(t));

for i=1:1:length(t)
    if (t(i) < ti)
        qt(i) = qi;
        dqt(i) = 0;
        ddqt(i) = 0;
    elseif (t(i) > tf)
        qt(i) = qf;
        dqt(i) = 0;
        ddqt(i) = 0;
    else
        qt(i) = a(1) + a(2) * t(i) + a(3) * t(i)^2 + a(4) * t(i)^3 + a(5) * t(i)^4 + a(6) * t(i)^5;
        dqt(i) = a(2) + 2 * a(3) * t(i) + 3 * a(4) * t(i)^2 + 4 * a(5) * t(i)^3 + 5 * a(6) * t(i)^4;
        ddqt(i) = 2 * a(3) + 6 * a(4) * t(i) + 12 * a(5) * t(i)^2 + 20 * a(6) * t(i)^3;
    end
end

subplot(1, 3, 1);
plot(t, qt)
ylim([0, 40]);
title('Orientation') % 5'th order function

subplot(1, 3, 2);
plot(t, dqt)
ylim([-10, 40]);
title('Velocity') % 4'th order function

subplot(1, 3, 3);
plot(t, ddqt)
ylim([-150, 150]);
title('Acceleration') % 3'rd order function