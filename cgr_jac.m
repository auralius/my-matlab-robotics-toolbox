function jac = cgr_jac(r, q)
% Compute jacobian of a serial robot numerically, works for both prismatic
% and revolute joint
% THIS DOES NOT CHANGE STRUCTURE OF THE ROBOT!
%
% r is the structure of the serial robot.
% q is the joint values (radians or meters).

epsilon = 1e-6; 
epsilon_inv = 1/epsilon;
n = length(q); % This is actually r.n, but MATLAB Coder doesnot like the latter.

% Caclulate f0, when no perturbation happens
[~, f0] = cgr_fkine_ee(r, q); 

% Do perturbation
qc0 = q;
jac = zeros(length(f0), n);
for i = 1 : n
    q = qc0;
    q(i) = qc0(i) + epsilon;
    
    [~, f1] = cgr_fkine_ee(r, q);
    jac(:, i) = (f1 - f0) .* epsilon_inv;
end

end