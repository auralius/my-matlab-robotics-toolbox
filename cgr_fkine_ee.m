function [R, p] = cgr_fkine_ee(r, q)
% This functions calculate tip position and orientation of the last link
% from given joint values.
% THIS DOES NOT CHANGE STRUCTURE OF THE ROBOT!
%
% r is the structure of the serial robot.
% q is the joint values (radians or meters).
% T contains the homogenous transformation matrix of each link starting
% from the base T(:,:,1) to the end-effector T(:,:,n+1).
%
% This gives the same result as the RVC toolbox.
%
% Contact: manurung.auralius@gmail.com
%
% References:
% https://www.cs.duke.edu/brd/Teaching/Bio/asmb/current/Papers/chap3-forward-kinematics.pdf
% See page 75

T = cgr_fkine(r, q);

R = T(1:3, 1:3, end);
p = T(1:3, 4, end);

end