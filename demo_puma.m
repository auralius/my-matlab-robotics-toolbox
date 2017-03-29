% https://www.cs.duke.edu/brd/Teaching/Bio/asmb/current/Papers/chap3-forward-kinematics.pdf
% page 98

%%
clc;
clear all;
close all;

%% Graphic
g = ncgr_graphic();

%% Puma robot DH-Parameters

global N_DOFS;
N_DOFS = 6;

theta = [0 0 0 0 0 0];
alpha = [-pi/2 0 pi/2 -pi/2 pi/2 0];
offset = [0 0 0 0 0 0];
a = [0 8 0 0 0 0]; % in inches
d = [13 0 2.5 8 0 2.5]; % in inches
type = ['r','r','r','r','r','r'];
base = [0; 0; 0];

% See http://medesign.seas.upenn.edu/index.php/Courses/MEAM520-12C-P01-IK
lb = [deg2rad(-180); deg2rad(-75); deg2rad(-235); deg2rad(-580); deg2rad(-120); deg2rad(-215)];
ub = [deg2rad(110); deg2rad(240); deg2rad(60); deg2rad(40); deg2rad(110); deg2rad(295)];

puma = cgr_create(theta, d, a, alpha, offset, type, base, ub, lb);
puma = cgr_self_update(puma, [0; 0; 0; 0; 0; 0]);
g = ncgr_plot(g, puma);


%% Demo inverese kinematics
x = puma.T(1:3,4, end);
step = linspace(0, 10, 20);
for i = 1:length(step)
    [q, k, err]= cgr_ikine1(puma, [x(1)+step(i); x(2); 13], 0.001, 1000)
    puma = cgr_self_update(puma, q);
    g = ncgr_plot(g, puma);
    pause(0.1);
end