function [scan_level, varargout] = sp_pathlevel_full(scan,varargin)

% perform line leveling on image scan over path averaging over width radius

switch nargin
    
    case 1
        
        figure
        subplot(1,2,1)
        hold on
        imagesc(scan) 
        axis image
%         set(gca,'clim',[min(scan(:)) max(scan(:))])
        colormap gwyddion
        [x, y] = getline;
        x = round(x); y = round(y);
        
        hold on
        plot(x,y,'k')
        
        path = [x y];
        width = input('Averaging width: ');
        
    case 3
        
        path = varargin{1};
        width = varargin{2};
        
    otherwise
        
        error('Only 1 or 3 arguments allowed')
        
end

path_x = path(:,1);
path_y = path(:,2);
if min(path_x) < 1
    path_x(path_x == min(path_x)) = 1;
end
if max(path_x) > size(scan,1)
    path_x(path_x == max(path_x)) = size(scan,1);
end
path_y(path_y == max(path_y)) = size(scan,2);
path_y(path_y == min(path_y)) = 1;
    plot(path_x,path_y,'r')

scan_norm = zeros(size(scan,1),1);

for j = 2:length(path_x)
        
    if path_y(j-1) > path_y(j)
        
        y = path_y(j):1:path_y(j-1);
        
    else
        
        y = path_y(j-1):1:path_y(j);
        
    end
    
    if path_x(j) ~= path_x(j-1);
        
        m = (path_y(j) - path_y(j-1))/(path_x(j) - path_x(j-1));
        b = path_y(j) - m*path_x(j);
        
%             plot((y-b)/m,y,'.k')
        x = (y-b)/m;
        
    else
        
        x = path_x(j)*ones(size(y));
%             plot(x,y,'.k')
        
    end
    
    if j == 2 && path_y(j-1) > path_y(j)
        
        y_lim(1) = max(y);
        
    elseif j == 2
        
        y_lim(1) = min(y);
        
    end
    
    if j == length(path_x) && path_y(j-1) > path_y(j)
        
        y_lim(2) = min(y);
        
    elseif j == length(path_x)
        
        y_lim(2) = max(y);
        
    end
    
    for l = 1:length(y)
        
        u = round(x(l) - width/2):round(x(l) + width/2);
        
        if u(1) <= 0
            idx = find(u == 0,1,'last');
            u = u(idx+1:end);
        end
        
        if u(end) > size(scan,2)
            idx = find(u == size(scan,2));
            u = u(1:idx);
        end
        
%             v = y(l)*ones(size(u));
        
        scan_norm(y(l)) = mean(scan(y(l),u));
        
%             hold on
%             plot(u,v,'k','linewidth',2)
    
    end
    
    scan_norm(y) = scan_norm(y);
    
end

% figure
% plot(scan_norm)

if y_lim(1) > y_lim(2);
    
    y_lim = fliplr(y_lim);

end

scan_norm = scan_norm/mean(scan_norm(y_lim(1):y_lim(2)));
scan_norm(1:y_lim(1)) = scan_norm(y_lim(1)); 
scan_norm(y_lim(2):end) = scan_norm(y_lim(2));
scan_norm = repmat(scan_norm,1,size(scan,2));

% figure
% subplot(1,2,2)
% imagesc(scan)
% subplot(1,2,1)
% imagesc(scan_norm)

if nargin == 1
    
    subplot(1,2,2)
    hold on
    imagesc(scan./scan_norm) 
    axis image
%         set(gca,'clim',[min(scan(:)) max(scan(:))])
    colormap gwyddion
    
end

switch nargout
    
    case 1
        
        scan_level = scan./scan_norm;
        
    case 2 
        
        scan_level = scan./scan_norm;
        varargout{1} = path;
        
end


