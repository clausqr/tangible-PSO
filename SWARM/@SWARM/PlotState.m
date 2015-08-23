function h = PlotState(obj, state, style)
hold on
    %unused idxs_inputs = (obj.n_inputs*(k-1)+1):(obj.n_inputs*k);
    h = zeros(1, obj.AgentCount);
    for k=1:obj.AgentCount
        idxs_states = (obj.n_states*(k-1)+1):(obj.n_states*k);
        h(k) = obj.Agent(k).PlotState(state(idxs_states), style);
    end
end