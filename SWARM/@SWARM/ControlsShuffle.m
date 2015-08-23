function us = ControlsShuffle(obj, u)


%     extra_delta_theta = pi/8;
%     u_plus = u + [0; extra_delta_theta];
%     u_minus = u - [0; extra_delta_theta];
%     us = [u_plus u u_minus];

n = obj.AgentCount;
%hack to get the number of shuffled controls... //TODO: fix this hack.
us = zeros(n*obj.n_inputs,...
    size(obj.Agent(1).ControlsShuffle(zeros(obj.n_inputs,1)),2)...
    );

for k = 1:n
    
    idxs_inputs = (obj.n_inputs*(k-1)+1):(obj.n_inputs*k);
    %unused    idxs_states = (obj.n_states*(k-1)+1):(obj.n_states*k);
    us(idxs_inputs,:) = ...
        obj.Agent(k).ControlsShuffle(u(idxs_inputs));
    
end

end