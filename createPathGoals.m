function Goal = createPathGoals(N_Agents)

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
