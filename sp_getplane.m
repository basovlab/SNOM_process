function out = sp_getplane(x, y, z)
% sp_getplane outputs the coefficients for equation of a plane given three
% points on the plane
% 
% x, y, z are the coordinates the known points in the form of 3x1 column
% vectors
% 
% output is a 1x3 vector with values such that out = [p00 p10 p01] where
% the p's are defined by the equation z = p00 + p10*x + p01*y


% first point on the plane
p = [x(1), y(1), z(1)];
q = [x(2), y(2), z(2)];
r = [x(3), y(3), z(3)];

% two vectors in the plane
pq = q - p;
pr = r - p;

% vector normal to the plane
n = cross(pq,pr);

% constant offset
out(1) = dot(n,p)/n(3);

% x coefficient
out(2) = -n(1)/n(3);

% y coefficient 
out(3) = -n(2)/n(3);