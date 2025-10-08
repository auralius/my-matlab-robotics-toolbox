%%
clc;
clear all;
close all;

%% Graphic
g = ncgr_graphic();

global N_DOFS;
N_DOFS = 3;

%% R-P robot DH-Parameters
L1 = 0.1;
L3 = 0.3;

% DH Parameters
theta = [0 0 0];
alpha = [-pi/2 0 0];
d = [L1 0 L3];
a = [0 0 0];
offset = [0 0 0];
type = ['r' 'p' 'r'];
base = [0; 0; 0];

ex4 = cgr_create(theta, d, a, alpha, offset, type, base, ...
                 [pi/2; 2; pi/2], [-pi/2; 0; -pi/2]);  % joint limts!
ex4 = cgr_self_update(ex4, [0; 0; 0;], base);
g = ncgr_plot_slider(g, ex4, [1 1 1], 0.3, [-0.2 0.2], [-0.1 1.0],[-0.1 0.5]);
 
