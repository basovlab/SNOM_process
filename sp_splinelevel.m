
close all
clear
clc

folder = {'TaS2/2016-06-07 - TaS2 device/20x10 microns - 156 K - cooling - 1150 cm-1 - 1.48 kOhm'};
prefix = {'Scan_045-Near-field Amplitude-bwd'};

[x, y, im_data, ref] = load_images_ac_binary(folder,prefix,0);
dy = abs(y(2) - y(1));

s3 = im_data{1}{1};
s3 = sp_removeoutliers(s3,5,1);

figure
imshow(s3,ref{1},[])
colormap spectral

cut_x = [0.5 0.5];
cut_y = [2+dy max(y)];
width = 0.2000;
[r,c] = sp_linecut(x,y,s3,cut_x,cut_y,width,0);

figure
plot(r+2,c,'.:')

% p = polyfit(r+2',c/mean(c),9);
% s3_norm = polyval(p,r'); s3_norm = s3_norm/mean(s3_norm);

% s3_norm = csaps(r,c,.9); 
% s3_norm = ppval(s3_norm,r);
s3_norm = smooth(r,c,0.15,'rloess');
% s3_norm = c;

hold on
plot(r+2,s3_norm)

s3_norm = s3_norm/median(s3_norm);
s3_norm = interp1(r+2,s3_norm,[y'],'nearest','extrap');

s3_norm = repmat(s3_norm,1,802);
s3_norm = s3./s3_norm;

cut_x = [0.5 0.5];
cut_y = [2+dy max(y)];
width = 0.2000;
[r,c] = sp_linecut(x,y,s3_norm,cut_x,cut_y,width,0);


plot(r+2,c)


figure
imshow(s3_norm,ref{1},[0 4])
colormap spectral


cut_x = [18 18];
cut_y = [0.0611 7.9580];
width = 0.5000;
[r,c] = sp_linecut(x,y,s3,cut_x,cut_y,width,0);


figure
plot(r+2,c/mean(c))
hold on

cut_x = [18 18];
cut_y = [0.0611 7.9580];
width = 0.5000;
[r,c] = sp_linecut(x,y,s3_norm,cut_x,cut_y,width,0);

plot(r+2,c/mean(c))
