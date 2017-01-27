function varargout = sp_gui(varargin)
% SP_GUI MATLAB code for sp_gui.fig
%      SP_GUI, by itself, creates a new SP_GUI or raises the existing
%      singleton*.
%
%      H = SP_GUI returns the handle to a new SP_GUI or the handle to
%      the existing singleton*.
%
%      SP_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SP_GUI.M with the given input arguments.
%
%      SP_GUI('Property','Value',...) creates a new SP_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sp_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sp_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sp_gui

% Last Modified by GUIDE v2.5 21-Dec-2016 14:44:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sp_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @sp_gui_OutputFcn, ...
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



% --- Executes just before sp_gui is made visible.
function sp_gui_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sp_gui (see VARARGIN)

% Choose default command line output for sp_gui
handles.output = hObject;

handles.im_data = zeros(128); handles.mask = handles.im_data;
handles.x = [0 1];
handles.y = [0 1];
handles.clim = [0 1];

handles.loaded = 0;
handles.folder = '';
handles.width = 0;

handles.im_object = [];
handles.level_path = [1 1; 2 2];
handles.line_cut_path = 0;
handles.edge_path = 0;
handles.line_cut_plot = {0,0,0};
handles.edge_plot = 0;
handles.level_path_plot = 0;
handles.levelled = 0;
handles.center = 0;
handles.cut_center_plot = 0;
handles.im_hist = 'a';
handles.fig = gcf;
handles.cut_fig = 1;
handles.cut_axes = 1;
handles.fid = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sp_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.axes1,'Color','Black','XTickLabel',[],'YTickLabel',[],...
    'PlotBoxAspectRatioMode','manual','PlotBoxAspectRatio',[1 1 1])
set(handles.slider1,'SliderStep',[1 1])
set(handles.axes2,'Visible','off')
set(handles.axes3,'Visible','off')
set(handles.edit1,'Visible','off')
set(handles.edit2,'Visible','off')
set(handles.edit3,'Visible','off')
set(handles.edit6,'Visible','off')
set(handles.edit7,'Visible','off')
set(handles.slider1,'Visible','off')
set(handles.text3,'Visible','off')
set(handles.text6,'Visible','off')
set(handles.text7,'Visible','off')
set(handles.text13,'Visible','off')
set(handles.text14,'Visible','off')
set(handles.text18,'Visible','off')

set(handles.pushbutton1,'Enable','off')
set(handles.pushbutton4,'Visible','off')
set(handles.pushbutton8,'Enable','off')
set(handles.pushbutton10,'Enable','off')
set(handles.pushbutton11,'Enable','on')
set(handles.togglebutton1,'Enable','off')
set(handles.togglebutton2,'Enable','off')
set(handles.popupmenu4,'Enable','off')



% --- Outputs from this function are returned to the command line.
function varargout = sp_gui_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% =========================================================================
% =========================================================================
% --- Executes on selection change in popupmenu1 'Channel...'.
function popupmenu1_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.loaded
    
    chan_val = get(handles.popupmenu1,'Value');
    chan_str = get(handles.popupmenu1,'String');
    chan = chan_str{chan_val};
    
    if strcmp(chan,'Channel...')
        
        msgbox('Choose a channel')
        
    else
        
        listbox1_Callback(hObject, eventdata, handles)
        
    end
    
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, ~, ~)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'),...
                    get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
% --- Executes on selection change in popupmenu2 'Direction...'.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.loaded
    
    dir_val = get(handles.popupmenu2,'Value');
    dir_str = get(handles.popupmenu2,'String');
    direction = dir_str{dir_val};
    
    if strcmp(direction,'Direction...')
        
        msgbox('Choose a direction')
        
    else
        
        listbox1_Callback(hObject, eventdata, handles)
        
    end
    
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, ~, ~)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'),...
                    get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
% --- Executes on selection change in popupmenu3 'Function...'.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.loaded
    
    fun_val = get(handles.popupmenu3,'Value');
    fun_str = get(handles.popupmenu3,'String');
    func = fun_str{fun_val};
    
    if strcmp(func,'Function...')
        
        msgbox('Choose a function')
        
    else
        
        listbox1_Callback(hObject, eventdata, handles)
        
    end
    
end

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, ~, ~)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'),...
                    get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white'); 
end



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton3 'Load'.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

chan_val = get(handles.popupmenu1,'Value');
chan_str = get(handles.popupmenu1,'String');
chan = chan_str{chan_val};

dir_val = get(handles.popupmenu2,'Value');
dir_str = get(handles.popupmenu2,'String');
direction = dir_str{dir_val};

func_val = get(handles.popupmenu3,'Value');
func_str = get(handles.popupmenu3,'String');
func = func_str{func_val};

if strcmp(chan,'Channel...')
    
    msgbox('Choose a channel')
    
elseif strcmp(direction,'Direction...')
    
    msgbox('Choose a direction')
    
elseif strcmp(func,'Function...') && get(handles.radiobutton1,'Value')
    
    msgbox('Choose a function')
    
else
    
    folder = ...
        uipickfiles('FilterSpec',...
        'C:\Users\Sai\Documents\SpiderOak Hive\Work\Experimental Data');
    
    set(handles.listbox1,'String',folder,'Value',1)
    handles.folder = folder;
    guidata(hObject, handles)
    
    listbox1_Callback(hObject, eventdata, handles)
    
end

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

chan_val = get(handles.popupmenu1,'Value');
chan_str = get(handles.popupmenu1,'String');
chan = chan_str{chan_val};

dir_val = get(handles.popupmenu2,'Value');
dir_str = get(handles.popupmenu2,'String');
direction = dir_str{dir_val};

func_val = get(handles.popupmenu3,'Value');
func_str = get(handles.popupmenu3,'String');
func = func_str{func_val};

if strcmp(chan,'CT') || strcmp(chan,'Topography')

    if strcmp(func,'arg')
        func = 'abs';
        func_err = 1;
        set(handles.popupmenu3,'Value',2)
    else
        func_err = 0;
    end

end

folder = get(handles.listbox1,'String');

if get(handles.listbox1,'Value') <= length(folder)
    folder = folder{get(handles.listbox1,'Value')};
else
    folder = folder{length(folder)};
end

