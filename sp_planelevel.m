function [scan_levelled,X,Y] = sp_planelevel(scan,path_x,path_y,radius)

if length(path_x) ~= 3 || length(path_y) ~= 3
    
    error('Choose exactly three points.')
    
end

nRho = radius;
squeezx = 1; 
squeezy = 1;

NOP = round(2*pi*nRho);
THETA = linspace(0,2*pi,NOP);
RHO = ones(1,NOP)*round(nRho);
[X0,Y0] = pol2cart(THETA,RHO);
X0 = squeezx*X0;
Y0 = squeezy*Y0;
[THETA,RHO] = cart2pol(X0,Y0);
[X0,Y0] = pol2cart(THETA,RHO);
X0 = round(X0);
Y0 = round(Y0);

path_z = [0 0 0];

X = zeros(3,length(X0)); Y = X;

for j = 1:length(path_x)
    
    X(j,:) = X0 + path_x(j);
    Y(j,:) = Y0 + path_y(j);
    
    cx = path_x(j); 
    cy = path_y(j);
    ix = size(scan,2);
    iy = size(scan,1);
    r = nRho;
    
    [x_mask,y_mask] = meshgrid(-(cx-1):(ix-cx),-(cy-1):(iy-cy));
    c_mask = ((x_mask.^2 + y_mask.^2) <= r^2);
    
%     figure
%     imagesc(c_mask)
%     axis image
    
    path_z(j) = mean(scan(c_mask ~= 0));
    
end

v1 = [path_x(2)-path_x(1) path_y(2)-path_y(1) path_z(2)-path_z(1)];
v2 = [path_x(3)-path_x(1) path_y(3)-path_y(1) path_z(3)-path_z(1)];

n = cross(v1,v2);

x = 1:size(scan,2); y = 1:size(scan,1);
[x,y] = meshgrid(x,y);
d = dot(n,[path_x(1) path_y(1) path_z(1)]);

z_plane = (d - n(1)*x - n(2)*y)/n(3); z_plane = z_plane - min(z_plane(:));

scan_levelled = scan - z_plane;
