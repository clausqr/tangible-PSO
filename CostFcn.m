function u = CostFcn(x, g)

% N_Agents = 3;
% n_states = 5;
% 
if numel(x) == 15
% u = norm(x(1:2)'-g(1:2)') +...
%          norm(x(5:6)'-g(5:6)') +...
%          norm(x(10:11)'-g(10:11)') ;
u1 = norm([x(1:2) x(5:6) x(10:11)] - [g(1:2) g(5:6) g(10:11)]);

u2 = abs(norm(x(1:2)-x(5:6))-0.1);
u3 = abs(norm(x(10:11)-x(5:6))-0.1);
u4 = abs(norm(x(1:2)-x(10:11))-0.1*sqrt(2));
    
u = 3*u1 + u2 + u3 + u4;


else
    u = norm(x(1:2)'-g(1:2)');
end

end