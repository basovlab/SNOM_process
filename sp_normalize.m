function scan_norm = sp_normalize(scan,area)

norm_factor = mean(mean(scan(area(1):area(2),area(3):area(4))));

scan_norm = scan/norm_factor;
