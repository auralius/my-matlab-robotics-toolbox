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
type = ['r','r','r','r'];
base = [0; 0; 0];

planar_4r = cgr_create(theta, d, a, alpha, offset, type, base, ...
    [pi/2; pi/2; pi/2; pi/2], [-pi/2; -pi/2; -pi/2; -pi/2]);  % joint limts!
planar_4r = cgr_self_update(planar_4r, [0; 0; 0; 0], base);
g = ncgr_plot(g, planar_4r, [1 1 1], 1);


%% Demo for inverse kinematics
for ii = 0: 0.1: 0.4
    base(1) = ii;
    for x = 0.5+ii :0.1: 1.5+ii
        [q, k, err]= cgr_ikine1(planar_4r, [x; 0; 0], 0.01, 100);
        %[q, k, err]= cgr_ikine2(planar_4r, [x; 0; 0], 2, 0.01, 100);
        planar_4r = cgr_self_update(planar_4r, q, base);
        g = ncgr_plot(g, planar_4r);
        pause(0.1);
    end
end


%% Demo for inverse kinematics
for ii = 0: 0.1: 0.4
    base(1) = ii;
    for x = 0.5+ii :0.1: 1.5+ii
        %[q, k, err]= cgr_ikine1(planar_4r, [x; 0; 0], 0.01, 100);
        [q, k, err]= cgr_ikine2(planar_4r, [x; 0; 0], 2, 0.01, 100);
        planar_4r = cgr_self_update(planar_4r, q, base);
        g = ncgr_plot(g, planar_4r);
        pause(0.1);
    end
end

