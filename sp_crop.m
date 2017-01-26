function [x, y, im_data_cropped, varargout] = sp_crop(im_data,ref,varargin)

% if specifying a rectangle via varargin, the structure is [ymin ymax xmin
% xmax]

switch nargin
    
    case 3
        
        dx = ref.PixelExtentInWorldX;
        dy = ref.PixelExtentInWorldY;
        x = linspace(ref.XWorldLimits(1)+dx/2,...
            ref.XWorldLimits(2)-dx/2,size(im_data,2));
        y = linspace(ref.YWorldLimits(1)+dy/2,...
            ref.YWorldLimits(2)-dy/2,size(im_data,1));
        
        rect = varargin{1};
        
        im_data_cropped = im_data(rect(1):rect(2),rect(3):rect(4));
        
        ref_out = imref2d(size(im_data_cropped));
%         ref_out.XWorldLimits = [x(rect(3))-dx/2 x(rect(4))+dx/2];
%         ref_out.YWorldLimits = [y(rect(1))-dy/2 y(rect(2))+dy/2];
        ref_out.XWorldLimits = [0 (x(rect(4))-x(rect(3)))+dx/2];
        ref_out.YWorldLimits = [0 (y(rect(2))-y(rect(1)))+dy/2];
        
        x = linspace(ref_out.XWorldLimits(1)+dx/2,...
            ref_out.XWorldLimits(2)-dx/2,size(im_data_cropped,2));
        x = x';
        
        y = linspace(ref_out.YWorldLimits(1)+dy/2,...
            ref_out.YWorldLimits(2)-dy/2,size(im_data_cropped,1));
        y = y';
        
        varargout{1} = ref_out;
        
    case 2
        
        dx = ref.PixelExtentInWorldX;
        dy = ref.PixelExtentInWorldY;
        x = linspace(ref.XWorldLimits(1)+dx/2,...
            ref.XWorldLimits(2)-dx/2,size(im_data,2));
        y = linspace(ref.YWorldLimits(1)+dy/2,...
            ref.YWorldLimits(2)-dy/2,size(im_data,1));
        
        figure
        imshow(im_data,ref,[min(im_data(:)) max(im_data(:))])
        colormap fire
        
        rect  = getrect;
        rect = [rect(1) rect(2) rect(1)+rect(3) rect(2)+rect(4)];
        rect = [rect(1)/dx rect(2)/dy rect(3)/dx rect(4)/dy];
        rect = round(rect);
        
        im_data_cropped = im_data(rect(2):rect(4),rect(1):rect(3));
        
        ref_out = imref2d(size(im_data_cropped));
        ref_out.XWorldLimits = [x(rect(1))-dx/2 x(rect(3))+dx/2];
        ref_out.YWorldLimits = [y(rect(2))-dy/2 y(rect(4))+dy/2];
        
        figure
        imshow(im_data_cropped,ref_out,[min(im_data(:)) max(im_data(:))])
        colormap fire
        
        x = linspace(ref_out.XWorldLimits(1)+dx/2,...
            ref_out.XWorldLimits(2)-dx/2,size(im_data_cropped,2));
        x = x';
        
        y = linspace(ref_out.YWorldLimits(1)+dy/2,...
            ref_out.YWorldLimits(2)-dy/2,size(im_data_cropped,1));
        y = y';
        
        varargout{1} = ref_out;
        
end


