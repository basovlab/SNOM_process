function varargout = sp_gui_level(varargin)
% SP_GUI_LEVEL MATLAB code for sp_gui_level.fig
%      SP_GUI_LEVEL, by itself, creates a new SP_GUI_LEVEL or raises the existing
%      singleton*.
%
%      H = SP_GUI_LEVEL returns the handle to a new SP_GUI_LEVEL or the handle to
%      the existing singleton*.
%
%      SP_GUI_LEVEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SP_GUI_LEVEL.M with the given input arguments.
%
%      SP_GUI_LEVEL('Property','Value',...) creates a new SP_GUI_LEVEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sp_gui_level_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sp_gui_level_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sp_gui_level

% Last Modified by GUIDE v2.5 12-Aug-2016 13:58:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sp_gui_level_OpeningFcn, ...
                   'gui_OutputFcn',  @sp_gui_level_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before sp_gui_level is made visible.
function sp_gui_level_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sp_gui_level (see VARARGIN)

% Choose default command line output for sp_gui_level
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sp_gui_level wait for user response (see UIRESUME)
% uiwait(handles.figure1);

handles.im_data = varargin{1}; handles.previous = handles.im_data;
handles.r = varargin{2}; 
handles.cmap = varargin{3};
handles.topo = varargin{4};
handles.x = varargin{5};
handles.y = varargin{6};
handles.mask = varargin{7};
handles.levelled = 0;
handles.level_path_plot = 0;
handles.printer = '';
handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
handles.save = varargin{8};
handles.fid = varargin{9};
handles.phase = varargin{10};

axes(handles.axes1)
handles.im_object = imshow(handles.im_data,handles.r,[]);
colormap(handles.axes1,handles.cmap);
set(gca,'fontsize',14)
axis tight
axis equal
colorbar('location','southoutside')
set(hObject,'UserData',varargin{1});

guidata(hObject, handles)

set(handles.edit1,'Visible','off') % hide width adjustment and label
set(handles.text2,'Visible','off')
set(handles.edit8,'Visible','off')
set(handles.text8,'Visible','off')
set(handles.edit9,'Visible','off')
set(handles.text9,'Visible','off')

if handles.topo ~= 2 && handles.phase == 2
    set(handles.edit2,'Visible','off') % hide plane level for non-topo data
    set(handles.text3,'Visible','off')
    set(handles.pushbutton2,'Enable','off')
    set(handles.togglebutton2,'Enable','off') % disable poly line level for non-topo data
%     set(handles.pushbutton5,'Enable','off') % disable poly bg for non-topo
end

set(handles.edit6,'String',num2str(handles.clim(1))) % set min and max 
set(handles.edit7,'String',num2str(handles.clim(2))) % values

set(handles.edit4,'Visible','off') % hide poly fit degree adjustment
set(handles.text4,'Visible','off')

set(handles.edit5,'Visible','off') % hide spline fit degree adjustment
set(handles.text5,'Visible','off')

set(handles.pushbutton6,'Enable','off') % disable spline for now


% --- Outputs from this function are returned to the command line.
function varargout = sp_gui_level_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(hObject);



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton1. 'Line level'
function pushbutton1_Callback(hObject, eventdata, handles) % 'do something'
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.previous = handles.im_data;

if handles.topo == 2 || handles.phase == 3
    handles.im_data = sp_linelevel_add(handles.im_data,...
        [1 size(handles.im_data,2)]);
else
    handles.im_data = sp_linelevel(handles.im_data,...
        [1 size(handles.im_data,2)]);
end

handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
set(hObject.Parent,'UserData',handles.im_data);
set(handles.edit6,'String',num2str(handles.clim(1)))
set(handles.edit7,'String',num2str(handles.clim(2)))

guidata(hObject,handles)

sp_gui_updateimobject(hObject,eventdata,handles);

