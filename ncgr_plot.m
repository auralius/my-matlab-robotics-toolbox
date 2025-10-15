function g = ncgr_plot(g, r, view_vector, axis_scale, x_range, y_range, z_range)
% Plot the robot, set the view vector, set the scale the three arrows
% representing the link's coordinate frame, and set the limits of the
% current axes
%
% Inputs:
%   g - graphic structure.
%   r - robot structure.
%   view_vector - view vector (1x3 vector)  - optional
%   x_range - x-axis limits (1x2 vector) - optional
%   y_range - x-axis limits (1x3 vector) - optional
%   z_range - x-axis limits (1x3 vector) - optional
%
% Outputs:
%   g - updated graphic structure
%
% Contact: manurung.auralius@gmail.com
%

N_DOFS = length(r.theta);

max_reach = 1.5*max(sum(abs(r.d)), sum(abs(r.a)));

if nargin < 3
    view_vector = [1 1 1];
    axis_scale = 0.3;
    x_range = [r.base(1)-max_reach r.base(1)+max_reach];
    y_range = [r.base(2)-max_reach r.base(2)+max_reach];
    z_range = [r.base(3)-max_reach r.base(3)+max_reach];

elseif nargin < 4
    axis_scale = 0.3;
    x_range = [r.base(1)-max_reach r.base(1)+max_reach];
    y_range = [r.base(2)-max_reach r.base(2)+max_reach];
    z_range = [r.base(3)-max_reach r.base(3)+max_reach];

elseif nargin < 5
    x_range = [r.base(1)-max_reach r.base(1)+max_reach];
    y_range = [r.base(2)-max_reach r.base(2)+max_reach];
    z_range = [r.base(3)-max_reach r.base(3)+max_reach];

elseif nargin < 6
    y_range = [r.base(2)-max_reach r.base(2)+max_reach];
    z_range = [r.base(3)-max_reach r.base(3)+max_reach];

elseif nargin < 7
    z_range = [r.base(3)-max_reach r.base(3)+max_reach];
end

if (g.h == -1) % only do once
    g.f = figure;
    hold on;
    grid on;
    axis equal

    xlim(x_range);
    ylim(y_range);
    zlim(z_range);

    view(view_vector);
    g.h = plot3(0, 0, 0, 'Marker', '.', 'LineWidth', 4, 'Color', [1, 0, 1, 0.2]);    

    g.quiver_x = quiver3(0,0,0,0,0,0, 'Color', 'r', 'LineWidth', 2, 'AutoScale', 'off');
    g.quiver_y = quiver3(0,0,0,0,0,0, 'Color', 'g', 'LineWidth', 2, 'AutoScale', 'off');
    g.quiver_z = quiver3(0,0,0,0,0,0, 'Color', 'b', 'LineWidth', 2, 'AutoScale', 'off');

    xlabel('x');
    ylabel('y');
    zlabel('z');

    for i = 0 : N_DOFS
        g.htxt(i+1) = text(0,0,0, num2str(i), 'FontWeight', 'bold');
    end

    set(g.htxt(1), 'Position', r.base);
end

for i = 1 : N_DOFS
    vx(:, i) = r.T(1:3, 1:3, i) * [1; 0; 0];
    vx(:, i) = vx(:, i) / norm(vx(:, i))  * axis_scale;
    vy(:, i) = r.T(1:3, 1:3, i) * [0; 1; 0];
    vy(:, i) = vy(:, i) / norm(vy(:, i)) * axis_scale;
    vz(:, i) = r.T(1:3, 1:3, i) * [0; 0; 1];
    vz(:, i) = vz(:, i) / norm(vz(:, i)) * axis_scale ;
    x(:, i)  = r.T(1:3, 4  , i);
    set(g.htxt(i+1), 'Position', x(:, i) + [0; 0; 0.02]);
end

set(g.h, 'XData', [r.base(1) x(1, :)], 'YData', [r.base(2) x(2, :)], ...
    'ZData', [r.base(3) x(3, :)]);

set(g.quiver_x, 'XData', x(1, :), 'YData', x(2, :), 'ZData', x(3, :), ...
    'UData', vx(1,:), 'VData', vx(2,:), 'WData', vx(3,:));
set(g.quiver_y, 'XData', x(1, :), 'YData', x(2, :), 'ZData', x(3, :), ...
    'UData', vy(1,:), 'VData', vy(2,:), 'WData', vy(3,:));
set(g.quiver_z, 'XData', x(1, :), 'YData', x(2, :), 'ZData', x(3, :), ...
    'UData', vz(1,:), 'VData', vz(2,:), 'WData', vz(3,:));

drawnow;

end