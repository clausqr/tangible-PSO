function newstate = getNewRandomState(obj)



n = obj.AgentCount;
newstate = 0*obj.State;
for k = 1:n
    
  %  idxs_inputs = (obj.n_inputs*(k-1)+1):(obj.n_inputs*k);
    idxs_states = (obj.n_states*(k-1)+1):(obj.n_states*k);
    newstate(idxs_states) =...
        obj.Agent(k).getNewRandomState();

end