if handles.save
    
    fid = fopen(handles.fid,'at');
    fprintf(fid,'%% -------------------------------------------------\n');
    if handles.topo == 2 || handles.phase == 3
        fprintf(fid,'im_data = sp_linelevel_add(im_data,[1 size(im_data,2)]);\n');
    else
        fprintf(fid,'im_data = sp_linelevel(im_data,[1 size(im_data,2)]);\n');
    end
    fprintf(fid,'\n');
    fclose(fid);
    
end



% =========================================================================
% =========================================================================
% --- Executes on button press in togglebutton2. 'Poly level'
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2

if get(hObject,'Value')
    set(handles.edit9,'Visible','on')
    set(handles.text9,'Visible','on')
    handles.previous = handles.im_data;
    guidata(hObject,handles)
else
    set(handles.edit9,'Visible','off')
    set(handles.text9,'Visible','off')
    deg = str2double(get(handles.edit9,'String'));
    
    if get(handles.radiobutton1,'Value')
        
        [handles.im_data,~] = sp_polylineleveladd(handles.previous,deg);
        
    elseif get(handles.radiobutton2,'Value')
        
        [handles.im_data,~] = sp_polylineleveladd(handles.previous,...
            deg,1 - handles.mask);
        
    else
        
        [handles.im_data,~] = sp_polylineleveladd(handles.previous,...
            deg,handles.mask);
        
    end
    
    handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
    set(hObject.Parent,'UserData',handles.im_data);
    set(handles.edit6,'String',num2str(handles.clim(1)))
    set(handles.edit7,'String',num2str(handles.clim(2)))
    
    guidata(hObject,handles)
    
    sp_gui_updateimobject(hObject,eventdata,handles);
    
    if handles.save
        
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------\n');
        if get(handles.radiobutton1,'Value')
            fprintf(fid,'im_data = sp_polylineleveladd(im_data,%i);\n',deg);
        elseif get(handles.radiobutton2,'Value')
            fprintf(fid,'im_data = sp_polylineleveladd(im_data,%i,1-mask);\n',deg);
        else
            fprintf(fid,'im_data = sp_polylineleveladd(im_data,%i,mask);\n',deg);
        end
        fprintf(fid,'\n');
        fclose(fid);
        
    end
    
end



% =========================================================================
% =========================================================================
function edit9_Callback(hObject, eventdata, handles) % 'Poly level - degree'
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double

deg = str2double(get(hObject,'String'));

if get(handles.radiobutton1,'Value')
    
    [handles.im_data,~] = sp_polylineleveladd(handles.previous,deg);
    
elseif get(handles.radiobutton2,'Value')
    
    [handles.im_data,~] = sp_polylineleveladd(handles.previous,...
        deg,1 - handles.mask);
    
else
    
    [handles.im_data,~] = sp_polylineleveladd(handles.previous,...
        deg,handles.mask);
    
end

handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
set(hObject.Parent,'UserData',handles.im_data);
set(handles.edit6,'String',num2str(handles.clim(1)))
set(handles.edit7,'String',num2str(handles.clim(2)))

guidata(hObject,handles)

