function varargout = Conteo_poros(varargin)
% CONTEO_POROS MATLAB code for Conteo_poros.fig
%      CONTEO_POROS, by itself, creates a new CONTEO_POROS or raises the existing
%      singleton*.
%
%      H = CONTEO_POROS returns the handle to a new CONTEO_POROS or the handle to
%      the existing singleton*.
%
%      CONTEO_POROS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTEO_POROS.M with the given input arguments.
%
%      CONTEO_POROS('Property','Value',...) creates a new CONTEO_POROS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Conteo_poros_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Conteo_poros_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Conteo_poros

% Last Modified by GUIDE v2.5 07-Dec-2020 11:38:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Conteo_poros_OpeningFcn, ...
                   'gui_OutputFcn',  @Conteo_poros_OutputFcn, ...
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


% --- Executes just before Conteo_poros is made visible.
function Conteo_poros_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Conteo_poros (see VARARGIN)

% Choose default command line output for Conteo_poros
handles.output = hObject;
global tres angle
tres=0;
angle=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Conteo_poros wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Conteo_poros_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
global imagen_gris im_salida im
global N M g s a v k c

[path,user_cance]=imgetfile();
if user_cance
    msgbox(sprintf('Error'),'Error','Error');
    return
end
im = uint8(imread(path));

[N,M] = size(im); %mira el tamaño de la imagen 
im_salida = ones(N,M); %crea un fondo blanco del tamaño de la imagen
g = ones(N,M);
s = ones(N,M);
a = ones(N,M);
v = ones(N,M);
k = ones(N,M);
c = ones(N,M);
% hObject    handle to busquela (see GCBO)


axes(handles.axes2);
imshow(im);
rgbimg = repmat(im, [1 1 3]);
imagen_gris = rgb2gray(rgbimg);

axes(handles.axes1)
imshow(imagen_gris)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider_binarizacion_Callback(hObject, eventdata, handles)
global imagen_gris1 im_salida selecionadorc selecionadort
global N M tres 

% hObject    handle to slider_binarizacion (see GCBO)
tres = get(handles.slider_binarizacion,'Value');
if (selecionadorc == '1' && selecionadort =='0')
for i=1:1:N
    for j=1:1:M
        if(imagen_gris1(i,j) < tres)
           im_salida(i,j)=0;
        else
            im_salida(i,j)=1;
        end
    end
end
end
if (selecionadorc == '0' && selecionadort =='1')
for i=1:1:N
    for j=1:1:M
        if(imagen_gris1(i,j) < tres)
           im_salida(i,j)=1;
        else
            im_salida(i,j)=0;
        end
    end
end
end
axes(handles.axes1)
imshow(im_salida)
title('binario')
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_binarizacion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_binarizacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_brillo_Callback(hObject, eventdata, handles)
% hObject    handle to slider_brillo (see GCBO)
global imagen_gris1
global brillo
global contraste
brillo = (get(handles.slider_brillo,'value')-0.5)*40;%brillo está dado con valores de 0 a 1
contraste = get(handles.slider_contraste,'value')*2;
axes(handles.axes1)

imshow(imagen_gris1*contraste+brillo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_brillo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_brillo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_contraste_Callback(hObject, eventdata, handles)
% hObject    handle to slider_contraste (see GCBO)
global imagen_gris1
global brillo
global contraste
brillo = (get(handles.slider_brillo,'value')-0.5)*40;%brillo está dado con valores de 0 a 1
contraste = get(handles.slider_contraste,'value')*2;
axes(handles.axes1)

imshow(imagen_gris1*contraste+brillo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_contraste_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_contraste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_rotacion_Callback(hObject, eventdata, handles)
% hObject    handle to slider_rotacion (see GCBO)
global imagen_gris
global imagen_gris1
global im imr
global angle

angle=(180*(get(handles.slider_rotacion,'value')))-90;

imagen_gris1 = imrotate(imagen_gris1,angle,'bicubic','crop');

axes(handles.axes1)
imshow(imagen_gris1)
axes(handles.axes3)
imshow(imagen_gris1)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_rotacion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_rotacion (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in CAJITAS.
function CAJITAS_Callback(hObject, eventdata, handles)
% hObject    handle to CAJITAS (see GCBO)
global im_salida imagen_gris1 acumulador1 acumulador2

img_bw=bwlabel(im_salida);
axes(handles.axes3)
imshow(imagen_gris1)
propiedades = regionprops(img_bw)

acumulador1=0;
acumulador2=0;
l=0;
for k=1 : length(propiedades)
    if(propiedades(k).Area>100)       
    caja = propiedades(k).BoundingBox
    rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','b','LineWidth',1)
    mensaje=questdlg('¿Lo sumo?','sumar', 'Si', 'No', 'No');
    if strcmp(mensaje,'Si')
        rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','g','LineWidth',1)  
        acumulador1=(acumulador1+(caja(3)))
        acumulador2=(acumulador2+(caja(4)))
        l=l+1
    else
        rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','r','LineWidth',1)
    end
    else
    end
end
set(handles.edit7,'string',l);
acumulador1=acumulador1/l;
acumulador2=acumulador2/l;
set(handles.edit1,'string',acumulador1);
set(handles.edit2,'string',acumulador2);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in CUANTO.
function CUANTO_Callback(hObject, eventdata, handles)
% hObject    handle to CUANTO (see GCBO)

dis = imdistline

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
global dis1 acumulador1 acumulador2
dis1 =  str2double(get(handles.edit5,'string'));
cambio =  str2double(get(handles.edit6,'string'));
x= acumulador1*cambio/dis1;
y= acumulador2*cambio/dis1;
set(handles.edit3,'string',x);
set(handles.edit4,'string',y);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


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



function edit5_Callback(hObject, eventdata, handles)
global dis1
% hObject    handle to edit5 (see GCBO)
dis1 =  str2double(get(handles.edit5,'string'))
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


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



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


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


% --- Executes on button press in control.
function control_Callback(hObject, eventdata, handles)
% hObject    handle to control (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of control


% --- Executes on button press in tratamiento.
function tratamiento_Callback(hObject, eventdata, handles)
% hObject    handle to tratamiento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tratamiento


% --- Executes during object creation, after setting all properties.
function uibuttongroup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup2 (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in uibuttongroup2.
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup2 
global selecionadorc selecionadort
if hObject == handles.control
        selecionadorc = '1';
        selecionadort = '0';
end
if hObject == handles.tratamiento
        selecionadorc = '0';
        selecionadort = '1';
end
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


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
