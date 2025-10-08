function T = cgr_fkine(r, q)
% This functions calculate tip position and orientation of all links from
% given joint values. This gives the same result as the RVC toolbox.
%
% THIS FUNCTION MUST NOT CHANGE STRUCTURE OF THE ROBOT!
%
% Inputs:
%   r - structure of the serial robot.
%   q - the joint values (radians or meters).
%
% Outputs:
%   T - homogenous transformation matrix of each link starting
%       from the base T(:,:,1) to the end-effector T(:,:,n+1).
%
% Contact: manurung.auralius@gmail.com
%
% References:
%   https://www.cs.duke.edu/brd/Teaching/Bio/asmb/current/Papers/chap3-forward-kinematics.pdf
%   See page 75

N_DOFS = length(q);

temp = eye(4);
T = repmat(zeros(4), 1, 1, N_DOFS);


for i = 1 : N_DOFS
    if r.type(i) == 'r'
        r.theta(i) = q(i);
    elseif r.type(i) == 'p'
        r.d(i) = q(i);
    end
end

for i = 1 : 1 : N_DOFS
    ct = cos(r.theta(i) + r.offset(i));
    st = sin(r.theta(i) + r.offset(i));
    ca = cos(r.alpha(i));
    sa = sin(r.alpha(i));
    
    temp = temp * [ ct    -st*ca   st*sa     r.a(i)*ct ; ...
        st    ct*ca    -ct*sa    r.a(i)*st ; ...
        0     sa       ca        r.d(i)    ; ...
        0     0        0         1         ];
    temp(1:3, 4) = temp(1:3, 4);
    T(:,:,i) = temp;
end

for i = 1:N_DOFS
    T(1:3,4,i) = T(1:3,4,i) + r.base;
end

end