sp_gui_updateimobject(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
% --- Executes on button press in togglebutton1. 'Path level'
function togglebutton1_Callback(hObject, eventdata, handles) % 'Done'
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if get(hObject,'Value')
    
    set(handles.im_object,'ButtonDownFcn',{@sp_gui_path_level,handles})
    set(handles.pushbutton1,'Enable','off')
    set(handles.pushbutton2,'Enable','off')
    set(handles.pushbutton5,'Enable','off')
    set(handles.edit2,'Enable','off')
    set(handles.edit1,'Visible','on')
    set(handles.edit8,'Visible','on')
    set(handles.text2,'Visible','on')
    set(handles.text8,'Visible','on')
    
else
    
    set(handles.edit1,'Visible','off')
    set(handles.edit8,'Visible','off')
    set(handles.text2,'Visible','off')
    set(handles.text8,'Visible','off')
    
    set(handles.pushbutton1,'Enable','on')
    set(handles.pushbutton2,'Enable','on')
    set(handles.pushbutton5,'Enable','on')
    set(handles.edit2,'Enable','on')
    if handles.levelled
        delete(handles.level_path_plot)
    end
    set(handles.im_object,'ButtonDownFcn','')
    set(hObject.Parent,'UserData',handles.im_data);
    handles.levelled = 0;
    
end

guidata(hObject,handles)

%  --- Executes on button press in image during 'Path level'.
function sp_gui_path_level(hObject, eventdata, handles)   

handles = guidata(hObject);

handles.previous = handles.im_data;

axes(handles.axes1)

set(handles.togglebutton1,'Enable','off')
set(handles.pushbutton1,'Enable','off')
[path_x,path_y] = getline;
dx = handles.r.PixelExtentInWorldX;
path_x = path_x/dx;
dy =  handles.r.PixelExtentInWorldY; 
path_y = path_y/dy;
path_y = round(path_y);
path_x = round(path_x);
path = [path_x path_y];
handles.level_path = path;

set(handles.togglebutton1,'Enable','on')
set(handles.pushbutton1,'Enable','on')

width = str2double(get(handles.edit1,'String'));
width = round(width/dx);

if width < 2
    width = 2;
end

if str2double(get(handles.edit8,'String')) <= 0
    if handles.topo == 2 || handles.phase == 3
        handles.im_data = sp_pathlevel_add(handles.im_data,path,width);
        
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%i %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'im_data = sp_pathlevel_add(im_data,path,width);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    else
        handles.im_data = sp_pathlevel(handles.im_data,path,width);
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%i %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'im_data = sp_pathlevel(im_data,path,width);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    end
else
    if str2double(get(handles.edit8,'String')) > 1
        smoothness = 1;
    else
        smoothness = str2double(get(handles.edit8,'String'));
    end
    
    if handles.topo == 2 || handles.phase == 3
        handles.im_data = sp_pathlevel_add(handles.im_data,path,width,...
            smoothness);
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%i %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'smoothness = %.4f;\n',smoothness);
            fprintf(fid,'im_data = sp_pathlevel_add(im_data,path,width,smoothness);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    else
        handles.im_data = sp_pathlevel(handles.im_data,path,width,...
            smoothness);
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%i %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'smoothness = %.4f;\n',smoothness);
            fprintf(fid,'im_data = sp_pathlevel(im_data,path,width,smoothness);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    end
end

handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];

handles.im_object.CData = handles.im_data;
set(handles.axes1,'CLim',handles.clim)

set(handles.im_object,'ButtonDownFcn',{@sp_gui_path_level,handles})

if not(isnumeric(handles.level_path_plot))
    delete(handles.level_path_plot)
end

hold on
handles.level_path_plot = plot(dx*path(:,1),dy*path(:,2),'k',...
    dx*(path(:,1)-width/2),dy*path(:,2),'--k',...
    dx*(path(:,1)+width/2),dy*path(:,2),'--k');

set(handles.axes1,'fontsize',14)
axis tight
axis equal
colorbar('location','southoutside')
box on

set(handles.edit6,'String',num2str(handles.clim(1)))
set(handles.edit7,'String',num2str(handles.clim(2)))

handles.width = width;
handles.levelled = 1;

guidata(hObject,handles)



% =========================================================================
% =========================================================================
function edit1_Callback(hObject, eventdata, handles) % 'width'
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

if get(handles.togglebutton1,'Value') && handles.levelled
    
    axes(handles.axes1)
    handles.previous = handles.im_data;
    dx =  handles.r.PixelExtentInWorldX; 
    dy =  handles.r.PixelExtentInWorldY; 
    path = handles.level_path;
    
    width = str2double(get(handles.edit1,'String'));
    width = round(width/dx);
    
    if width < 2
        width = 2;
    end
    
