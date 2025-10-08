%%
clc;
clear all;
close all;

%% Graphic
g = ncgr_graphic();

global N_DOFS;
N_DOFS = 4;

%% 4-R-planar robot DH-Parameters
theta = [0 0 0 0];
alpha = [0 0 0 0];
offset = [0 0 0 0];
d = [0 0 0 0];
a = [0.5 0.5 0.5 0.5];
type = ['r' 'r' 'r' 'r'];
base = [0; 0; 0];

planar_4r = cgr_create(theta, d, a, alpha, offset, type, base, ...
    [pi/2; pi/2; pi/2; pi/2], [-pi/2; -pi/2; -pi/2; -pi/2]);  % joint limts!
planar_4r = cgr_self_update(planar_4r, [0; 0; 0; 0], base);
g = ncgr_plot_slider(g, planar_4r, [1 1 1], 0.3, [0 2], [-1 1], [-0.1 0.2]);