if ischar(folder)

    idx = strfind(folder,'\');
    filebasename = folder(idx(end)+1:end);

    if get(handles.radiobutton1,'Value')

        prefix = strcat(chan,'-',direction,'-',func);
        [x, y, im_data,xreal,yreal] = sp_gui_load_image(folder,prefix);
        if strcmp(chan,'CT')
            im_data = 1e9*im_data;
            set(handles.pushbutton1,'String','Fix zero')
            set(handles.pushbutton12,'Enable','off')
        elseif strcmp(func,'abs')
            im_data = 1e6*im_data;
            set(handles.pushbutton1,'String','Use mask')
            set(handles.pushbutton12,'Enable','on')
        else
            set(handles.pushbutton1,'String','Use mask')
            set(handles.pushbutton12,'Enable','on')
        end
        
        if get(handles.checkbox3,'Value')
            fid = fopen(handles.fid,'at');
            fprintf(fid,'');
            fclose(fid);
        end

    else

        prefix = strcat('*',chan,'*',direction);
        [x, y, im_data, xreal, yreal] = sp_gui_load_image_ac(folder,prefix);
        if strcmp(chan,'Topography')
            im_data = 1e9*im_data;
            set(handles.pushbutton1,'String','Fix zero')
            set(handles.pushbutton12,'Enable','off')
        else
            set(handles.pushbutton1,'String','Use mask')
            set(handles.pushbutton12,'Enable','on')
        end
        im_data(im_data > 10^36) = 0;

    end
    
    if get(handles.checkbox3,'Value')
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% load %s\n\n',strcat(filebasename,'_',prefix));
        fclose(fid);
    end
    
    set(handles.text17,'String',xreal);
    set(handles.text16,'String',yreal);

    handles.im_data = im_data; handles.previous = im_data;
    set(handles.pushbutton11,'Enable','on')
    handles.x = x;
    handles.y = y;
    handles.clim = [min(im_data(:)) max(im_data(:))];

    r = imref2d(size(im_data)); 
    r.XWorldLimits = [0 xreal];
    r.YWorldLimits = [0 yreal];
    handles.r = r;
    
    if ~handles.loaded
        set(handles.pushbutton1,'Enable','on')
        set(handles.togglebutton1,'Enable','on')
        set(handles.togglebutton2,'Enable','on')
        set(handles.popupmenu4,'Enable','on')
        set(handles.pushbutton8,'Enable','on')
        set(handles.pushbutton10,'Enable','on')
        set(handles.slider1,'Visible','on','Value',1)
        set(handles.text13,'Visible','on')
        set(handles.text14,'Visible','on')
        handles.loaded = 1;
    end

    if strcmp(chan,'CT')
        
        if func_err
            msgbox('No ''arg'' function for CT')
        end
        
    end
    
    if not(isempty(find(size(handles.mask) ~= size(handles.im_data),1)))
        handles.mask = zeros(size(handles.im_data));
    end
    
    set(handles.text2,'String',filebasename)
    set(handles.edit6,'Visible','on','String',num2str(handles.clim(1)))
    set(handles.edit7,'Visible','on','String',num2str(handles.clim(2)))
    set(handles.radiobutton3,'Value',1)
    set(handles.radiobutton4,'Value',0)
    set(handles.radiobutton5,'Value',0)
    
    guidata(hObject, handles)
    
    sp_gui_updateimobject(hObject, eventdata, handles);
    
    if not(isnumeric(handles.im_hist))
        sp_gui_generatehistogram(hObject,eventdata,handles);
    end
    
else

    msgbox('Choose a directory')

end



% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
% --- Executes on button press in radiobutton1. 'Neaspec'
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.loaded = 0;

set(handles.popupmenu1,'String',{'Channel...',...
    'CT',...
    'M1',...
    'O1',...
    'O2',...
    'O3',...
    'O4'},...
    'Value',1)

set(handles.popupmenu2,'String',{'Direction...',...
    'F',...
    'B'},...
    'Value',1)

set(handles.popupmenu3,'Enable','on','Value',1)
set(handles.listbox1,'Value',1,'String',' ')

handles.folder = 0;

set(handles.pushbutton1,'Enable','off')
set(handles.pushbutton4,'Visible','off')
set(handles.pushbutton8,'Enable','off')
    set(handles.pushbutton11,'Enable','off')
set(handles.togglebutton1,'Enable','off')
set(handles.togglebutton2,'Enable','off')
set(handles.popupmenu4,'Enable','off')

guidata(hObject,handles)



% =========================================================================
% =========================================================================
% --- Executes on button press in radiobutton2. 'attocube'
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.loaded = 0;

set(handles.popupmenu1,'String',{'Channel...',...
    'Topography',...
    'Probe phase',...
    'Frequency Shift',...
    'Near-field Amplitude',...
    'Near-field Phase'},...
    'Value',1)

set(handles.popupmenu2,'String',{'Direction...',...
    'fwd',...
    'bwd'},...
    'Value',1)

set(handles.popupmenu3,'Enable','off','Value',1)
set(handles.listbox1,'Value',1,'String',' ')

handles.folder = 0;

set(handles.pushbutton1,'Enable','off')
set(handles.pushbutton4,'Visible','off')
set(handles.pushbutton8,'Enable','off')
    set(handles.pushbutton11,'Enable','off')
set(handles.togglebutton1,'Enable','off')
set(handles.togglebutton2,'Enable','off')
set(handles.popupmenu4,'Enable','off')

guidata(hObject,handles)



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton10. 'Level'
function pushbutton10_Callback(hObject, eventdata, handles) 
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cmap = get(handles.popupmenu4,'String');
handles.previous = handles.im_data;

if get(hObject,'Value')

    handles.subgui = sp_gui_level(handles.im_data,handles.r,...
        cmap{get(handles.popupmenu4,'Value')},...
        get(handles.popupmenu1,'Value'),...
        handles.x,handles.y,handles.mask,...
        get(handles.checkbox3,'Value'),handles.fid,...
        get(handles.popupmenu3, 'Value'));
    guidata(hObject,handles);
    
else
    
    handles.im_data = get(handles.subgui,'UserData');
    delete(handles.subgui);
    handles.subgui = 0;
    handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
    
    guidata(hObject,handles)
    
    sp_gui_updateimobject(hObject, eventdata, handles);
    
    if not(isnumeric(handles.im_hist))
        sp_gui_generatehistogram(hObject,eventdata,handles);
    end
    
end


% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton1 'Normalize - use mask'.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.previous = handles.im_data;

if get(handles.popupmenu1,'Value') == 2
    
    handles.im_data = handles.im_data - min(handles.im_data(:));
    handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
    
    if get(handles.checkbox3,'Value')
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------');
        fprintf(fid,'\n');
        fprintf(fid,'im_data = im_data - min(im_data(:));\n');
        fprintf(fid,'\n');
        fclose(fid);
    end
    
else
    
    norm_val = mean(handles.im_data(handles.mask > 0)); 
    handles.im_data = handles.im_data/norm_val;
    handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
    
    axes(handles.axes1)
    cla
    handles.im_object = imshow(handles.im_data,handles.r,...
                             handles.clim,'Parent',handles.axes1);
                         
    if (get(handles.togglebutton1,'Value'))
       set(handles.im_object,'ButtonDownFcn',...
                            {@sp_gui_getimprofile,handles})
    end
    
    set(gca,'fontsize',14)
    axis tight
    axis equal
    colorbar('location','southoutside')
    cmap = cellstr(get(handles.popupmenu4,'String'));
    cmap = cmap{get(handles.popupmenu4,'Value')};
    colormap(handles.axes1,cmap)
    
    if get(handles.togglebutton2,'Value')
        hold on
        if ~isnumeric(handles.edge_plot)
            delete(handles.edge_plot)
        end
        handles.edge_plot = plot(handles.edge_path{1},...
            handles.edge_path{2},'--k');
    end
    
    if get(handles.checkbox3,'Value')
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------');
        fprintf(fid,'\n');
        fprintf(fid,'norm_val = mean(im_data(mask > 0));\n');
        fprintf(fid,'im_data = im_data/norm_val;\n');
        fprintf(fid,'\n');
        fclose(fid);
    end
    
%     fprintf('rect = [%i,%i,%i,%i]\n',...
%                         rect(1),rect(2),rect(3),rect(4));

end

set(handles.edit6,'String',num2str(handles.clim(1)))
set(handles.edit7,'String',num2str(handles.clim(2)))

guidata(hObject,handles)

sp_gui_updateimobject(hObject, eventdata, handles);

if not(isnumeric(handles.im_hist))
    sp_gui_generatehistogram(hObject,eventdata,handles);
end



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton12. 'Normalize - get area'
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton1,'Enable','off')
set(handles.pushbutton3,'Enable','off')
set(handles.togglebutton1,'Enable','off')
set(handles.togglebutton2,'Enable','off')
rect = getrect(handles.axes1);
set(handles.pushbutton1,'Enable','on')
set(handles.pushbutton3,'Enable','on')
set(handles.togglebutton1,'Enable','on')
set(handles.togglebutton2,'Enable','on')

