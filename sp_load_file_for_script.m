function [im_data, x, y] = sp_load_file_for_script(folder, filebasename, prefix)
filepath = [folder '\' filebasename '\' filebasename '_' prefix '.dump'];
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