function [cut_x,cut_y] = sp_makecutpath(x1,y1,m_cut,l_right,l_left)

if m_cut ~= Inf
    
    % find intercept for full equation of cut path
    b = y1 - m_cut*x1;
    
    % find endpoints of line prependicular
    x2 = x1 + sqrt(l_right^2/(1 + m_cut^2));
    y2 = m_cut*x2 + b;
    
    x0 = x1 - sqrt(l_left^2/(1 + m_cut^2));
    y0 = m_cut*x0 + b;
    
    cut_x = [x0; x2];
    cut_y = [y0; y2];
    
else
    
    cut_x = [x1; x1];
    
    y2 = y1 + l_right;
    y0 = y1 - l_left;
    cut_y = [y0; y2];
    
end