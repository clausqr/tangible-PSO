function u = CostFcn(x, g)

% N_Agents = 3;
% n_states = 5;

    u = norm(x(1:2)-g(1:2)) +...
        norm(x(5:6)-g(5:6)) +...
        norm(x(10:11)-g(10:11)) ;

end