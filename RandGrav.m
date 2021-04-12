function varargout = RandGrav(varargin)
%% ��������� ������������ ����������������� ���� ����
% Last Modified 12-Apr-2021 13:29:07
% Begin initialization code - DO NOT EDIT
% �����: �.�. �������  � ��.

% ��� ������������ ��������� ����� ���� ������������ ��������.
% ����������, ��� � ������������� ����� ������ �� �������������:
% ������� �.�. � ��. ������������ ���������� ����������������� ������������
% ����������� ��������������� ���� � ��������� ��������.
% XXVIII �����-������������� ������������� ����������� �� ���������������
% ������������� ��������, 31 ��� 2021 �. - 2 ���� 2021 �, �����-���������, ������

% This computer program can be used freely.
% Please, when using it, give a link to the original source:
% Aleksei Sholokhov et al. Simulation of self-consistent transformants
% for the anomalous gravity field at local regions.
% 28th Saint Petersburg International Conference on Integrated
% Navigation Systems, 31 May 2021 - 2 June 2021, Saint Petersburg, Russia

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RandGrav_OpeningFcn, ...
                   'gui_OutputFcn',  @RandGrav_OutputFcn, ...
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

function RandGrav_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
clc
% DelOldWindows;
% ������������� ���� ���������
set(gcf, 'Units', 'pixels')
fs  = get(hObject, 'Position');         % ��������� ���� �������
sz  = get(groot, 'ScreenSize');         % ��������� ������
dhor= fs(1) + 0.5*fs(3)- 0.5*sz(3);
dver= fs(2) + 0.5*fs(4)- 0.5*sz(4);
fs(1) = fs(1) - dhor;
fs(2) = fs(2) - dver;
set(hObject, 'Position', fs);           % ��������� ���� � ������ ������
% �������� ������
try % ������� ������ ������ ������� ������ ������ ���������
    load([mfilename '_ini']);
catch % �� ��������� (������ ������ ����� ���. ������)
    disp('������������ ����������� ��������� �� ���������.')
    sound(sin(linspace(0,3000,8192)));  % �������� ������ ���������
    UD.LimMO    =  [-100 100];          % ���������� �������� MO, ����
    UD.LimSKO   = [1 1000];             % ���������� �������� CKO, ����
    UD.RcorL    = [1 20000];            % ���. ����. ������� ����������, �
    UD.LimXY    = [0 12000000];         % ���. ����. ��������� ��������, �
    UD.LimdXY   = [1 10000];            % ���. ����. ���� �����, �
    UD.LimNw    = [3 1000];             % ���. � ����. ������� ����������
    UD.XNs  = '6020000';                % �������� ����������, �
    UD.XSs  = '6000000';                % ����� ����������, �
    UD.YEs  = '11620000';               % ��������� ����������, �
    UD.YWs  = '11600000';               % �������� ����������, �
    UD.dXs  = '2000';                   % ��� ����� �� ���������� X, �
    UD.dYs  = '2000';                   % ��� ����� �� ���������� Y, �
    UD.KF   = 1;                        % ��� �������������� �������
    UD.MO   = '0';                      % ����������� ���� - ��, ����
    UD.SKO  = '1';                      % ������������ ���� - ���, ����
    UD.Rcor = '5000';                   % ������ ���������� ����, �
    UD.Nwx  = 30;                       % ������� ���������� �� X
    UD.Nwy  = 30;                       % ������� ���������� �� Y
    UD.State= 1;                        % 1 - ���� ������������ ������� ����
    UD.NKR  = 0;                        % 1 - ���� ����������� ����. ����.
    UD.GrViz= 'on';                     % ������� ����������� ������ 6 ����
end
UD.GrViz = 'on';                      % ����� ����
% UD = rmfield(UD,{'T' 'C'});           % �������� �����
% save([mfilename '_ini'], 'UD');       % �������

% ��������� ���� ��������� � ������������ � ��������� �������
set(handles.TagXN,      'String', UD.XNs);
set(handles.TagXS,      'String', UD.XSs);
set(handles.TagYE,      'String', UD.YEs);
set(handles.TagYW,      'String', UD.YWs);
set(handles.TagDX,      'String', UD.dXs);
set(handles.TagDY,      'String', UD.dYs);
set(handles.TagKF,      'Value',  UD.KF);
set(handles.TagNKR,     'Value',  UD.NKR);
set(handles.TagMO,      'String', UD.MO);
set(handles.TagSKO,     'String', UD.SKO);
set(handles.TagRcor,    'String', UD.Rcor);
set(handles.TagNwx,     'String', UD.Nwx);
set(handles.TagNwy,     'String', UD.Nwy);

set(hObject, 'UserData', UD);
Nodes(hObject, eventdata, handles);
% TagOK_ButtonDownFcn(hObject, eventdata, handles);

function varargout = RandGrav_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function ALL_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function TagVAST_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagXS_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagXN_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagYW_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagYE_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagDX_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagDY_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagMO_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagSKO_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagRcor_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagKF_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagNwx_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);
function TagNwy_CreateFcn(hObject, eventdata, handles)
ALL_CreateFcn(hObject, eventdata, handles);

function TagVAST_Callback(hObject, eventdata, handles)
% ����� �������� ��������� ���� ���, 
% ���������/���������� ��������� ������� ����������:
hdn = [ handles.TagXN handles.TagXS handles.TagYW handles.TagYE ...
        handles.TagDX handles.TagDY handles.TagNKR ...
        handles.TagNwx handles.TagNwy ...
        handles.TagOK handles.TagSave handles.TagShowMap ...
        handles.TagMO handles.TagSKO handles.TagRcor handles.TagKF ];
if get(hObject, 'Value') == 2
    % - ������ ������������� ����� c ����������� ����
    set(hdn, 'Enable', 'off');
    set(handles.TagLoad, 'Enable', 'on');
else
    % - ��������� ������������ ������ ���������� �.�.
    set(hdn, 'Enable', 'on');
    set(handles.TagLoad, 'Enable', 'off');
