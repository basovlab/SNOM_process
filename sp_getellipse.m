function out = sp_getellipse(scan,a,b,center)

% if a > b
%     nRho = b;
% %     squeezx = a/b; 
% %     squeezy = 1;
% else
%     nRho = a;
%     squeezx = 1; 
%     squeezy = b/a;
% end

% NOP = round(2*pi*nRho);
% THETA = linspace(0,2*pi,NOP);
% RHO = ones(1,NOP)*round(nRho);
% [X0,Y0] = pol2cart(THETA,RHO);
% X0 = squeezx*X0;
% Y0 = squeezy*Y0;
% [THETA,RHO] = cart2pol(X0,Y0);
% [X0,Y0] = pol2cart(THETA,RHO);
% X0 = round(X0);
% Y0 = round(Y0);
% 
cx = center(1);
cy = center(2);
ix = size(scan,2);
iy = size(scan,1);
% r = nRho;

[x_mask,y_mask] = meshgrid(-(cx-1):(ix-cx),-(cy-1):(iy-cy));
out = ((x_mask.^2/a^2 + y_mask.^2/b^2) <= 1);

figure
imagesc(out)
colormap gray
axis image
