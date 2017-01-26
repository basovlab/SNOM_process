function out = sp_correctdrift(z)

d = diff(z,1,2);

[~,j] = max(abs(d),[],2);

out = zeros(size(z));
for m = 1:137
    
    out(m,:) = circshift(z(m,:),-j(m) + round(mean(j)),2);

end

