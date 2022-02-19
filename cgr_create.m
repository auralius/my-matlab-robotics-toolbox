function robot = cgr_create(theta, d, a, alpha, offset, type, base, ub, lb)
% Create a robot structure
%
% Syntax: robot = cgr_create(theta, d, a, alpha, offset, type, base, ub, lb)
%
% Inputs:
%   theta - joint angle
%   d - joint extension
%   a - joint offset
%   alpha - joint twist
%   offset - joint variable offset
%   type - joint type: 'p'  for prosmatic joint and 'r' for rotational
%          joint
%   base - base coordinate (3x1 vector)
%   ub - joint upper boundaries - optional
%   lb - joint lower boundaries - optional
%
% Outputs:
%   robot - robot structure
%
% Examples:
%   theta = [0 0];
%   alpha = [0 0];
%   offset = [0 0];
%   d = [0 0];
%   a = [0.5 0.5];
%   type = ['r','r'];
%   base = [0; 0; 0];
%
%   planar_2r = cgr_create(theta, d, a, alpha, offset, type, base, ...
%     [pi/2; pi/2], [-pi/2; -pi/2;]);  
%

global N_DOFS;

if ~iscolumn(base)
    error('>> The base coordinate must be a column vactor (3x1)!');
end

if nargin < 8
    ub = ones(1, N_DOFS)*inf;
    lb = -ones(1, N_DOFS)*inf;
end

r = struct( ...
    'base', base, ...
    'theta', theta, ...
    'd', d, ...
    'a', a, ...
    'alpha', alpha, ...
    'offset', offset, ...
    'qc', zeros(N_DOFS, 1), ...
    'type', type, ...
    'jac', zeros(3, N_DOFS), ...
    'T', repmat(zeros(4), 1, 1, N_DOFS), ...
    'ub', ub, ...
    'lb', lb);

robot = r;
end