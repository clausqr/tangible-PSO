function u = InverseKinematicsFcn(obj, x, y)
% INVERSEKINEMATICS Inverse Dynamics (or Kinematics) function,
%   finds the right control inputs to go towards a desired state,
% starting from the current state.

AngleYtoX = atan2(y(2)-x(2), y(1)-x(1));
DistanceYtoX = norm(x(1:2)-y(1:2));

current_state_angle = x(5);
current_vel = x(4);

% choose wether to saturate controls
vel_saturation = true;
angle_saturation = false;

max_delta_theta = pi/8;

ref_vel = 0.025;
max_vel = 5*ref_vel;
vel_step = ref_vel/4;

delta_theta = AngleYtoX - current_state_angle;

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

if ~vel_saturation
    a = 0.85; % damping to avoid error acumulation
    delta_v = -current_vel + a*DistanceYtoX;
else
 
    delta_v = vel_step*(2*rand(1)-1)/2;
    new_current_vel = current_vel + delta_v;
    
    if new_current_vel > max_vel
        delta_v = -(max_vel - new_current_vel) - vel_step;
    elseif current_vel < 0
        delta_v = -new_current_vel + vel_step;
    else
        
    end
        
    
    
end

u = [delta_v; delta_theta];

end