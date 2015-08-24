function u = InverseKinematicsFcn(obj, x, y)
% INVERSEKINEMATICS Inverse Dynamics (or Kinematics) function,
%   finds the right control inputs to go towards a desired state,
% starting from the current state.

AngleYtoX = atan2(y(2)-x(2), y(1)-x(1));
DistanceYtoX = norm(x(1:2)-y(1:2));

current_state_angle = x(5);
current_vel = x(4);

angle_saturation = true;
max_delta_theta = pi/8;
ref_vel = 0.025;
max_vel = ref_vel;
max_delta_v = 1/8*ref_vel;

delta_theta = AngleYtoX - current_state_angle;
%steering only control




% unwinding
if delta_theta > pi
    delta_theta= delta_theta- 2*pi;
elseif delta_theta < -pi
    delta_theta= delta_theta+ 2*pi;
end


% Saturation in angle steering
if angle_saturation
    if delta_theta > max_delta_theta
        delta_theta = max_delta_theta;
    elseif delta_theta < -max_delta_theta
        delta_theta = -max_delta_theta;
    else
        delta_theta = 0;
    end
end


%   a = 0.05;
%   b = 0.15;
% delta_v = a*DistanceYtoX + b*(ref_vel-current_vel);


a = 0.9;
% delta_v = -current_vel + a*ref_vel*rand(1) ;

%delta_v = -current_vel + a*DistanceYtoX;
a = a*(1+cos(AngleYtoX))/2;
delta_v = -current_vel+a*DistanceYtoX+ref_vel*(1-cos(AngleYtoX)); %+max_delta_v*(rand(1)*2-1)/2;

% if (current_vel+delta_v) > max_vel
%     delta_v = -(current_vel-max_vel);
% elseif (current_vel+delta_v) < 0
%     delta_v = -current_vel;
% else
%     if delta_v > max_delta_v
%         delta_v = max_delta_v;
%     elseif delta_v < -max_delta_v
%         delta_v = -max_delta_v;
%     else
%         delta_v =0;
%     end
% end


u = [delta_v; delta_theta];

end