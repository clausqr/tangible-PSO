classdef SWARM < matlab.mixin.Copyable
    % SWARM Set of functions to model a Agent SWARM and manipulate its state space.
    % (c) https://github.com/clausqr for ECI2015
    %
    %  Provides methods to model an instance of a SWARM but also exposes its
    %  static methods to update state, generate and manipulate controls,
    %  etc, and also to plot the states.
    properties (GetAccess = public, SetAccess = protected)
        
        % Properties for the actual instance that moves around (additional
        % static methods used for path planning modify these values only
        % through instance methods.
        
        % Replicates the Agent interface for properties and methods, and
        % encapsulates the 1 to many translations
        
        InitialState    % Initial Sate
        State           % Current State
        StateHistory    % State History
        CurrentIterationStep    % Current Iteration Step
        
        Agent     % list of Agents.
        AgentCount % Count of Agents
        
        n_states    % number of states for each Agent
        n_inputs    % number of inputs for each Agent
    end
    
    methods (Access = public)
        
        % Constructor
        function obj = SWARM()
            
            obj.AgentCount = 0;
            obj.CurrentIterationStep = 1;
        end
        
        function obj = AddAgent(obj, a)
            
            n = obj.AgentCount;
            if (n == 0)
                obj.Agent = a;
            else
                obj.Agent(n+1) = a;
            end
            
            % Hack to obtain the number of states,
            % //TODO: find a better way to obtain it!
            
            obj.n_states = numel(obj.Agent(1).getNewRandomState);
            obj.n_inputs = numel(obj.Agent(1).InverseKinematicsFcn(zeros(obj.n_states,1),...
            zeros(obj.n_states,1)));
            
            k = n+1;
            idxs = (obj.n_states*(k-1)+1):(obj.n_states*k);
            obj.State(idxs,1) = obj.Agent(k).State;
            obj.InitialState(idxs,1) = obj.Agent(k).InitialState;
            
            obj.AgentCount = n+1;
            
        end
        
        function obj = Init(obj, InitialStates)
            n = obj.AgentCount;
            % Hack to obtain the number of states and inputs,
            % //TODO: find a better way to obtain it!
            
            if isempty(obj.n_states)
                obj.n_states = numel(obj.Agent(1).getNewRandomState);
            end
            if isempty(obj.n_inputs)
                obj.n_inputs = numel(obj.Agent(1).InverseKinematicsFcn(zeros(obj.n_states,1),...
                zeros(obj.n_states,1)));
            end
            
            for k = 1:n
                idxs = (obj.n_states*(k-1)+1):(obj.n_states*k);
                obj.Agent(k).Init(InitialStates(idxs));
                obj.State(idxs) = obj.Agent(k).State;
                obj.InitialState(idxs,1) = obj.Agent(k).InitialState;
            end
        end
        
        % Updates the state of the actual instance
        function obj = UpdateState(obj, u)
            
            
            n = obj.AgentCount;
            
            % Hack to obtain the number of states and inputs,
            % //TODO: find a better way to obtain it!
            if isempty(obj.n_inputs)
                x = obj.Agent(1).getNewRandomState;
                temp_u = obj.Agent(1).InverseKinematicsFcn(x, x);
                obj.n_inputs = numel(temp_u);
            end
            
            for k = 1:n
                idxs_inputs = (obj.n_inputs*(k-1)+1):(obj.n_inputs*k);
                idxs_states = (obj.n_states*(k-1)+1):(obj.n_states*k);
                obj.Agent(k).UpdateState(u(idxs_inputs));
                obj.State(idxs_states) = obj.Agent(k).State;
            end
            
            % Save history
            k = obj.CurrentIterationStep;
            obj.StateHistory{k} = obj.State;
            obj.CurrentIterationStep = k+1;
        end
        
        % Following function can't be static, depends on number of states
        % and inputs.
        newstate = StateTransitionFcn(obj, State, Controls)  % State Transition function

        s = getNewRandomState(obj) % Function used to get a random point in state space
        controls = InverseKinematicsFcn(obj, FromState, ToState)  % Inverse Dynamics (or Kinematics) function
        us = ControlsShuffle(obj, u) % Shuffle the controls for branching and stuff
        PlotStateTransition(obj, varargin) % and to plot a transition between states
        d = DistanceInStateSpace(obj, x, y) % Function to compute distance between a pair of states
        h = PlotState(obj, State, Style) % Function used to plot a state

    end
    
    % Following static methods are implemented here so they can be called
    % from the outside for path planning purposes, and from the inside for
    % actual instance movement.
    
    methods (Static)
                
        
        %PlotStateTransition(FromState, ToState, Controls, Style, Width) % and to plot a transition between states
        
    end
    
end
