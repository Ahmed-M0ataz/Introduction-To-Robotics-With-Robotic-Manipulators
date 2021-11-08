clc; clear all; close all;

mdl_ur5;

Kp = 50;
Kd = 10;

T = 15;

sim('inverse_dynamics.slx', T);

open_system('inverse_dynamics/q_tilda');
open_system('inverse_dynamics/qd_tilda')