function [r,c,varargout] = sp_edgecut(x,y,z,x0,y0,edge_path,l_right,l_left,width)
% x1 and y1 are the center point for the cut
% 
% edge_path is the path along the edge - the cut will be orthogonal to this
% 
% l_right/left are the length of the cut to the left and right of the start
% point
% 
% width is the width of the cut

% find slope of edge path
m = diff(edge_path(:,2))/diff(edge_path(:,1));

% make cut path perpendicular to edge
[cut_x,cut_y] = sp_makecutpath(x0,y0,tand(atand(m)+90),l_right,l_left);

% get edge cut
[r,c] = sp_linecut(x,y,z,cut_x,cut_y,width,0);

% get paths of lines orthogonal to cut path
[x1,y1] = sp_makecutpath(cut_x(1),cut_y(1),m,width/2,width/2);
[x2,y2] = sp_makecutpath(cut_x(2),cut_y(2),m,width/2,width/2);

% output data for plotting if requested
varargout{1} = [cut_x cut_y];
varargout{2} = [x1 y1];
varargout{3} = [x2 y2];