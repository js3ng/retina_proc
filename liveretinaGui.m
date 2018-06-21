function varargout = liveretinaGui(varargin)
%LIVERETINAGUI MATLAB code file for liveretinaGui.fig
%      LIVERETINAGUI, by itself, creates a new LIVERETINAGUI or raises the existing
%      singleton*.
%
%      H = LIVERETINAGUI returns the handle to a new LIVERETINAGUI or the handle to
%      the existing singleton*.
%
%      LIVERETINAGUI('Property','Value',...) creates a new LIVERETINAGUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to liveretinaGui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      LIVERETINAGUI('CALLBACK') and LIVERETINAGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in LIVERETINAGUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help liveretinaGui

% Last Modified by GUIDE v2.5 20-Jun-2018 16:53:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @liveretinaGui_OpeningFcn, ...
                   'gui_OutputFcn',  @liveretinaGui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before liveretinaGui is made visible.
function liveretinaGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for liveretinaGui
handles.output = hObject;
handles.height = 0;
set(handles.height_txt,'String',num2str(handles.height));
handles.width = 0;
set(handles.width_txt,'String',num2str(handles.width));
% handles.filtMode = 2;
handles.sh_mode = 1;
% handles.size = 7;
% handles.std = 2;
handles.t1_mean = 10;
handles.t2_mean = -10;
handles.t1_var = 0;
handles.t2_var = 0;
handles.fpn_mean = 0;
handles.fpn_var = 0;
handles.deadpix_PR = 0.001;
handles.satpix_PR = 0.001;
set(handles.in_axes,'Xtick',[]);
set(handles.in_axes,'Ytick',[]);
set(handles.spatial_axes,'Xtick',[]);
set(handles.spatial_axes,'Ytick',[]);
set(handles.st_axes,'Xtick',[]);
set(handles.st_axes,'Ytick',[]);
handles.cam = webcam;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes liveretinaGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = liveretinaGui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
contents = cellstr(get(hObject,'String'));
display(contents);
display(contents{get(hObject,'Value')});
if string(contents{get(hObject,'Value')}) == 'LPF'
    handles.sh_mode = 1;
elseif string(contents{get(hObject,'Value')}) == 'HPF'
    handles.sh_mode = 2;
elseif string(contents{get(hObject,'Value')}) == 'NF'
    handles.sh_mode = 3;
end

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function size_txt_Callback(hObject, eventdata, handles)
% hObject    handle to size_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of size_txt as text
%        str2double(get(hObject,'String')) returns contents of size_txt as a double
handles.size = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function size_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function std_txt_Callback(hObject, eventdata, handles)
% hObject    handle to std_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of std_txt as text
%        str2double(get(hObject,'String')) returns contents of std_txt as a double
handles.std = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function std_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to std_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
contents = cellstr(get(hObject,'String'));
display(contents);
display(contents{get(hObject,'Value')});
if string(contents{get(hObject,'Value')}) == 'Gaussian'
    handles.filtMode = 2;
elseif string(contents{get(hObject,'Value')}) == '4NN'
    handles.filtMode = 3;
elseif string(contents{get(hObject,'Value')}) == '9NN'
    handles.filtMode = 1;
end

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function fpn_mean_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fpn_mean_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.fpn_mean = get(hObject,'Value');
set(handles.fpn_mean_txt,'String',num2str(handles.fpn_mean));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function fpn_mean_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fpn_mean_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fpn_var_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fpn_var_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.fpn_var = get(hObject,'Value');
set(handles.fpn_var_txt,'String',num2str(handles.fpn_var));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function fpn_var_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fpn_var_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function fpn_mean_txt_Callback(hObject, eventdata, handles)
% hObject    handle to fpn_mean_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fpn_mean_txt as text
%        str2double(get(hObject,'String')) returns contents of fpn_mean_txt as a double


% --- Executes during object creation, after setting all properties.
function fpn_mean_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fpn_mean_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fpn_var_txt_Callback(hObject, eventdata, handles)
% hObject    handle to fpn_var_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fpn_var_txt as text
%        str2double(get(hObject,'String')) returns contents of fpn_var_txt as a double


% --- Executes during object creation, after setting all properties.
function fpn_var_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fpn_var_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function dead_slider_Callback(hObject, eventdata, handles)
% hObject    handle to dead_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.deadpix_PR = get(hObject,'Value');
set(handles.dead_pix_text,'String',num2str(handles.deadpix_PR));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function dead_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dead_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sat_slider_Callback(hObject, eventdata, handles)
% hObject    handle to sat_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.satpix_PR = get(hObject,'Value');
set(handles.sat_pix_text,'String',num2str(handles.satpix_PR));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function sat_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sat_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function dead_pix_text_Callback(hObject, eventdata, handles)
% hObject    handle to dead_pix_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dead_pix_text as text
%        str2double(get(hObject,'String')) returns contents of dead_pix_text as a double


