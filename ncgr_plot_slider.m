function g = ncgr_plot_slider(g, r, view_vector, axis_scale, x_range, y_range, z_range)
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

global N_DOFS;

max_reach = 1.5*max(sum(abs(r.d)), sum(abs(r.a)));

if (g.h == -1) %  only do once
    f = figure;
    hold on;
    grid on;
    axis equal

    if nargin < 3
        view_vector = [1 1 1];
        axis_scale = 0.5;

        xlim([r.base(1) - max_reach r.base(1) + max_reach]);
        ylim([r.base(2) - max_reach r.base(2) + max_reach]);
        zlim([r.base(3) - max_reach r.base(3) + max_reach]);

    elseif nargin < 4
        axis_scale = 0.5;

        xlim([r.base(1) - max_reach r.base(1) + max_reach]);
        ylim([r.base(2) - max_reach r.base(2) + max_reach]);
        zlim([r.base(3) - max_reach r.base(3) + max_reach]);

    elseif nargin < 5
        xlim([r.base(1) - max_reach r.base(1) + max_reach]);
        ylim([r.base(2) - max_reach r.base(2) + max_reach]);
        zlim([r.base(3) - max_reach r.base(3) + max_reach]);

    elseif nargin < 6
        xlim(x_range);
        ylim([r.base(2)-max_reach r.base(2)+max_reach]);
        zlim([r.base(3)-max_reach r.base(3)+max_reach]);

    elseif nargin < 7
        xlim(x_range);
        ylim(y_range);
        zlim([r.base(3) - max_reach r.base(3) + max_reach]);

    else
        xlim(x_range);
        ylim(y_range);
        zlim(z_range);
    end

    % Store app state via guidata
    S.N = N_DOFS;
    S.sl = gobjects(N_DOFS, 1);
    S.last = nan(1, N_DOFS);  % last seen values for continuous change
    S.minV = -pi;
    S.maxV = pi;
    guidata(f, S)

    % --- Create sliders (tall+narrow = vertical look) ---
    for k = 1 : N_DOFS
        S = guidata(f);
        S.sl(k) = uicontrol('Parent', f, ...
            'Style', 'slider', ...
            'Units', 'pixels', ...
            'Min',S.minV, 'Max', S.maxV, 'Value',0, ...
            'SliderStep', [0.01 0.1], ...
            'Callback',@(h,~)on_value_changed(f, k)); % when value changes
        guidata(f, S);
    end

    % --- Layout + continuous polling on mouse move ---
    f.SizeChangedFcn = @(h,~)do_layout(h);
    f.WindowButtonMotionFcn = @(h,~)poll_while_dragging(h);  % continuous
    f.CloseRequestFcn = @(h,~)on_close(h);
    do_layout(f);      % initial placement
    init_last(f);      % init last = Value

    % --- Start plotting the robot ---
    view(view_vector);
    g.h = plot3(0, 0, 0, '-m*', 'LineWidth', 4);

    g.quiver_x = quiver3(0,0,0,0,0,0, axis_scale, 'r', 'LineWidth', 2);
    g.quiver_y = quiver3(0,0,0,0,0,0, axis_scale, 'g', 'LineWidth', 2);
    g.quiver_z = quiver3(0,0,0,0,0,0, axis_scale, 'b', 'LineWidth', 2);

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
    vy(:, i) = r.T(1:3, 1:3, i) * [0; 1; 0];
    vz(:, i) = r.T(1:3, 1:3, i) * [0; 0; 1];
    x(:, i)  = r.T(1:3, 4  , i);
    set(g.htxt(i+1), 'Position', x(:, i) + [0; 0; 0.2]);
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

% ===== Helpers =====

    function do_layout(fig)
        % Place N vertical sliders along the right edge.
        S = guidata(fig);
        if isempty(S) || ~isfield(S,'sl'), return; end
        if ~ishandle(fig), return; end

        padRight = 20;  % px from window's right edge
        gap = 2;        % px between sliders
        barW = 16;      % slider thickness (classic uicontrol)
        topPad = 40;
        botPad = 20;

        pos = getpixelposition(fig); % [x y w h]
        usableH = max(pos(4) - topPad - botPad, 60);
        xRight = pos(3) - padRight;

        for k = 1 : S.N
            set(S.sl(k), 'Position', [xRight - (k-1) * (barW + gap), ...
                botPad, barW, usableH]);
        end
    end

    function init_last(fig)
        S = guidata(fig);
        for k = 1 : S.N
            S.last(k) = get(S.sl(k),'Value');
        end
        guidata(fig,S);
    end

    function poll_while_dragging(fig)
        % Simulate ValueChanging: whenever any slider's Value differs from 
        % last, call on_value_changing and update last. 
        S = guidata(fig);
        if isempty(S) || ~isfield(S,'sl'), return; end

        changedIdx = [];
        newVals = S.last;

        for k = 1:S.N
            v = get(S.sl(k),'Value');
            if ~isequaln(v, S.last(k))
                changedIdx(end+1) = k; %#ok<AGROW>
                newVals(k) = v;
            end
        end

        if ~isempty(changedIdx)
            % fire "changing" for each changed slider
            for j = changedIdx
                on_value_changing(fig, j, newVals(j));
            end
            S.last = newVals;
            guidata(fig,S);
        end
    end

    function on_value_changing(fig, idx, val)
        % Continuous event (while dragging)
        r.theta(idx) = val;
        r = cgr_self_update(r, r.theta);
        g = ncgr_plot(g, r);
    end

    function on_value_changed(fig, idx)
        % Discrete event (on change action).
        h = gcbo; %#ok<GFLD>  % handle to slider that fired
        if isempty(h) || ~ishandle(h), return; end
        val = get(h,'Value');
        %fprintf('Changed   | slider %d -> %.3f\n', idx, val);

        % Keep 'last' in sync (in case Callback fires without mouse motion)
        S = guidata(fig);
        S.last(idx) = val;
        guidata(fig,S);
    end

    function on_close(fig)
        set(fig,'WindowButtonMotionFcn',[]);
        delete(fig);
    end

end