if str2double(get(handles.edit8,'String')) <= 0
    if handles.topo == 2 || handles.phase == 3
        handles.im_data = sp_pathlevel_add(handles.im_data,path,width);
        
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%i %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'im_data = sp_pathlevel_add(im_data,path,width);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    else
        handles.im_data = sp_pathlevel(handles.im_data,path,width);
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%i %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'im_data = sp_pathlevel(im_data,path,width);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    end
else
    if str2double(get(handles.edit8,'String')) > 1
        smoothness = 1;
    else
        smoothness = str2double(get(handles.edit8,'String'));
    end
    
    if handles.topo == 2 || handles.phase == 3
        handles.im_data = sp_pathlevel_add(handles.im_data,path,width,...
            smoothness);
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%i %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'smoothness = %.4f;\n',smoothness);
            fprintf(fid,'im_data = sp_pathlevel_add(im_data,path,width,smoothness);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    else
        handles.im_data = sp_pathlevel(handles.im_data,path,width,...
            smoothness);
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%i %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'smoothness = %.4f;\n',smoothness);
            fprintf(fid,'im_data = sp_pathlevel(im_data,path,width,smoothness);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    end
end

    handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
    
    handles.im_object.CData = handles.im_data;
    set(handles.axes1,'CLim',handles.clim)
    
    set(handles.im_object,'ButtonDownFcn',{@sp_gui_path_level,handles})
    if not(isnumeric(handles.level_path_plot))
        delete(handles.level_path_plot)
    end
    
    hold on
    handles.level_path_plot = plot(dx*path(:,1),dy*path(:,2),'k',...
        dx*(path(:,1)-width/2),dy*path(:,2),'--k',...
        dx*(path(:,1)+width/2),dy*path(:,2),'--k');
    
    set(handles.axes1,'fontsize',14)
    axis tight
    axis equal
    colorbar('location','southoutside')
    box on
    
    handles.clim = [min(handles.im_data(:))...
        max(handles.im_data(:))];
    
    set(handles.edit6,'String',num2str(handles.clim(1)))
    set(handles.edit7,'String',num2str(handles.clim(2)))

    handles.width = width;
    guidata(hObject,handles)
    
    
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
function edit8_Callback(hObject, eventdata, handles) % loess smoothness
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double

if get(handles.togglebutton1,'Value') && handles.levelled
    
    axes(handles.axes1)
    handles.previous = handles.im_data;
    dx =  handles.r.PixelExtentInWorldX; 
    dy =  handles.r.PixelExtentInWorldY; 
    path = handles.level_path;
    
    width = str2double(get(handles.edit1,'String'));
    width = round(width/dx);
    
    if width < 2
        width = 2;
    end
    
if str2double(get(handles.edit8,'String')) <= 0
    if handles.topo == 2 || handles.phase == 3
        handles.im_data = sp_pathlevel_add(handles.im_data,path,width);
        
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%i %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'im_data = sp_pathlevel_add(im_data,path,width);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    else
        handles.im_data = sp_pathlevel(handles.im_data,path,width);
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%.4f %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'im_data = sp_pathlevel(im_data,path,width);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    end
else
    if str2double(get(handles.edit8,'String')) > 1
        smoothness = 1;
    else
        smoothness = str2double(get(handles.edit8,'String'));
    end
    
    if handles.topo == 2 || handles.phase == 3
        handles.im_data = sp_pathlevel_add(handles.im_data,path,width,...
            smoothness);
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%i %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'smoothness = %.4f;\n',smoothness);
            fprintf(fid,'im_data = sp_pathlevel_add(im_data,path,width,smoothness);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    else
        handles.im_data = sp_pathlevel(handles.im_data,path,width,...
            smoothness);
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% --------------------\n');
            fprintf(fid,'path = [%i %i\n',path(1,1),path(1,2));
            if size(path,1) > 2
                
                for j = 1:size(path,1)-2
                    
                    fprintf(fid,'        %i %i\n',path(j+1,1),path(j+1,2));
                    
                end
                
            end
            fprintf(fid,'        %i %i];\n',path(end,1),path(end,2));
            fprintf(fid,'width = %i;\n',width);
            fprintf(fid,'smoothness = %.4f;\n',smoothness);
            fprintf(fid,'im_data = sp_pathlevel(im_data,path,width,smoothness);');
            fprintf(fid,'\n\n');
            fclose(fid);
        end
    end
end

    handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
    
    handles.im_object.CData = handles.im_data;
    set(handles.axes1,'CLim',handles.clim)
    
    set(handles.im_object,'ButtonDownFcn',{@sp_gui_path_level,handles})
    if not(isnumeric(handles.level_path_plot))
        delete(handles.level_path_plot)
    end
    
    hold on
    handles.level_path_plot = plot(dx*path(:,1),dy*path(:,2),'k',...
        dx*(path(:,1)-width/2),dy*path(:,2),'--k',...
        dx*(path(:,1)+width/2),dy*path(:,2),'--k');
    
    set(handles.axes1,'fontsize',14)
    axis tight
    axis equal
    colorbar('location','southoutside')
    box on
    
    handles.clim = [min(handles.im_data(:))...
        max(handles.im_data(:))];
    
    set(handles.edit6,'String',num2str(handles.clim(1)))
    set(handles.edit7,'String',num2str(handles.clim(2)))

    handles.width = width;
    guidata(hObject,handles)
    
    
end

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton2. 'Plane level'
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1)
set(handles.pushbutton1,'Enable','off')
set(handles.togglebutton1,'Enable','off')
set(handles.pushbutton2,'Enable','off')
set(handles.pushbutton5,'Enable','off')
set(handles.edit1,'Enable','off')
set(handles.edit2,'Enable','off')
[path_x,path_y] = getpts;
set(handles.pushbutton1,'Enable','on')
set(handles.togglebutton1,'Enable','on')
set(handles.pushbutton2,'Enable','on')
set(handles.pushbutton5,'Enable','on')
set(handles.edit1,'Enable','on')
set(handles.edit2,'Enable','on')

