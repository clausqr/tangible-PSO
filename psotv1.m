% psotv1
% script to test and run the PSO for swarm trajectories
clear
%hold off
addpath('PSO')
addpath('UAV')
addpath('SWARM')

% Particles count
N_Particles = 3;

% Agent count (Physical count of robots, each particle consists of 
% N_Agent agents)
N_Agents = 3;

% Starting point and Goal points moved to individual functions for clarity
Path.Start = createPathStartingPoints(N_Agents);
Path.Goal = createPathGoals(N_Agents);

PlotStartingPointandGoals(N_Agents, Path);

%% Initialize the Swarm
s = SWARM();
for k = 1:N_Agents
    s.AddAgent(UAV(Path.Start.state(:, k)));
end

%% Initialize PSO and world.
p = PSO(s, N_Particles, @sin);



%%
hold on

% Max number of iterations
N_max_iterations = 400;
% initialize distance logging into d, d(k, i) is the k-th Particle distance to
% the goal on the i-th iteration
d = zeros(N_Particles, N_max_iterations);
% Initialize variables for the while loop
i = 1;
for k = 1:N_Particles
    d(k, i) = p(k).getDistanceToState(Path.Goal.state(:,k));
end
Path.Goal.Reached = false;

while (i < N_max_iterations) && ~Path.Goal.Reached
    
    for k = 1:N_Particles
        
        g(k).Grow();
        d(k, i) = g(k).getDistanceToState(Path.Goal.state(:,k));
        
        
    end
    drawnow update
    Path.Goal.Reached = logical(sum(d(k, i) < Path.Goal.Radius(1:N_Particles)) >= N_Particles);
    i = i+1;
end

% trim distance log
d = d(:, 1:i-1);

%%
% actually find the path!
for k = 1:N_Particles
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

for k = 1:N_Particles
    plot(d(k,:))
end