x1 = rect(1); 
if x1 > max(handles.x); x1 = max(handles.x);
elseif x1 < min(handles.x); x1 = min(handles.x); end
x2 = x1 + rect(3);
if x2 > max(handles.x); x2 = max(handles.x);
elseif x2 < min(handles.x); x2 = min(handles.x); end
y1 = rect(2);
if y1 > max(handles.y); y1 = max(handles.y);
elseif y1 < min(handles.y); y1 = min(handles.y); end
y2 = y1 + rect(4);
if y2 > max(handles.y); y2 = max(handles.y);
elseif y2 < min(handles.y); y2 = min(handles.y); end

rect(3) = find(handles.x >= x1,1);
rect(4) = find(handles.x >= x2,1);
rect(1) = find(handles.y >= y1,1);
rect(2) = find(handles.y >= y2,1);

handles.im_data = sp_normalize(handles.im_data,rect);
handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];

axes(handles.axes1)
cla
handles.im_object = imshow(handles.im_data,handles.r,...
                         handles.clim,'Parent',handles.axes1);

if (get(handles.togglebutton1,'Value'))
   set(handles.im_object,'ButtonDownFcn',...
                        {@sp_gui_getimprofile,handles})
end

set(gca,'fontsize',14)
axis tight
axis equal
colorbar('location','southoutside')
cmap = cellstr(get(handles.popupmenu4,'String'));
cmap = cmap{get(handles.popupmenu4,'Value')};
colormap(handles.axes1,cmap)

if get(handles.togglebutton2,'Value')
    hold on
    if ~isnumeric(handles.edge_plot)
        delete(handles.edge_plot)
    end
    handles.edge_plot = plot(handles.edge_path{1},...
        handles.edge_path{2},'--k');
end

if get(handles.checkbox3,'Value')
    fid = fopen(handles.fid,'at');
    fprintf(fid,'%% -------------------------------------------------');
    fprintf(fid,'\n');
    fprintf(fid,'im_data = sp_normalize(im_data,[%i %i %i %i]);\n',...
        rect(1),rect(2),rect(3),rect(4));
    fprintf(fid,'\n');
    fclose(fid);
end
    
set(handles.edit6,'String',num2str(handles.clim(1)))
set(handles.edit7,'String',num2str(handles.clim(2)))

guidata(hObject,handles)

sp_gui_updateimobject(hObject, eventdata, handles);

if not(isnumeric(handles.im_hist))
    sp_gui_generatehistogram(hObject,eventdata,handles);
end



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton8. 'Crop - get area'
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.previous = handles.im_data;
set(handles.pushbutton1,'Enable','off')
set(handles.pushbutton3,'Enable','off')
set(handles.togglebutton1,'Enable','off')
set(handles.togglebutton2,'Enable','off')
rect = getrect(handles.axes1);
set(handles.pushbutton1,'Enable','on')
set(handles.pushbutton3,'Enable','on')
set(handles.togglebutton1,'Enable','on')
set(handles.togglebutton2,'Enable','on')

dx = handles.r.PixelExtentInWorldX;
dy = handles.r.PixelExtentInWorldY;
x1 = rect(1); 
if x1 > max(handles.x); x1 = max(handles.x);
elseif x1 < min(handles.x); x1 = min(handles.x); end
x2 = x1 + rect(3);
if x2 > max(handles.x); x2 = max(handles.x);
elseif x2 < min(handles.x); x2 = min(handles.x); end
y1 = rect(2);
if y1 > max(handles.y); y1 = max(handles.y);
elseif y1 < min(handles.y); y1 = min(handles.y); end
y2 = y1 + rect(4);
if y2 > max(handles.y); y2 = max(handles.y);
elseif y2 < min(handles.y); y2 = min(handles.y); end

rect(3) = round(x1/dx); if rect(3) < 1; rect(3) = 1; end
rect(4) = round(x2/dx); 
if rect(4) > handles.r.ImageSize(2); rect(4) = handles.r.ImageSize(2); end
rect(1) = round(y1/dy); if rect(1) < 1; rect(1) = 1; end
rect(2) = round(y2/dy); 
if rect(2) > handles.r.ImageSize(1); rect(2) = handles.r.ImageSize(1); end

[x, y, handles.im_data, handles.r] = sp_crop(handles.im_data,...
    handles.r,rect);
[~, ~, handles.mask, ~] = sp_crop(handles.mask,...
    handles.r,rect);
handles.x = x;
handles.y = y;
set(handles.text17,'String',handles.r.ImageExtentInWorldX);
set(handles.text16,'String',handles.r.ImageExtentInWorldY);

handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];

set(handles.edit6,'String',num2str(handles.clim(1)))
set(handles.edit7,'String',num2str(handles.clim(2)))

guidata(hObject,handles)

sp_gui_updateimobject(hObject, eventdata, handles);

if not(isnumeric(handles.im_hist))
    sp_gui_generatehistogram(hObject,eventdata,handles);
end

if get(handles.checkbox3,'Value')
    fid = fopen(handles.fid,'at');
    fprintf(fid,'%% -------------------------------------------------');
    fprintf(fid,'\nrect = [%i,%i,%i,%i]\n',rect(1),rect(2),rect(3),rect(4));
    fprintf(fid,'[x,y,im_data,ref] = sp_crop(im_data,ref,rect);\n');
    if get(handles.checkbox2,'Value')
        fprintf(fid,'[~,~,mask,~] = sp_crop(mask,ref,rect);\n');
    end
    fprintf(fid,'\n');
    fclose(fid);
end


% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton15. 'Crop - manual'
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.previous = handles.im_data;
set(handles.pushbutton1,'Enable','off')
set(handles.pushbutton3,'Enable','off')
set(handles.togglebutton1,'Enable','off')
set(handles.togglebutton2,'Enable','off')
rect = inputdlg({'x1','x2','y1','y2'},'Crop area',1,...
    {'0',num2str(handles.r.XWorldLimits(2)),'0',...
    num2str(handles.r.YWorldLimits(2))});
set(handles.pushbutton1,'Enable','on')
set(handles.pushbutton3,'Enable','on')
set(handles.togglebutton1,'Enable','on')
set(handles.togglebutton2,'Enable','on')

