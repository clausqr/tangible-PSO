function h = PlotStartingPointandGoals(N_Agents, Path)
h = [];
% plot starting positions and goal
for k = 1:N_Agents
    hold on
    h = [h PlotCircle(Path.Start.pos(:,k), Path.Goal.Radius(k)/8, 3, 'Green')];
    h = [h PlotPoint(Path.Start.pos(:,k), '*g')];
    h = [h PlotCircle(Path.Goal.pos(:,k), Path.Goal.Radius(k), 3, 'Red')];
    h = [h PlotPoint(Path.Goal.pos(:,k), '*r')];
end

axis equal
