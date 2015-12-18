function mute

%%%%% main gui for the MuTE toolbox%%%%%%%%%%%

 %%%%% last modified: 18-12-2015 by Frederik Van de Steen

close all
clc

main_fig=figure('Units','normalized','Visible','off','Position',[0.1,0.1,0.3,0.5],'Color',[116  175  173] ./ 255,'name','MuTE parameters and methods','Menubar','none','NumberTitle','off','Tag','mute_main');
method = mute_config();
% assignin('caller', 'method', mute_config()) 
uicontrol('Units','normalized','Style','text','String','Welcome to the MuTE toolbox','Fontsize',16,...
    'Position',[0.05,0.935,0.90,0.037],'BackgroundColor',[116  175  173] ./ 255);

uicontrol('Units','normalized','Style','edit',...
    'Position',[0.05,0.83,0.90,0.09],'BackgroundColor',[116  175  173] ./ 255 );

uicontrol('Units','normalized','Style','edit',...
    'Position',[0.05,0.05,0.90,0.77],'BackgroundColor',[116  175  173] ./ 255);

h.gen_param    = uicontrol('Units','normalized','Style','pushbutton',...
    'String','General parameters and Data','Position',[0.2,0.85,0.6,0.05],'FontSize',14,'callback',{@gen_param_callback,method.gen_def},'BackgroundColor',[217  133  59]./255);
h.gen_param_check = uicontrol('Units','normalized','Style','checkbox',...
    'Position',[0.83,0.85,0.05,0.05],'BackgroundColor',[116  175  173] ./ 255 ,'ForegroundColor',[217  133  59]./255,'Tag','gen_param_check','callback',@gen_param_check_callback);

h.binnue_param = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Binnue parameters','Position',[0.15,0.64,0.35,0.05],'FontSize',12,'Callback',{@param_gui_callback,method.binnue},'BackgroundColor',[217  133  59]./255);
h.binnue_check = uicontrol('Units','normalized','Style','checkbox',...
    'Position',[0.55,0.64,0.05,0.05],'BackgroundColor',[116  175  173] ./ 255 ,'ForegroundColor',[217  133  59]./255,'Tag','binnue_check','callback',{@param_callback,'binnue_check'});

h.binue_param = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Binue parameters','Position',[0.15,0.72,0.35,0.05],'FontSize',12,'callback',{@param_gui_callback,method.binue},'BackgroundColor',[217  133  59]./255);
h.binue_check = uicontrol('Units','normalized','Style','checkbox',...
    'Position',[0.55,0.72,0.05,0.05],'BackgroundColor',[116  175  173] ./ 255 ,'ForegroundColor',[217  133  59]./255,'Tag','binue_check','callback',{@param_callback,'binue_check'});

h.linnue_param = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Linnue parameters','Position',[0.15,0.48,0.35,0.05],'FontSize',12,'callback',{@param_gui_callback,method.linnue},'BackgroundColor',[217  133  59]./255);
h.linnue_check = uicontrol('Units','normalized','Style','checkbox',...
    'Position',[0.55,0.48,0.05,0.05],'BackgroundColor',[116  175  173] ./ 255 ,'ForegroundColor',[217  133  59]./255,'Tag','linnue_check','callback',{@param_callback,'linnue_check'});

h.linue_param = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Linue parameters','Position',[0.15,0.56,0.35,0.05],'FontSize',12,'callback',{@param_gui_callback,method.linue},'BackgroundColor',[217  133  59]./255);
h.linue_check = uicontrol('Units','normalized','Style','checkbox',...
    'Position',[0.55,0.56,0.05,0.05],'BackgroundColor',[116  175  173] ./ 255 ,'ForegroundColor',[217  133  59]./255,'Tag','linue_check','callback',{@param_callback,'linue_check'});


h.nnnue_param = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Nnnue parameters','Position',[0.15,0.32,0.35,0.05],'FontSize',12,'Callback',{@param_gui_callback,method.nnnue},'BackgroundColor',[217  133  59]./255);
h.nnnue_check = uicontrol('Units','normalized','Style','checkbox',...
    'Position',[0.55,0.32,0.05,0.05],'BackgroundColor',[116  175  173] ./ 255 ,'ForegroundColor',[217  133  59]./255,'Tag','nnnue_check','callback',{@param_callback,'nnnue_check'});

h.nnue_param = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Nnue parameters','Position',[0.15,0.4,0.35,0.05],'FontSize',12,'callback',{@param_gui_callback,method.nnue},'BackgroundColor',[217  133  59]./255);
h.nnue_check = uicontrol('Units','normalized','Style','checkbox',...
    'Position',[0.55,0.4,0.05,0.05],'BackgroundColor',[116  175  173] ./ 255 ,'ForegroundColor',[217  133  59]./255,'Tag','nnue_check','callback',{@param_callback,'nnue_check'});

h.neunetnue_param = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Neunetnue parameters','Position',[0.15,0.16,0.35,0.05],'FontSize',12,'callback',{@param_gui_callback,method.neunetnue},'BackgroundColor',[217  133  59]./255);
h.neunetnue_check = uicontrol('Units','normalized','Style','checkbox',...
    'Position',[0.55,0.16,0.05,0.05],'BackgroundColor',[116  175  173] ./ 255 ,'ForegroundColor',[217  133  59]./255,'Tag','neunetnue_check','callback',{@param_callback,'neunetnue_check'});

