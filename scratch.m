% -------------------------------------------------
cut_x = [1.6803 0.8364];
cut_y = [0.8576 0.3463];
width = 0.1000;
[r,c] = sp_linecut(x,y,im_data,...
                        cut_x,cut_y,width,0);

