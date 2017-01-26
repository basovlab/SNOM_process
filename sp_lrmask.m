function out = sp_lrmask(mask,x,y,direction,add)

% find slope of line
if x(1) == x(2)
    m = Inf;
elseif y(1) == y(2)
    m = 0;
    
else
    p = polyfit(x,y,1);
    m = p(1);
    b = p(2);
end

y = 1:size(mask,1);
x = round((y - b)/m);

if add
    for k = 1:max(y);
        if strcmp(direction,'right') && x(k) > 0 && x(k) < size(mask,2)
            mask(k,x(k):end) = 1;
        elseif  x(k) > 0 && x(k) < size(mask,2)
            mask(k,1:x(k)) = 1;
        end
    end
else
    for k = 1:max(y);
        if strcmp(direction,'right')  && x(k) > 0 && x(k) < size(mask,2)
            mask(k,x(k):end) = 0;
        elseif  x(k) > 0 && x(k) < size(mask,2)
            mask(k,1:x(k)) = 0;
        end
    end
end

out = mask;

