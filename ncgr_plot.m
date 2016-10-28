function g = ncgr_plot(g, r)
% Plot the robot

% Adjust the scale of the three arrows representing the coordinate frame
axis_scale = 0.5;

if (g.h == -1)
    figure;
    hold on;
    grid on;
    
    g.h = plot3(0, 0, 0, '-m*', 'LineWidth', 4);
    
    % Adjust axis limit here, we start form robot base:
    xlim([r.base(1)-3 r.base(1)+3]);
    ylim([r.base(2)-3 r.base(2)+3]);
    zlim([r.base(3)-3 r.base(3)+3]);
    
    g.quiver_x = quiver3(0,0,0,0,0,0, axis_scale, 'r');
    g.quiver_y = quiver3(0,0,0,0,0,0, axis_scale, 'g');
    g.quiver_z = quiver3(0,0,0,0,0,0, axis_scale, 'b');
    %axis equal tight
    
    view([1 1 1]);
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