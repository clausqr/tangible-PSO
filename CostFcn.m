function u = CostFcn(x, g)

% N_Agents = 3;
% n_states = 5;
%
N_Agents = numel(x) / 5;
if numel(x) == 15
    % u = norm(x(1:2)'-g(1:2)') +...
    %          norm(x(6:7)'-g(6:7)') +...
    %          norm(x(11:12)'-g(11:12)') ;
    u1 = norm([x(1:2) x(6:7) x(11:12)] - [g(1:2) g(6:7) g(11:12)]);
    
    d12 = norm((x(1:2)-x(6:7))-(g(1:2)-g(6:7)));
    d23 = norm((x(11:12)-x(6:7)) - (g(11:12)-g(6:7)));
    d13 = norm((x(1:2)-x(11:12))-(g(1:2)-g(11:12)));
    
    % u12 = f(d12/norm(g(1:2)-g(6:7)));
    % u23 = f(d23/norm(g(11:12)-g(6:7)));
    % u13 = f(d13/norm(g(1:2)-g(11:12)));
    
    u12 = (d12);
    u23 = (d23);
    u13 = (d13);
    
    u1g1 = norm(x(1:2)'-g(1:2)');
    u2g2 = norm(x(6:7)'-g(6:7)');
    u3g3 = norm(x(11:12)'-g(11:12)');
    
    
    u = u1g1^2 + u2g2^2 + u3g3^2 + (u12^2+u23^2+u13^2);
    
    u = u1 + (u12^2+u23^2+u13^2);
    
elseif numel(x)==5
    u = norm(x(1:2)'-g(1:2)');
else
    u = 0;
    for k1 = 1:N_Agents
        idxs1 = ((k1-1)*5+1):((k1-1)*5+2);
        d = norm(x(idxs1) - g(idxs1));
        u = u + 2*d^2;
        for k2 = k1:N_Agents
            idxs2 = ((k2-1)*5+1):((k2-1)*5+2);
            dab = norm( (x(idxs1)-x(idxs2)) - (g(idxs1)-g(idxs2)));
            u = u + dab^2;
        end
    end
    
end
