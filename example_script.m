% psotv1
% script to test and run the PSO for swarm trajectories
clear
clf
addpath('PSO')
addpath('UAV')
addpath('SWARM')

% Particles count
N_Particles = 25;

% Agent count (Physical count of robots, each particle consists of 
% N_Agent agents)
N_Agents = 3;

% Starting point and Goal points moved to individual functions for clarity
Path.Start = createPathStartingPoints(N_Agents);
Path.Goal = createPathGoals(N_Agents);

PlotStartingPointandGoals(N_Agents, Path);

%% Initialize the Swarm and PSO
s = SWARM();
for k = 1:N_Agents
    s.AddAgent(UAV(Path.Start.state(:, k)));
end

% Initialize PSO 
p = PSO(s, N_Particles, Path.Goal, @CostFcn);

%% Iterate PSO

    p.Iterate();
    drawnow update
    %%
    filename = 'sample-PSO-run.gif';
for k = 1:40
    p.Iterate();
    axis([0 1 0 1])
    drawnow update
    
       frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if k == 1;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end
end
%p.Particle(1).Fitness


