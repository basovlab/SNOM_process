function im_data_out = sp_removeoutliers(im_data,threshold,sign,varargin)

if sign
    CC = bwconncomp((im_data > threshold));
else
    CC = bwconncomp((im_data < threshold));
end

if length(varargin) == 1;
    mask = varargin{1};
end

for k = 1:length(CC.PixelIdxList)
    
    err = 1;
    inds = CC.PixelIdxList{k};
    
    if length(varargin) == 1;
        idx = find(mask > 0);
        inds = intersect(inds,idx);
    end
    
    while err > 1e-5;
        
        old = im_data(inds);
        
        for m = 1:length(inds)
            
            [idx,jdx] = ind2sub(size(im_data),inds(m));
            
            if idx == 1
                
                if jdx ==1 
                    im_data(idx,jdx) = (im_data(idx+1,jdx) + ...
                        im_data(idx,jdx+1))/2;
                elseif jdx == size(im_data,2)
                    im_data(idx,jdx) = (im_data(idx+1,jdx) + ...
                        im_data(idx,jdx-1))/2;
                else
                    im_data(idx,jdx) = (im_data(idx+1,jdx) + ...
                        im_data(idx,jdx+1) + im_data(idx,jdx-1))/3;
                end
                
            elseif idx == size(im_data,1)
                
               if jdx == 1
                    im_data(idx,jdx) = (im_data(idx-1,jdx) + ...
                        im_data(idx,jdx+1))/2;
               elseif jdx == size(im_data,2)
                    im_data(idx,jdx) = (im_data(idx-1,jdx) + ...
                        im_data(idx,jdx-1))/2;
               else
                    im_data(idx,jdx) = (im_data(idx-1,jdx) + ...
                        im_data(idx,jdx+1) + im_data(idx,jdx-1))/3;
               end
               
            elseif jdx == 1
                
                im_data(idx,jdx) = (im_data(idx-1,jdx) + ...
                    im_data(idx+1,jdx) + im_data(idx,jdx+1))/3;
                
            elseif jdx == size(im_data,2)
                
                im_data(idx,jdx) = (im_data(idx-1,jdx) + ...
                    im_data(idx+1,jdx) + im_data(idx,jdx-1))/3;
                
            else
                
                im_data(idx,jdx) = (im_data(idx+1,jdx) + ...
                    im_data(idx-1,jdx) + ...
                    im_data(idx,jdx+1) + im_data(idx,jdx-1))/4;
                
            end
            
        end
        
        err = sqrt(sum(sum((im_data(inds) - old).^2)));
        
    end
    
end

im_data_out = im_data;

