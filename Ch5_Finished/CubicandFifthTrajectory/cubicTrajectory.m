%% Single segment trajectory
clc; clear all; close all;

% Boundary conditions

qi = 10;
qf = 30;
dqi = 0;
dqf = 0;
ti = 0;
tf = 1;

a = calculateCoefficients([qi qf], [dqi dqf], [ti, tf]);

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
        qt(i) = a(1) + a(2) * t(i) + a(3) * t(i)^2 + a(4) * t(i)^3;
        dqt(i) = a(2) + 2 * a(3) * t(i) + 3 * a(4) * t(i)^2;
        ddqt(i) = 2 * a(3) + 6 * a(4) * t(i);
    end
end

subplot(1, 3, 1);
plot(t, qt)
ylim([0, 40]);
title('Orientation') % cubic function

subplot(1, 3, 2);
plot(t, dqt)
ylim([-10, 40]);
title('Velocity') % parobolic function

subplot(1, 3, 3);
plot(t, ddqt)
ylim([-150, 150]);
title('Acceleration') % linear function (discontinuous)

%% Multisegment trajectory

clc; clear all; close all;

% Boundary conditions
qk = [10 20 0 30 40];
%dqk = [0 -10 10 3 0];
tk = [0 2 4 8 10];
dqk = zeros(1, length(tk));

%middle point velocities are calculated automatically
for i=2:1:length(tk)-1
    vk = (qk(i) - qk(i-1)) / (tk(i) - tk(i-1));
    vk1 = (qk(i+1) - qk(i)) / (tk(i+1) - tk(i));
    
    if sign(vk) ~= sign(vk1)
        dqk(i) = 0;
    else
        dqk(i) = 0.5 * (vk + vk1);
    end
end

n = 1000;
t = zeros(length(tk)-1, n);

for i=1:1:length(tk)-1
    t(i, :) = linspace(tk(i), tk(i+1), n);
end

qt = zeros(length(tk)-1, n);
dqt = zeros(length(tk)-1, n);
ddqt = zeros(length(tk)-1, n);

for i=1:1:length(tk)-1
    ak = calculateCoefficients([qk(i), qk(i+1)], [dqk(i), dqk(i+1)], [tk(i), tk(i+1)]);
    
    ti = t(i, :);
    
    qt(i, :) = ak(1) + ak(2) * ti + ak(3) * ti.^2 + ak(4) * ti.^3;
    dqt(i, :) = ak(2) + 2 * ak(3) * ti + 3 * ak(4) * ti.^2;
    ddqt(i, :) = 2 * ak(3) + 6 * ak(4) * ti;
end

qt = qt'; qt = qt(:);
dqt = dqt'; dqt = dqt(:);
ddqt = ddqt'; ddqt = ddqt(:);
t = t'; t = t(:);

subplot(1, 3, 1);
plot(t, qt)
ylim([-10, 50]);
title('Orientation') % cubic function

subplot(1, 3, 2);
plot(t, dqt)
ylim([-20, 20]);
title('Velocity') % parobolic function

subplot(1, 3, 3);
plot(t, ddqt)
ylim([-40, 40]);
title('Acceleration') % linear function (discontinuous)