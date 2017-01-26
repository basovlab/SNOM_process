function [fitresult, gof, varargout] = sp_fitplane(x, y, z, varargin)
% sp_fitplane(X,Y,Z)
%  Create a fit to a plane.
%
%  Data for plane fit:
%      X Input : x
%      Y Input : y
%      Z Output: z
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 04-Mar-2016 08:30:24

% Fit: 

% Prepare data
[xData, yData, zData] = prepareSurfaceData(x, y, z);

% Set up fittype and options.
ft = fittype( 'poly11' );

% Fit model to data.
[fitresult, gof] = fit([xData, yData], zData, ft);

if ~isempty(varargin)
    
    % Plot fit with data.
    figure( 'Name', 'untitled fit 1' );
    h = plot(fitresult, [xData, yData], zData);
    legend( h, 'untitled fit 1', 'z vs. x, y', 'Location', 'NorthEast' );
    % Label axes
    xlabel x
    ylabel y
    zlabel z
    grid on
    view( 11.5, 72.0 );
    
end

if nargout == 3
    
    varargout{1} = [fitresult.p00 fitresult.p10 fitresult.p01];
    fprintf('\nz(x,y) = p00 + p10*x + p01*y\n')
    
end