dx = handles.r.PixelExtentInWorldX;
dy = handles.r.PixelExtentInWorldY;
x1 = str2double(rect{1}); 
if x1 > max(handles.x); x1 = max(handles.x);
elseif x1 < min(handles.x); x1 = min(handles.x); end
x2 = str2double(rect{2});
if x2 > max(handles.x); x2 = max(handles.x);
elseif x2 < min(handles.x); x2 = min(handles.x); end
y1 = str2double(rect{3});
if y1 > max(handles.y); y1 = max(handles.y);
elseif y1 < min(handles.y); y1 = min(handles.y); end
y2 = str2double(rect{4});
if y2 > max(handles.y); y2 = max(handles.y);
elseif y2 < min(handles.y); y2 = min(handles.y); end

rect = [];
rect(3) = round(x1/dx); if rect(3) < 1; rect(3) = 1; end
rect(4) = round(x2/dx); 
if rect(4) > handles.r.ImageSize(2); rect(4) = handles.r.ImageSize(2); end
rect(1) = round(y1/dy); if rect(1) < 1; rect(1) = 1; end
rect(2) = round(y2/dy); 
if rect(2) > handles.r.ImageSize(1); rect(2) = handles.r.ImageSize(1); end

[x, y, handles.im_data, handles.r] = sp_crop(handles.im_data,...
    handles.r,rect);

[~, ~, handles.mask, ~] = sp_crop(handles.mask,...
    handles.r,rect);

handles.x = x;
handles.y = y;
set(handles.text17,'String',handles.r.ImageExtentInWorldX);
set(handles.text16,'String',handles.r.ImageExtentInWorldY);

handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];

set(handles.edit6,'String',num2str(handles.clim(1)))
set(handles.edit7,'String',num2str(handles.clim(2)))

guidata(hObject,handles)

sp_gui_updateimobject(hObject, eventdata, handles);

if not(isnumeric(handles.im_hist))
    sp_gui_generatehistogram(hObject,eventdata,handles);
end

if get(handles.checkbox3,'Value')
    fid = fopen(handles.fid,'at');
    fprintf(fid,'%% -------------------------------------------------');
    fprintf(fid,'\nrect = [%i,%i,%i,%i]\n',rect(1),rect(2),rect(3),rect(4));
    fprintf(fid,'[x,y,im_data,ref] = sp_crop(im_data,ref,rect);\n');
    if get(handles.checkbox2,'Value')
        fprintf(fid,'[~,~,mask,~] = sp_crop(mask,ref,rect);\n');
    end
    fprintf(fid,'\n');
    fclose(fid);
end



% =========================================================================
% =========================================================================
% --- Executes on button press in togglebutton1 'Free cut'.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(hObject,'Value')
    
    set(handles.edit1,'Visible','on')
    set(handles.text3,'Visible','on')
    set(handles.togglebutton2,'Enable','off')
    set(handles.im_object,'ButtonDownFcn',{@sp_gui_getimprofile,handles})
    
else
    
    set(handles.edit1,'Visible','off')
    set(handles.text3,'Visible','off')
    set(handles.im_object,'ButtonDownFcn','')
    delete(handles.line_cut_plot{1})
    delete(handles.line_cut_plot{2})
    delete(handles.line_cut_plot{3})
    handles.line_cut_path = 0;
    set(handles.togglebutton2,'Enable','on')
    handles.cut_fig = 0;
    handles.cut_axes = 0;
    guidata(hObject,handles)
    
end

%  --- Executes on button press in image during 'Free cut'.
function sp_gui_getimprofile(hObject, eventdata, handles)    
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);
handles.previous = handles.im_data;

set(handles.togglebutton1,'Enable','off')
set(handles.pushbutton1,'Enable','off')
set(handles.pushbutton3,'Enable','off')
[cut_x,cut_y] = getline(handles.axes1);
set(handles.togglebutton1,'Enable','on')
set(handles.pushbutton1,'Enable','on')
set(handles.pushbutton3,'Enable','on')

m = diff(cut_y)/diff(cut_x);

if length(cut_x) ~= 2 
    
    msgbox('Choose exactly 2 points')
    
else
        
    width = str2double(get(handles.edit1,'String'));
    [r,c] = sp_linecut(handles.x,handles.y,handles.im_data,...
                                cut_x,cut_y,width,0);

    if isnumeric(handles.cut_fig)
        handles.cut_fig = figure;
        hold off
        plot(r,c)
        handles.cut_axes = gca;
    else
        axes(handles.cut_axes)
        plot(r,c)
    end
    
    xlabel('Position')
    ylabel('Signal')
    set(gca,'fontsize',14)
    axis tight
    ylim('auto')
    
    
    axes(handles.axes1)
    hold on
    if ~isnumeric(handles.line_cut_plot{1});
        delete(handles.line_cut_plot{1})
        delete(handles.line_cut_plot{2})
        delete(handles.line_cut_plot{3})
    end
    
    
    p1 = plot(cut_x,cut_y,'k','linewidth',1.5);
    [x1,y1] = sp_makecutpath(cut_x(1),cut_y(1),...
        tand(atand(m(1)) + 90),width/2,width/2);
    [x2,y2] = sp_makecutpath(cut_x(2),cut_y(2),...
        tand(atand(m(1)) + 90),width/2,width/2);
    p2 = plot(x1,y1,'k','linewidth',1.5);
    p3 = plot(x2,y2,'k','linewidth',1.5);
    hold off

    handles.line_cut_plot = {p1, p2, p3};
    
    handles.line_cut_path = {cut_x,cut_y};
    handles.width = width;
    
    handles.printer = 'Free_cut';
    
    if get(handles.checkbox3,'Value')
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------');
        fprintf(fid,'\n');
        fprintf(fid,'cut_x = [%.4f %.4f];\n',cut_x(1),cut_x(2));
        fprintf(fid,'cut_y = [%.4f %.4f];\n',cut_y(1),cut_y(2));
        fprintf(fid,'width = %.4f;\n',handles.width);
        fprintf(fid,'[r,c] = sp_linecut(x,y,im_data,...\n');
        fprintf(fid,'                        cut_x,cut_y,width,0);\n');
        fprintf(fid,'\n');
        fclose(fid);
    end
    
    guidata(hObject,handles)
    
end



% =========================================================================
% =========================================================================
% --- Executes on button press in togglebutton2 'Edge cut'.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(hObject,'Value')
    
    set(handles.edit1,'Visible','on')
    set(handles.edit2,'Visible','on')
    set(handles.edit3,'Visible','on')
    set(handles.text3,'Visible','on')
    set(handles.text6,'Visible','on')
    set(handles.text7,'Visible','on')
    set(handles.pushbutton4,'Visible','on')
    set(handles.pushbutton1,'Enable','off')
    set(handles.pushbutton3,'Enable','off')
    set(handles.pushbutton4,'Enable','off')
    set(handles.togglebutton1,'Enable','off')
    set(handles.togglebutton2,'Enable','off')
    
    [edge_x,edge_y] = getline(handles.axes1);
    
    if length(edge_x) == 1
        edge_x(2) = handles.x(round(length(handles.x)/2)); 
        edge_x = edge_x';
        edge_y(2) = handles.y(round(length(handles.y)/2));
        edge_y = edge_y';
    elseif length(edge_x) > 2
        edge_x = edge_x(1:2);
        edge_y = edge_y(1:2);
    end
    
    set(handles.togglebutton2,'Enable','on')
    set(handles.pushbutton1,'Enable','on')
    set(handles.pushbutton3,'Enable','on')
    set(handles.pushbutton4,'Enable','on')
    
    axes(handles.axes1)
    if ~isnumeric(handles.edge_plot)
        delete(handles.edge_plot)
    end
    hold on
    handles.edge_plot = plot(edge_x,edge_y,'--k');
    hold off
    
    handles.edge_path = {edge_x,edge_y};
    
    guidata(hObject,handles)
    
