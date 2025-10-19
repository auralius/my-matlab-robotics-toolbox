% Example 2 in the slides: 
% https://docs.google.com/presentation/d/1IwAoLZMTFeWiz0YZUyCvjQ4Hp7PpCqGMhgCqimQRPWs/edit?usp=sharing

clc;
clear all;
close all;

%% Graphic
g = ncgr_graphic();

%% R-R-R-P robot DH-Parameters
L2 = 0.1;

% DH Parameters
theta = [0 0 0 0];
alpha = [pi/2 0 pi/2 0];
d = [0 0 0 0];
a = [0 L2 0 0];
offset = [0 0 pi/2 0];
type = ['r' 'r' 'r' 'p'];
base = [0; 0; 0];

ex2 = cgr_create(theta, d, a, alpha, offset, type, base, ...
                 [pi/2; pi/2; pi/2; 2], [-pi/2; -pi/2; -pi/2; 0]);  % joint limts!
ex2 = cgr_self_update(ex2, [0; 0; 0; 0], base);
g = ncgr_plot_slider(g, ex2, [1 1 1], 0.1, [-0.5 0.5], [-0.5 0.5],[-0.1 0.5]);
 