if length(path_x) == 3

    dx =  handles.r.PixelExtentInWorldX; 
    dy =  handles.r.PixelExtentInWorldY; 
    
    path_x = round(path_x/dx);
    path_y = round(path_y/dy);
    
    radius = str2double(get(handles.edit2,'String'));
    
    if radius < 1
        radius = 1;
        set(handles.edit2,'String','1')
    end
    
    radius = round(radius);
    handles.previous = handles.im_data;
    [handles.im_data,X,Y] = sp_planelevel(handles.im_data,...
        path_x,path_y,radius);

    handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
    
    handles.planepoints = {path_x,path_y};
    handles.printer = 'Plane';
    
    set(handles.edit6,'String',num2str(handles.clim(1)))
    set(handles.edit7,'String',num2str(handles.clim(2)))
    
    guidata(hObject,handles)
    sp_gui_updateimobject(hObject,eventdata,handles)
    
    hold on
    plot(dx*X(1,:),dy*Y(1,:),'-k')
    plot(dx*X(2,:),dy*Y(2,:),'-k')
    plot(dx*X(3,:),dy*Y(3,:),'-k')
    
    set(hObject.Parent,'UserData',handles.im_data);
    
    if handles.save
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------');
        fprintf(fid,'\n');
        fprintf(fid,'path_x = [%i %i %i];\n',path_x(1),path_x(2),path_x(3));
        fprintf(fid,'path_y = [%i %i %i];\n',path_y(1),path_y(2),path_y(3));
        fprintf(fid,'radius = %i;\n',radius);
        fprintf(fid,'[im_data,X,Y] = sp_planelevel(im_data,...\n');
        fprintf(fid,'         path_x,path_y,radius);\n');
        fprintf(fid,'\n');
        fclose(fid);
    end
    
else
   
    msgbox('Choose exactly 3 points.')
    
end



% =========================================================================
% =========================================================================
function edit2_Callback(hObject, eventdata, handles) % 'radius'
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