else
    
    set(handles.edit1,'Visible','off')
    set(handles.pushbutton4,'Visible','off')
    set(handles.edit2,'Visible','off')
    set(handles.edit3,'Visible','off')
    set(handles.text3,'Visible','off')
    set(handles.text6,'Visible','off')
    set(handles.text7,'Visible','off')
    
    if length(handles.center) > 1
        delete(handles.line_cut_plot{1})
        delete(handles.line_cut_plot{2})
        delete(handles.line_cut_plot{3})
        delete(handles.cut_center_plot)
    end
    
    delete(handles.edge_plot)
    set(handles.togglebutton1,'Enable','on')
    handles.cut_axes = 0;
    handles.cut_fig = 0;
    guidata(hObject,handles)
    
end



% =========================================================================
% =========================================================================
% --- Executes on selection change in popupmenu4 'Colormap'.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cmap = cellstr(get(hObject,'String'));
cmap = cmap{get(hObject,'Value')};
colormap(handles.axes1,cmap);

guidata(hObject,handles)

sp_gui_updateimobject(hObject,eventdata,handles)

if not(isnumeric(handles.im_hist))
    
    handles.clim = [str2double(get(handles.edit6,'String'))...
        str2double(get(handles.edit7,'String'))];
    sp_gui_generatehistogram(hObject, eventdata, handles)
    

end

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'),...   
                    get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
function edit1_Callback(hObject, eventdata, handles) % 'Set width' 
% (set averaging width)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.togglebutton1,'Value') || (get(handles.togglebutton2,...
                    'Value') && not(length(handles.center) == 1))
    
    if iscell(handles.line_cut_path)
    cut_x = handles.line_cut_path{1};
    cut_y = handles.line_cut_path{2};
    
    m = diff(cut_y)/diff(cut_x);
    m = tand(atand(m) + 90);
    
    width = str2double(get(handles.edit1,'String'));
    [r,c] = sp_linecut(handles.x,handles.y,handles.im_data,...
                                cut_x,cut_y,width,0);

    if isnumeric(handles.cut_fig)
        handles.cut_fig = figure;
        hold off
        plot(r,c)
        handles.cut_axes = gca;
    else
        axes(handles.cut_axes)
        plot(r,c)
    end
    
    xlabel('Position')
    ylabel('Signal')
    set(handles.cut_axes,'fontsize',14)
    axis tight
    ylim('auto')
    
    axes(handles.axes1)
    hold on
    
    if ~isnumeric(handles.line_cut_plot{1});
        delete(handles.line_cut_plot{1})
        delete(handles.line_cut_plot{2})
        delete(handles.line_cut_plot{3})
    end
    
    p1 = plot(cut_x,cut_y,'k','linewidth',1.5);
    [x1,y1] = sp_makecutpath(cut_x(1),cut_y(1),m,width/2,width/2);
    [x2,y2] = sp_makecutpath(cut_x(2),cut_y(2),m,width/2,width/2);
    p2 = plot(x1,y1,'k','linewidth',1.5);
    p3 = plot(x2,y2,'k','linewidth',1.5);
    hold off
    
    handles.line_cut_plot = {p1, p2, p3};
    handles.width = width;
    
    guidata(hObject,handles)
    
    if get(handles.checkbox3,'Value')
        if get(handles.togglebutton2,'Value')
            x = handles.center; y0 = x(2); x0 = x(1);
            edge_path = [handles.edge_path{1} handles.edge_path{2}];
            lr = str2double(get(handles.edit2,'String')); 
            ll = str2double(get(handles.edit3,'String'));
            
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% -------------------------------------------------');
            fprintf(fid,'\n');
            fprintf(fid,'edge_path = [%.4f %.4f\n',edge_path(1,1),edge_path(1,2));
            fprintf(fid,'             %.4f %.4f];\n',edge_path(2,1),edge_path(2,2));
            fprintf(fid,'x0 = %.4f; y0 = %.4f;\n',x0,y0);
            fprintf(fid,'lr = %.4f; ll = %.4f;\n',lr,ll);
            fprintf(fid,'width = %.4f;\n',handles.width);
            fprintf(fid,'[r,c,cut_path,widthr,widthl] = sp_edgecut(x,y,im_data,...\n');
            fprintf(fid,'                                    x0,y0,edge_path,lr,ll,width);\n');
            fprintf(fid,'\n');
            fclose(fid);
        else
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% -------------------------------------------------');
            fprintf(fid,'\n');
            fprintf(fid,'cut_x = [%.4f %.4f];\n',cut_x(1),cut_x(2));
            fprintf(fid,'cut_y = [%.4f %.4f];\n',cut_y(1),cut_y(2));
            fprintf(fid,'width = %.4f;\n',handles.width);
            fprintf(fid,'[r,c] = sp_linecut(x,y,im_data,...\n');
            fprintf(fid,'                        cut_x,cut_y,width,0);\n');
            fprintf(fid,'\n');
            fclose(fid);
        end
    end
    end
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'),...
                    get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
function edit2_Callback(hObject, eventdata, handles) % set right length
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (get(handles.togglebutton2,'Value') && not(length(handles.center) == 1))
    
    x = handles.center;
    y = x(2); x = x(1);
    
    width = str2double(get(handles.edit1,'String'));
    
    edge_path = [handles.edge_path{1} handles.edge_path{2}];
    lr = str2double(get(handles.edit2,'String')); 
    ll = str2double(get(handles.edit3,'String'));
    
    [r,c,cut_path,width1,width2] = sp_edgecut(handles.x,handles.y,...
        handles.im_data,x,y,edge_path,...
        lr,ll,width);
        
    if ~isnumeric(handles.line_cut_plot{1});
        delete(handles.cut_center_plot)
        delete(handles.line_cut_plot{1})
        delete(handles.line_cut_plot{2})
        delete(handles.line_cut_plot{3})
    end
    
    axes(handles.axes1)
    hold on
    handles.cut_center_plot = plot(x,y,'.k','markersize',20);
    p1 = plot(cut_path(:,1),cut_path(:,2),'k','linewidth',1.5);    
    p2 = plot(width1(:,1),width1(:,2),'k','linewidth',1.5);
    p3 = plot(width2(:,1),width2(:,2),'k','linewidth',1.5);
    hold off

    if isnumeric(handles.cut_fig)
        handles.cut_fig = figure;
        hold off
        plot(r,c)
        handles.cut_axes = gca;
    else
        axes(handles.cut_axes)
        plot(r,c)
    end
    set(handles.cut_axes,'fontsize',14)
    xlabel('Distance (\mum)')
    ylabel('Signal')
    
    handles.width = width;
    handles.line_cut_plot = {p1,p2,p3};
    handles.line_cut_path = {cut_path(:,1),cut_path(:,2)};
    
    guidata(hObject,handles)
    
    if get(handles.checkbox3,'Value')
        x = handles.center; y0 = x(2); x0 = x(1);
        edge_path = [handles.edge_path{1} handles.edge_path{2}];
        lr = str2double(get(handles.edit2,'String')); 
        ll = str2double(get(handles.edit3,'String'));
        
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------');
        fprintf(fid,'\n');
        fprintf(fid,'edge_path = [%.4f %.4f\n',edge_path(1,1),edge_path(1,2));
        fprintf(fid,'             %.4f %.4f];\n',edge_path(2,1),edge_path(2,2));
        fprintf(fid,'x0 = %.4f; y0 = %.4f;\n',x0,y0);
        fprintf(fid,'lr = %.4f; ll = %.4f;\n',lr,ll);
        fprintf(fid,'width = %.4f;\n',handles.width);
        fprintf(fid,'[r,c,cut_path,widthr,widthl] = sp_edgecut(x,y,im_data,...\n');
        fprintf(fid,'                                    x0,y0,edge_path,lr,ll,width);\n');
        fprintf(fid,'\n');
        fclose(fid);
    end
    
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'),...
                    get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