end
function TagXS_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
XN  = str2num(get(handles.TagXN, 'String'));    % ���. ����������
dX  = str2num(get(handles.TagDX, 'String'));    % ��� �����
L   = [UD.LimXY(1) XN - 2*dX];
InpMinMax(hObject, L, handles);
Nodes(hObject, eventdata, handles);
UD.State = 1;
set(handles.TagRAND3D, 'UserData', UD);
function TagXN_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
XS  = str2num(get(handles.TagXS, 'String'));    % ���. ����������
dX  = str2num(get(handles.TagDX, 'String'));    % ��� �����
L   = [XS + 2*dX UD.LimXY(2)];
InpMinMax(hObject, L, handles);
Nodes(hObject, eventdata, handles);
UD.State = 1;
set(handles.TagRAND3D, 'UserData', UD);
function TagYW_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
YE  = str2num(get(handles.TagYE, 'String'));    % ����. ����������
dY  = str2num(get(handles.TagDY, 'String'));    % ��� �����
L   = [UD.LimXY(1) YE - 2*dY];
InpMinMax(hObject, L, handles);
Nodes(hObject, eventdata, handles);
UD.State = 1;
set(handles.TagRAND3D, 'UserData', UD);
function TagYE_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
YW  = str2num(get(handles.TagYW, 'String'));    % ���. ����������
dY  = str2num(get(handles.TagDY, 'String'));    % ��� �����
L   = [YW + 2*dY UD.LimXY(2)];
InpMinMax(hObject, L, handles);
Nodes(hObject, eventdata, handles);
UD.State = 1;
set(handles.TagRAND3D, 'UserData', UD);
function TagDX_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
InpMinMax(hObject, UD.LimdXY, handles);
Nodes(hObject, eventdata, handles);
function TagDY_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
InpMinMax(hObject, UD.LimdXY, handles);
Nodes(hObject, eventdata, handles);
function TagSKO_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
InpMinMax(hObject, UD.LimSKO, handles);
UD.State = 1;
set(handles.TagRAND3D, 'UserData', UD);
function TagMO_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
InpMinMax(hObject, UD.LimSKO, handles);
UD.State = 1;
set(handles.TagRAND3D, 'UserData', UD);
function TagRcor_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
InpMinMax(hObject, UD.RcorL, handles);
UD.State = 1;
set(handles.TagRAND3D, 'UserData', UD);
function TagNKR_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
UD.NKR = get(hObject, 'Value');
set(handles.TagRAND3D, 'UserData', UD);
function TagNwx_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
InpMinMax(hObject, UD.LimNw, handles);
UD.State = 1;
set(handles.TagRAND3D, 'UserData', UD);
function TagNwy_Callback(hObject, eventdata, handles)
UD  = get(handles.TagRAND3D, 'UserData');
InpMinMax(hObject, UD.LimNw, handles);
UD.State = 1;
set(handles.TagRAND3D, 'UserData', UD);
function TagKF_Callback(hObject, eventdata, handles)

function DelOldWindows
% ��������� ��������������� ���� �� ������� �������, ���� ��� ����
dd = findobj('Name', '������������ ���������� ��');
if ~isempty(dd)
    delete(dd)
end
dd = findobj('Name', '������������ ���������� ����');
if ~isempty(dd)
    delete(dd)
end

function Nodes(hObject, eventdata, handles)
% ������� ������������ ����� ����� �� ����, ������������
% �������� � ��������� ������� �������� � ������ ������ ����� �����,
% ���������� ��� ������������.
% ��������� ���������������� ������
UD  = get(handles.TagRAND3D, 'UserData');
XN  = str2num(get(handles.TagXN, 'String'));    % ���. ����������
XS  = str2num(get(handles.TagXS, 'String'));    % ���. ����������
YE  = str2num(get(handles.TagYE, 'String'));    % ����. ����������
YW  = str2num(get(handles.TagYW, 'String'));    % ���. ����������
dX  = str2num(get(handles.TagDX, 'String'));    % ��� ����� �� X
dY  = str2num(get(handles.TagDY, 'String'));    % ��� ����� �� Y
% ����� �����
Nx  = fix((XN-XS)/dX)+1;    
Ny  = fix((YE-YW)/dY)+1;
Nxy = Nx*Ny;
Nxys = [num2str(Nx, '%9.0f') 'x' num2str(Ny, '%9.0f')];
% ������������� ������ ������� � ������ ������ ����� �����
XN  = XS + dX*(Nx-1);
YE  = YW + dY*(Ny-1);
% ����� ���������
set(handles.TagXN,      'String', num2str(XN, '%9.0f'));
set(handles.TagYE,      'String', num2str(YE, '%9.0f'));
% ����� ������ (dX, dY) � '�����'
axp = get(handles.TagAXmap, 'Position');
axh = axp(4);
str = { ['\DeltaX=' num2str(XN-XS, '%9.0f') '�']
        ['\DeltaY=' num2str(YE-YW, '%9.0f') '�']
        ['�����: ' num2str(Nx, '%6.0f') 'x' num2str(Ny, '%6.0f')]};
htxt= findobj('Tag', 'TagDXYmap');
if isempty(htxt)
    hdxt = text(0.5, 0.75*axh, str,...
        'Parent',   handles.TagAXmap,...
        'Tag',      'TagDXYmap',...
        'FontSize', 8,...
        'HorizontalAlignment', 'center');
else
    set(htxt, 'String', str);
end

function InpMinMax(hObject, eventdata, handles)
% ��������� � ���������� �������� � ���� �������� �������� ������
InpFilterEdit(hObject, eventdata, handles);
Val = str2num(get(hObject, 'String'));
if Val < eventdata(1)
    Val = eventdata(1);
    set(hObject, 'String', num2str(Val, '%9.0f'), 'ForegroundColor', 'r');
elseif Val > eventdata(2)
    Val = eventdata(2);
    set(hObject, 'String', num2str(Val, '%9.0f'), 'ForegroundColor', 'r');
end

function InpFilterEdit(hObject, eventdata, handles)
% ������� ������. ������� ������ �����.
Str = get(hObject, 'String');
Str(Str == ',') = '.';          % �������� ������� �������,
Str(find(Str == ' ')) = '';     % ������� ������� � Str,
Num = str2num(Str);
if isempty(Num)
    set(hObject, 'String', 0);
    hmsg = msgbox({ '��������� ������������ ��������'
                '���������� ��������� ���� ���������!'},...
                '������ ����� ������', 'warn');
else
    set(hObject, 'String', Str);
end

function TagShowMap_Callback(hObject, eventdata, handles)
% ������� � ������� ����������� �����
% ��������� ���������������� ������
UD  = get(handles.TagRAND3D,    'UserData');
HN  = UD.HN;    % ��������, ��.��� � �.�. ������������ (c��� �����)
Nms = HN(:,6);
sel = listdlg(  'PromptString',     '�������� ���� ����� ��� ������',...
                'SelectionMode',    'multiple',...
                'Name',             '����� ����������� �����',...
                'ListSize',         [300 160],...
                'InitialValue',     1,...
                'OKString',         '��������',...
                'CancelString',     '������',...
                'ListString',       Nms);
