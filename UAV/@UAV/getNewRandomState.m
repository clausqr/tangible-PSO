function s = getNewRandomState()


s = diag([1 1 0 0 2*pi])*rand(5,1) + [0; 0; 0.5; 0; -pi]; 


end
