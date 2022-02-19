function [q, iter_taken, err] = cgr_ikine1(r, p, treshold, max_iter)
% Compute the inverse kinematics by using the pseudo-inverse method
%
% https://groups.csail.mit.edu/drl/journal_club/papers/033005/buss-2004.pdf
% See Equ. 7.
%
% Inputs:
%   r - sructure of the robot.
%   p - the target cartesian position (3x1 vector)
%   treshold - terminate the iteration when err < treshold
%   max_iter - maximum iiterations
%
% Outputs:
%   q - computed joint values
%   iter_taken - total iteration number
%   err - actual error between the actual position and the target position
%

if nargin  < 3
    treshold = 0.01;
    max_iter = 100;
elseif nargin  < 4
    max_iter = 100;
end

% Get current pose.
q = r.qc;
T =  cgr_fkine(r, q); 
x = T(1:3, 4, end);
jac = cgr_jac(r, q);

iter_taken = 1;

while 1
    iter_taken = iter_taken + 1;
    
    delta_x = p - x;

    delta_q = pinv(jac)*delta_x;
    q = q + delta_q;
    q = min(r.ub, max(q, r.lb)); % This is a saturation function.
    
    [~, x] = cgr_fkine_ee(r, q); 
    jac = cgr_jac(r, q);
    
    err = norm(delta_x);
    
    if err < treshold || iter_taken > max_iter
        %fprintf('**cgr_ikine1** breaks after %i iterations with errror %f.\n', k, err);
        break;
    end
end

end