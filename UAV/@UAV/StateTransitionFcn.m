function newstate = StateTransitionFcn(state, input)

x = state(1);       %pos.x
y = state(2);       %pos.y
z = state(3);       %pos.z
v = state(4);       %velocity
theta = state(5);   %angle

delta_v = input(1);      %commanded change in velocity
delta_theta = input(2);  %commanded steering change in angle

newv = v + delta_v;
newtheta = theta + delta_theta;

% unwinding
if newtheta > pi
    newtheta = newtheta - 2*pi;
elseif newtheta < -pi
    newtheta = newtheta + 2*pi;
end

newx = x + newv*cos(newtheta);
newy = y + newv*sin(newtheta);
newz = z;

newstate = [newx; newy; newz; newv; newtheta];
