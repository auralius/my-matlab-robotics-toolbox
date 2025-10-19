% Example 4 in the slides: 
% https://docs.google.com/presentation/d/1IwAoLZMTFeWiz0YZUyCvjQ4Hp7PpCqGMhgCqimQRPWs/edit?usp=sharing

clc;
clear all;
close all;

%% Graphic
g = ncgr_graphic();

%% R-P-R robot DH-Parameters
L1 = 0.3;
L2 = 0.3;

% DH Parameters
theta = [0 0 0];
alpha = [pi/2 pi/2 0];

d = [0 0 0];
a = [L1 L2 0];
offset = [0 -pi/2 0];
type = ['r' 'r' 'r'];
base = [0; 0; 0];

ex4 = cgr_create(theta, d, a, alpha, offset, type, base, ...
                 [pi/2; pi/2; pi/2], [-pi/2; -pi/2; -pi/2]);  % joint limts!
ex4 = cgr_self_update(ex4, [0; 0; 0;], base);
g = ncgr_plot_slider(g, ex4, [1 1 1], 0.2, [-1 1], [-1 1.0],[-1 1]);
 