if strcmp(handles.printer,'Plane')
    
    path_x = handles.planepoints{1};
    path_y = handles.planepoints{2};
    
    dx =  handles.r.PixelExtentInWorldX; 
    dy =  handles.r.PixelExtentInWorldY;
    
    radius = str2double(get(handles.edit2,'String'));
    
    if radius < 1
        radius = 1;
        set(handles.edit2,'String','1')
    end
    
    radius = round(radius);
    
    [handles.im_data,X,Y] = sp_planelevel((handles.im_data),path_x,path_y,radius);
    
    handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
    
    handles.planepoints = {path_x,path_y};
    
    handles.printer = 'Plane';
    
    set(handles.edit6,'String',num2str(handles.clim(1)))
    set(handles.edit7,'String',num2str(handles.clim(2)))
    
    guidata(hObject,handles)
    
    if handles.save
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------');
        fprintf(fid,'\n');
        fprintf(fid,'path_x = [%i %i %i];\n',path_x(1),path_x(2),path_x(3));
        fprintf(fid,'path_y = [%i %i %i];\n',path_y(1),path_y(2),path_y(3));
        fprintf(fid,'radius = %i;\n',radius);
        fprintf(fid,'[im_data,X,Y] = sp_planelevel(im_data,...\n');
        fprintf(fid,'         path_x,path_y,radius);\n');
        fprintf(fid,'\n');
        fclose(fid);
    end
    
    sp_gui_updateimobject(hObject,eventdata,handles)
    
    hold on
    plot(dx*X(1,:),dy*Y(1,:),'-k')
    plot(dx*X(2,:),dy*Y(2,:),'-k')
    plot(dx*X(3,:),dy*Y(3,:),'-k')
    hold off
    
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton5. 'Poly BG'
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if get(hObject,'Value')
    
    set(handles.edit4,'Visible','on')
    set(handles.text4,'Visible','on')
    set(handles.edit5,'Visible','on')
    set(handles.text5,'Visible','on')
    set(handles.pushbutton1,'Enable','off')
    set(handles.togglebutton1,'Enable','off')
    set(handles.pushbutton2,'Enable','off')
    set(handles.edit1,'Enable','off')
    set(handles.edit2,'Enable','off')
    handles.previous = handles.im_data;
    guidata(hObject,handles)

else
    
    set(handles.edit4,'Visible','off')
    set(handles.text4,'Visible','off')
    set(handles.edit5,'Visible','off')
    set(handles.text5,'Visible','off')
    set(handles.pushbutton1,'Enable','on')
    set(handles.togglebutton1,'Enable','on')
    set(handles.pushbutton2,'Enable','on')
    set(handles.edit1,'Enable','on')
    set(handles.edit2,'Enable','on')
    if get(handles.radiobutton1,'Value')
        exclude = 0;
    elseif get(handles.radiobutton2,'Value')
        exclude = find(1 - handles.mask);
    else
        exclude = find(handles.mask);
    end
    
    bg = sp_polybg(handles.x,handles.y,handles.previous,...
        [str2double(get(handles.edit4,'String'))...
        str2double(get(handles.edit5,'String'))],...
        exclude);
        
    if handles.save
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------\n');
        if get(handles.radiobutton1,'Value')
            fprintf(fid,'exclude = 0;\n');
        elseif get(handles.radiobutton2,'Value')
            fprintf(fid,'exclude = find(1 - mask);\n');
        else
            fprintf(fid,'exclude = find(mask);\n');
        end
        fprintf(fid,'bg = sp_polybg(x,y,im_data,[%s %s],exclude);\n\n',...
            get(handles.edit4,'String'),get(handles.edit5,'String'));
        fclose(fid);
    end
    
    if handles.topo == 2 || handles.phase == 3
        
        handles.im_data = handles.previous - bg;
        
    else
        
        handles.im_data = handles.previous./bg;
        
    end
    
    handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
    
    guidata(hObject,handles)
    
    sp_gui_updateimobject(hObject, eventdata, handles);
    
    set(hObject.Parent,'UserData',handles.im_data)
    
end


% =========================================================================
% =========================================================================
function edit4_Callback(hObject, eventdata, handles) % 'degree x'
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double

