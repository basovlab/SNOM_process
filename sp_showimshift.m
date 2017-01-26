function moving_reg = sp_showimshift(fixed,moving,dimensions)

% normalize images
fixed = fixed/max(fixed(:));
moving = moving/max(moving(:));

figure
imshowpair(fixed,moving)

% set real-world limits so outputs are in correct units
rw = imref2d(size(fixed));
rw.XWorldLimits = [0 dimensions(1)];
rw.YWorldLimits = [0 dimensions(2)];

% figure
% imshowpair(fixed,rw,moving,rw)
% set(gca,'ydir','normal')

% configure automatic intensity-based image registration
[optimizer,metric] = imregconfig('monomodal');

% update optimizer settings
optimizer.GradientMagnitudeTolerance = 1e-5;
optimizer.MinimumStepLength = 1e-6;
optimizer.MaximumStepLength = 2e-3;
disp(optimizer)

% [moving_reg,~] = imregister(moving,rw,fixed,rw,'translation'...
%     ,optimizer,metric);

% figure, imshowpair(fixed,rw,moving_reg,rw)
% set(gca,'ydir','normal')

% get relative shift between images in form of affine transformation
moving_reg = imregister(moving,rw,fixed,rw,'translation',optimizer,metric);

figure
imshowpair(fixed,moving_reg)
