function r = cgr_self_update(r, qc, base)
% Apply joint inputs and update the pose of the robot
%
% Inputs:
%   r - robot structure
%   qc - target joint inputs (1xN_DOFS vector)
%   base - robot's base coordinate (3x1 vector) 
%
% Outputs:
%   r - updated robot structure
%
% Contact: manurung.auralius@gmail.com
%
    if nargin > 2
        r.base = base;
    end
    
    r.qc = qc;
    r.theta = qc;
    r.T = cgr_fkine(r, qc); 
    r.jac = cgr_jac(r, qc);
end