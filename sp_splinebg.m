function out = sp_splinebg(x,y,im_data,smoothness,varargin)

% for choosing area, rect must be in form [y_min y_max; x_min x_max];

% figure
% imagesc(im_data)
% colormap sky
% axis image
% colorbar

if smoothness > 1
    smoothness = 1;
elseif smoothness < 0
    smoothness = 0;
end

switch nargin
    
    case 5
        
        if ~isempty(find(size(varargin{1})==1,1))
            exclude = varargin{1};
            if exclude == 0
                exclude = [];
            end
            rect = [1 size(im_data,1); 1 size(im_data,2)];
            z = im_data;
        else
            exclude = [];
            rect = varargin{1};
            z = im_data;
        end
        
    case 6
        
        if ~isempty(find(size(varargin{1})==1,1))
            exclude = varargin{1};
            rect = varargin{2};
            z = im_data;
        else
            exclude = varargin{2};
            rect = varargin{1};
            z = im_data;
        end
        
    otherwise
        
        z = im_data;
        exclude = [];
        rect = [1 size(im_data,1); 1 size(im_data,2)];

end

% Fit
[xData, yData, zData] = prepareSurfaceData(x(rect(2):rect(4)),...
    y(rect(1):rect(3)),z(rect(1):rect(3),rect(2):rect(4)));

% Fit model to data.
if isempty(exclude)
    
    [out, ~] = fit( [xData, yData], zData,'lowess','Span',smoothness);
    
else
    
    [out, ~] = fit( [xData, yData], zData,'lowess','Span',smoothness,...
        'Exclude',exclude);
    
end

[x,y] = meshgrid(x,y);
xData = x(rect(1):rect(3),rect(2):rect(4));
yData = y(rect(1):rect(3),rect(2):rect(4));

out = out(xData,yData);
% figure
% imagesc(xData,yData,zData)
% colormap sky
% axis image
% colorbar

out = interp2(xData,yData,out,x,y,'spline');

% figure
% imagesc(out)
% colormap sky
% axis image
% colorbar
% 
% figure
% imagesc(im_data - out + min(out(:)))
% colormap sky
% axis image
% colorbar