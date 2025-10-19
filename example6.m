% Example 6 in the slides: 
% https://docs.google.com/presentation/d/1IwAoLZMTFeWiz0YZUyCvjQ4Hp7PpCqGMhgCqimQRPWs/edit?usp=sharing

clc;
clear all;
close all;

g = ncgr_graphic();

% R-R-P-R-R-R
L1 = 0.2;
L2 = 0.2;

% Classic DH
theta  = [0 0 0 0 0 0]';
alpha  = [pi/2  -pi/2  0  pi/2  -pi/2 0]';
d      = [0      0     0  L1      0   L2]';   % d3 is variable (q3)
a      = [0      0     0  0      0    0]';
offset = [0 -pi/2 0 0 0 0]';
type   = ['r' 'r' 'p' 'r' 'r' 'r'];
base   = [0;0;0];

% Limits: q1,q2 in rad; q3 in meters (forward/back)
qmax = [  pi;   pi;  1;  pi;  pi;  pi];
qmin = [ -pi;  -pi;  0; -pi; -pi; -pi];

ex6 = cgr_create(theta, d, a, alpha, offset, type, base, qmax, qmin);

% Start pose
q0 = [0; 0; 0; 0; 0; 0];
ex6 = cgr_self_update(ex6, q0, base);

% Sliders: [q1(rad), q2(rad), q3(m)]
g = ncgr_plot_slider(g, ex6, [1 1 1], 0.1, [-1 1], [-1 1], [-1 1]);
