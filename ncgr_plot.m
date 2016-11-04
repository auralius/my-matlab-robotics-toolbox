function g = ncgr_plot(g, r, view_vector, axis_scale)
% Plot the robot
% g is the graphic structure.
% r is the robot structure.
% view_vector is the view vector (1x3 vector).

% Adjust the view and the scale of the three arrows representing the
% coordinate frame

if (g.h == -1)
    figure;
    hold on;
    grid on;
    
    if nargin < 3
        view([1 1 1]);
        axis_scale = 0.5;
    elseif nargin < 4
        axis_scale = 0.5;
        view(view_vector);
    else
        view(view_vector);
    end
    
    g.h = plot3(0, 0, 0, '-m*', 'LineWidth', 4);
    
    % Adjust axis limit here, we start form robot base:
    max_range = max(sum(r.d),sum(r.a));
    xlim([r.base(1)-max_range r.base(1)+max_range]);
    ylim([r.base(2)-max_range r.base(2)+max_range]);
    zlim([r.base(3)-max_range r.base(3)+max_range]);
    
    g.quiver_x = quiver3(0,0,0,0,0,0, axis_scale, 'r');
    g.quiver_y = quiver3(0,0,0,0,0,0, axis_scale, 'g');
    g.quiver_z = quiver3(0,0,0,0,0,0, axis_scale, 'b');
    %axis equal tight    
end

for i = 1 : r.n
    vx(:, i) = r.T(1:3,1:3,i)*[1; 0; 0];
    vy(:, i) = r.T(1:3,1:3,i)*[0; 1; 0];
    vz(:, i) = r.T(1:3,1:3,i)*[0; 0; 1];
    x(:, i) = r.T(1:3,4, i);
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