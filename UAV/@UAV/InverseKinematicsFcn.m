function u = InverseKinematicsFcn(obj, x, y)
% INVERSEKINEMATICS Inverse Dynamics (or Kinematics) function,
%   finds the right control inputs to go towards a desired state, 
% starting from the current state.        
        
AngleYtoX = atan2(y(2)-x(2), y(1)-x(1));
%DistanceYtoX = norm(x-y);
current_state_angle = x(5);


delta_theta = AngleYtoX - current_state_angle;
%steering only control

% a = 0.005;
% b = -0.05;
% delta_v = a*DistanceYtoX + b*(obj.State(4)-0.05);

% max_delta_theta = pi/8;
% if delta_theta > max_delta_theta
%     delta_theta = max_delta_theta;
% elseif delta_theta < -max_delta_theta
%     delta_theta = -max_delta_theta;
% else
%     delta_theta = 0;
% end

delta_v = 0;

u = [delta_v; delta_theta];

end