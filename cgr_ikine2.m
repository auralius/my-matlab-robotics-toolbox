function [q, iter_taken, err] = cgr_ikine2(r, p, lambda, treshold, max_iter)
% Using damped least square method
% http://math.ucsd.edu/~sbuss/ResearchWeb/ikmethods/iksurvey.pdf
% See Equ. 11.
% r is the sructure of the robot.
% p (3x1) is the target cartesian position;
%
% THIS DOES NOT CHANGE STRUCTURE OF THE ROBOT!

global N_DOFS;

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

    % Keep in mind then inverse operation fails when matrix is not full
    % rank, instead we will use pinv, Therefore, when lambda = 0, this
    % method is the same as the pseudo-inverse method.
    if lambda > 0 
        K = (jac'*jac + lambda^2 .* eye(N_DOFS))\jac';
    else
        K = pinv(jac);
    end
    
    delta_q = K*delta_x;
    q = q + delta_q;
    q = min(r.ub, max(q, r.lb)); % This is a saturation function.
    
    [~, x] = cgr_fkine_ee(r, q); 
    jac = cgr_jac(r, q);
    
    err = norm(delta_x);
    
    if err < treshold || iter_taken > max_iter
        %fprintf('**cgr_ikine2** breaks after %i iterations with errror %f.\n', iter_taken, err);
        break;
    end
end

end