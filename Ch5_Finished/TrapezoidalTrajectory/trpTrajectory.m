clc; clear all; close all;

mdl_ur5;

dqmax  = 3.14; % rad/s
ddqmax = 10.0;  % rad/s^2

q0 = qz; % initial orientation
qf = qr; % final orientation

L = abs(qf - q0);
[Lmax, imax] = max(L); % maximum displacement

% do synchronization
ta = dqmax / ddqmax;
T = (Lmax * ddqmax + dqmax^2) / (ddqmax * dqmax); % time duration to track the trajectory

%% calculate trapezoidal trajectory
sn = 1000; % sampling number
t = zeros(3, sn);
t(1, :) = linspace(0, ta, sn);
t(2, :) = linspace(ta, T-ta, sn);
t(3, :) = linspace(T-ta, T, sn);

q = zeros(6, sn, 3);
dq = zeros(6, sn, 3);
ddq = zeros(6, sn, 3);

for i = 1:3
    for j = 1:6
        if j ~= imax
            dqmaxi = L(j) / (T - ta);
            ddqmaxi = L(j) / (ta * (T - ta));

            if i == 1
                q(j, :, i) = q0(j) + 0.5 * ddqmaxi * t(i, :).^2;
                dq(j, :, i) = ddqmaxi * t(i, :);
                ddq(j, :, i) = ddqmaxi;
            elseif i == 2
                q(j, :, i) = q0(j) + ddqmaxi * ta * (t(i, :) - 0.5 * ta);
                dq(j, :, i) = dqmaxi;
                ddq(j, :, i) = 0;
            else
                q(j, :, i) = qf(j) - 0.5 * ddqmaxi * (T*ones(1, sn) - t(i, :)).^2;
                dq(j, :, i) = -ddqmaxi * (t(i, :) - T*ones(1, size(t, 2)));
                ddq(j, :, i) = -ddqmaxi;
            end
        else
            dqmaxi = dqmax;
            ddqmaxi = ddqmax;
            
            if i == 1
                q(j, :, i) = q0(j) + 0.5 * ddqmaxi * t(i, :).^2;
                dq(j, :, i) = ddqmaxi * t(i, :);
                ddq(j, :, i) = ddqmaxi;
            elseif i == 2
                q(j, :, i) = q0(j) + ddqmaxi * ta * (t(i, :) - 0.5 * ta);
                dq(j, :, i) = dqmaxi;
                ddq(j, :, i) = 0;
            else
                q(j, :, i) = qf(j) - 0.5 * ddqmaxi * (T*ones(1, sn) - t(i, :)).^2;
                dq(j, :, i) = -ddqmaxi * (t(i, :) - T*ones(1, size(t, 2)));
                ddq(j, :, i) = -ddqmaxi;
            end
        end
    end
end

t = t';
t = t(:)';

%% plot position, velocity, acceleration

figure
hold on
for j = 1:6
    qi = q(j, :, :);
    qi = qi(:);
    plot(t, qi);
end
title('position');
hold off

figure
hold on
for j = 1:6
    dqi = dq(j, :, :);
    dqi = dqi(:);
    plot(t, dqi);
end
title('velocity');
hold off

figure
hold on
for j = 1:6
    ddqi = ddq(j, :, :);
    ddqi = ddqi(:);
    plot(t, ddqi);
end
title('acceleration');
hold off