%DISTANCEXYFROM5STATE Returns the distance between the x, y components of a 5 state (x, y, z, v, theta)

function d = DistanceInStateSpace(x, y)

d = norm(x(1:2,:) - y(1:2,:));