% --- Executes during object creation, after setting all properties.
function dead_pix_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dead_pix_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sat_pix_text_Callback(hObject, eventdata, handles)
% hObject    handle to sat_pix_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sat_pix_text as text
%        str2double(get(hObject,'String')) returns contents of sat_pix_text as a double


% --- Executes during object creation, after setting all properties.
function sat_pix_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sat_pix_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function t1_mean_slider_Callback(hObject, eventdata, handles)
% hObject    handle to t1_mean_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.t1_mean = get(hObject,'Value');
set(handles.t1_mean_txt,'String',num2str(handles.t1_mean));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function t1_mean_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1_mean_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function t1_var_slider_Callback(hObject, eventdata, handles)
% hObject    handle to t1_var_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.t1_var = get(hObject,'Value');
set(handles.t1_var_txt,'String',num2str(handles.t1_var));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function t1_var_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1_var_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function t2_mean_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to t2_mean_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.t2_mean = get(hObject,'Value');
set(handles.t2_mean_txt,'String',num2str(handles.t2_mean));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function t2_mean_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2_mean_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function t2_var_slider_Callback(hObject, eventdata, handles)
% hObject    handle to t2_var_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.t2_var = get(hObject,'Value');
set(handles.t2_var_txt,'String',num2str(handles.t2_var));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function t2_var_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2_var_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function t1_var_txt_Callback(hObject, eventdata, handles)
% hObject    handle to t1_var_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1_var_txt as text
%        str2double(get(hObject,'String')) returns contents of t1_var_txt as a double


% --- Executes during object creation, after setting all properties.
function t1_var_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1_var_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t2_mean_txt_Callback(hObject, eventdata, handles)
% hObject    handle to t2_mean_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t2_mean_txt as text
%        str2double(get(hObject,'String')) returns contents of t2_mean_txt as a double


% --- Executes during object creation, after setting all properties.
function t2_mean_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2_mean_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t2_var_txt_Callback(hObject, eventdata, handles)
% hObject    handle to t2_var_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t2_var_txt as text
%        str2double(get(hObject,'String')) returns contents of t2_var_txt as a double


% --- Executes during object creation, after setting all properties.
function t2_var_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2_var_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t1_mean_txt_Callback(hObject, eventdata, handles)
% hObject    handle to t1_mean_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1_mean_txt as text
%        str2double(get(hObject,'String')) returns contents of t1_mean_txt as a double


% --- Executes during object creation, after setting all properties.
function t1_mean_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1_mean_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function height_txt_Callback(hObject, eventdata, handles)
% hObject    handle to height_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of height_txt as text
%        str2double(get(hObject,'String')) returns contents of height_txt as a double
handles.height = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function height_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to height_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function width_txt_Callback(hObject, eventdata, handles)
% hObject    handle to width_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of width_txt as text
%        str2double(get(hObject,'String')) returns contents of width_txt as a double
handles.width = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function width_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to width_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in toggle_start.
function toggle_start_Callback(hObject, eventdata, handles)
% hObject    handle to toggle_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of toggle_start
set(handles.in_axes,'Xtick',[]);
set(handles.in_axes,'Ytick',[]);
set(handles.spatial_axes,'Xtick',[]);
set(handles.spatial_axes,'Ytick',[]);
set(handles.st_axes,'Xtick',[]);
set(handles.st_axes,'Ytick',[]);
imHeight = handles.height;
imWidth = handles.width;
vidSize = [imHeight imWidth];
deadpix_PR = 1-handles.deadpix_PR;
satpix_PR = 1-handles.satpix_PR;
thresh1_arr = normrnd(handles.t1_mean,handles.t1_var, vidSize);
thresh2_arr = normrnd(handles.t2_mean,handles.t2_var, vidSize);
filtMode = handles.filtMode;
sh_mode = handles.sh_mode;
enDiv = 0;
divMode = zeros(4,2);
gaussSize = handles.size;
std = handles.std;
%pixel nu
pix_mean = handles.fpn_mean;
pix_var = handles.fpn_var;
pix_nu = normrnd(pix_mean,pix_var, vidSize); 
%dead/sat pixels
deadPix=zeros(vidSize);
r=rand(vidSize);
deadPix = (r<(1-deadpix_PR)/2);
satPix=zeros(vidSize);
r=rand(vidSize);
satPix = (r<(1-satpix_PR)/2);
init_spatial = rand(imHeight, imWidth)*255;
spatial_past = init_spatial;

while get(hObject,'Value') == 1.0
    rgbImage = snapshot(handles.cam);
    grayImage = double(rgb2gray(rgbImage));
    [ ~,s_f, i_f, rbg_f ] = live_retina_model( grayImage, spatial_past, imHeight, ...
        imWidth, filtMode, ...
        sh_mode, enDiv, divMode, gaussSize, std, thresh1_arr, ...
        thresh2_arr, pix_nu, deadPix, satPix );
    imagesc(i_f, 'Parent',handles.in_axes);
    imagesc(s_f, 'Parent',handles.spatial_axes);
    imagesc(rbg_f, 'Parent',handles.st_axes);
    colormap(gray);
    drawnow;
    spatial_past = s_f;
end
