function u = CostFcn(x, g)

% N_Agents = 3;
% n_states = 5;
% 
if numel(x) == 15
% u = norm(x(1:2)'-g(1:2)') +...
%          norm(x(6:7)'-g(6:7)') +...
%          norm(x(11:12)'-g(11:12)') ;
u1 = norm([x(1:2) x(6:7) x(11:12)] - [g(1:2) g(6:7) g(11:12)]);

u1u2 = norm((x(1:2)-x(6:7))-(g(1:2)-g(6:7)));
u2u3 = norm((x(11:12)-x(6:7)) - (g(11:12)-g(6:7)));
u1u3 = norm((x(1:2)-x(11:12))-(g(1:2)-g(11:12)));
    
u1g1 = norm(x(1:2)'-g(1:2)');
u2g2 = norm(x(6:7)'-g(6:7)');
u3g3 = norm(x(11:12)'-g(11:12)');


u = u1g1^2 + u2g2^2 + u3g3^2 + (u1u2^2+u2u3^2+u1u3^2);
%u = u2g2;

else
    u = norm(x(1:2)'-g(1:2)');
end

end