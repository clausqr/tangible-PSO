classdef PSO < matlab.mixin.Copyable
    % PSO Particle Swarm Optimization for Formation Pathfinding.
    %
    % (c) https://github.com/clausqr for ECI2015
    properties (GetAccess = public, SetAccess = protected)

        ParticlesCount      % Number of Particles
        Particle            % Array of Particles
                            % Particle Fields:
                            %       Particle.Fitness    
                            %       Particle.BestState
        GlobalBestState     % Best state overall
        GlobalFitness       % And keep track of best global fitness
        GlobalFitnessHistory% log it here
        CostFcn             % Cost function used to weight the fitness
        Goal                % Goal of optimization
        
    end
    
    methods (Access = public)
        
        function obj = PSO(Agent, ParticleCount, Goal, CostFcn)
            % PSO Constructor
            obj = obj.reset(Agent, ParticleCount, Goal, CostFcn);
        end
        
        obj = Iterate(obj);
    end
    
    methods (Access = private)
        
        function obj = AddParticle(obj, a)
            % PSO Constructor
            n = obj.ParticlesCount;
            if (n == 0)
                obj.Particle.Agent = a;
                obj.Particle.Fitness = [];
                obj.Particle.BestState = a.InitialState;
                obj.Particle.StateVel = zeros(size(a.InitialState));
            else
                obj.Particle(n+1).Agent = a;
                obj.Particle(n+1).Fitness = [];
                obj.Particle(n+1).BestState = a.InitialState;
                obj.Particle(n+1).StateVel = zeros(size(a.InitialState));
            end
            obj.ParticlesCount = n+1;
        end
        function obj = reset(obj, Agent, ParticleCount, Goal, CostFcn)
            obj.CostFcn = CostFcn;
            obj.ParticlesCount = 0;
            obj.GlobalFitnessHistory = [];
            obj.GlobalBestState = Agent.InitialState;
            [nxg, nyg] = size(Goal.state);
            obj.Goal.State = reshape(Goal.state, nxg*nyg, 1);
            for k = 1:ParticleCount
                % copy the Agent passed as a reference, don't touch the
                % original. Each copy will behave separately. Agent needs
                % to be a subclass of matlab.mixin.Copyable superclass,
                % otherwise this won't work and we'd be moving the same
                % agent in different directions instead of cloning them.
                % For detail see http://www.mathworks.com/help/matlab/ref/matlab.mixin.copyable-class.html
                a = copy(Agent);
                obj.AddParticle(a)
            end
        end
    end
end