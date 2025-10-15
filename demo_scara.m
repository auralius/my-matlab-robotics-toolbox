%%
clc;
clear all;
close all;

%% Graphic
g = ncgr_graphic();

%% Scara robot DH-Parameters

theta = [0 0 0 0];
alpha = [0 0 0 0];
offset = [0 0 0 0];
a = [0 0.45 0.72 0];
d = [0.21 0 0 0];
type = ['r' 'r' 'r' 'p'];
base = [0; 0; 0];

scara = cgr_create(theta, d, a, alpha, offset, type, base);
scara = cgr_self_update(scara, [0 0 0 0]);
g = ncgr_plot(g, scara);

pause(1);
scara = cgr_self_update(scara, [0 0 0 -0.2]);
g = ncgr_plot(g, scara);

pause(1);
scara = cgr_self_update(scara, [0 0 0 0]);
g = ncgr_plot(g, scara);

%% Demo inverese kinematics
[q, k, err]= cgr_ikine1(scara, [0.5; 0.5; -0.5], 0.01, 100);
scara = cgr_self_update(scara, q);
g = ncgr_plot(g, scara);
pause(0.1);