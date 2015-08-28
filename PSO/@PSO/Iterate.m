function obj = Iterate(obj)
persistent h1
persistent h2
persistent h3
persistent h4
persistent h5

% propagate step

% //TODO: See how particle velocity is handled (independently of Agent
% velocity) check (1).
for k = 1:obj.ParticlesCount
    
    n = obj.Particle(k).Agent.CurrentIterationStep;
    if (n == 1)
        x = obj.Particle(k).Agent.State;
        y = obj.Particle(k).Agent.getNewRandomState;
        % Launch the particles at random at the first iteration
        u = obj.Particle(k).Agent.InverseKinematicsFcn(x, x+y/30);
        
        obj.Particle(k).Agent.UpdateState(u);
        y = obj.Particle(k).Agent.State;
    else
        % Using nomenclature of
        % [1]	M. Saska, J. Chudoba, L. Precil, J. Thomas, G. Loianno, A. Tresnak, V. Vonasek, and V. Kumar, ?Autonomous deployment of swarms of micro-aerial vehicles in cooperative surveillance,? 2014 International Conference on Unmanned Aircraft Systems (ICUAS), pp. 584?595, 2014.
        %  bj: "[...] Each particle remembers its state with the best
        %   function value (cost function) visited so far; later called the
        %   individual best position of j-th PSO particle and denoted as bj
        %   [...]"
        bj = obj.Particle(k).BestState;
        %  bg:  "[...] The social knowledge is represented by the best
        %   position visited by a particle in the whole population; later
        %   called the global best position and denoted bg. [...]
        bg = obj.GlobalBestState;
        %  pj, uj: "[...] In the PSO algorithm, each particle j is represented by
        %   its D-dimensional position pj(t) and its current velocity vector
        %   uj(t). [...]"
        pj = obj.Particle(k).Agent.State;
        uj = obj.Particle(k).StateVel;
        %  fi1, fi2: "[...] where \Phi1 and \Phi2 are obtained as [...]
        fi1 = diag(rand(size(pj)));
        fi2 = diag(rand(size(pj)));
        uj = uj + fi1*(bj - pj) + fi2*(bg-pj);
        x = pj;
        pj = pj + uj;
        y = pj;
        
        if k == 1
            %            if ishandle(h5)
            %                 delete(h5)
            %             end
            %             h5 = obj.Particle(k).Agent.PlotState(z,'xg');
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
    z = obj.Particle(k).Agent.State;
    obj.Particle(k).StateVel = z - x;
    if k == 1
        %BREAKPOINT HERE TO LOOK AT EACH STEP
        obj.Particle(k).Agent.PlotStateTransition(x, z);
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
obj.GlobalBestStateHistory = [obj.GlobalBestStateHistory obj.GlobalBestState];

end