function edit3_Callback(hObject, eventdata, handles) % set left length
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (get(handles.togglebutton2,'Value') && not(length(handles.center) == 1))
    
    x = handles.center;
    y = x(2); x = x(1);
    
    width = str2double(get(handles.edit1,'String'));
    
    edge_path = [handles.edge_path{1} handles.edge_path{2}];
    lr = str2double(get(handles.edit2,'String')); 
    ll = str2double(get(handles.edit3,'String'));
    
    [r,c,cut_path,width1,width2] = sp_edgecut(handles.x,handles.y,...
        handles.im_data,x,y,edge_path,...
        lr,ll,width);
        
    if ~isnumeric(handles.line_cut_plot{1});
        delete(handles.cut_center_plot)
        delete(handles.line_cut_plot{1})
        delete(handles.line_cut_plot{2})
        delete(handles.line_cut_plot{3})
    end
    
    axes(handles.axes1)
    hold on
    handles.cut_center_plot = plot(x,y,'.k','markersize',20);
    p1 = plot(cut_path(:,1),cut_path(:,2),'k','linewidth',1.5);    
    p2 = plot(width1(:,1),width1(:,2),'k','linewidth',1.5);
    p3 = plot(width2(:,1),width2(:,2),'k','linewidth',1.5);
    hold off

    if isnumeric(handles.cut_fig)
        handles.cut_fig = figure;
        hold off
        plot(r,c)
        handles.cut_axes = gca;
    else
        axes(handles.cut_axes)
        plot(r,c)
    end
    set(handles.cut_axes,'fontsize',14)
    xlabel('Distance (\mum)')
    ylabel('Signal')
    
    handles.width = width;
    handles.line_cut_plot = {p1,p2,p3};
    handles.line_cut_path = {cut_path(:,1),cut_path(:,2)};
    
    guidata(hObject,handles)
    
    if get(handles.checkbox3,'Value')
        x = handles.center; y0 = x(2); x0 = x(1);
        edge_path = [handles.edge_path{1} handles.edge_path{2}];
        lr = str2double(get(handles.edit2,'String')); 
        ll = str2double(get(handles.edit3,'String'));
        
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------');
        fprintf(fid,'\n');
        fprintf(fid,'edge_path = [%.4f %.4f\n',edge_path(1,1),edge_path(1,2));
        fprintf(fid,'             %.4f %.4f];\n',edge_path(2,1),edge_path(2,2));
        fprintf(fid,'x0 = %.4f; y0 = %.4f;\n',x0,y0);
        fprintf(fid,'lr = %.4f; ll = %.4f;\n',lr,ll);
        fprintf(fid,'width = %.4f;\n',handles.width);
        fprintf(fid,'[r,c,cut_path,widthr,widthl] = sp_edgecut(x,y,im_data,...\n');
        fprintf(fid,'                                    x0,y0,edge_path,lr,ll,width);\n');
        fprintf(fid,'\n');
        fclose(fid);
    end
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'),...
                    get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton4 'Set center'.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[x,y] = getpts(handles.axes1);

if length(x) ~= 1
        
        msgbox('Select exactly one point')
    
else
    
    if ~isnumeric(handles.cut_center_plot)
        delete(handles.cut_center_plot)
        delete(handles.line_cut_plot{1})
        delete(handles.line_cut_plot{2})
        delete(handles.line_cut_plot{3})
    end
    
    width = str2double(get(handles.edit1,'String'));
    
    axes(handles.axes1)
    hold on
    handles.cut_center_plot = plot(x,y,'.k','markersize',20);
    
    edge_path = [handles.edge_path{1} handles.edge_path{2}];
    lr = str2double(get(handles.edit2,'String')); 
    ll = str2double(get(handles.edit3,'String'));
    
    [r,c,cut_path,width1,width2] = sp_edgecut(handles.x,handles.y,...
        handles.im_data,x,y,edge_path,...
        lr,ll,width);
    
    p1 = plot(cut_path(:,1),cut_path(:,2),'k','linewidth',1.5);    
    p2 = plot(width1(:,1),width1(:,2),'k','linewidth',1.5);
    p3 = plot(width2(:,1),width2(:,2),'k','linewidth',1.5);
    hold off

    if isnumeric(handles.cut_fig)
        handles.cut_fig = figure;
        hold off
        plot(r,c)
        handles.cut_axes = gca;
    else
        axes(handles.cut_axes)
        plot(r,c)
    end
    set(handles.cut_axes,'fontsize',14)
    xlabel('Distance (\mum)')
    ylabel('Signal')
    
    handles.center = [x,y];
    handles.width = width;
    handles.line_cut_plot = {p1,p2,p3};
    handles.line_cut_path = {cut_path(:,1),cut_path(:,2)};
    
    handles.printer = 'Edge_cut';
    
    guidata(hObject,handles)
    
    if get(handles.checkbox3,'Value')
        x = handles.center; y0 = x(2); x0 = x(1);
        edge_path = [handles.edge_path{1} handles.edge_path{2}];
        lr = str2double(get(handles.edit2,'String')); 
        ll = str2double(get(handles.edit3,'String'));
        
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------');
        fprintf(fid,'\n');
        fprintf(fid,'edge_path = [%.4f %.4f\n',edge_path(1,1),edge_path(1,2));
        fprintf(fid,'             %.4f %.4f];\n',edge_path(2,1),edge_path(2,2));
        fprintf(fid,'x0 = %.4f; y0 = %.4f;\n',x0,y0);
        fprintf(fid,'lr = %.4f; ll = %.4f;\n',lr,ll);
        fprintf(fid,'width = %.4f;\n',handles.width);
        fprintf(fid,'[r,c,cut_path,widthr,widthl] = sp_edgecut(x,y,im_data,...\n');
        fprintf(fid,'                                    x0,y0,edge_path,lr,ll,width);\n');
        fprintf(fid,'\n');
        fclose(fid);
    end
end



% =========================================================================
% =========================================================================
function edit6_Callback(hObject, eventdata, handles) % 'Min'
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.clim(1) = str2double(get(handles.edit6,'String')); 

