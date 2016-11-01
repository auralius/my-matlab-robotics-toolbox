function [q, k, err] = cgr_ikine1(r, p, treshold, max_iter)
% https://groups.csail.mit.edu/drl/journal_club/papers/033005/buss-2004.pdf
% See Equ. 7.
% r is the sructure of the robot.
% p (3x1) is the target cartesian position;
%
% THIS DOES NOT CHANGE STRUCTURE OF THE ROBOT!

if nargin  < 3
    treshold = 0.01;
    max_iter = 100;
elseif nargin  < 4
    max_iter = 100;
end

% Make sure robot stucture has been updated by calling cgr_self_update!
x = r.T(1:3, 4, end);
q = r.qc;
jac = r.jac;

k = 1;

while 1
    k = k + 1;
    
    delta_x = p - x;

    delta_q = pinv(jac)*delta_x;
    delta_q = min(r.ub, max(delta_q, r.lb)); % This is a saturation function.
    q = q + delta_q;
    
    [~, x] = cgr_fkine_ee(r, q); 
    jac = cgr_jac(r, q);
    
    err = norm(delta_x);
    
    if err < treshold || k > max_iter
        fprintf('**cgr_ikine1** breaks after %i iterations with errror %f.\n', k, err);
        break;
    end
end

end