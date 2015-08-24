function Goal = createPathGoals(N_Agents)

if N_Agents == 3
% Goal and goal size.
Goal.pos(:,1) = [0.9; 0.9; 0.5];
Goal.state(:,1) = [Goal.pos(:,1); 0; 0];
Goal.Radius(1) = 0.0625;

% Goal and goal size.
Goal.pos(:,2) = [0.8; 0.9; 0.5];
Goal.state(:,2) = [Goal.pos(:,2); 0; 0];
Goal.Radius(2) = 0.0625;

% Goal and goal size.
Goal.pos(:,3) = [0.9; 0.8; 0.5];
Goal.state(:,3) = [Goal.pos(:,3); 0; 0];
Goal.Radius(3) = 0.0625;
else
for k = 1:N_Agents
    % Goal and goal size.
Goal.pos(:,k) = [rand(1); rand(1); 0.5];
Goal.state(:,k) = [Goal.pos(:,k); 0; 0];
Goal.Radius(k) = 0.0625;
end
    
end