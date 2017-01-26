function [x, y, im_data, xreal, yreal] = sp_gui_load_image(folder,prefix)

% give error if no files are found
if ~exist(folder,'dir') 
    error('No files with specified base name in specified directory.')
end

idx = strfind(folder,'\');
filebasename = folder(idx(end)+1:end);

filepath = [folder '\' filebasename '_' prefix '.dump'];
fid = fopen(filepath,'r');

fgetl(fid); fgetl(fid);

xreal = fgetl(fid);
xreal = 1e6*str2double(xreal(strfind(xreal,'=')+1:end));

xres = fgetl(fid);
xres = str2double(xres(strfind(xres,'=')+1:end));

yreal = fgetl(fid);
yreal = 1e6*str2double(yreal(strfind(yreal,'=')+1:end));

yres = fgetl(fid);
yres = str2double(yres(strfind(yres,'=')+1:end));

fgetl(fid);

fseek(fid,1,0);

im_data = fread(fid,[xres yres],'double','a');
im_data = im_data';

s = size(im_data);
ref = imref2d(s);
ref.XWorldLimits = [0 xreal];
ref.YWorldLimits = [0 yreal]; 

dx = ref.PixelExtentInWorldX;
dy = ref.PixelExtentInWorldY;

x = linspace(ref.XWorldLimits(1)+dx/2,...
    ref.XWorldLimits(2)-dx/2,xres);
y = linspace(ref.YWorldLimits(1)+dy/2,...
    ref.YWorldLimits(2)-dy/2,yres);

fclose(fid);

end


% 
% function [x, y, im_data] = sp_gui_load_image(folder,prefix,dimensions)
% 
%     
% % % load names of files in directory 
% % files = dir(...
% %     [folder '/' folder '*.ascii']); 
% 
% % give error if no files are found
% if ~exist(folder,'dir') 
%     error('No files with specified base name in specified directory.')
% end
% 
% idx = strfind(folder,'/');
% filebasename = folder(idx(end)+1:end);
% 
% filepath = [folder '/' filebasename '_' prefix '.ascii']
% im_data = importdata(filepath);
% 
% s = size(im_data);
% ref = imref2d(s);
% ref.XWorldLimits = [0 dimensions(1)];
% ref.YWorldLimits = [0 dimensions(2)]; 
% 
% dx = ref.PixelExtentInWorldX;
% dy = ref.PixelExtentInWorldY;
% 
% x = dx/2:dx:(s(2)-1/2)*dx;
% %             x = 0:dimensions(1)/size(data_scratch,2):dimensions(1); 
% %             x = x(1:end-1);
% 
% y = dy/2:dx:(s(1)-1/2)*dy;
% %             y = 0:dimensions(2)/size(data_scratch,1):dimensions(2);
% %             y = y(1:end-1);
% 
% 
%     
% end
% 
% 
% 
