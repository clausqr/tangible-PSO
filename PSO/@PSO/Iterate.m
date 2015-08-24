function obj = Iterate(obj)
persistent h1
persistent h2
persistent h3
persistent h4
persistent h5
persistent y
persistent y_old
% propagate step

% //TODO: See how particle velocity is handled (independently of Agent
% velocity) check (1).
for k = 1:obj.ParticlesCount
    x = obj.Particle(k).Agent.State;
    n = obj.Particle(k).Agent.CurrentIterationStep;
    if (n == 1)
        y = obj.Particle(k).Agent.getNewRandomState;
        y_old = y;
    else
        state_vel = y-y_old;
        aa = 1;       % how much to leave to randomness between best global and best of particle
        ab = 1;       % bias point between best global and best of particle
                        % ab = 1, aa = 0  ->  deterministically use
                        %   particles' best state
                        % ab = 0, aa = 0  ->  deterministically use
                        %   global best state
                        % ab = 1,  aa = 1  ->  randomly determine wether
                        %   particle's or global best state will be used
        ar = ab*((1-aa)+aa*rand(1)); % composition
        ac = 0.05;      % how much of bias towards random point

        if ~isempty(obj.Particle(k).Fitness)
            d = 0.5;%*obj.Particle(k).Fitness;
        else
            d = 0;
        end
        a = (1-ac)*(  ar);
        b = (1-ac)*(1-ar);
        c = ac;
        z = a*obj.Particle(k).BestState + ...
            b*obj.GlobalBestState + ...
            c*obj.Particle(k).Agent.getNewRandomState;
        y_old = y;
        y = z + d*state_vel;
        
        if k == 1
           if ishandle(h5)
                delete(h5)
            end
            h5 = obj.Particle(k).Agent.PlotState(z,'xg');
            if ishandle(h4)
                delete(h4)
            end
            h4 = obj.Particle(k).Agent.PlotState(y,'*g');
            if ishandle(h1)
                delete(h1)
            end
            h1 = obj.Particle(k).Agent.PlotState(x,'.k');
        end
    end    
    u = obj.Particle(k).Agent.InverseKinematicsFcn(x, y);
    obj.Particle(k).Agent.UpdateState(u);
    if k == 1      
        obj.Particle(k).Agent.PlotStateTransition(x, obj.Particle(k).Agent.State);
    end
end

% evaluate fitness for each particle
for k = 1:obj.ParticlesCount
    % calculate current fitness
    f = ...
        obj.CostFcn(obj.Particle(k).Agent.State,...
        obj.Goal.State);
    
    % check if it's particles' best
    if isempty(obj.Particle(k).Fitness)
        % if it's the first time we run, initialize with the current
        % fitness
        obj.Particle(k).Fitness = f;
    elseif (f < obj.Particle(k).Fitness)
        % if we are at a new best fit save current state as the best one
        obj.Particle(k).BestState = ...
            obj.Particle(k).Agent.State;
        % and log the fitness value
        obj.Particle(k).Fitness = f;
        % draw (only first particle)
        if k == 1
            clear h1;
            if ishandle(h2)
                delete(h2)
            end
            % Plot particles global best...
            h2 = obj.Particle(k).Agent.PlotState(obj.Particle(k).BestState,'*b');
        end
        
        % and while we're at it, check if it's the global best
        if isempty(obj.GlobalFitness)
            % if it's the first time we run, initialize with the current
            % fitness
            obj.GlobalFitness = f;
        elseif (f < obj.GlobalFitness)
            % and if we have a better value store it:
            % add current state to the history
            obj.GlobalFitnessHistory =...
                [obj.GlobalFitnessHistory f];
            % and set new best global fitness
            obj.GlobalFitness = f;
            obj.GlobalBestState = ...
                obj.Particle(k).Agent.State;
        end
    end
    
end

if ishandle(h3)
    delete(h3)
end
h3 = obj.Particle(k).Agent.PlotState(obj.GlobalBestState,'or');

end