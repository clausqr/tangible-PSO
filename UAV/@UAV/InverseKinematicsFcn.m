function u = InverseKinematicsFcn(obj, x, y)
% INVERSEKINEMATICS Inverse Dynamics (or Kinematics) function,
%   finds the right control inputs to go towards a desired state,
% starting from the current state.

AngleYtoX = atan2(y(2)-x(2), y(1)-x(1));
DistanceYtoX = norm(x(1:2)-y(1:2));

current_state_angle = x(5);
current_vel = x(4);

angle_saturation = false;


delta_theta = AngleYtoX - current_state_angle;
%steering only control
ref_vel = 0.025;

%   a = 0.05;
%   b = 0.15;
% delta_v = a*DistanceYtoX + b*(ref_vel-current_vel);


 a = 0.9;
% delta_v = -current_vel + a*ref_vel*rand(1) ;

%delta_v = -current_vel + a*DistanceYtoX;

max_delta_v = ref_vel;
delta_v = -current_vel + a*DistanceYtoX;

% if delta_v > max_delta_v
%     delta_v = max_delta_v;
% end
% elseif delta_v < -max_delta_v
%     delta_v = -max_delta_v;
% end

% unwinding
if delta_theta > pi
    delta_theta= delta_theta- 2*pi;
elseif delta_theta < -pi
    delta_theta= delta_theta+ 2*pi;
end


% Saturation in angle steering
max_delta_theta = pi/8;
if angle_saturation
    if delta_theta > max_delta_theta
        delta_theta = max_delta_theta;
    elseif delta_theta < -max_delta_theta
        delta_theta = -max_delta_theta;
    else
      %  delta_theta = 0;
    end
end


u = [delta_v; delta_theta];

end