if not(isnumeric(handles.im_hist))
    
    lim = [min(handles.im_data(:)) max(handles.im_data(:))];
    clims = [str2double(get(handles.edit6,'String'))...
        str2double(get(handles.edit7,'String'))];

    axes(handles.axes3)
    
    x = linspace(lim(1),lim(2),256);
    y = 1:10;
    cmapbar = repmat(x,10,1);   
    
    if clims(2) < lim(2)
        idx = find(x > clims(2),1);
        cmapbar(:,idx:end) = cmapbar(1,idx);
    end

    if clims(1) > lim(1)
        idx = find(x > clims(1),1);
        cmapbar(:,1:idx) = cmapbar(1,idx);
    end
    
    imagesc(x,y,cmapbar)
    
    if clims(1) < lim(1)
        c = get(gca,'clim');
        set(gca,'clim',[clims(1) c(2)])
    end

    if clims(2) > lim(2)
        c = get(gca,'clim');
        set(gca,'clim',[c(1) clims(2)])
    end
    
    set(gca,'FontSize',14,'YTick',[])
    
end

axes(handles.axes1)
set(gca,'CLim',handles.clim)

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
function edit7_Callback(hObject, eventdata, handles) % 'Max'
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.clim(2) = str2double(get(hObject,'String'));

if not(isnumeric(handles.im_hist))
    
    lim = [min(handles.im_data(:)) max(handles.im_data(:))];
    clims = [str2double(get(handles.edit6,'String'))...
        str2double(get(handles.edit7,'String'))];

    axes(handles.axes3)
    
    x = linspace(lim(1),lim(2),256);
    y = 1:10;
    cmapbar = repmat(x,10,1);   
    
    if clims(2) < lim(2)
        idx = find(x > clims(2),1);
        cmapbar(:,idx:end) = cmapbar(1,idx);
    end

    if clims(1) > lim(1)
        idx = find(x > clims(1),1);
        cmapbar(:,1:idx) = cmapbar(1,idx);
    end
    
    imagesc(x,y,cmapbar)
    
    
    if clims(1) < lim(1)
        c = get(gca,'clim');
        set(gca,'clim',[clims(1) c(2)])
    end

    if clims(2) > lim(2)
        c = get(gca,'clim');
        set(gca,'clim',[c(1) clims(2)])
    end
    
    set(gca,'Fontsize',14,'YTick',[])
    
end

axes(handles.axes1)
set(gca,'CLim',handles.clim)

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton6. 'Auto range'
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.clim(1) = min(handles.im_data(:));
handles.clim(2) = max(handles.im_data(:));

set(handles.edit6,'String',num2str(handles.clim(1)))
set(handles.edit7,'String',num2str(handles.clim(2)))

axes(handles.axes1)
set(gca,'CLim',handles.clim)

if not(isnumeric(handles.im_hist))
    
    lim = [min(handles.im_data(:)) max(handles.im_data(:))];
    
    axes(handles.axes3)
    
    x = linspace(lim(1),lim(2),256);
    y = 1:10;
    cmapbar = repmat(x,10,1);   
    imagesc(x,y,cmapbar)
        
    set(gca,'Fontsize',14,'YTick',[])
    
end

guidata(hObject,handles)



% =========================================================================
% =========================================================================
% --- Executes on slider movement. 'yscale'
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(hObject,'Value')
    
    set(handles.axes2,'YScale','linear')
    axes(handles.axes2)
    ylim('auto')
    
else
    
    set(handles.axes2,'YScale','log')
    counts_max = get(handles.axes2,'YLim');
    set(handles.axes2,'YLim',[0.5,counts_max(2)])
    
end

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% =========================================================================
% =========================================================================
function edit9_Callback(hObject, eventdata, handles) % 'threshold'
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

t = str2double(get(hObject,'String'));
hl = get(handles.checkbox1,'Value');
handles.previous = handles.im_data;

if get(handles.checkbox4,'Value')
    handles.im_data = sp_removeoutliers(handles.im_data,t,hl,handles.mask);
else
    handles.im_data = sp_removeoutliers(handles.im_data,t,hl);
end
handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
set(handles.edit6,'String',num2str(handles.clim(1)))
set(handles.edit7,'String',num2str(handles.clim(2)))

guidata(hObject,handles)

sp_gui_updateimobject(hObject,eventdata,handles)

if not(isnumeric(handles.im_hist))
    sp_gui_generatehistogram(hObject,eventdata,handles);
end

if get(handles.checkbox3,'Value')
    fid = fopen(handles.fid,'at');
    fprintf(fid,'%% -------------------------------------------------');
    fprintf(fid,'\n');
    if ~get(handles.checkbox4,'Value')
        fprintf(fid,'im_data = sp_removeoutliers(im_data,%.4f,%i);\n',t,hl);
    else
        fprintf(fid,'im_data = sp_removeoutliers(im_data,%.4f,%i,mask);\n',t,hl);
    end
    fprintf(fid,'\n');
    fclose(fid);
end

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% =========================================================================
% =========================================================================
% --- Executes on button press in togglebutton11. 'Mask'
function togglebutton11_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton11

cmap = get(handles.popupmenu4,'String');
% handles.mask = zeros(size(handles.im_data));

if get(hObject,'Value')

    handles.subgui = sp_gui_mask(handles.im_data,handles.r,...
        cmap{get(handles.popupmenu4,'Value')},...
        get(handles.popupmenu1,'Value'),...
        handles.x,handles.y,handles.mask,...
        get(handles.checkbox3,'Value'),handles.fid);
    guidata(hObject,handles);
    
else
    
    handles.mask = get(handles.subgui,'UserData');
%     figure, imagesc(handles.mask); colormap gray; axis image
    delete(handles.subgui);
    handles.subgui = 0;
    handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
    
    guidata(hObject,handles)
    
    sp_gui_updateimobject(hObject,eventdata,handles)
    sp_gui_generatehistogram(hObject,eventdata,handles)
    
end



% =========================================================================
% =========================================================================
% --- Executes on button press in checkbox2. 'Show mask'
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2

sp_gui_updateimobject(hObject,eventdata,handles)



% =========================================================================
% =========================================================================
function sp_gui_generatehistogram(hObject, eventdata, handles)

handles = guidata(hObject);

axes(handles.axes2)
if get(handles.radiobutton3,'Value')

    handles.im_hist = histogram(handles.axes2,handles.im_data(:),...
            'FaceColor',[0 0 0],'EdgeColor',[0.5 0.5 0.5]);    
    lim = [min(handles.im_data(:)) max(handles.im_data(:))];

elseif get(handles.radiobutton4,'Value')
    
    idx = find(handles.mask);
    handles.im_hist = histogram(handles.axes2,handles.im_data(idx),...
            'FaceColor',[0 0 0],'EdgeColor',[0.5 0.5 0.5]);    
    lim = [min(handles.im_data(idx)) max(handles.im_data(idx))];
    
else
    
    idx = find(1-handles.mask);
    handles.im_hist = histogram(handles.axes2,handles.im_data(idx),...
            'FaceColor',[0 0 0],'EdgeColor',[0.5 0.5 0.5]);    
    lim = [min(handles.im_data(idx)) max(handles.im_data(idx))];
    