h.neunetue_param = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Neunetue parameters','Position',[0.15,0.24,0.35,0.05],'FontSize',12,'callback',{@param_gui_callback,method.neunetue},'BackgroundColor',[217  133  59]./255);
h.neunetue_check = uicontrol('Units','normalized','Style','checkbox',...
    'Position',[0.55,0.24,0.05,0.05],'BackgroundColor',[116  175  173] ./ 255 ,'ForegroundColor',[217  133  59]./255,'Tag','neunetue_check','callback',{@param_callback,'neunetue_check'});

tmp = findobj('Tag','gen_param_check');
setappdata(tmp,'gen_check',0);
 

logo = imread(which('MuTE_logo.png'));
% web_mute = 'http://mutetoolbox.guru/';
% h.web = uicontrol('Units','normalized','Style','pushbutton',...
%     'Position',[0.1,0.02,0.18,0.02],'callback',@(o,e)web(web_mute),'BackgroundColor',[116  175  173] ./ 255);

h.binnue_execute_ = uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.413,0.05,0.18,0.05],'callback',@execute_callback,'CData',logo,'BackgroundColor',[217  133  59]./255);
h.binnue_generate_ = uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.1,0.05,0.18,0.05],'callback',{@generate_callback},'String','generate script','BackgroundColor',[217  133  59]./255);
h.main_quit    = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Quit','Position',[0.80,0.05,0.15,0.05],'FontSize',14,'BackgroundColor',[217  133  59]./255);
set(h.main_quit,'callback',{@quit_fcn,h});



set(main_fig,'Visible','on')

function generate_callback(hObject,eventdata,handles)
   parentfig = get(hObject,'Parent');

method = getappdata(parentfig);
which(2) = get(findobj('Tag','binnue_check'),'Value');
which(1) = get(findobj('Tag','binue_check'),'Value');
which(4) = get(findobj('Tag','linnue_check'),'Value');
which(3) = get(findobj('Tag','linue_check'),'Value');
which(6) = get(findobj('Tag','nnnue_check'),'Value');
which(5) = get(findobj('Tag','nnue_check'),'Value');
which(8) = get(findobj('Tag','neunetnue_check'),'Value');
which(7) = get(findobj('Tag','neunetue_check'),'Value');
method.which = which;
   if get(findobj('Tag','gen_param_check'),'Value') == 0 && sum(which) == 0
       mute_errorscreen('please specify the general parameters and at least one method')
       return
   
   elseif get(findobj('Tag','gen_param_check'),'Value') == 0 
       mute_errorscreen('please specify the general parameters')
       return
    elseif sum(which) == 0
       mute_errorscreen('please specify the parameters of at least one method')
       return
   end
cd(method.gen_param.folder)

delete('mute_analysis_scripts.m')

mute_write_script(method)
disp(['script has been written, check:' method.gen_param.folder])
cd(method.gen_param.folder)
close






function h = quit_fcn(hObject,eventdata,handles)

close all;clear all
disp('bye bye and thanks for using MuTE')

function param_gui_callback(hObject,callbackdata,x)
  param_gui(x);

function execute_callback(hObject,eventdata,handles)
   parentfig = get(hObject,'Parent');

method = getappdata(parentfig);
which(2) = get(findobj('Tag','binnue_check'),'Value');
which(1) = get(findobj('Tag','binue_check'),'Value');
which(4) = get(findobj('Tag','linnue_check'),'Value');
which(3) = get(findobj('Tag','linue_check'),'Value');
which(6) = get(findobj('Tag','nnnue_check'),'Value');
which(5) = get(findobj('Tag','nnue_check'),'Value');
which(8) = get(findobj('Tag','neunetnue_check'),'Value');
which(7) = get(findobj('Tag','neunetue_check'),'Value');
method.which = which;
   if get(findobj('Tag','gen_param_check'),'Value') == 0 && sum(which) == 0
       mute_errorscreen('please specify the general parameters and at least one method')
       return
   
   elseif get(findobj('Tag','gen_param_check'),'Value') == 0 
       mute_errorscreen('please specify the general parameters')
       return
    elseif sum(which) == 0
       mute_errorscreen('please specify the parameters of at least one method')
       return
   end

mute_write_script(method)
cd(method.gen_param.folder)
mute_analysis_scripts
disp(['script has been written, check:' method.gen_param.folder])



function param_callback(hObject,~,tag)
parentfig = get(hObject,'Parent');
method=getappdata(parentfig);
if ~isfield(method,tag(1:end-6))
    mute_errorscreen(['please click on the ' tag(1:end-6) ' parameters button to specify the parameters'])
    set(findobj('tag',tag),'Value',0)
end

function gen_param_callback(hObject,callbackdata,x)
 gen_param_gui(x)

function gen_param_check_callback(hObject,eventdata,handles)
if getappdata(hObject,'gen_check') && get(hObject,'Value') == 0
    mute_errorscreen('you cannot uncheckt general parameters once specified. If you wish to edit general parameter please click on the general parameters button');
    set(hObject,'Value',1) ;
elseif getappdata(hObject,'gen_check') == 0 && get(hObject,'Value') == 1
    set(hObject,'Value',0) ;
    mute_errorscreen('please specifiy general parameter by clicking on the general parameters button ');
end