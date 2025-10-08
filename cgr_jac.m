function jac = cgr_jac(r, q)
% Compute jacobian of a serial robot numerically, works for both prismatic
% and revolute joint
%
% THIS DOES NOT CHANGE STRUCTURE OF THE ROBOT!
%
% Inputs:
%   r - structure of the serial robot.
%   q - joint values (1xN_DOFS vector)
%
% Outputs:
%   jac - computed jacobian matrix

N_DOFS = length(q);

epsilon = 1e-6; 
epsilon_inv = 1/epsilon;

% Caclulate f0, when no perturbation happens
[~, f0] = cgr_fkine_ee(r, q); 

% Do perturbation
qc0 = q;
jac = zeros(3, N_DOFS);
for i = 1 : N_DOFS
    q = qc0;
    q(i) = qc0(i) + epsilon;
    
    [~, f1] = cgr_fkine_ee(r, q);
    jac(:, i) = (f1 - f0) .* epsilon_inv;
end

end