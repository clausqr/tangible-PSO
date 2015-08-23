classdef PSO < matlab.mixin.Copyable
    % PSO Particle Swarm Optimization for Formation Pathfinding.
    %
    % (c) https://github.com/clausqr for ECI2015
    properties (GetAccess = public, SetAccess = protected)
        
        Particle           % Array of Particles
        ParticlesCount     % Number of Particles
        CostFunction       % Cost function used to weight the fitness
        
    end
    
    methods (Access = public)
        
        function obj = PSO(CostFunction)
            % PSO Constructor
            obj = obj.reset(CostFunction);
        end
        
        function obj = AddParticle(obj, a)
            % PSO Constructor
            n = obj.ParticlesCount;
            if (n == 0)
                obj.Particle = a;
            else
                obj.Particle(n+1) = a;
            end
            obj.ParticlesCount = n+1;
        end
        
    end
    
    methods (Access = private)
        function obj = reset(obj, CostFunction)
            obj.CostFunction = CostFunction;
            obj.ParticlesCount = 0;
        end
    end
end