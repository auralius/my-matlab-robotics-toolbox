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

N_DOFS = length(r.theta);
qc = zeros(1, N_DOFS);

g = ncgr_plot(g, r, view_vector, axis_scale, x_range, y_range, z_range);
if g.sl == -1 %only do once
    g.sl = gobjects(N_DOFS, 1);
    g.last = nan(1, N_DOFS);  % last seen values for continuous change

    % --- Create sliders (tall+narrow = vertical look) ---
    for k = 1 : N_DOFS
        g.sl(k) = uicontrol('Parent', g.f, ...
            'Style', 'slider', ...
            'Units', 'pixels', ...
            'Min',r.lb(k), 'Max', r.ub(k), 'Value', 0, ...
            'SliderStep', [0.01 0.1], ...
            'Callback',@(h,~)on_value_changed(g.f, k)); % when value changes
    end

    % --- Layout + continuous polling on mouse move ---
    g.f.SizeChangedFcn = @(h,~)do_layout(h);
    g.f.WindowButtonMotionFcn = @(h,~)poll_while_dragging(h);  % continuous
    g.f.CloseRequestFcn = @(h,~)on_close(h);
    do_layout();      % initial placement
    init_last();      % init last = Value
end

% ===== Helpers =====

function do_layout()
    % Place N vertical sliders along the right edge.
    if ~ishandle(g.f), return; end

    padRight = 20;  % px from window's right edge
    gap = 2;        % px between sliders
    barW = 16;      % slider thickness (classic uicontrol)
    topPad = 40;
    botPad = 20;

    pos = getpixelposition(g.f); % [x y w h]
    usableH = max(pos(4) - topPad - botPad, 60);
    xRight = pos(3) - padRight;

    for k = 1 : N_DOFS
        set(g.sl(k), 'Position', [xRight - (k-1) * (barW + gap), ...
            botPad, barW, usableH]);
    end
end

function init_last()
    for k = 1 : N_DOFS
        g.last(k) = get(g.sl(k),'Value');
    end
end

function poll_while_dragging(fig)
    % Simulate ValueChanging: whenever any slider's Value differs from
    % last, call on_value_changing and update last.
    if ~isfield(g, 'sl'), return; end

    changedIdx = [];
    newVals = g.last;

    for k = 1:N_DOFS
        v = get(g.sl(k), 'Value');
        if ~isequaln(v, g.last(k))
            changedIdx(end+1) = k; %#ok<AGROW>
            newVals(k) = v;
        end
    end

    if ~isempty(changedIdx)
        % fire "changing" for each changed slider
        for j = changedIdx
            on_value_changing(fig, j, newVals(j));
        end
        g.last = newVals;
    end
end

function on_value_changing(fig, idx, val)
    % Continuous event (while dragging)
    qc(idx) = val;
    r = cgr_self_update(r, qc);
    g = ncgr_plot(g, r, view_vector, axis_scale, x_range, y_range, z_range);
end

function on_value_changed(fig, idx)
    % Discrete event (on change action).
    h = gcbo; %#ok<GFLD>  % handle to slider that fired
    if isempty(h) || ~ishandle(h), return; end
    val = get(h,'Value');

    qc(idx) = val;
    r = cgr_self_update(r, qc);
    g = ncgr_plot(g, r, view_vector, axis_scale, x_range, y_range, z_range);

    %fprintf('Changed   | slider %d -> %.3f\n', idx, val);

    % Keep 'last' in sync (in case Callback fires without mouse motion)
    g.last(idx) = val;
    end

function on_close(fig)
    set(fig,'WindowButtonMotionFcn',[]);
    delete(fig);
end

end