end

cmap = get(handles.popupmenu4,'String');
cmap = cmap{get(handles.popupmenu4,'Value')};
set(gca,'Fontsize',14,'XTick',[])
ylabel('Counts')
xlim(lim)

if ~get(handles.slider1,'Value')
    set(handles.axes2,'YScale','log')
    counts_max = get(handles.axes2,'YLim');
    set(handles.axes2,'YLim',[0.5,counts_max(2)])
end

axes(handles.axes3)
x = linspace(lim(1),lim(2),256);
y = 1:10;
cmapbar = repmat(x,10,1);

clims = handles.clim;
 
if clims(2) < lim(2)
    idx = find(x > clims(2),1);
    cmapbar(:,idx:end) = cmapbar(1,idx);
end

if clims(1) > lim(1)
    idx = find(x > clims(1),1);
    cmapbar(:,1:idx) = cmapbar(1,idx);
end

imagesc(x,y,cmapbar);
colormap(handles.axes3,cmap)
set(handles.axes3,'FontSize',14,'YTick',[])
xlabel('Value')

if clims(1) < lim(1)
    c = get(gca,'clim');
    set(gca,'clim',[clims(1) c(2)])
end

if clims(2) > lim(2)
    c = get(gca,'clim');
    set(gca,'clim',[c(1) clims(2)])
end



% =========================================================================
% =========================================================================
function sp_gui_updateimobject(hObject, eventdata, handles)

handles = guidata(hObject);

axes(handles.axes1)
cla
handles.im_object = imshow(handles.im_data,handles.r,...
                         handles.clim,'Parent',handles.axes1);
                     
if (get(handles.togglebutton1,'Value'))
   set(handles.im_object,'ButtonDownFcn',...
                        {@sp_gui_getimprofile,handles})
end

set(gca,'fontsize',14)
axis tight
axis equal
colorbar('location','southoutside')
cmap = cellstr(get(handles.popupmenu4,'String'));
cmap = cmap{get(handles.popupmenu4,'Value')};
colormap(handles.axes1,cmap)

if get(handles.togglebutton2,'Value')
    
    hold on
    
    if ~isnumeric(handles.edge_plot)
        delete(handles.edge_plot)
    end
    
    handles.edge_plot = plot(handles.edge_path{1},...
        handles.edge_path{2},'--k');
    
end

if get(handles.checkbox2,'Value')
    
    hold on
    green = cat(3, zeros(size(handles.mask)),... 
        handles.mask, zeros(size(handles.mask)));
    handles.mask_im_object = imshow(green,handles.r,...
                             'Parent',handles.axes1);
    hold off
    set(handles.mask_im_object,'AlphaData',0.35*handles.mask)
    
end

guidata(hObject,handles)





% =========================================================================
% =========================================================================
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
0;


% =========================================================================
% =========================================================================
function file_exp2fig_Callback(hObject, eventdata, handles)
% hObject    handle to file_exp2fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure
imshow(handles.im_data,handles.r, handles.clim);
set(gca,'fontsize',14)
axis tight
axis equal
colorbar('location','southoutside')
cmap = cellstr(get(handles.popupmenu4,'String'));
cmap = cmap{get(handles.popupmenu4,'Value')};
colormap(gca,cmap)


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1. 'Outliers - high'
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

if get(hObject,'Value')
    set(handles.radiobutton6,'Value',0)
end
    
% --- Executes on button press in radiobutton3. 'Ignore mask'
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3

set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
sp_gui_generatehistogram(hObject,eventdata,handles)

% --- Executes on button press in radiobutton4. 'Include mask'
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4

set(handles.radiobutton3,'Value',0)
set(handles.radiobutton5,'Value',0)
sp_gui_generatehistogram(hObject,eventdata,handles)


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5

set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
sp_gui_generatehistogram(hObject,eventdata,handles)


% --------------------------------------------------------------------
function file_mask_Callback(hObject, eventdata, handles)
% hObject    handle to file_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function file_mask_save_Callback(hObject, eventdata, handles)
% hObject    handle to file_mask_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,path] = uiputfile('*.mat','Save mask');
a = handles.mask; %#ok<NASGU>
save(strcat(path,filename),'a');

% --------------------------------------------------------------------
function file_mask_load_Callback(hObject, eventdata, handles)
% hObject    handle to file_mask_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,path] = uigetfile('*.mat','Load mask');
handles.mask = load(strcat(path,filename));
handles.mask = handles.mask.a;

guidata(hObject,handles)

sp_gui_updateimobject(hObject,eventdata,handles)
sp_gui_generatehistogram(hObject,eventdata,handles)


% --------------------------------------------------------------------
function file_mask_show_Callback(hObject, eventdata, handles)
% hObject    handle to file_mask_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure
imshow(handles.mask,handles.r);
set(gca,'fontsize',14)
axis tight
axis equal
colormap gray


% --- Executes on button press in checkbox3. 'Save'
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3

if get(hObject,'Value')
    
    if isnumeric(handles.fid)
        [fid,path] = uiputfile('*.m','Save filen name');
        handles.fid = strcat(path,fid);
    end
    
end

guidata(hObject,handles)
    
% --- Executes on button press in pushbutton11. 'Undo'
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.im_data = handles.previous;

guidata(hObject,handles)

sp_gui_updateimobject(hObject,eventdata,handles)

if get(handles.checkbox3,'Value')
    fid = fopen(handles.fid,'at');
    fprintf(fid,'%% UNDO last step\n\n');
    fclose(fid);
end


% --------------------------------------------------------------------
function file_save_Callback(hObject, ~, handles)
% hObject    handle to file_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fid,path] = uiputfile('*.m','Save filen name');
handles.fid = strcat(path,fid);

guidata(hObject,handles)
        


% --- Executes on button press in radiobutton6. 'Outliers - low'
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6

if get(hObject,'Value')
    set(handles.checkbox1,'Value',0)
end

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in pushbutton17. 'rotate clockwise'
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.previous = handles.im_data;
handles.im_data = fliplr(transpose(handles.im_data));
handles.mask = fliplr(transpose(handles.mask));

IEIX = handles.r.XWorldLimits;
IEIY = handles.r.YWorldLimits;

handles.r.ImageSize = fliplr(handles.r.ImageSize);
handles.r.XWorldLimits = IEIY;
handles.r.YWorldLimits = IEIX;

x = handles.x;
y = handles.y; 

handles.x = y;
handles.y = x;

guidata(hObject,handles)

sp_gui_updateimobject(hObject, eventdata, handles)

% --- Executes on button press in pushbutton18. 'rotate c-clockwise'
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.previous = handles.im_data;
handles.im_data = transpose(fliplr(handles.im_data));
handles.mask = transpose(fliplr(handles.mask));

IEIX = handles.r.XWorldLimits;
IEIY = handles.r.YWorldLimits;

handles.r.ImageSize = fliplr(handles.r.ImageSize);
handles.r.XWorldLimits = IEIY;
handles.r.YWorldLimits = IEIX;

x = handles.x;
y = handles.y; 

handles.x = y;
handles.y = x;

guidata(hObject,handles)

sp_gui_updateimobject(hObject, eventdata, handles)

