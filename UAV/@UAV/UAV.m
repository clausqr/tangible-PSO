classdef UAV < handle
    % UAV Set of functions to model a UAV and manipulate its state space.
    % (c) https://github.com/clausqr for ECI2015
    %  
    %  Provides methods to model an instance of a UAV but also exposes its
    %  static methods to update state, generate and manipulate controls,
    %  etc, and also to plot the states.
    properties (GetAccess = public, SetAccess = protected)
    
        % Properties for the actual instance that moves around (additional
        % static methods used for path planning modify these values only
        % through instance methods.
        
        InitialState    % Initial Sate
        State           % Current State
        StateHistory    % State History
        CurrentIterationStep    % Current Iteration Step
   
    end
    
    methods (Access = public)
        
        % Constructor
        function obj = UAV(InitialState)
            
            obj.Init(InitialState);
            
        end
        
        function obj = Init(obj, InitialState)
            
            obj.InitialState = InitialState;
            obj.State = InitialState;
            obj.CurrentIterationStep = 1;
            
        end
        
        % Updates the state of the actual instance
        function obj = UpdateState(obj, u)
            
            k = obj.CurrentIterationStep;
            obj.StateHistory{k} = obj.State;
            
            obj.State = obj.StateTransitionFcn(obj.State, u);
            obj.CurrentIterationStep = k+1;
        end

    end
    
    % Following static methods are implemented here so they can be called
    % from the outside for path planning purposes, and from the inside for
    % actual instance movement.
    methods (Static)
       
        newstate = StateTransitionFcn(State, Controls)  % State Transition function
        
        controls = InverseKinematics(FromState, ToState)  % Inverse Dynamics (or Kinematics) function
        
        d = DistanceInStateSpace(x, y) % Function to compute distance between a pair of states
        
        us = ControlsShuffle(u) % Function used to generate several variations of a control input, used for branching
        
        s = getNewRandomState() % Function used to get a random point in state space
        
        h = PlotState(State, Style) % Function used to plot a state
        
        PlotStateTransition(varargin) % and to plot a transition between states
        %PlotStateTransition(FromState, ToState, Controls, Style, Width) % and to plot a transition between states
  
    end
    
end
