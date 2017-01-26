function scan_level = sp_linelevel_add(scan,width)

% perform line leveling on image scan over horizontal section given by
% width (in pixels)

scan_norm = median(scan(:,width(1):width(2)),2);
scan_norm = repmat(scan_norm,1,width(2));

scan_level = scan - scan_norm + median(scan_norm(:));