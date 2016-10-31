%%
clc;
clear all;
close all;

%% Graphic
g = ncgr_graphic();

%% Scara robot DH-Parameters
d2 = 218.44 / 1000.0;
d3 = -88.9 / 1000.0;
a2 = 332.74 / 1000.0;
a3 = 0 / 1000.0;
d4 = 432.09 / 1000.0;
d6 = 53.34 / 1000.0;

theta = [0 0 0 0 0 0];
alpha = [0 -pi/2 0 pi/2 -pi/2 pi/2];
offset = [0 0 0 0 0 0];
a = [0 0 a2 a3 0 0];
d = [0 d2 d3 d4 0 0];
type = ['r','r','r','r','r','r'];
base = [0; 0; 0];

puma = cgr_create(theta, d, a, alpha, offset, type, base);
puma = cgr_self_update(puma, [0; 0; 0; 0; 0; 0]);
g = ncgr_plot(g, puma);

pause(1);
puma = cgr_self_update(puma, [0; 0; 0; -0.2; 0; 0 ]);
g = ncgr_plot(g, puma);

pause(1);
puma = cgr_self_update(puma, [0; 0; 0; 0; 0; 0]);
g = ncgr_plot(g, puma);

% %% Demo inverese kinematics
% [q, k, err]= cgr_ikine1(puma, [0.5; 0.5; -0.5], 0.01, 100);
% puma = cgr_self_update(puma, q);
% g = ncgr_plot(g, puma);
% pause(0.1);
