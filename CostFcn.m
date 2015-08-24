function u = CostFcn(x, g)

% N_Agents = 3;
% n_states = 5;
% 
if numel(x) == 15
% u = norm(x(1:2)'-g(1:2)') +...
%          norm(x(5:6)'-g(5:6)') +...
%          norm(x(10:11)'-g(10:11)') ;
u1 = norm([x(1:2) x(5:6) x(10:11)] - [g(1:2) g(5:6) g(10:11)]);

u1u2 = norm((x(1:2)-x(5:6))-(g(1:2)-g(5:6)));
u2u3 = norm((x(10:11)-x(5:6)) - (g(10:11)-g(5:6)));
u1u3 = norm((x(1:2)-x(10:11))-(g(1:2)-g(10:11)));
    
u1g1 = norm(x(1:2)'-g(1:2)');
u2g2 = norm(x(5:6)'-g(5:6)');
u3g3 = norm(x(10:11)'-g(10:11)');


u = u1g1^2 + u2g2^2 + u3g3^2 + (u1u2^2+u2u3^2+u1u3^2);


else
    u = norm(x(1:2)'-g(1:2)');
end

end