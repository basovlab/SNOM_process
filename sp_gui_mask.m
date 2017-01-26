function varargout = sp_gui_mask(varargin)
% SP_GUI_MASK MATLAB code for sp_gui_mask.fig
%      SP_GUI_MASK, by itself, creates a new SP_GUI_MASK or raises the existing
%      singleton*.
%
%      H = SP_GUI_MASK returns the handle to a new SP_GUI_MASK or the handle to
%      the existing singleton*.
%
%      SP_GUI_MASK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SP_GUI_MASK.M with the given input arguments.
%
%      SP_GUI_MASK('Property','Value',...) creates a new SP_GUI_MASK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sp_gui_mask_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sp_gui_mask_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sp_gui_mask

% Last Modified by GUIDE v2.5 09-Aug-2016 22:12:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sp_gui_mask_OpeningFcn, ...
                   'gui_OutputFcn',  @sp_gui_mask_OutputFcn, ...
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


% --- Executes just before sp_gui_mask is made visible.
function sp_gui_mask_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sp_gui_mask (see VARARGIN)

% Choose default command line output for sp_gui_mask
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sp_gui_mask wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% read data passed from main GUI
handles.im_data = varargin{1}; 
handles.r = varargin{2}; 
handles.cmap = varargin{3};
handles.topo = varargin{4};
handles.x = varargin{5};
handles.y = varargin{6};
handles.clim = [min(handles.im_data(:)) max(handles.im_data(:))];
handles.mask = varargin{7}; 
handles.previous = handles.mask;
handles.save = varargin{8};
handles.fid = varargin{9};

% show image and mask
axes(handles.axes1)
handles.im_object = imshow(handles.im_data,handles.r,[]);
colormap(handles.axes1,handles.cmap);
set(gca,'fontsize',14)
axis image
colorbar('location','southoutside')

hold on
green = cat(3, zeros(size(handles.mask)),... 
    handles.mask, zeros(size(handles.mask)));
handles.mask_im_object = imshow(green,handles.r,...
                         'Parent',handles.axes1);
hold off
set(handles.mask_im_object,'AlphaData',0.35*handles.mask)
set(hObject,'UserData',varargin{1});

set(handles.edit1,'String',num2str(handles.clim(2)))
set(handles.edit4,'String',num2str(handles.clim(1)))
set(handles.edit6,'String',num2str(min(handles.im_data(:))))
set(handles.edit7,'String',num2str(max(handles.im_data(:))))

guidata(hObject, handles)


% --- Outputs from this function are returned to the command line.
function varargout = sp_gui_mask_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, ~, ~) %#ok<*DEFNU>
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(hObject);



% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton1. 'Rectangle'
function pushbutton1_Callback(hObject, eventdata, handles) % 'do something'
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.previous = handles.mask;
rect = getrect(handles.axes1);

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

if get(handles.radiobutton1,'Value')
    handles.mask(rect(1):rect(2),rect(3):rect(4)) = 1;
    if handles.save
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------');
        fprintf(fid,'\nmask(%i:%i,%i:%i) = 1;\n\n',rect);
        fclose(fid);
    end
else
    handles.mask(rect(1):rect(2),rect(3):rect(4)) = 0;
    if handles.save
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------');
        fprintf(fid,'\nmask(%i:%i,%i:%i) = 0;\n\n',rect);
        fclose(fid);
    end
end
guidata(hObject,handles)

sp_gui_updateimobject(hObject,eventdata,handles)

set(handles.output,'UserData',handles.mask)



% =========================================================================
% =========================================================================
function edit1_Callback(hObject, eventdata, handles) % 'High'
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

handles.previous = handles.mask;
if isnumeric(str2double(get(hObject,'String')))
    if get(handles.radiobutton1,'Value')
        handles.mask(handles.im_data > str2double(get(hObject,'String'))) = 1;
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% -------------------------------------------------');
            fprintf(fid,'\nmask(im_data > %.4f) = 1;\n\n',str2double(get(hObject,'String')));
            fclose(fid);
        end
    else
        handles.mask(handles.im_data > str2double(get(hObject,'String'))) = 0;
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% -------------------------------------------------');
            fprintf(fid,'\nmask(im_data > %.4f) = 0;\n\n',str2double(get(hObject,'String')));
            fclose(fid);
        end
    end
end

guidata(hObject,handles)

sp_gui_updateimobject(hObject,eventdata,handles)

