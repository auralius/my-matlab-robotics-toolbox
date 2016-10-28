%%
clc;
clear all;
close all;

%% Scara robot DH-Parameters
theta = [0 0 0 0];
alpha = [0 0 0 0];
offset = [0 0 0 0];
a = [0 0.45 0.72 0];
d = [0.21 0 0 0];
type = ['r','r','r','p'];
base = [0; 0; 0];

scara = cgr_create(theta, d, a, alpha, offset, type, base);
