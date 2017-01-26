function [x, y, im_data, xreal, yreal] = sp_gui_load_image_ac(folder,prefix,varargin)

% load attocube images
% dimensions (x,y) 

% tic

% load names of files in directory 
files_binary = dir([folder '/' prefix '.bcrf']);
files_ascii = dir([folder '/' prefix '.asc']);

% give error if no files are found
if isempty(files_binary) && isempty(files_ascii)
    
    error('No files with specified base name in specified directory.')
    
elseif isempty(files_ascii)
    
    filepath = [folder '/' files_binary.name];
    
    % get image metadata 
    
    % open file to read
    fid = fopen(filepath,'r');
    
    % skip first two header lines
    fgetl(fid);
    fgetl(fid);
    
    % read x size in pixels
    xres = fgetl(fid);
    xres = str2double(xres(strfind(xres,'=')+1:end));
%     fprintf('xres = %i\n',xres)
    
    % read y size in pixels
    yres = fgetl(fid);
    yres = str2double(yres(strfind(yres,'=')+1:end));
%     fprintf('yres = %i\n',yres)
    
    % read x size in micron
    xreal = fgetl(fid);
    xreal = 1e6*str2double(xreal(strfind(xreal,'=')+1:end));
%     fprintf('xreal = %.2f\n',xreal)
    
    % read y size in micron
    yreal = fgetl(fid);
    yreal = 1e6*str2double(yreal(strfind(yreal,'=')+1:end));
%     fprintf('yreal = %.2f\n',yreal)
    
    for j = 1:9
        fgetl(fid);
    end
    clear j
    
    im_data = fread(fid,[xres yres],'single','b');
    im_data = (im_data');
    
    fclose(fid);
    
    % create image reference object
    ref = imref2d([yres xres]);
    ref.XWorldLimits = [0 xreal];
    ref.YWorldLimits = [0 yreal]; 
    
    dx = ref.PixelExtentInWorldX;
    dy = ref.PixelExtentInWorldY;
    
    % create x and y vectors
    x = linspace(ref.XWorldLimits(1)+dx/2,...
        ref.XWorldLimits(2)-dx/2,xres);
    y = linspace(ref.YWorldLimits(1)+dy/2,...
        ref.YWorldLimits(2)-dy/2,yres);
    
else
    
    filepath = [folder '/' files_ascii.name];
    
    % get image metadata 
    
    % open file to read
    fid = fopen(filepath,'r');
    
    % skip first two header lines
    fgetl(fid); fgetl(fid); fgetl(fid);
    
    % read x size in pixels
    xres = fgetl(fid);
    xres = str2double(xres(strfind(xres,':')+1:end));
    % fprintf('xres = %i\n',xres)
    
    % read y size in pixels
    yres = fgetl(fid);
    yres = str2double(yres(strfind(yres,':')+1:end));
    % fprintf('yres = %i\n',yres)
    
    % read x size in micron
    xreal = fgetl(fid);
    xreal = 1e6*str2double(xreal(strfind(xreal,':')+1:end));
    % fprintf('xreal = %.2f\n',xreal)
    
    % read y size in micron
    yreal = fgetl(fid);
    yreal = 1e6*str2double(yreal(strfind(yreal,':')+1:end));
    % fprintf('yreal = %.2f\n',yreal)
    
    % close file
    fclose(fid);
    
    % read ascii data and transpose
    im_data = importdata(filepath,'\t',14);
    im_data = transpose(reshape(im_data.data,xres,yres));
    
    % create image reference object
    ref = imref2d([yres xres]);
    ref.XWorldLimits = [0 xreal];
    ref.YWorldLimits = [0 yreal]; 
    
    dx = ref.PixelExtentInWorldX;
    dy = ref.PixelExtentInWorldY;
    
    % create x and y vectors
    x = linspace(ref.XWorldLimits(1)+dx/2,...
        ref.XWorldLimits(2)-dx/2,xres);
    y = linspace(ref.YWorldLimits(1)+dy/2,...
        ref.YWorldLimits(2)-dy/2,yres);
    
end


% toc




