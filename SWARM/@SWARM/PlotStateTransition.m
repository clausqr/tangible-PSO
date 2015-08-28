function h = PlotStateTransition(obj, varargin)

hold on
us = varargin{1};
vs = varargin{2};
if nargin > 3
    color = varargin{4};
    width = varargin{5};
end

%unused idxs_inputs = (obj.n_inputs*(k-1)+1):(obj.n_inputs*k);
h = zeros(1, obj.AgentCount);

for k=1:obj.AgentCount
    idxs_states = (obj.n_states*(k-1)+1):(obj.n_states*k);
    
    u = us(idxs_states);
    v = vs(idxs_states);
    
    if nargin >3
        %h(k) = 
        obj.Agent(k).PlotStateTransition(u, v, e, color, width);
    else
        %h(k) = 
        obj.Agent(k).PlotStateTransition(u, v);
    end
    
end
end




