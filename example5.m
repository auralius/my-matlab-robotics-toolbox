% Example 5 in the slides: 
% https://docs.google.com/presentation/d/1IwAoLZMTFeWiz0YZUyCvjQ4Hp7PpCqGMhgCqimQRPWs/edit?usp=sharing

clc;
clear all;
close all;

%% Graphic
g = ncgr_graphic();

%% R-P-R robot DH-Parameters
L = 0.3;

% DH Parameters
theta = [0 0 0];
alpha = [0 -pi/2 0];

d = [0 0 L];
a = [L L 0];
offset = [0 0 0];
type = ['r' 'r' 'r'];
base = [0; 0; 0];

ex5 = cgr_create(theta, d, a, alpha, offset, type, base, ...
                 [pi/2; pi/2; pi/2], [-pi/2; -pi/2; -pi/2]);  % joint limts!
ex5 = cgr_self_update(ex5, [0; 0; 0;], base);
g = ncgr_plot_slider(g, ex5, [1 1 1], 0.2, [-1 1], [-1 1.0],[-1 1]);
 
