function obj = Iterate(obj)
persistent h1
persistent h2
persistent h3
persistent h4

% propagate step
for k = 1:obj.ParticlesCount
    x = obj.Particle(k).Agent.State;
    if (obj.Particle(k).Agent.CurrentIterationStep == 1)
        y = obj.Particle(k).Agent.getNewRandomState;
    else
        a = 0.4;
        b = 0.4;
        c = 0.2;
        y = a*obj.Particle(k).BestState + ...
            b*obj.GlobalBestState + ...
            c*obj.Particle(k).Agent.getNewRandomState;
        
%         if k == 1
%             if ~isempty(h4)
%                 delete(h4)
%             end
%             h4 = obj.Particle(k).Agent.PlotState(y,'*g');
%         end
    end
    u = obj.Particle(k).Agent.InverseKinematicsFcn(x, y);
    obj.Particle(k).Agent.UpdateState(u);
    if k == 1
        h1 = obj.Particle(k).Agent.PlotState(obj.Particle(k).Agent.State,'.k');
    end
end

% evaluate fitness for each particle
for k = 1:obj.ParticlesCount
    f = ...
        obj.CostFcn(obj.Particle(k).Agent.State,...
        obj.Goal.State);
    
    % check if it's particles' best
    if isempty(obj.Particle(k).Fitness)
        obj.Particle(k).Fitness = f;
    elseif (f < obj.Particle(k).Fitness)
        obj.Particle(k).BestState = ...
            obj.Particle(k).Agent.State;
        if k == 1
            clear h1;
            if ~isempty(h2)
                clear h2
            end
            h2 = obj.Particle(k).Agent.PlotState(obj.Particle(k).BestState,'.b');
        end
        % and while we're at it, check if it's the global best
        if isempty(obj.GlobalFitness)
            obj.GlobalFitness = f;
        elseif (f < obj.GlobalFitness)
            obj.GlobalFitness = f;
            obj.GlobalBestState = ...
                obj.Particle(k).Agent.State;
        end
    end
    
    obj.Particle(k).Fitness = f;
    
end

if ~isempty(h3)
    clear h3
end
h3 = obj.Particle(k).Agent.PlotState(obj.GlobalBestState,'.r');

end