if ~isempty(sel)
    % ������������� ������ ��������� ���� (�� ������)
    nn  = UD.nn;    % ������� ���������� [nx ny]
    A   = UD.A;
    x   = UD.x;
    y   = UD.y;
    Nx  = numel(x);
    Ny  = numel(y);
    [xx,yy] = meshgrid(x, y); % ���������� ����� �����
    % ������ ���� - ��������
    str = get(handles.TagKF,    'String');
    str = str{UD.KF};
    if numel(sel) == 6
        % ������� ��� ���� ����� - ����� � ����� ���� 2x3 ������
        figure( 'Name', [num2str(UD.KF) '-' str ', '...
                num2str(nn(1)) 'x' num2str(nn(2))...
                ' ��������, ' num2str(Nx) 'x' num2str(Ny) ' �����.'],...
                'Position', [150 10 1400 800])
        for p = 1:size(HN,1)
            subplot(2,3,p);
            [C,h] = contourf(yy, xx, reshape(A(p,:,:), [Nx Ny])' * HN{p,4});
            clabel(C,h), grid on, axis equal
            set(gca, 'XTickLabelRotation', 90)
            title([HN{p,6} ' - ' HN{p,3} ', ' HN{p,5}])
            xlabel('Y')
            ylabel('X')
        end
    else % ������� HE ��� ���� ����� - ����� ��-�����������
        for i = 1:numel(sel)
            p = sel(numel(sel) - i + 1); % ����� ��������� �������������
            hfig    = figure;
            pos     = get(hfig, 'Position');
            pos(1)  = pos(1) - 15*i;
            pos(2)  = pos(2) - 15*i;
            Tit     = [HN{p,6} ' - ' HN{p,3} ', ' HN{p,5}];
            set(hfig, 'Name', Tit, 'Position', pos);
            % surf(yy, xx, reshape(A(p,:,:), [Nx Ny]) * HN{4,p});
            if HN{p,7} < 0
                % �������� ����������� �������������
                [C,h] = contourf(yy, xx, reshape(A(p,:,:), [Nx Ny])' * HN{p,4});
            else
                % �������� ����������� � �������� ����������
                Nzal    = 100; % ����� ��������
                % ������ ������� ������� ���������
                zal     = linspace(-HN{p,7}*Nzal, HN{p,7}*Nzal, 2*Nzal+1);
                [C,h] = contourf(yy, xx, reshape(A(p,:,:), [Nx Ny])' * HN{p,4}, zal);
            end
            clabel(C,h), grid on, axis equal
            title(Tit)
            % ��������� ����, ������� X
            hax = get(h, 'Parent');
            TagShowMap_AxesFit(0,0, hax);
            set(hfig, 'SizeChangedFcn', {@TagShowMap_AxesFit, hax});
            % if sel(i) == 1
            % hold on, quiver(yy, xx, p{5}, p{4}); hold off
            % end
        end
    end % if numel(sel) == 6
end % if ~isempty(sel)

function TagShowMap_AxesFit(hObject, eventdata, AxHandle)
% ������� �������� � ������ ��� ��������� ����
set(gcf, 'Position', [600 400 750 575]);
Xnum= get(AxHandle, 'XTick');
if any(Xnum<1E+5)
    Xstr= cellstr(num2str(Xnum'));
    Xstr{numel(Xstr)} = ' �';
else
    Xnum = 0.001*Xnum;
    Xstr= cellstr(num2str(Xnum'));
    Xstr{numel(Xstr)} = 'Y, ��';
end
set(AxHandle, 'XTickLabel', Xstr);
% ��� Y
Ynum= get(AxHandle, 'YTick');
if any(Ynum<1E+5)
    Ystr= cellstr(num2str(Ynum'));
    Ystr{numel(Ystr)} = ' �';
else
    Ynum = 0.001*Ynum;
    Ystr= cellstr(num2str(Ynum'));
    Ystr{numel(Ystr)} = 'X, ��';
end
set(AxHandle, 'YTickLabel', Ystr);

function TagLoad_Callback(hObject, eventdata, handles)
% �������� ���������� �����
[FileName,PathName] = uigetfile(...
    {   '*.mat',    '��������� ���� (*.mat)';...
        '*.txf',    '���������� �� (*.txf)';...
        '*.txt',    '������ ��� (*.txt)'},...
    '����� ����� ������������', [mfilename '_ini.mat']);
if ~isnumeric(FileName)
    % ������������� ������ ��������� ���� (�� ������)
    [~,~,ext] = fileparts(FileName);
    if strcmp(ext, '.mat')
        try
            FNameC  = [PathName FileName];
            load(FNameC, 'UD');
            % ��������� ���� ���������
            set(handles.TagXN,      'String', UD.XNs);
            set(handles.TagXS,      'String', UD.XSs);
            set(handles.TagYE,      'String', UD.YEs);
            set(handles.TagYW,      'String', UD.YWs);
            set(handles.TagDX,      'String', UD.dXs);
            set(handles.TagDY,      'String', UD.dYs);
            set(handles.TagKF,      'Value',  UD.KF);
            set(handles.TagMO,      'String', UD.MO);
            set(handles.TagSKO,     'String', UD.SKO);
            set(handles.TagRcor,    'String', UD.Rcor);
            set(handles.TagNwx,     'String', UD.Nwx);
            set(handles.TagNwy,     'String', UD.Nwy);
            set(handles.TagRcor,    'String', UD.Rcor);
            set(handles.TagRAND3D,  'UserData', UD);
            Nodes(hObject, eventdata, handles);
            TagShowMap_Callback(handles.TagShowMap, eventdata, handles);
            set([handles.TagSave handles.TagShowMap], 'Enable', 'on');
        catch
            str = ['����. ' FNameC ' �� �������� ��������� ������.'];
            disp(str)
            msgbox(str, '������');
        end % try
    elseif strcmp(ext, '.txf')
        % ������ ��� � ���������������� ������� TXF-�����
        % ������������ ����� ���
        UD  = get(handles.TagRAND3D,    'UserData');
        x   = UD.x;
        y   = UD.y;
        [xx,yy] = meshgrid(x, y); % ���������� ����� �����
        A   = UD.A;
        HN  = UD.HN;
        g   = reshape(A(1,:,:), [numel(x) numel(y)])' * HN{1,4}; % ACT � �����
        
        % ������ ����� � ����. ��������
        FName  = [PathName FileName];
        fid = fopen(FName);
        T   = textread(FName, '%s', 'delimiter', '\n');
        fclose(fid);
        
        k = 1; % ������� ����. �������
        for i = 1:numel(T)
            if strcmp(T{i}, '.OBJ   270520141   DOT')
                BL(k,:) = str2num(T{i+3}); % ���������� BL ����. ������
                NB(k)   = i+5; % ����� ������ � ��������� ����
                k = k + 1;
            end
        end
        
        if k > 1 % � TXF-����� ���� ���� �� ���� ����. �����
            % ������������ BL � ������������ �����
            XN  = str2num(UD.XNs);          % �������� �����,       ����00
            XS  = str2num(UD.XSs);          % ����� �����,          ����00
            YE  = str2num(UD.YEs);          % �������� �����,       ����00
            YW  = str2num(UD.YWs);          % ��������� �����,      ����00
            bl  = BL - fix(BL);             % ���� �������, 0.��������
            BL  = (fix(BL) + bl*0.6)*10000; % ���������� ����.�.,   ������.���

            % �������� ��� �� ����� � �������� �����
            gB  = interp2(xx,yy,g, BL(:,1), BL(:,2));
            % �������� ��� ��� + ��������� ��������
            gF  = 1.5*gB + 0.1*randn(size(gB));
            
            % ������������ ����� TXF-����� �� ���������� ��� ���� � ���
            for k = 1:numel(NB)
                % ��� ����
                sBk = num2str(gB(k), '%6.2f'); % ��� ����
                if gB(k) > 0
                    sBk = ['+' sBk];
                end
                sB  = T{NB(k)};             % �������� ������ ��� ����
                dB  = find(sB==' ');
                sB  = sB(1:dB(numel(dB)));  % ��������� ������ �������� ���
                T{NB(k)} = [sB sBk];        % ������ � ����� ��������� ��� ����

                % ��� ���
                sFk = num2str(gF(k), '%6.2f'); % ��� ���
                if gF(k) > 0
                    sFk = ['+' sFk];
                end
                sF  = T{NB(k)+1};           % �������� ������ ��� ���
                dF  = find(sF==' ');
                % T{NB(k)-4} %  ���� ����������� ������� - �������
                sF  = sF(1:dF(numel(dF)));  % ��������� ������ �������� ���
                T{NB(k)+1} = [sF sFk];      % ������ � ����� ��������� ��� ���
            end
            
            % �������� ����������� TXF-�����
            FT  = [FName(1:length(FName)-4) '_NEW.txf'];
            [filename, pathname] = uiputfile(FT,  '���������� ��� ���� � ���');
            if filename ~= 0 % ������������ �� ����� ������ (����� TXF-����)1
                fid = fopen(fullfile(pathname, filename), 'w');
                for i = 1:numel(T)
                    fprintf(fid, '%s \r\n', T{i});
                end
                fclose(fid);
                disp('��� ���� � ��� ��������� � TXF-����:')
                disp(fullfile(pathname, filename))
            else
                disp('��� ���� � ��� �� ��������� � TXF-����.')
            end % if filename ~= 0

        else % if k > 1
            disp('� ��������� TXF-����� �� ������� ���������������� ������.')
        end  % if k > 1
        
    else % ������ ��������� ���� � ������� ��� � �����������!
        msgbox('��� ����������� ���� �����������, ��������� ����� �������� �����������', '��������� ���������');
        try
            FNameC  = [PathName FileName];
            % ����������� ���� ������ ������ � ����������� �� ������� �����
            T  = textread(FNameC, '%s', 1);
            fl = str2num(T{1});
            if fl(1) == 1
                [N B L X Y G] = textread(FNameC, '%f %f %f %f %f %f');
            else
                [Xs Ys Gs]  = textread(FNameC, '%s %s %s');
                for i = 1:numel(Gs)
                    xi   = findstr(Xs{i}, ',');
                    yi   = findstr(Ys{i}, ',');
                    gi   = findstr(Gs{i}, ',');
                    Xs{i}(xi) = '.';
                    Ys{i}(yi) = '.';
                    Gs{i}(gi) = '.';
                    X(i,1) = str2num(Xs{i});
                    Y(i,1) = str2num(Ys{i});
                    G(i,1) = str2num(Gs{i});
                end
            end
            % ������������������ ����� �� ��������� XY
            i = 1;
            j = 1;
            x(i, j) = X(1);
            y(i, j) = Y(1);
            dirx= sign(X(2) - X(1));
            diry= sign(Y(2) - Y(1));
            for k = 2:numel(G)
                if diry ~= 0
                    if sign(Y(k)-Y(k-1)) ==  diry
                        j = j + 1;
                    else
                        j = 1;
                        i = i + 1;
                    end
                end % if diry ~= 0
                if dirx ~= 0
                    if sign(X(k)-X(k-1)) ==  dirx
                        i = i + 1;
                    else
                        i = 1;
                        j = j + 1;
                    end
                end % if dirx ~= 0
                x(i) = X(k);
                y(j) = Y(k);
                dg(i, j) = G(k);
            end
            dg(1,1) = G(1);
            % ����������� � ����������
            UD  = get(handles.TagRAND3D,    'UserData');
            UD.x    = x;
            UD.y    = y;
            UD.dg   = dg';
            set(handles.TagXN,     'String', num2str(x(numel(x))));
            set(handles.TagXS,     'String', num2str(x(1)));
            set(handles.TagYE,     'String', num2str(y(numel(y))));
            set(handles.TagYW,     'String', num2str(y(1)));
            set(handles.TagDX,     'String', num2str(x(2)-x(1)));
            set(handles.TagDY,     'String', num2str(y(2)-y(1)));
            str = { ['\DeltaX=' num2str(x(numel(x))-x(1), '%9.0f') '�']
            ['\DeltaY=' num2str(y(numel(y))-y(1), '%9.0f') '�']
            ['�����: ' num2str(numel(x), '%6.0f') 'x' num2str(numel(y), '%6.0f')]};
            htxt= findobj('Tag', 'TagDXYmap');
            set(htxt, 'String', str);
            set(handles.TagRAND3D, 'UserData', UD);
        catch
            str = {'�� ������� ������������� ����.', FNameC};
            disp(str)
            msgbox(str, '������');
        end % try (��������� ���� ���)
    end % if strcmp(ext, '.mat')
end % if ~isnumeric(FileName)

function TagSave_Callback(hObject, eventdata, handles)
% ����� ���� ����� ��� ����������
% ��������� ���������������� ������
UD  = get(handles.TagRAND3D,    'UserData');
HN  = UD.HN;    % ��������, ��.��� � �.�. ������������ (c��� �����)
Nms = HN(:,6);
sel = listdlg(  'PromptString',     '�������� ���� ����� ��� ����������',...
                'SelectionMode',    'multiple',...
                'Name',             '���������� �����',...
                'ListSize',         [300 160],...
                'InitialValue',     1,...
                'ListString',       Nms);
if ~isempty(sel)
    % ������������� ������ ��������� ���� (�� ������)
    A   = UD.A;
    x   = UD.x;
    y   = UD.y;
    Nx  = numel(x);
    Ny  = numel(y);
    % ����� ���� ������������
    for i = 1:numel(sel)
        p = sel(i);
        [FileName,PathName] = uiputfile({'*.txt', '��������� �����'},...
            ['���������� �����: ' Nms{p}],...
            ['MAP_' HN{p,3} '.txt']);
            ['MAP_' HN{p,3} '.txt']
        if FileName ~= 0 % �� ������ ������
            FFN = fullfile(PathName,FileName);
            xyz2file(x, y, reshape(A(p,:,:), [Nx Ny])' * HN{p,4}, FFN);
            disp([Nms{p} ' - ��������� � ����: ' FFN])
        end
    end % for q = 1:numel(sel)
end % if ~isempty(sel)

function TagSave_ButtonDownFcn(hObject, eventdata, handles)
% ������� ��� ���������� MAT-����� (������ ������ ���� ���������)
UD  = get(handles.TagRAND3D,    'UserData');
[FileName,PathName] = uiputfile({'*.mat', '����� ������'},...
    '���������� ����� � ������� �����', [mfilename '_ALL']);
if FileName ~= 0 % �� ������ ������
    FFN = fullfile(PathName,FileName);
    save(FFN, 'UD');
    disp(['C������ MAT-����: ' FFN])
end

function xyz2file(x, y, z, FN)
%% ������� �������� ���� ����� � ����
% x, y  - ������� ��������� �� ��������������� ����
% z     - ������� �� ���������� ��������� � ����
% FN    - ��� �����

% ������������ ����� ��� BL ������� ����� �-41-XXIV, ������
% ������ ��� �� ��.���
B   = x/10000;
Bg  = fix(B);
Bm  = fix((B-Bg)*100);
Bs  = ((B-Bg)*100 - Bm)*60;
Bsi = find(abs(Bs-60) < 1e-6);
Bs(Bsi) = 0;
Bm(Bsi) = Bm(Bsi) + 1;
Bg(numel(Bg)) = Bg(numel(Bg))+1;
Bm(numel(Bm)) = 0;
L   = y/10000;
Lg  = fix(L);
Lm  = fix((L-Lg)*100);
Ls  = ((L-Lg)*100 - Lm)*60;
Lsi = find(abs(Ls-60) < 1e-6);
Ls(Lsi) = 0;
Lm(Lsi) = Lm(Lsi) + 1;
Lg(numel(Lg)) = Lg(numel(Lg))+1;
Lm(numel(Lm)) = 0;
% [B' Bg' Bm' Bs']
% [L' Lg' Lm' Ls']

% ������ ���.�������� (���� �������)
x   = x/10000;
y   = y/10000;
x   = fix(x) + (x-fix(x))/0.6;
y   = fix(y) + (y-fix(y))/0.6;



% ������������ ��������� �������
[r,c] = size(z);
M{r*c} = 0;     % �������������� ������
k = 1;
for j = 1:c
    for i = 1:r
%         M1   = [num2str(k,      '%8.0f') ' '...
%                 num2str(x(j),   '%8.1f') ' '...
%                 num2str(y(i),   '%9.1f') ' '...
%                 num2str(x(j),   '%8.1f') ' '...
%                 num2str(y(i),   '%9.1f') ' '...
%                 num2str(z(i,j), '%9.2f')];
%         % �������� ������� ����� BL -  ������ ��� �� ��.���
%         M1   = [num2str(k,      '%8.0f') ' '...
%                 num2str(Bg(j),  '%3.0f') ' '...
%                 num2str(Bm(j),  '%2.0f') ' '...
%                 num2str(Bs(j),  '%5.3f') ' '...
%                 num2str(Lg(i),  '%3.0f') ' '...
%                 num2str(Lm(i),  '%2.0f') ' '...
%                 num2str(Ls(i),  '%5.3f') ' '...
%                 num2str(z(i,j), '%9.2f')];
%         M1(find(M1 == '.')) = ',';
        % �������� ������� ����� BL -  ���.�������� (���� �������)
        M1   = [num2str(x(j),   '%10.8f') ' '...
                num2str(y(i),   '%10.8f') ' '...
                num2str(z(i,j), '%9.2f')];
        M1(find(M1 == '.')) = ',';
        M{k} = M1;
        k = k + 1;
    end
end
% ����� ������ � ����
fid = fopen(FN ,'w');
for i = 1:k-1,
    fprintf(fid,'%s\r\n', M{i});
    % fprintf(fid,'%8.1f %9.1f %9.2f\r\n', M(i,:));
end
% disp(['������ ��������� � ����: "' FN '"']);
fclose(fid);

function [kfr, r] = vkf(s1, s2, dr, Tr)
% ������� ������������ �������� �������� �������������� �������
% ���� ��������� ��������� s1, s2 �� ��������� �� 0 �� Tr.
% dr - ������ ������������ ��������� ��������� s1, s2.
for i = 1:fix(Tr/dr)
    l = length(s1);
    kfr(i)  = sum(s1.*s2)/(l-1) - mean(s1)*mean(s2);
    r(i)   = (i-1)*dr;
    s1(1) = [];
    s2(l)= [];
end

function [kfr, r] = vkf2D(s1, s2, dr, Tr, var)
% ������� ������������ �������� �������� �������������� �������
% ���� ��������� 2D-����� s1, s2 �� ��������� �� 0 �� Tr.
% dr - ������ ������������ ��������� ��������� s1, s2.
% var - ������� �������: 1 - �������� �� �������������� ���,
% 2 - �� ������������, 3 - �� ���� ���� ������������.
switch var
    case 1
    for i = 1:fix(Tr/dr)
        l = size(s1, 2);
        kfr(i) = sum(sum(s1.*s2))/(numel(s1)-1) - mean(mean(s1))*mean(mean(s2));
        r(i)   = (i-1)*dr;
        s1(:,1)= [];
        s2(:,l)= [];
    end
    case 2
    for i = 1:fix(Tr/dr)
        l = size(s1, 1);
        kfr(i) = sum(sum(s1.*s2))/(numel(s1)-1) - mean(mean(s1))*mean(mean(s2));
        r(i)   = (i-1)*dr;
        s1(1,:)= [];
        s2(l,:)= [];
    end
    case 3
    for i = 1:fix(Tr/dr)
        l = size(s1, 2);
        kfr(i) = sum(sum(s1.*s2))/(numel(s1)-1) - mean(mean(s1))*mean(mean(s2));
        r(i)   = (i-1)*dr;
        s1(:,1)= [];
        s2(:,l)= [];
        s1(1,:)= [];
        s2(l,:)= [];
    end

end

function TagOK_Callback(hObject, eventdata, handles)
% �������� ������� - ������ ������������ ����
% ���������� ������������ � ���������
mG  = 1e5;                      % ���������� � �/�^2
go  = 9.8;                      % ���������� �������� ���, �/�^2
ro  = 180*3600/pi;              % ����� ���.� � �������
MapViz = 0;                     % ������� ������ ���� (1 - ���������)

% ������������ ��������� ������� ����������
set([handles.TagSave handles.TagShowMap], 'Enable', 'off');
% ��������� ���������������� ������
UD  = get(handles.TagRAND3D,    'UserData');
% ��������� ��������, �������� ��������!
UD.XNs = get(handles.TagXN,     'String');
UD.XSs = get(handles.TagXS,     'String');
UD.YEs = get(handles.TagYE,     'String');
UD.YWs = get(handles.TagYW,     'String');
UD.dXs = get(handles.TagDX,     'String');
UD.dYs = get(handles.TagDY,     'String');
UD.KF  = get(handles.TagKF,     'Value');
UD.MO  = get(handles.TagMO,     'String');
UD.SKO = get(handles.TagSKO,    'String');
UD.Rcor= get(handles.TagRcor,   'String');
UD.Nwx = get(handles.TagNwx,    'String');
UD.Nwy = get(handles.TagNwy,    'String');
UD.NKR = get(handles.TagNKR,    'Value');

% �������� ������ ��� ����������
xS  = str2num(UD.XSs);          % ����� ����: ��., ���., ���., ����.
xN  = str2num(UD.XNs);
yW  = str2num(UD.YWs);
yE  = str2num(UD.YEs);
dx  = str2num(UD.dXs);          % ���� ����� � ���. � ����. ������������
dy  = str2num(UD.dYs);
S   = str2num(UD.SKO)/mG;       % ��� ���, (����)/mG
Dk  = str2num(UD.Rcor);         % ������ ���������� ���, ��
nx  = str2num(UD.Nwx);          % ����� �������� ��������. ���� �� X
ny  = str2num(UD.Nwy);          % ����� �������� ��������. ���� �� Y
Mdg = str2num(UD.MO);           % �������� �������� ��� (���. ��.),����
go  = go + Mdg/mG;              % �������� � ����������� �������� ���

% ��������� ������������ ������� (��� ����� 2D)
mx  = (xN+xS)/2;        % �������� ��������� �������������� �� X
my  = (yE+yW)/2;        % �������� ��������� �������������� �� Y
wx  = 2*pi/(xN-xS);     % ������� ������� �� X
wy  = 2*pi/(yE-yW);    	% ������� ������� �� Y
cc  = @(x, y, nx, ny)   cos(nx*wx*(x-mx)) .* cos(ny*wy*(y-my));
cs  = @(x, y, nx, ny)   cos(nx*wx*(x-mx)) .* sin(ny*wy*(y-my));
ss  = @(x, y, nx, ny)   sin(nx*wx*(x-mx)) .* sin(ny*wy*(y-my));

% ������ ��������� ��������� (�� � ������������ ��������� �����):
for SHOW_KF=0   % ����� �������� ������ ����� ��
switch UD.KF % ����� ���. ������� ACT (�������� g)
    case 1
        str = '������ �������� (M-III)';
        D  = Dk  /(13/16);  % �������� ��, �����. ���. ������ ����������
        % D  = Dk  /1.361;    % 2-� �������
        % D  = Dk;
        % ������� �������������� ����������
        R   = @(x,y)    1/D * sqrt(x.^2 + y.^2);
        % ������� �������� �������������� ��������� �����
        W2  = @(nx,ny)  D^2 * ((wx*nx).^2 + (wy*ny).^2);
        % g -- ACT
        Kg  = @(x,y)    S^2         * exp(-R(x,y))  .*...
                        (1 + R(x,y) - 1/2*R(x,y).^2);
        Cg  = @(nx,ny)  S^2         * 15*pi*D^2*   W2(nx,ny) ./...
                        (1+W2(nx,ny)).^(7/2);
        % gx -- ��-X ���
        Kgx = @(x,y)    2*(S/D)^2   * exp(-R(x,y))  .*...
                        (1 - 1/4*R(x,y) - 1/4*R(x,y).*(5-R(x,y)).*...
                        (x./sqrt(x.^2 + y.^2)).^2 );
        Cgx = @(nx,ny)  Cg(nx,ny)  .* (wx*nx).^2;
        % gy -- ��-Y ���
        Kgy = @(x,y)    2*(S/D)^2   * exp(-R(x,y))  .*...
                        (1 - 1/4*R(x,y) - 1/4*R(x,y).*(5-R(x,y)).*...
                        (y./sqrt(x.^2 + y.^2)).^2 );
        Cgy = @(nx,ny)  Cg(nx,ny)  .* (wy*ny).^2;
        % � -- ��
        KT  = @(x,y)    3/2*D^2*S^2 * exp(-R(x,y))  .*...
                        (1 + R(x,y) + 1/3*R(x,y).^2);
        CT  = @(nx,ny)  3/2*D^2*S^2 * 10*pi*D^2 ./ (1+W2(nx,ny)).^(7/2);
        % Tx -- ��-X ��
        KTx = @(x,y)    1/2*S^2     * exp(-R(x,y))  .*...
                        (1 + R(x,y) - R(x,y).^2 .* (x./sqrt(x.^2 + y.^2)).^2 );
        CTx = @(nx,ny)  CT(nx,ny)  .* (wx*nx).^2;
        % Ty -- ��-Y ��
        KTy = @(x,y)    1/2*S^2     * exp(-R(x,y))  .*...
                        (1 + R(x,y) - R(x,y).^2 .* (y./sqrt(x.^2 + y.^2)).^2 );
        CTy = @(nx,ny)  CT(nx,ny)  .* (wy*ny).^2;
    case 2
        str = '������ ����� (M-IV)';
        D  = Dk  /(37/32); % �������� ��, �����. ���. ������ ����������
        % D  = Dk  /1.860; % 2-� �������
        % D  = Dk;
        % ������� �������������� ����������
        R   = @(x,y)    1/D * sqrt(x.^2 + y.^2);
        % ������� �������� �������������� ��������� �����
        W2  = @(nx,ny)  D^2 * ((wx*nx).^2 + (wy*ny).^2);
        % g -- ACT
        Kg  = @(x,y)    S^2         * exp(-R(x,y))  .*...
                        (1 + R(x,y) + 1/6*R(x,y).^2 - 1/6*R(x,y).^3);
        Cg  = @(nx,ny)  S^2         * 35*pi*D^2*   W2(nx,ny) ./...
                        (1+W2(nx,ny)).^(9/2);
        % gx -- ��-X ���
        Kgx = @(x,y)    2/3*(S/D)^2 * exp(-R(x,y))  .*...
                        (1 + R(x,y) - 1/4*R(x,y).^2 - 1/4*R(x,y).^2 .*(6-R(x,y)).*...
                        (x./sqrt(x.^2 + y.^2)).^2 );
        Cgx = @(nx,ny)  Cg(nx,ny)  .* (wx*nx).^2;
        % gy -- ��-Y ���
        Kgy = @(x,y)    2/3*(S/D)^2 * exp(-R(x,y))  .*...
                        (1 + R(x,y) - 1/4*R(x,y).^2 - 1/4*R(x,y).^2 .*(6-R(x,y)).*...
                        (y./sqrt(x.^2 + y.^2)).^2 );
        Cgy = @(nx,ny)  Cg(nx,ny)  .* (wy*ny).^2;
        % � -- ��
        KT  = @(x,y)    3/2*D^2*S^2 * exp(-R(x,y))  .*...
                        (1 + R(x,y) + 2/5*R(x,y).^2 + 1/15*R(x,y).^3);
        CT  = @(nx,ny)  3/2*D^2*S^2 * 14*pi*D^2 ./ (1+W2(nx,ny)).^(9/2);
        % Tx -- ��-X ��
        KTx = @(x,y)    3/10*S^2    * exp(-R(x,y))  .*...
                        (1 + R(x,y) + 1/3*R(x,y).^2 - 1/3*R(x,y).^2 .*...
                        (1+R(x,y)) .* (x./sqrt(x.^2 + y.^2)).^2 );
        CTx = @(nx,ny)  CT(nx,ny)  .* (wx*nx).^2;
        % Ty -- ��-Y ��
        KTy = @(x,y)    3/10*S^2    * exp(-R(x,y))  .*...
                        (1 + R(x,y) + 1/3*R(x,y).^2 - 1/3*R(x,y).^2 .*...
                        (1+R(x,y)) .* (y./sqrt(x.^2 + y.^2)).^2 );
        CTy = @(nx,ny)  CT(nx,ny)  .* (wy*ny).^2;
end
end % SHOW_KF

% ������, ������� ��������: �������������� ��, ��, ����. �������� ������������,
% ���������� ������������ ��� ������ �������, �����������, ������ ��������
% ��������� (������� ����� ���������� �������� �� ��������, -1 �����. �������.)
HN  = { Kg 	Cg  'g'    mG       '����'  '�������� ���� �������' 10
        Kgx Cgx 'gx'   1e2*mG   '���'   '����������� ��� �� X'  0.2
        Kgy Cgy 'gy'   1e2*mG   '���'   '����������� ��� �� Y'  0.2
        KT 	CT  'T/g'  1e3/go   '��'    '����������� ���������' 100
        KTx CTx 'Tx/g' ro/go    '���.�' '����������� �� �� X'   1
        KTy CTy 'Ty/g' ro/go    '���.�' '����������� �� �� Y'   1 };

%% ������������ ���������� ����
Nx  = fix((xN-xS)/dx)+1;    % ����� �����
Ny  = fix((yE-yW)/dy)+1;
% ������������� ������ ������� � ������ ������ ����� �����
xN  = xS + dx*(Nx-1);
yE  = yW + dy*(Ny-1);
Sxy = (xN-xS)*(yE-yW);      % ������� ������
% ���������� ����� �����
x   = linspace(xS,xN,Nx);
y   = linspace(yW,yE,Ny);

% ��������� ����� ��� ������������ ��������� ���������� �����
Rcc = randn(nx+1, ny+1);
Rss = randn(nx+1, ny+1);
Rcs = randn(nx+1, ny+1) + randn(nx+1, ny+1);

% ���������� ������������� ���������� (���������� ��)
disp([num2str(UD.KF) '-' str ', ' num2str(nx) 'x' num2str(ny) ' ��������.'])
[NX,NY] = meshgrid(0:ny, 0:nx);         % ����� ��������, ��� X - ��������
for k = 1:size(HN,1)                    % ���� �� ��������������
    K = feval(HN{k,1}, 1e-50,1e-50);    % ��������� k-� �������������
    V = feval(HN{k,2}, NX,NY) *4/Sxy;   % ������������ ���������� (��)
    V(1,:) = V(1,:)/2;
    V(:,1) = V(:,1)/2;
    % �������� �������� ���������� �� �� ���������
    if strcmp(UD.GrViz, 'on')
        disp(['CX-' HN{k,3} ': ' num2str(100*(sum(sum(V)))/K, '%6.2f') '%'])
    end
    % ������������ KP �� ��������� (�������� ���������, ���� �����)
    if UD.NKR
        V = V * K/sum(sum(V));
    end
    v{k}   = sqrt(V);                   % ����� �� �� ��� ��������� �� �.�.
end

% ������ �������� ������������ � ����� ����� ��������� ����� (�����)
tic
A(size(HN,1),Nx,Ny) = 0;                % �������������� ������
for i = 1:Nx    % ����� i,j �� ����� ��������� ����� �����
    for j = 1:Ny
        % ������������ sin,cos �� ��������� �����
        Sij =   cc(x(i), y(j), NX,NY)   .* Rcc +...
                cs(x(i), y(j), NX,NY)   .* Rcs +...
                ss(x(i), y(j), NX,NY)   .* Rss;
        for k = 1:size(HN,1) % �������������
            A(k,i,j) = sum(sum(v{k} .* Sij));
        end
    end
    if i==1 && toc*Nx > 10 % ������ ������� ���������
        disp(['������ �������� � (' num2str(Nx) 'x' num2str(Ny) ') ����� ��� '...
             num2str(size(HN,1)) ' ���� ����, ~' num2str(round(toc*Nx)) ' c.'])
    end
end
% �������� ���������� ������������ (M.O.) � �������� ����� ���
A(1,:,:) = A(1,:,:) + Mdg/mG;

% ����� ����������� ���� ������������ 2x3 � ����� ���� ������
if MapViz
figure( 'Name', [num2str(UD.KF) '-' str ', ' num2str(nx) 'x' num2str(nx)...
                ' ��������, ' num2str(Nx) 'x' num2str(Ny) ' �����.'],...
        'Position', [150 10 1400 800], 'Tag', 'MAP6', 'Visible', UD.GrViz)
[xx,yy] = meshgrid(x, y);
for p = 1:size(HN,1)
    subplot(2,3,p); % contour contourf
    [C,h] = contourf(yy, xx, reshape(A(p,:,:), [Nx Ny])' * HN{p,4});
    clabel(C,h), grid on, axis equal
    set(gca, 'XTickLabelRotation', 90, 'Tag', ['MAPg' HN{p,3}])
    title([HN{p,6} ' - ' HN{p,3} ', ' HN{p,5}])
    xlabel('Y')
    ylabel('X')
end
else
    disp('������������ ���� ���������.')
end % if MapViz

%% ���������� ����������� ���������� � ���� ..._ini.mat
UD.x    = x;
UD.y    = y;
UD.A    = A;
UD.nn   = [nx ny]; % ������� ����������
UD.HN   = HN;
UD.State= 0;
set(handles.TagRAND3D, 'UserData', UD);
% TagShowMap_Callback(handles.TagShowMap, eventdata, handles);
set([handles.TagSave handles.TagShowMap], 'Enable', 'on');
sound(sin(linspace(0,3000,8192))); % �������� ������ ���������
% print('-djpeg', '-r300', ['F_jpeg' datestr(now,'_mmdd_HHMMSS')])
save([mfilename '_ini'], 'UD');

function TagOK_ButtonDownFcn(hObject, eventdata, handles)
%% ������ ������ ���� ��� ������ ���������
% �������� ��� � ��� ��� ������� ���������� ������������
% �������������� "���������" ������: uncomment ��� �������
% set(handles.TagVAST, 'Value', 2)
% TagVAST_Callback(handles.TagVAST, eventdata, handles);
% TagLoad_Callback(hObject, eventdata, handles);

UD  = get(handles.TagRAND3D, 'UserData');
HN  = UD.HN;                % ������ ������ � ��������������:
% HN===={ Kg  Cg  'g'    mG       '����'  '�������� ���� �������' 10
%         Kgx Cgx 'gx'   1e2*mG   '���'   '����������� ��� �� X'  0.2
%         Kgy Cgy 'gy'   1e2*mG   '���'   '����������� ��� �� Y'  0.2
%         KT  CT  'T/g'  1e3/go   '��'    '����������� ���������' 100
%         KTx CTx 'Tx/g' ro/go    '���.�' '����������� �� �� X'   1
%         KTy CTy 'Ty/g' ro/go    '���.�' '����������� �� �� Y'   1 };

x   = UD.x;                 % ���������� ����� �����
y   = UD.y;
Rcor= str2num(UD.Rcor);     % �������� ���������� ���, �
SKO = str2num(UD.SKO);      % ��� ���� ���, ����
Trx = x(numel(x)) - x(1);   % ����. �������� �� �� ��� X, �
Try = y(numel(y)) - y(1);   % ����. �������� �� �� ��� Y, �
drx = str2num(UD.dXs);      % ��� ����� �� ��� X, �
dry = str2num(UD.dYs);      % ��� ����� �� ��� Y, �
A   = UD.A;                 % �������� ������� ���������� ������������
g   = reshape(A(1,:,:), [numel(x) numel(y)])' * HN{1,4}; % ACT � �����
gx  = reshape(A(2,:,:), [numel(x) numel(y)])' * HN{2,4}; % gx � �����
Tx  = reshape(A(5,:,:), [numel(x) numel(y)])' * HN{5,4}; % ���-x � �����
% �� ������������
Kg  = HN{1,1};              % �� ���
Kgx = HN{2,1};              % �� ����������� ��� �� X
KTx = HN{5,1};              % �� ����������� �� �� X (���-X)

% �������� ��� �� ����� � ����������� �������� �����
% (������ ������ �������, ������ �� ������������)
[xx,yy] = meshgrid(x, y);
xz  = mean(x);              % ���������� �������� �����, �
yz  = mean(y);
gk  = interp2(xx,yy,g, xz,yz);

%% ������� ��
Rmax = 10*Rcor;             % ����. �������� ��������� �� �� ��������, �
% �� ���
[kfg, r] = vkf2D(g, g, Rmax/100, Rmax, 1); % �� �� ���������� �� ��� y
rkm = r * 0.001;                            % ������� � ��
kag = Kg(r,0)*HN{1,4}^2;                    % �� �������������
figure
line(rkm,kfg, 'color', 'k', 'linewidth', 1, 'LineStyle', '-');
hdg = line(rkm,kag, 'color', 'k', 'linewidth', 2, 'LineStyle', '-');
% �� ���-x
kfTx= vkf2D(Tx, Tx, Rmax/100, Rmax, 1);     % �� �� ���������� �� ��� x
kaTx= KTx(r,0)*HN{5,4}^2;                   % �� �������������
% figure
line(rkm,60*kfTx, 'color', 'k', 'linewidth', 1, 'LineStyle', '--');
hdTx= line(rkm,60*kaTx, 'color', 'k', 'linewidth', 2, 'LineStyle', '--');
% �� gx
kfgx= vkf2D(gx, gx, Rmax/100, Rmax, 1);     % �� �� ���������� �� ��� x
kagx= Kgx(r,0)*HN{2,4}^2;                             % �� �������������
% figure
line(rkm,60*70*kfgx, 'color', 'k', 'linewidth', 1, 'LineStyle', '-.');
hdgx= line(rkm,60*70*kagx, 'color', 'k', 'linewidth', 2, 'LineStyle', '-.');
% ������� �� �������
grid on
text( 7,kag(1)*1.05,...
    ['\itK\rm_{ACT}(0) = ' num2str(kag(1),  '%9.1f') ' ����^2' ],...
    'BackgroundColor', [1 1 1])
text(11,kag(1)*0.85,...
    ['\itK\rm_{���}(0) = ' num2str(kaTx(2), '%9.1f') ' ���.�^2'],...
    'BackgroundColor', [1 1 1])
text(15,kag(1)*0.55,...
    ['\itK\rm_{���}(0) = ' num2str(kagx(2), '%9.2f') ' �^2'],...
    'BackgroundColor', [1 1 1])
legend([hdg hdTx hdgx], {'ACT', '���' '���'})
line([0 rkm(numel(rkm))], [0 0], 'Color', 'k')
text(-2, 0, '0')
set(gca, 'YTickLabel', [], 'YGrid', 'off')
% ����� ������� � ����� ��������
% print('-djpeg', '-r300', ['F_jpeg' datestr(now,'_mmdd_HHMMSS')])











