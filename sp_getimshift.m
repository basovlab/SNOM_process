function [x_shift,y_shift,varargout] = sp_getimshift(fixed,moving,dimensions,varargin)

% normalize images
fixed = fixed/max(fixed(:));
moving = moving/max(moving(:));

% set real-world limits so outputs are in correct units
rw = imref2d(size(fixed));
rw.XWorldLimits = [0 dimensions(1)];
rw.YWorldLimits = [0 dimensions(2)];

% figure
% imshowpair(fixed,rw,moving,rw)

% configure automatic intensity-based image registration
[optimizer,metric] = imregconfig('monomodal');

% update optimizer settings
optimizer.GradientMagnitudeTolerance = 1e-6;
optimizer.MinimumStepLength = 5e-7;
optimizer.MaximumStepLength = 5e-4;
optimizer.MaximumIterations = 1000;
optimizer.RelaxationFactor = 0.5;

[moving_reg,~] = imregister(moving,fixed,'translation',...
    optimizer,metric);
figure, imshowpair(fixed,moving_reg)

% get relative shift between images in form of affine transformation
if ~isempty(varargin)
    tform = imregtform(moving,rw,fixed,rw,'rigid',optimizer,metric,...
        'DisplayOptimization',0);
else
    tform = imregtform(moving,rw,fixed,rw,'translation',optimizer,metric,...
        'DisplayOptimization',0);    
end
tform = tform.T;

% extract translation from affine transformation
x_shift = tform(3,1);
y_shift = tform(3,2);

if ~isempty(varargin)
    
    varargout{1} = acosd(tform(1,1));
    
end

