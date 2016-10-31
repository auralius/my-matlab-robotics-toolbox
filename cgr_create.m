function r = cgr_create(theta, d, a, alpha, offset, type, base, ub, lb)
% Create a robot structure

    % Base position of the robot (nx1)
    r.base = base;         
    
    % The DH-parameters:
    r.theta = theta;
    r.d = d;
    r.a = a;
    r.alpha = alpha;
    r.offset = offset;
    
    % Number of DOFs
    r.n = length(theta);       
    
    % Current joint commands (nx1) in radians and meters, for revolute and 
    % prismatic joint, respectively
    r.qc = zeros(r.n, 1); 
    
    % Either 'r' or 'p' for revolute and prismatic joint, respectively
    r.type = type;        
       
    % Jacobian of the robot (3xn)
    r.jac = zeros(3, r.n); 
    
    % Homogenous transformation matrix for every link
    r.T = repmat(zeros(4), 1, 1, r.n);  
    
    % Joint limits,upper boundaries and lower boundaries
    if nargin > 7
        r.ub = ub; 
        r.lb = lb;
    else
        r.ub = ones(r.n, 1).*inf; 
        r.lb = ones(r.n, 1).*-inf;
    end
end