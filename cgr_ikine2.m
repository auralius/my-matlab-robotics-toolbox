function [q, k, err] = cgr_ikine2(r, p, lambda, treshold, max_iter)
% Using damped least square method
% http://math.ucsd.edu/~sbuss/ResearchWeb/ikmethods/iksurvey.pdf
% See Equ. 11.
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

    % Keep in mind then inverse operation fails when matrix is not full
    % rank, instead we will use pinv, Therefore, when lambda = 0, this
    % method is the same as the pseudo-inverse method.
    if lambda > 0 
        K = (jac'*jac + lambda^2 .* eye(r.n))\jac';
    else
        K = pinv(jac);
    end
    
    delta_q = K*delta_x;
    q = q + delta_q;
    q = min(r.ub, max(q, r.lb)); % This is a saturation function.
    
    [~, x] = cgr_fkine_ee(r, q); 
    jac = cgr_jac(r, q);
    
    err = norm(delta_x);
    
    if err < treshold || k > max_iter
        fprintf('**cgr_ikine1** breaks after %i iterations with errror %f.\n', k, err);
        break;
    end
end

end