function PlotStartingPointandGoals(N_Agents, Path)

% plot starting positions and goal
for k = 1:N_Agents
    hold on
    PlotCircle(Path.Start.pos(:,k), Path.Goal.Radius(k)/8, 3, 'Green');
    PlotPoint(Path.Start.pos(:,k), '*g');
    PlotCircle(Path.Goal.pos(:,k), Path.Goal.Radius(k), 3, 'Red');
    PlotPoint(Path.Goal.pos(:,k), '*r');
end

axis equal