% exclude = find(data_scratch(y1:y2,x1:x2) > str2double(get(handles.edit7,'String')));

if get(handles.radiobutton1,'Value')
    exclude = 0;
elseif get(handles.radiobutton2,'Value')
    exclude = find(1 - handles.mask);
else
    exclude = find(handles.mask);
end

bg = sp_polybg(handles.x,handles.y,handles.previous,...
    [str2double(get(hObject,'String')) str2double(get(handles.edit5,'String'))],...
    exclude);

if handles.topo == 2 || handles.phase == 3
    
    handles.im_data = handles.previous - bg;
    
else
    
    figure, imagesc(bg); colormap spectral
    handles.im_data = handles.previous./bg;
    
end

handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];

guidata(hObject,handles)

sp_gui_updateimobject(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
function edit5_Callback(hObject, eventdata, handles) % 'degree y'
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double

if get(handles.radiobutton1,'Value')
    exclude = 0;
elseif get(handles.radiobutton2,'Value')
    exclude = find(1 - handles.mask);
else
    exclude = find(handles.mask);
end

bg = sp_polybg(handles.x,handles.y,handles.previous,...
    [str2double(get(handles.edit4,'String')) str2double(get(hObject,'String'))],...
    exclude);

if handles.topo == 2 || handles.phase == 3
    
    handles.im_data = handles.previous - bg;
    
else
    
    figure, imagesc(bg); colormap spectral
    handles.im_data = handles.previous./bg;
    
end

handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];

guidata(hObject,handles)

sp_gui_updateimobject(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton6. 'Spline BG'
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(hObject,'Value')
    
    set(handles.edit5,'Visible','on')
    set(handles.text5,'Visible','on')
    set(handles.pushbutton1,'Enable','off')
    set(handles.pushbutton5,'Enable','off')
    set(handles.togglebutton1,'Enable','off')
    set(handles.pushbutton2,'Enable','off')
    set(handles.edit1,'Enable','off')
    set(handles.edit2,'Enable','off')

else
    
    set(handles.edit5,'Visible','off')
    set(handles.text5,'Visible','off')
    set(handles.pushbutton1,'Enable','on')
    set(handles.pushbutton5,'Enable','on')
    set(handles.togglebutton1,'Enable','on')
    set(handles.pushbutton2,'Enable','on')
    set(handles.edit1,'Enable','on')
    set(handles.edit2,'Enable','on')
    set(hObject.Parent,'UserData',handles.im_data)
    
end



% =========================================================================
% =========================================================================
function edit6_Callback(hObject, eventdata, handles) % 'Min'
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double

handles.clim(1) = str2double(get(handles.edit6,'String')); 

axes(handles.axes1)
set(gca,'CLim',handles.clim)

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
function edit7_Callback(hObject, eventdata, handles) % 'Max'
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

handles.clim(2) = str2double(get(handles.edit7,'String')); 

axes(handles.axes1)
set(gca,'CLim',handles.clim)

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton7. 'Undo'
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.im_data = handles.previous;
guidata(hObject,handles)
sp_gui_updateimobject(hObject,eventdata,handles)



% =========================================================================
% =========================================================================
% --- Executes on button press in radiobutton1. 'Ignore mask'
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)

% --- Executes on button press in radiobutton2. 'Include mask'
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2

set(handles.radiobutton1,'Value',0)
set(handles.radiobutton3,'Value',0)

% --- Executes on button press in radiobutton3. 'Exclude mask'
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3

set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)



% =========================================================================
% =========================================================================
function sp_gui_updateimobject(hObject, eventdata, handles)

handles = guidata(hObject);

axes(handles.axes1)
cla
handles.im_object = imshow(handles.im_data,handles.r,...
                         handles.clim,'Parent',handles.axes1);
                     
handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
set(gca,'CLim',handles.clim)
set(gca,'fontsize',14)
axis tight
axis equal
colorbar('location','southoutside')

guidata(hObject,handles)



