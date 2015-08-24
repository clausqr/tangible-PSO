n = 201;
[x_, y_] = meshgrid(linspace(0,1,n),linspace(0,1,n));
z_=x_*0;
g = createPathGoals(3);
g = [g.state(:,1); g.state(:,2); g.state(:,3)];
for k1 = 1:n
    for k2 = 1:n
        x = x_(k1,k2);
        y = y_(k1,k2);
        s1 = [x y 0 0 0];
        s = [s1 s1 s1]';
        z_(k1,k2) = CostFcn(s, g);
    end
end
%%
contourf(z_.*(z_<1/70))