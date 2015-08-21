% psotv1
% script to test and run the PSO for swarm trajectories
clear
%hold off
addpath('PSO')
addpath('UAV')

% Agents count
N_Agents = 2;

% Starting position, attitude and initial velocity
Path.Start.pos(:,1) = [0.1; 0.1; 0.5];
Path.Start.vel(:,1) = 0.025;
Path.Start.ang(:,1) = -pi/2;
Path.Start.state(:,1) = [Path.Start.pos(:,1); ...
    Path.Start.vel(:,1); ...
    Path.Start.ang(:,1)];

% Starting position, attitude and initial velocity
Path.Start.pos(:,2) = [0.2; 0.1; 0.5];
Path.Start.vel(:,2) = 0.025;
Path.Start.ang(:,2) = -pi/2;
Path.Start.state(:,2) = [Path.Start.pos(:,2); ...
    Path.Start.vel(:,2); ...
    Path.Start.ang(:,2)];

% Goal and goal size.
Path.Goal.pos(:,1) = [0.9; 0.9; 0.5];
Path.Goal.state(:,1) = [Path.Goal.pos(:,1); 0; 0];
Path.Goal.Radius(1) = 0.125;
Path.Goal.pos(:,2) = [0.8; 0.9; 0.5];
Path.Goal.state(:,2) = [Path.Goal.pos(:,2); 0; 0];
Path.Goal.Radius(2) = 0.125;

% % plot starting positions and goal
% for k = 1:N_Agents
%     hold on
%     PlotCircle(Path.Start.pos(:,k), Path.Goal.Radius(k)/8, 3, 'Green');
%     PlotPoint(Path.Start.pos(:,k), '*g');
%     PlotCircle(Path.Goal.pos(:,k), Path.Goal.Radius(k), 3, 'Red');
%     PlotPoint(Path.Goal.pos(:,k), '*r');
% end

%%
% Initialize states, PSO and world.
p = PSO(@sin);

for k = 1:N_Agents
    
    % Initialize the k-th Agent
    a(k) = UAV(Path.Start.state(:,k)); %#ok<SAGROW>
    
    % and add it to the PSO
    p.AddAgent(a(k));
    
end


%%
hold on

% Max number of iterations
N_max_iterations = 400;
% initialize distance logging into d, d(k, i) is the k-th agent distance to
% the goal on the i-th iteration
d = zeros(N_Agents, N_max_iterations);
% Initialize variables for the while loop
i = 1;
for k = 1:N_Agents
    d(k, i) = g(k).getDistanceToState(Path.Goal.state(:,k));
end
Path.Goal.Reached = false;

while (i < N_max_iterations) && ~Path.Goal.Reached
    
    for k = 1:N_Agents
        
        g(k).Grow();
        d(k, i) = g(k).getDistanceToState(Path.Goal.state(:,k));
        
        
    end
    drawnow update
    Path.Goal.Reached = logical(sum(d(k, i) < Path.Goal.Radius(1:N_Agents)) >= N_Agents);
    i = i+1;
end

% trim distance log
d = d(:, 1:i-1);

%%
% actually find the path!
for k = 1:N_Agents
    [Path.States, Path.Controls] = g(k).FindPathBetweenStates(Path.Start.state(:,k),...
                                Path.Goal.state(:,k));
    % Plot it!
    PlotPath(Path.States, Path.Controls);
    
end

%% 
% plot convergence plot
figure('Name', 'Convergence Plot')
title('Convergence Plot')
hold on
    xlabel('Iterations [n]');
    ylabel('Distance [normalized]');

for k = 1:N_Agents
    plot(d(k,:))
end







