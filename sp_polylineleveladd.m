function [im_data_level,varargout] = sp_polylineleveladd(im_data,degree,varargin)

bg = im_data;
x = 1:size(im_data,2);

if length(varargin) == 1
    
    mask = varargin{1};
    
    for k = 1:size(im_data,1)
        
        exclude = mask(k,:);
        y = im_data(k,:);
        p = fit(x',y',...
            strcat('poly',num2str(degree)),'Exclude',find(exclude > 0));
        bg(k,:) = transpose(feval(p,x'));
        
    end
    
else
    
    for k = 1:size(im_data,1)
        
        p = polyfit((1:size(im_data,2)),im_data(k,:),degree);
        bg(k,:) = polyval(p,(1:size(im_data,2)));
        
    end
    
end

im_data_level = im_data - bg;

varargout{1} = bg;