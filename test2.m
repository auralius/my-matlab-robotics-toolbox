%%
clc;
clear all;
close all;

%% Graphic
g = ncgr_graphic();

%% 4-R-planar robot DH-Parameters
theta = [0 0 0 0];
alpha = [0 0 0 0];
offset = [0 0 0 0];
d = [0 0 0 0];
a = [0.5 0.5 0.5 0.5];
type = ['r','r','r','r'];
base = [0; 0; 0];

planar_4r = cgr_create(theta, d, a, alpha, offset, type, base);
planar_4r = cgr_self_update(planar_4r, [0; 0; 0; 0]);
g = ncgr_plot(g, planar_4r); 

pause(1);
planar_4r = cgr_self_update(planar_4r, [0; pi/2; 0; 0]);
g = ncgr_plot(g, planar_4r); 

pause(1);

for x = 0.1:0.1:1.9
[q, k, err]= cgr_ikine1(planar_4r, [x; 0; 0], 0.01, 100);
planar_4r = cgr_self_update(planar_4r, q);
g = ncgr_plot(g, planar_4r); 
pause(0.1);
end



