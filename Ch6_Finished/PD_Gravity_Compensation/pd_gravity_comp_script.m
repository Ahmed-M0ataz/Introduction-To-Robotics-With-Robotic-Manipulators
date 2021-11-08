clc; clear all; close all;

mdl_ur5;

Kp = 50;
Kd = 10;

T = 10;

sim('pd_gravity_comp.slx', T);

open_system('pd_gravity_comp/q_tilda');
open_system('pd_gravity_comp/qd')