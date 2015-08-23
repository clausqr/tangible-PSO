function us = ControlsShuffle(u)
    

    extra_delta_theta = pi/8;
    u_plus = u + [0; extra_delta_theta];
    u_minus = u - [0; extra_delta_theta];
    us = [u_plus u u_minus];


end