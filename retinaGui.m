function varargout = retinaGui(varargin)
% RETINAGUI MATLAB code for retinaGui.fig
%      RETINAGUI, by itself, creates a new RETINAGUI or raises the existing
%      singleton*.
%
%      H = RETINAGUI returns the handle to a new RETINAGUI or the handle to
%      the existing singleton*.
%
%      RETINAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RETINAGUI.M with the given input arguments.
%
%      RETINAGUI('Property','Value',...) creates a new RETINAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before retinaGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to retinaGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help retinaGui

% Last Modified by GUIDE v2.5 20-Jun-2018 14:24:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @retinaGui_OpeningFcn, ...
    'gui_OutputFcn',  @retinaGui_OutputFcn, ...
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


% --- Executes just before retinaGui is made visible.
function retinaGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to retinaGui (see VARARGIN)

% Choose default command line output for retinaGui
handles.output = hObject;

handles.in_vid_path = '';
handles.height = 0;
set(handles.height_txt,'String',num2str(handles.height));
handles.width = 0;
set(handles.width_txt,'String',num2str(handles.width));
handles.nFrames = 0;
set(handles.nFrames_txt,'String',num2str(handles.nFrames));
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

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes retinaGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = retinaGui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in run_button.
function run_button_Callback(hObject, eventdata, handles)
% hObject    handle to run_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

enDiv = 0; %partion filtering
divMode = [4 1; 2 1; 4 1;1 3];
in_vid_path = '../example_video/fil_cat.avi';
deadpix_PR = 1-handles.deadpix_PR;
satpix_PR = 1-handles.satpix_PR;

[ i_vid, s_vid, st_vid, rgb_vid ] = retina_model( in_vid_path, handles.height, handles.width,...
    handles.nFrames, handles.filtMode, handles.sh_mode, enDiv, divMode, handles.size, handles.std, ...
    handles.t1_mean, handles.t2_mean, handles.t1_var, handles.t2_var, handles.fpn_mean, handles.fpn_var, ...
    deadpix_PR, satpix_PR, 0, 0 );

fprintf('filter mode = %d\n',handles.filtMode);
fprintf('gaussian std = %d\n',handles.std);
fprintf('gaussian size = %d\n', handles.size);
set(handles.in_axes,'Xtick',[]);
set(handles.in_axes,'Ytick',[]);
set(handles.spatial_axes,'Xtick',[]);
set(handles.spatial_axes,'Ytick',[]);
set(handles.st_axes,'Xtick',[]);
set(handles.st_axes,'Ytick',[]);
for ii = 1:handles.nFrames
    imagesc(i_vid(:,:,ii), 'Parent',handles.in_axes);
    imagesc(s_vid(:,:,ii), 'Parent',handles.spatial_axes);
    imagesc(st_vid(:,:,ii), 'Parent',handles.st_axes);
    colormap(gray);
    pause(1/20);
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



function nFrames_txt_Callback(hObject, eventdata, handles)
% hObject    handle to nFrames_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nFrames_txt as text
%        str2double(get(hObject,'String')) returns contents of nFrames_txt as a double
handles.nFrames = str2double(get(hObject,'String'));
guidata(hObject,handles);




% --- Executes during object creation, after setting all properties.
function nFrames_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nFrames_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% function in_vid_txt_Callback(hObject, eventdata, handles)
% % hObject    handle to in_vid_txt (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%
% % Hints: get(hObject,'String') returns contents of in_vid_txt as text
% %        str2double(get(hObject,'String')) returns contents of in_vid_txt as a double
% handles.in_vid_path = get(hObject,'String');
% guidata(hObject,handles);
%
%
% % --- Executes during object creation, after setting all properties.
% function in_vid_txt_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to in_vid_txt (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
%
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



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
