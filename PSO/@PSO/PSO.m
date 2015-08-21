classdef PSO < matlab.mixin.Copyable
    % PSO Particle Swarm Optimization for Formation Pathfinding.
    %
    % (c) https://github.com/clausqr for ECI2015
    properties (GetAccess = public, SetAccess = protected)
        
        Agent           % Array of agents
        AgentsCount     % Number of agents
        CostFunction    % Cost function used to weight the fitness 
        
    end
    
    methods (Access = public)

        function obj = PSO(CostFunction)
            % PSO Constructor
            obj = obj.reset(CostFunction);
        end
        
        function obj = AddAgent(obj, a)
            % PSO Constructor
            n = obj.AgentsCount;
            if (n == 0)
                obj.Agent = a;
            else
                obj.Agent(n+1) = a;
            end
            obj.AgentsCount = n+1;
        end

    end
    
    methods (Access = private)
        function obj = reset(obj, CostFunction)
            obj.CostFunction = CostFunction;
            obj.AgentsCount = 0;
        end
    end
end