set(handles.output,'UserData',handles.mask)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, ~, ~)
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
function edit4_Callback(hObject, eventdata, handles) % 'Low'
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double

% exclude = find(data_scratch(y1:y2,x1:x2) > str2double(get(handles.edit7,'String')));

handles.previous = handles.mask;
if isnumeric(str2double(get(hObject,'String')))
    if get(handles.radiobutton1,'Value')
        handles.mask(handles.im_data < str2double(get(hObject,'String'))) = 1;
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% -------------------------------------------------');
            fprintf(fid,'\nmask(im_data < %.4f) = 1;\n\n',str2double(get(hObject,'String')));
            fclose(fid);
        end
    else
        handles.mask(handles.im_data < str2double(get(hObject,'String'))) = 0;
        if handles.save
            fid = fopen(handles.fid,'at');
            fprintf(fid,'%% -------------------------------------------------');
            fprintf(fid,'\nmask(im_data < %.4f) = 0;\n\n',str2double(get(hObject,'String')));
            fclose(fid);
        end
    end
end

guidata(hObject,handles)

sp_gui_updateimobject(hObject,eventdata,handles)

set(handles.output,'UserData',handles.mask)

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, ~, ~)
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
function edit6_Callback(hObject, ~, handles) % 'Min'
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
function edit6_CreateFcn(hObject, ~, ~)
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
function edit7_Callback(hObject, ~, handles) % 'Max'
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
function edit7_CreateFcn(hObject, ~, ~)
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

handles.mask = handles.previous;

guidata(hObject,handles)

sp_gui_updateimobject(hObject,eventdata,handles)

set(handles.output,'UserData',handles.mask)


% =========================================================================
% =========================================================================
% --- Executes on button press in pushbutton8. 'Reset'
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.previous = handles.mask;
handles.mask = zeros(size(handles.im_data));

guidata(hObject,handles)

sp_gui_updateimobject(hObject,eventdata,handles)


if handles.save
    fid = fopen(handles.fid,'at');
    fprintf(fid,'%% -------------------------------------------------');
    fprintf(fid,'\nmask = zeros(size(im_data));\n\n');
    fclose(fid);
end

set(handles.output,'UserData',handles.mask)



% =========================================================================
% =========================================================================
% --- Executes on button press in radiobutton1. 'Add'
function radiobutton1_Callback(~, ~, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.radiobutton2,'Value',0)


% --- Executes on button press in radiobutton2. 'Subtract'
function radiobutton2_Callback(~, ~, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2

set(handles.radiobutton1,'Value',0)



% =========================================================================
% =========================================================================
function sp_gui_updateimobject(hObject, ~, ~)

handles = guidata(hObject);

axes(handles.axes1)
cla
handles.im_object = imshow(handles.im_data,handles.r,...
                         handles.clim,'Parent',handles.axes1);
                     
handles.clim = [str2double(get(handles.edit6,'String'))...
    str2double(get(handles.edit7,'String'))];
set(gca,'CLim',handles.clim)
set(gca,'fontsize',14)
axis tight
axis equal
colorbar('location','southoutside')

hold on
green = cat(3, zeros(size(handles.mask)),... 
    handles.mask, zeros(size(handles.mask)));
handles.mask_im_object = imshow(green,handles.r,...
                         'Parent',handles.axes1);
hold off
set(handles.mask_im_object,'AlphaData',0.35*handles.mask)

guidata(hObject,handles)


% --- Executes on button press in pushbutton9. 'Region'
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.previous = handles.mask;
[x,y] = getline;

x = round(x/handles.r.PixelExtentInWorldX);
y = round(y/handles.r.PixelExtentInWorldY);

if get(handles.radiobutton3,'Value')
    direction = 'right';
else
    direction = 'left';
end

if get(handles.radiobutton1,'Value')
    add = 1;
else
    add = 0;
end

if length(x) == 2
    
    handles.mask = sp_lrmask(handles.mask,x,y,direction,add);
    
    if handles.save
        fid = fopen(handles.fid,'at');
        fprintf(fid,'%% -------------------------------------------------');
        fprintf(fid,'\nmask = sp_lrmask(mask,[%i %i],[%i %i],''%s'',%i);\n\n',...
            x(1),x(2),y(1),y(2),direction,add);
        fclose(fid);
    end

else
    
    msgbox('Choose a channel')

end

guidata(hObject,handles);

sp_gui_updateimobject(hObject, eventdata, handles);

set(handles.output,'UserData',handles.mask)


