%%
clc;
clear all;
close all;

%% Graphic
g = ncgr_graphic();

global N_DOFS;
N_DOFS = 2;

%% 2-R-planar robot DH-Parameters
theta = [0 0];
alpha = [0 0];
offset = [0 0];
d = [0 0];
a = [0.5 0.5];
<<<<<<< HEAD
type = ['r' 'r'];
base = [0; 0; 0];

planar_2r = cgr_create(theta, d, a, alpha, offset, type, base, ...
    [pi/2 pi/2], [-pi/2 -pi/2]);  % joint limts!
planar_2r = cgr_self_update(planar_2r, [0 0], base);
g = ncgr_plot(g, planar_2r, [0 0 1], 1);  % view_vector = [0 0 1] => top view

for k = 0:0.1:pi
    planar_2r = cgr_self_update(planar_2r, [0+k 0+k], base);
=======
type = ['r','r'];
base = [0; 0; 0];

planar_2r = cgr_create(theta, d, a, alpha, offset, type, base, ...
    [pi/2; pi/2], [-pi/2; -pi/2;]);  % joint limts!
planar_2r = cgr_self_update(planar_2r, [0; 0], base);
g = ncgr_plot(g, planar_2r, [0 0 1], 1);

for k = 0:0.1:pi
    planar_2r = cgr_self_update(planar_2r, [0+k; 0+k], base);
>>>>>>> 6bab2b9b70984b137f8ff706abc6a7585b277821
    g = ncgr_plot(g, planar_2r, [0 0 1], 1);
    pause(0.5);
end


